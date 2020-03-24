Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6636EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB521473
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nOa862p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgCXOYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgCXOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Bq9iittk7Qhb2lNlE0Btgsw/+4NODDlNnnHOmS2nT1U=; b=nOa862p53xYIjICWnbHVneDa2W
        KjSaQw/dLBiY8Qvc7BKghfUqPSAUGD3NdGCnvJunvWK+x1dZhp7v/g7RC4eUzKTP2Nb7yyHtShcSm
        HicLJ0W/iau1YAUx1+PFSLquLExz6X4mvmUCq2TcabyJD9CqhxhW2m4L/9gMMvNevItL5Tm6AyyG/
        MCPq5n4A89qmcwSCaUjlLvNV8NTm0nF574eQeBexc/HKK9HbdnpBiH3CoRvN5/43r/4jf6gunHKDn
        8gOTaa6OH/XiDjlg1V705ewFjBV7iZGXEjpytjGwuwMHTVXGysBsIbiTIaeQgAB8t6chw/SJkb0NR
        LsdsSgJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTt-0001fb-L5; Tue, 24 Mar 2020 14:24:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 070AC30743D;
        Tue, 24 Mar 2020 15:24:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DAEC1286C13AD; Tue, 24 Mar 2020 15:24:34 +0100 (CET)
Message-Id: <20200324135603.483964896@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 00/17] Add static_call()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend; because of the typo in the lkml address]

static_call(), is the idea of static_branch() applied to indirect function
calls. Remove a data load (indirection) by modifying the text.

The inline implementation still relies on objtool to generate the
.static_call_sites section, mostly because this is a natural place for x86_64
and works for both GCC and LLVM.  Other architectures can pick other means
if/when they implement the inline patching. The out-of-line (aka. trampoline)
variant doesn't require this.

Patches can also be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call


Comments?

