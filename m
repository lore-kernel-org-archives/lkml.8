Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65082166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WM1/1CZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgEAUbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8857C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+G16InsIrRwpcDBg1OGwf42TIo1M6ObSKGir1LYMpTU=; b=WM1/1CZyWUO7Wu5K5Gey5ILrrs
        +uDtcs1N+wSrWXpoCXfBTE8c2KHwQcPjRq4tIjlYf4zYLpx3ASCguedqO9D64oqmk9YXjX2W7uJ43
        2cOen1ACwuXpcrOwLYfucurxOYRhERYBi7JMkEfQPP6oJJzK6n8+0MVSMzgh5ErWSbz1yZG51LldX
        rXIHcWKoOBx05V10dgs5M3Rcr9/dUv0u7/Xtk9V95gnviz0f3FgFhiBLry2iFzDrhsCADhIgcdSIj
        JUlJe5XjKtCyv3rkOp9H3SLcFupv1MomLJPVkaRY9rg2MjYJjq/0vMFE9Vo8nSWIGiHdwQnnp0Zd9
        06RXMkpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJN-0002kp-GE; Fri, 01 May 2020 20:31:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2A2230602B;
        Fri,  1 May 2020 22:31:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AD92725BAEC02; Fri,  1 May 2020 22:31:00 +0200 (CEST)
Message-Id: <20200501202849.647891881@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:28:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 00/18] Add static_call()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_call(), is the idea of static_branch() applied to indirect function
calls. Remove a data load (indirection) by modifying the text.

The inline implementation still relies on objtool to generate the
.static_call_sites section, mostly because this is a natural place for x86_64
and works for both GCC and LLVM.  Other architectures can pick other means
if/when they implement the inline patching. The out-of-line (aka. trampoline)
variant doesn't require this.

Patches go on top of tip/objtool/core.

Patches can also be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/static_call

Changes since the last time:

 - Fixed the inline variant; the previous version relied on the section of
   symbols to detect the static call sites, but undefined symbols do not
   have a section, so it basically ended up not patching many sites. IOW
   inline mostly behaved in the out-of-line variant.

 - Fixed an issue with modules

 - Clarified static_cond_call() has 'void' return.

 - Clarified DEFINE_STATIC_COND_CALL() (ab)use.

 - Tracing no longer adds an indirect call for !HAVE_STATIC_CALL


