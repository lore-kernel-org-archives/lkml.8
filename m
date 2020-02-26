Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD1C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA024650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582685494;
	bh=OUGcqtr3slwiFA2R7LCmSyIH96FefNBvDVOEGJkbPG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UdKaokPnEpqxUygr9LY0o3H6i4AWSkRiGvatB1zZwfOUcoYkEyNUfgutQDAp1taUW
	 GJHb7Zrqaj7NEYyHYgWYAfOnZv6LKD3Q1xOv+X9RVJnQ+Rb+pliwvg499gk/SPxEYn
	 gaOUOv+Au5aKriKfZ3dxZrUsrqf5wX8z+MrufoHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgBZCvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgBZCvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:51:31 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBD921744;
        Wed, 26 Feb 2020 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582685491;
        bh=OUGcqtr3slwiFA2R7LCmSyIH96FefNBvDVOEGJkbPG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qu/zSUYOAQ9tXmWzOgoLPNgBh1WuBbX/46dvRHNsTu81c7I0agKHdUsithrjlsFXl
         /Sh3Tisnq1oz0Z+eEypyOYd4mLgcZeSQaTNjChNVbgO3MrICxDHKLkFDXmSL5DdRFC
         NRxCk7NAsxOwTkkN0myj3r+mrSNdhhOrNdriPR/8=
Date:   Tue, 25 Feb 2020 18:51:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Limit runaway reclaim due to watermark boosting
Message-Id: <20200225185130.6a32a8a6920d11b4c098e90e@linux-foundation.org>
In-Reply-To: <20200225141534.5044-1-mgorman@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 14:15:31 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:

> Ivan Babrou reported the following

http://lkml.kernel.org/r/CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com
is helpful.

> 	Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when
> 	an external fragmentation event occurs") introduced undesired
> 	effects in our environment.
> 
> 	  * NUMA with 2 x CPU
> 	  * 128GB of RAM
> 	  * THP disabled
> 	  * Upgraded from 4.19 to 5.4
> 
> 	Before we saw free memory hover at around 1.4GB with no
> 	spikes. After the upgrade we saw some machines decide that they
> 	need a lot more than that, with frequent spikes above 10GB,
> 	often only on a single numa node.
> 
> There have been a few reports recently that might be watermark boost
> related. Unfortunately, finding someone that can reproduce the problem
> and test a patch has been problematic.  This series intends to limit
> potential damage only.

It's problematic that we don't understand what's happening.  And these
palliatives can only reduce our ability to do that.

Rik seems to have the means to reproduce this (or something similar)
and it seems Ivan can test patches three weeks hence.  So how about a
debug patch which will help figure out what's going on in there?
