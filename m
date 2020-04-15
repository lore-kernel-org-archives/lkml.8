Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93124206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586967379;
	bh=QB4mrJlnOHdWx6xcWQ3bgKLDC0djAowm6CN2swhUgAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ifnPOCawUWuTgQEicUwSRnKsk+1NP6xlur5zEws8WEzI/Afs8q00BvRlPDB5BZTL
	 X+sN4fOukadFhnU3jiy16427eZIoBxgWhPPj4J/7rWMyhq1hq70LO9gPzIKyJDqk3q
	 0OoutLELHRVGYDxBdr/XwOanCr0wW6VxvNefAlbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415482AbgDOQQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:16:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415030AbgDOQQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:16:08 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37523206F9;
        Wed, 15 Apr 2020 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967368;
        bh=QB4mrJlnOHdWx6xcWQ3bgKLDC0djAowm6CN2swhUgAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUA5ezWyshgzOZhu8futGHv425Kc4sK7tph+I65jlqCAnNOBN27id/xh4f9c0+iTk
         cC427/zhcBlwWTuupq6M3+4ovf2dUx+vCFCLk0xaEwBL2+BKV8CBh3NCehpKMKxD4n
         2EQKEchO5L8JGeI9gcvFZ5LsWbke8LwC6kX7BRnI=
Date:   Wed, 15 Apr 2020 21:45:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Maciej Grochowski <maciek.grochowski@gmail.com>
Cc:     dan.j.williams@intel.com,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/dmaengine: Typos fixes in API documentation
Message-ID: <20200415161559.GZ72691@vkoul-mobl>
References: <20200414041703.6661-1-maciek.grochowski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041703.6661-1-maciek.grochowski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-20, 00:17, Maciej Grochowski wrote:
> From: Maciej Grochowski <maciej.grochowski@pm.me>

Applied, thanks

-- 
~Vinod
