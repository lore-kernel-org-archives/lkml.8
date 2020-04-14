Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE29206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YR0grewP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgDNTuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505187AbgDNTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:48:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C38C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9vok3C1d2NVKjQ/zMjs0qD8eBUGaGr2I4zwLsLwFDMU=; b=YR0grewPR3o/qBdW2F2EzZExHe
        WCuo8fyMPSarL/iOd9uBNfxjK0hp2HpNLQ/tLwbsIvfXjomTri0l+MvpZcoa4oWKkwEEbXBxBrqTV
        VYtFT5XC95c1fTAK+hPdyDprkFqzPekdFw12w8xxWLaXlINawBRfdRP2fabskPkq2TbN+9kHfR1VX
        WeVbxOh6tSiVvquBNIB4jKfO2t4Rx+E4tdFZEMWpyqj/cSR4zIszV7ra4q2th4W2vmR7yAUlS6I5r
        wG68C3sVCRhBs0+0AUlVr5zoor+r49e6mSi7j64LKKKoERR1yC67cqHf3X5S0RriSm7yGP5ahbIGo
        Ure0veDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jORXP-0003eF-VO; Tue, 14 Apr 2020 19:48:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B2BD981086; Tue, 14 Apr 2020 21:48:01 +0200 (CEST)
Date:   Tue, 14 Apr 2020 21:48:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
Message-ID: <20200414194801.GH2483@worktop.programming.kicks-ass.net>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
 <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
 <20200414175604.GD2483@worktop.programming.kicks-ass.net>
 <e9e1c4cd-193f-fd5e-65c4-cc9fb159d861@oracle.com>
 <20200414184233.GG2483@worktop.programming.kicks-ass.net>
 <ed46281f-46e5-10a0-1b61-60a54ea9d84e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed46281f-46e5-10a0-1b61-60a54ea9d84e@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:27:27PM +0200, Alexandre Chartre wrote:
> This provides a generic code to handle any intra-function call. Currently we have
> the RSB stuffing ones which are forgotten with the UNWIND_HINT_TYPE_RADDR_DELETE
> directive. And for retpoline, they will not return if we have an indirect jump
> (JMP_NOSPEC) but they will return if we have an indirect call (CALL_NOSPEC). The
> code can handle both cases. For example, if we were to have a CALL_NOSPEC invocation
> which is not in an alternative then objtool can now correctly handle it.

The specialness of CALL_NOSPEC goes away with my proposed retpoline
rework as well. I really don't think we need something as complicated as
this.

Fundamentally validate_branch() will continue after a CALL instruction;
so I'm thikning the worst that can happen from not following a
(theoretical direct return) is a false-positive unreachable code
warning, and we can trivially fix those with exisiting hints.

