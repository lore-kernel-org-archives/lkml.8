Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C5AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463EE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597732544;
	bh=rUWChlbE1aEqHYoPTipxMradvFr9SB3+1uYoSmaW41M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilYoZOx7B9/ig9I1+WY4mSkt8l8Yps8OyJoPtPhLNSNsFdiDmklEhJapVW+C+dDs5
	 vhLBhlMKbwTSQvyiQyuBOp/ilgORM9bwWKq8E+1VSiJcNfNhpTAz1pMpzp3vWA2As0
	 aVs6IllCvPkTpsvQWp4k6pHealVtmbn9xJID7UFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHRGfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRGfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:35:43 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C44E12067C;
        Tue, 18 Aug 2020 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732542;
        bh=rUWChlbE1aEqHYoPTipxMradvFr9SB3+1uYoSmaW41M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSJ7DxFdS8XCIJZS6ZR/Q+tyQpdWUjU4vJ3uF06Gv2W4Edqk0XRTBXlX3MXzGt0DM
         Ag99XVItHAqKF13elvod9mX712p8zYG67xU3mEEXpvNbpjpv3fOPdfiAGLx2ck7WQ8
         nQS8jQaoGcvOEtUu1uPObUPO9twz6BEM9vNscL5s=
Date:   Tue, 18 Aug 2020 12:05:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: add definition for maximum number of ports
Message-ID: <20200818063538.GV2639@vkoul-mobl>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817174727.15139-2-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 01:47, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> A Device may have at most 15 physical ports (DP0, DP1..DP14).
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/soundwire/sdw.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 76052f12c9f7..0aa4c6af7554 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -38,7 +38,8 @@ struct sdw_slave;
>  #define SDW_FRAME_CTRL_BITS		48
>  #define SDW_MAX_DEVICES			11
>  
> -#define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
> +#define SDW_MAX_PORTS			15
> +#define SDW_VALID_PORT_RANGE(n)		((n) < SDW_MAX_PORTS && (n) >= 1)

What is the use of this one if we are allocating all ports always, Also,
I dont see it used in second patch?

>  
>  enum {
>  	SDW_PORT_DIRN_SINK = 0,
> -- 
> 2.17.1

-- 
~Vinod
