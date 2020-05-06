Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E49BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22732206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pf+y99HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgEFQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729239AbgEFQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:16:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C5BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Niy0rZZjNxl+4CF2hwLXln+QcVk8fiTWigxcJncCQfw=; b=Pf+y99HMCQ2lFtQFQgxAkQUqH8
        qMV0tWIRSMoZiU6/N21sP+sevuzojTvLEj5Pi0I9V2Ft1QsPnQdj4bl8xG6ybadJD+l9QAH8qBGuV
        YKGxRZcuQO8pbn07DL6N5/FeY+Jv+IH3Sz8E7Mj2rEIQvWy697DscpGviAVsidD+mOIBcxOaaLLSW
        T50x/1b1S4UWjX0MtmeILYAg8uoX5OG2uQCwwT8pENwhitqIJ++jf8ulJ76aAH2oDgIyVrRVxweNB
        9Ul4Lffau2XBqIvllJkCPnTfypJF+ldlT9ULjfh6DqG9/vJzBs2+Y6Z7AJy8VxWd5OAJL2qgLjDzK
        Nd3jfg4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMiX-0006rq-C2; Wed, 06 May 2020 16:16:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91CF3300238;
        Wed,  6 May 2020 18:16:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81F53203ECDC2; Wed,  6 May 2020 18:16:15 +0200 (CEST)
Date:   Wed, 6 May 2020 18:16:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 09/18] x86/static_call: Add out-of-line static call
 implementation
Message-ID: <20200506161615.GU3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.301405080@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501202944.301405080@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:28:58PM +0200, Peter Zijlstra wrote:

> +#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
> +	asm(".pushsection .text, \"ax\"				\n"	\
> +	    ".align 4						\n"	\
> +	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
> +	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    "	jmp.d32 " #func "				\n"	\

I remembered Nick asked this to be .byte 0xe9; .long #func - (.+4); last
time, now done.

> +	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
> +	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
> +	    ".popsection					\n")
