Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF9C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DCE20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pigp0QNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgC3NfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:35:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgC3NfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CvvArYDvBqOkdl+lX9jI0WvLOwqcoIarX9fq8ZHcgqI=; b=Pigp0QNodaKGL2Ed8OjzNOG7nL
        OduPAs3HgmaFckP8uzvJQ0UXeDFopmT1Y4E2T3AQ0JpZkR/JqGZPhwjwA9+4W4erY8PM2PxxRrTXz
        pW6EFtNJg0EbwqxvdT52ikvVvgotHBi3+kxRZPdCUTsdnuMIKCKcHE9JAQ6u8EY+0huBWZJyOVmKw
        7m30DOhK375I4LqLNoWbbwj5M23wUXDJcK+r7Uf5yrjjAQm7hJAHeg9hbJBHxptsxIPkS8HtWCSYj
        hGuGi7GBbTvz9DaF2/OXRLddZbCNN3mkpAFlfGWinzS41FtR5sEx+rLboHqivctuJk9RfUdR7eFOK
        mZfygVZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIuZK-00050Y-Ts; Mon, 30 Mar 2020 13:35:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C06153025C3;
        Mon, 30 Mar 2020 15:35:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F3E620B15B97; Mon, 30 Mar 2020 15:35:08 +0200 (CEST)
Date:   Mon, 30 Mar 2020 15:35:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        riel@surriel.com
Subject: Re: [PATCH] sched: Align rq->avg_idle and rq->avg_scan_cost
Message-ID: <20200330133508.GN20696@hirez.programming.kicks-ass.net>
References: <20200330090127.16294-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330090127.16294-1-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:01:27AM +0100, Valentin Schneider wrote:
> 
> """
> The result of E1 >> E2 is E1 right-shifted E2 bit positions. [...] If E1
> has a signed type and a negative value, the resulting value is
> implementation-defined.

True; but the kernel uses -fwrapv, which would mandate 2s complement,
which then gets us to the next point:

> """
> 
> Not only this, but (arithmetic) right shifting a negative value (using 2's
> complement) is *not* equivalent to dividing it by the corresponding power
> of 2. 

True; good catch.
