Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF965C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB5321473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 19:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+lOIHhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDST2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDST2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:28:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Om9Pn6c41Q2Pv/+P2olefe0VgPv5maq/6fkuXbhZtt8=; b=S+lOIHhuOL4BPLfPMD3fHu/zp3
        SESIX52ZNdhZ97Lp8/MlUwvoJ9DqXPb+NyAjfQkzoXPdHExLGtJaDb93PUIfBeabVePFYnJyaoJRt
        kqCEpvcM9vsP0H05fHUjQpVnlKYqFaKXRZCnxN7n93AuGH+1lxyCU1ZK6TCeEzLVR0locYeYtu7oH
        ba4Fi/m2zv1g/S3HJqbecWFcMd08n/p/DUw15NTyO+jgSZ4OobyALl4GfhjVTQubNy0Qf1J3g0EdH
        0P9JEfDo464SaTu8MpdGehEZE9C1a9DzL7sOaQzyfQz6Wz15DPZsB/IoIbdZeJ6+/865pQVPmwQ+2
        L6kTOMoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQFbf-0001KT-Rv; Sun, 19 Apr 2020 19:27:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A00230275A;
        Sun, 19 Apr 2020 21:27:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1ECB72B4E42EA; Sun, 19 Apr 2020 21:27:54 +0200 (CEST)
Date:   Sun, 19 Apr 2020 21:27:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 3/7] objtool: Allow branches within the same
 alternative.
Message-ID: <20200419192754.GY20696@hirez.programming.kicks-ass.net>
References: <20200416150752.569029800@infradead.org>
 <20200416151024.885221682@infradead.org>
 <20200419163219.b5dpg246xh6avsci@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419163219.b5dpg246xh6avsci@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 11:32:19AM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 16, 2020 at 05:07:55PM +0200, Peter Zijlstra wrote:
> > From: Alexandre Chartre <alexandre.chartre@oracle.com>
> > 
> > Currently objtool prevents any branch to an alternative. While preventing
> > branching from the outside to the middle of an alternative makes perfect
> > sense, branching within the same alternative should be allowed. To do so,
> > identify each alternative and check that a branch to an alternative comes
> > from the same alternative.
> > 
> > Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20200414103618.12657-3-alexandre.chartre@oracle.com
> 
> I I think I'd rather just drop this patch.  It adds some complexity and
> I don't really see a benefit to having the warning in the first place.

Also; we totally don't need it, sorry for not realizing that earlier.
Consider it gone.
