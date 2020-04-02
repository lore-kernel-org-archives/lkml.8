Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2147C2BA1E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705D72145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBAHwiN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgDBO23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:28:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbgDBO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j/8a96fqeZAuiVy6S5hR0dB16EbF/5r64jo0EgfpZqw=; b=nBAHwiN9U4ETGo8K3sVmLBS5Zh
        i49IKbjJ8/jWrEkVatZcsAWpm2rveMNK7/35SB+klm33JYaqGf8+13FlGBZlfTmgrcw21ZvwfpPPr
        cM77QfLIQyKzgzRCurRv289EruAkgJcxrnd4LC2Nxcp7KRe0rnSCgY2WCwg/j6C3jYh/gnN3MR4WK
        gdP0Sgy4UfOpfyqHTvh1KEorBu/IFzOvHMelc5aZkE5W+OI/5KADrYP0qtH2pWrKdmO1dRlqPTfs+
        Nkm7Pp24wAEvHJA+lxltBPwx+SKSlLLOnz25u2dcrInG5TnV/e81bjXcXNc7f1QYd4ntob7EWIC+h
        fFQSXz+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK0pU-0003C3-H6; Thu, 02 Apr 2020 14:28:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD50F307062;
        Thu,  2 Apr 2020 16:28:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FF0C2B0D8F6B; Thu,  2 Apr 2020 16:28:21 +0200 (CEST)
Date:   Thu, 2 Apr 2020 16:28:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 0/5] objtool fixes
Message-ID: <20200402142821.GI20713@hirez.programming.kicks-ass.net>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:23:24PM -0500, Josh Poimboeuf wrote:
> Some objtool fixes related to CONFIG_UBSAN_TRAP, Clang assembler, and
> more...
> 
> Josh Poimboeuf (5):
>   objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
>   objtool: Support Clang non-section symbols in ORC dump
>   objtool: Support Clang non-section symbols in ORC generation
>   objtool: Fix switch table detection in .text.unlikely
>   objtool: Make BP scratch register warning more robust
> 
>  tools/objtool/check.c    | 26 ++++++++++++++++--------
>  tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
>  tools/objtool/orc_gen.c  | 33 +++++++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 32 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
