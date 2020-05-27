Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54992207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590620711;
	bh=+OCiFvqapFwho37Ni+WlLY1vTVuWc8/yy5EEM83gbnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E+gXxXvBBUdnB6iLRBlo2NNVp0epZSesORNxZfdDXA4qvz943JpShMiWwgGywtij+
	 k5qldJOjDqkfs3waMjct1Nb3syoZ7XDYyAfeDrpaKpVs0XxA5uxix2DifB3rX7gMw3
	 XLP8WVForRyIFiuSpXiwGhnjyQD6GGSrszzKH0JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgE0XFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE0XFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:05:10 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B36C207BC;
        Wed, 27 May 2020 23:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590620708;
        bh=+OCiFvqapFwho37Ni+WlLY1vTVuWc8/yy5EEM83gbnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X4cefrp3c3fJivmkV69IA2bJcizzHytTU73I4j30H3cDKndZSfY2hZOFg9mFhEhzX
         xH3U4jr6nh7Pjh72BWvOt3jNN0mXVJr/51BU5Y2BOqp8ikAYT7M+hriOi4UdM9C0Lp
         fzLJAnP0CWyORRU8CVAhHwnhquU6RjYh0xNvkP5A=
Date:   Wed, 27 May 2020 16:05:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-Id: <20200527160508.2ef29d6904c07ca6c650638c@linux-foundation.org>
In-Reply-To: <20200527224542.yx45druzqtlaxrl7@master>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
        <20200525091458.GK1634618@smile.fi.intel.com>
        <20200525144312.mbw2z3ydncyasvss@master>
        <20200525153216.GD1634618@smile.fi.intel.com>
        <20200525134110.5737dd603d5fa1230e2f7ece@linux-foundation.org>
        <20200525215741.zd3gry4yyqqplix6@master>
        <20200525153146.c1337b1ca7af386ac30e5702@linux-foundation.org>
        <20200527224542.yx45druzqtlaxrl7@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 22:45:42 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> /* a tiny module only meant to test get_count_order/long */
> unsigned int order_comb[][2] = {
> 	{0x00000003,  2},
> 	{0x00000004,  2},
> 	{0x00001fff, 13},
> 	{0x00002000, 13},
> 	{0x50000000, 32},
> 	{0x80000000, 32},
> };
> 
> static int __init test_getorder_startup(void)
> {
> 	int i;
> 
> 	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
> 		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
> 			pr_warn("get_count_order wrong for %lx\n",
> 					order_comb[i][0]);
> 	}
> 
> 	return 0;
> }
> 
> Since I don't get a way to iterate all the possibilities, some random
> combination is chosen. Is this one looks good?

Looks good.

You might want to add a less-negative number as well?  0x80030000. 
Something that won't turn positive if it has 1 subtracted from it.

