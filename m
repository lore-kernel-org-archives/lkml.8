Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4173220719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHzN/uRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgDGN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:28:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGN2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FABG1nsUHC99ShEuLwmDippLPOdYOOruooCxAiRmuhs=; b=GHzN/uRc/BMFdpy3BouGji/K//
        +Z6DYoWnPnQJXxR7gdL40oyG4486KAo6RF39nVPINJCP9UxF5z0GYEpePvsXD8vaOsi7GnMN/soHi
        uInUeMygfP4Dumy8QeD4hRKl+2ebbi2jYCEJnshZ/EkBZF53RqLM0XTuBYQZh72X8SVVXzrn44Igh
        4ndaAvewTfBFaWs9D1SFUIco+aSkBMBVYpsygPpnBbLwtoGvkqcsme5tq1PeNOnn6R2Z8KHw5Dste
        D+k2mPSA510vHT4nA17lAqsx02rvS+4I+lAE8PmfZCuvlag5odRM+PpCYZ+jekYf+tUvvKItagOJi
        yycPv0sQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLoHQ-0003da-4Q; Tue, 07 Apr 2020 13:28:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19D273011DD;
        Tue,  7 Apr 2020 15:28:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 039B02B907A96; Tue,  7 Apr 2020 15:28:37 +0200 (CEST)
Date:   Tue, 7 Apr 2020 15:28:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407132837.GA20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-10-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:42AM +0200, Alexandre Chartre wrote:
> Now that intra-function calls have been annotated and are supported
> by objtool, that retpoline return instructions have been annotated,
> and that __FILL_RETURN_BUFFER code is compatible with objtool, then
> all ANNOTATE_NOSPEC_ALTERNATIVE directives can be removed.

Like Josh said in the previous thread, this isn't going to work right.

> -	ANNOTATE_NOSPEC_ALTERNATIVE
>  	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
>  		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
>  		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD

The problem is that while objtool can now understand the code flow and
the corresponding stack layout, we only have a single ORC table, one
that must be valid for all alternatives.

Effectively this means there should not be any orc entries in an
alternative range.

In practise it _might_ work when the instruction of the various
alternatives have unique offsets in the range. But I'm not entirely sure
of that.

Josh, we should probably have objtool verify it doesn't emit ORC entries
in alternative ranges.
