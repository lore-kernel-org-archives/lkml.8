Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFFC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29524654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582114783;
	bh=3qlQaNnljrjKc6kTfdEHEH7GOaqiJKE0UHCyGlk27r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XYAxVqSqx9JcL5ylFdIQBynL2UtcE2ZIMTt/2if8zceKLcWMRB0UJvHGCgjt2mZgm
	 eiXpVI7+IydFG+PlWakF+YbTA1OZ1WpWvqZgjEcH+pG4KizsXy08gnLipqepxQr/x+
	 JIkk/nFlzPVAHQ3pF1IKX6MghWJsXQK/R4+NtRnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgBSMTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:19:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgBSMTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:19:42 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A46206EF;
        Wed, 19 Feb 2020 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582114781;
        bh=3qlQaNnljrjKc6kTfdEHEH7GOaqiJKE0UHCyGlk27r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzAw6yKdrIeP2fvdG7r+0HFXbf3YyAJkINJj5eDwB5yzQZuZkbh/7IqefsLnvf5u3
         /F7fEQLZiZHEVUj7RbAIbNpdpN7wjrs3AgQHHghWPRp00TvJEKQU3PZsSf4bGOF7pw
         eLxuuS7qC/lCftaiBw+oHi31FMz7qZrM7iGIRtBc=
Date:   Wed, 19 Feb 2020 17:49:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: tegra210-adma: Replace zero-length array with
 flexible-array member
Message-ID: <20200219121937.GK2618@vkoul-mobl>
References: <20200214171657.GA25663@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214171657.GA25663@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-20, 11:16, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]

Applied, thanks

-- 
~Vinod
