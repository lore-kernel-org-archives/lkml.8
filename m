Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5143C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30FE2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wVJsnqhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgHROQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgHROM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D59AC061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X0x5Gc8q0SKpcWhwznqI3m5M3STHJrZbcbIqjua2ldQ=; b=wVJsnqhguAp37mrbxj2Htt92iP
        sv5/s3bcBpU9eWAZr+5+kz77WF3YjRTbykmldDHG2KLIIj8QykroGI+z7L6eoXIxGKQPu24UrHPiI
        G8vLZ1kccKgHv+11GNfWzsjPifSx4KHp8MQ0nlplKmWA66zJXFpQ7hzLOPyaQIU7AJ5fPEN3tJROK
        9zWZ4NPdWF1d+j7j1yIG5mujF30YAsmiTLq+6CuLIGVmf2zG/n32zd/CyU6qMf1xEu/TpinTOv5e9
        grxg/DQmzS0wuOcm39d/nQWoDyengXAMsaqltRyVBawUmne6KtBsHIzFulCLnJ8JPtc+0uSi86z5w
        tt7Y6WdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LJ-0000oC-PU; Tue, 18 Aug 2020 14:12:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFF423060F2;
        Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9526523D42BFA; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135735.948368560@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 00/18] Add static_call
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

static_call(), is the idea of static_branch() applied to indirect function
calls. Remove a data load (indirection) by modifying the text.

The inline implementation still relies on objtool to generate the
.static_call_sites section, mostly because this is a natural place for x86_64
and works for both GCC and LLVM.  Other architectures can pick other means
if/when they implement the inline patching. The out-of-line (aka. trampoline)
variant doesn't require this.

Patches go on top of linus' tree.

Changes since last time:

 - rebased
 - review feedback from Steve

