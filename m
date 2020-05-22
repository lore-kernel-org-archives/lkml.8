Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB13AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF0420679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KOSE1DG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgEVQh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEVQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:37:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E86C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hy2JiXCRdu+a2EjO8Xgf5JCvZMJtvHvVr/oDtabhsk0=; b=KOSE1DG0JgaWl+3FSE/HH45eVY
        rfg2A3Y/vvxBBZugw5Ai+g9VDdowOupp0to9kQx8U2Ovd9Ymr8PJHKNeKPiwZUmb+AotBWb82K4EL
        t5pDOXASz69UY22umFtAbtBnOLNh3g24MMt9EroFNImlourj8ZxvNVXTAQueWLx/DKX8YXKfpQxOm
        FRR0CahJPdixNWaOiOiHn6DTXVBqjyRIEQuUBqO9+/6d1GbZml6zOJpDlcdCfJr0nrZUwMvDrWB0R
        paVUhCy1Z0vwZObrDvxppAj6ciV0fiD3b7j8iluvZ5kbtGoZ5NmztWPWZ6cSFlrHXR/oVxs28kMWN
        6esL+ciA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcAgH-0004nu-5H; Fri, 22 May 2020 16:37:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 131F1306102;
        Fri, 22 May 2020 18:37:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F33E32B7F3D10; Fri, 22 May 2020 18:37:54 +0200 (CEST)
Date:   Fri, 22 May 2020 18:37:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Tobias S. Predel" <tobias.predel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        namit@vmware.com
Subject: Re: Regression in linux-next 20200521 / Kernel Ring Buffer full of
 warnings
Message-ID: <20200522163754.GY317569@hirez.programming.kicks-ass.net>
References: <20200522163052.GA8791@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522163052.GA8791@t2b3>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 06:30:52PM +0200, Tobias S. Predel wrote:
> Hello,
> 
> since two days I experience some kind of loop/pause on my user interface
> with linux-next. That didn't happen before.
> 
> I am using linux-next 20200521 (ge8f3274774b4) and I get messages like 
> the following ones while user interface is almost not usable.
> (Touchpad gestures aren't shown. Video gets stuck and fast-forwards after a while)
> 
> The whole things starts after a while in graphical user session 
> (Desktop environement Sway), not immediately after startup.
> 
> I would be glad if someone could look into this or if this is reproducable
> also on other computers apart from mine (HP ProBook 430 G5).
> 
> Thanks in advance!

https://lkml.kernel.org/r/20200521110027.GC325303@hirez.programming.kicks-ass.net
