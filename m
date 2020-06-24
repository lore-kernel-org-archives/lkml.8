Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D07A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592991760;
	bh=POC8Wy5W8HTGPEipKgRNZ1OHxxsOy/XY4a0SBFZb7sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PPxpbhRVtFhh1iGgS6IRQTSkHZhwOLtkfekbW2SnEBPh0KPc8bQNmRoLHGrr6ZVhi
	 GVqAwcy5XivO8t3DpJpWW3MbkG7JQ/A+FfkSUeombpQ3qA6BnC0XXoXwAyzYMVgtsr
	 ET7ZLlS7Y1Z+HEqZ6NKDzLWUhZMvvAHQEEnF6jhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbgFXJmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388005AbgFXJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:42:38 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4849B20885;
        Wed, 24 Jun 2020 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592991758;
        bh=POC8Wy5W8HTGPEipKgRNZ1OHxxsOy/XY4a0SBFZb7sA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ybftKYnLOHEYJTD5rDbKXmc8Lz2zb2r+pORrKDYLA/6TKMDELxG8MDiMrvnWT+AkZ
         nCzzLRrchZQUbJfL/YExokHyzRoY7dA42D1qVl4UGc0rI2iy0YZIWWMVVx4j0NJYB2
         IybzbssoS1gJ3VOOd5YLZFEenZD5S455zG/QoW+0=
Date:   Wed, 24 Jun 2020 15:12:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v5] dmaengine: tegra210-adma: Fix runtime PM imbalance
 on error
Message-ID: <20200624094234.GW2324254@vkoul-mobl>
References: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624064626.19855-1-dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-06-20, 14:46, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied, thanks

-- 
~Vinod
