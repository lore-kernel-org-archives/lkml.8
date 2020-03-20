Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B4EC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE26620776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584711520;
	bh=lJF3p8wBmDcPt7q/ttSYu3J0rSwSBfMouALJLtfIRec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cBXluwb3c9Dga7lGtvi+0POURfURqKsonRP4b/71ugBcAvwlF0j6HE5j9TL8RCHUT
	 P+wl+ItYfPnI1VGMJ6YQcyq5uL5ehiDINRglB2D2qLqAsEBdM6rUtTocHiqMx5/jZP
	 X/wJ8DNvw/Wdzm4H2OOCnpZXWj8hCwLgdoCy2bis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTNij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgCTNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:38:39 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE5D20739;
        Fri, 20 Mar 2020 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584711519;
        bh=lJF3p8wBmDcPt7q/ttSYu3J0rSwSBfMouALJLtfIRec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgk4salsY3Fwi2RzwNkN/s40VAPuS25fuKUhR89286TkBkN8BVsg/VKixsEHWV+Ub
         Hi0jhXQsIZEwXLTBKu1gbNZtDRywKU8Ax3Pg/BeC/5X/vblZdU2wpeN1hFv8l6g+C2
         UscdLToEAS/KZ5+J/IkBkv9VTkxVUaEz2LCQnT5I=
Date:   Fri, 20 Mar 2020 19:08:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 2/7] soundwire: intel: reuse code for wait loops to
 set/clear bits
Message-ID: <20200320133834.GB4885@vkoul-mobl>
References: <20200311221026.18174-1-pierre-louis.bossart@linux.intel.com>
 <20200311221026.18174-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311221026.18174-3-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-03-20, 17:10, Pierre-Louis Bossart wrote:
> Refactor code and use same routines on set/clear
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 45 +++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 28a8563c4e0f..1a3b828b03a1 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -134,40 +134,33 @@ static inline void intel_writew(void __iomem *base, int offset, u16 value)
>  	writew(value, base + offset);
>  }
>  
> +static int intel_wait_bit(void __iomem *base, int offset, u32 mask, u32 target)
> +{
> +	int timeout = 10;
> +	u32 reg_read;
> +
> +	do {
> +		reg_read = readl(base + offset);
> +		if ((reg_read & mask) == target)
> +			return 0;
> +
> +		timeout--;
> +		udelay(50);

This should use udelay_range, but this can be different patch as this is
code move, so okay

> +	} while (timeout != 0);
> +
> +	return -EAGAIN;
> +}
> +
>  static int intel_clear_bit(void __iomem *base, int offset, u32 value, u32 mask)
>  {
> -	int timeout = 10;
> -	u32 reg_read;
> -
>  	writel(value, base + offset);
> -	do {
> -		reg_read = readl(base + offset);
> -		if (!(reg_read & mask))
> -			return 0;
> -
> -		timeout--;
> -		udelay(50);
> -	} while (timeout != 0);
> -
> -	return -EAGAIN;
> +	return intel_wait_bit(base, offset, mask, 0);
>  }
>  
>  static int intel_set_bit(void __iomem *base, int offset, u32 value, u32 mask)
>  {
> -	int timeout = 10;
> -	u32 reg_read;
> -
>  	writel(value, base + offset);
> -	do {
> -		reg_read = readl(base + offset);
> -		if (reg_read & mask)
> -			return 0;
> -
> -		timeout--;
> -		udelay(50);
> -	} while (timeout != 0);
> -
> -	return -EAGAIN;
> +	return intel_wait_bit(base, offset, mask, mask);
>  }
>  
>  /*
> -- 
> 2.20.1

-- 
~Vinod
