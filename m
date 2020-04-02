Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85ACC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A46620675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="paSCP1/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbgDBP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:27:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55286 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgDBP1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SZ61JY4/qMzGRRy2q/yJ6msRavUpvnK9aapJOKTpzqU=; b=paSCP1/eVNRse/xGNQY5Ty4LAv
        UReZvtQdW5qGp98i+k17hrCYfWxaCpH/moDsumrF7ZLvCjkaqLAuX7+hcSzqaaBo0SbqITSWy9Ank
        Qk/9Gz+JRY+g39AgBXF67vm6MM0fAfziPaKX5rRTJKVJ7MkAQz6zYDqviOqdzYVwKD82feB3ndOSq
        IVBwOeLNokLziSvhvc1PxYRSlvHFeUrEfFd6d5/sXagT9oemcTq2OlLMA7P82JXMVMRG3Lb1z/v6s
        kzXEJjO9bup9HbotVSt/OO2q3PxGd9pIvkr79hfGGkvWzvFUeSHRtnUKudwy4CjVU5QHP3iUmTpr4
        diPrxg4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK1kV-0002tW-CS; Thu, 02 Apr 2020 15:27:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D17ED3056DE;
        Thu,  2 Apr 2020 17:27:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9FF52B0DE831; Thu,  2 Apr 2020 17:27:17 +0200 (CEST)
Date:   Thu, 2 Apr 2020 17:27:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200402152717.GE20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402082220.808-5-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:22:17AM +0200, Alexandre Chartre wrote:
> With retpoline, the return instruction is used to branch to an address
> stored on the stack. So, unlike a regular return instruction, when a
> retpoline return instruction is reached the stack has been modified
> compared to what we have when the function was entered.
> 
> Provide the mechanism to explicitly call-out such return instruction
> so that objtool can correctly handle them.

https://lkml.kernel.org/r/20200331222703.GH2452@worktop.programming.kicks-ass.net

And also, the split out version:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=core/objtool&id=ec9d9549901dfd2ff411676dfc624e50219e4d5a
