Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7038C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFAC216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghHY8m6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEHNwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727076AbgEHNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:52:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF577C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:52:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so756312plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0jCsV9kMCvKoLy/+F2UgXK4X/51ktfa1OAMmkbW9Vos=;
        b=ghHY8m6xtX8A574McPTJ+47EkLLBC4yXXpjqq5KpkaG44TQALnL8DTje3tAxiPinzi
         fXfnByOXmrNQArBPy2GqK++mVUdsKUcHeqINCPGHjg0HmnstTAdBq8Pyj7wtwj10gsva
         Ng92GCFDKcfcF2puH7AWmOgxKZpLDKE3bLs5G8mZ3jKLRq3w/W7V7+zgryKhtPTTzN8e
         91HI2CD9MSokbfuol3Yjg42Vw4RjQj9xnuO0Zsa5XrKwjIl71sN1hHhARQvfttm0rsdb
         cUxf7iSBcs+dVFb2zTcuhMUUygVCggJQqUrtkYkKIBCSbkBYzLbUNk9W7+KI303KiSEk
         EbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jCsV9kMCvKoLy/+F2UgXK4X/51ktfa1OAMmkbW9Vos=;
        b=lYiz2Boh5OBl45S1q6wJZ/mayIrj+p5Nax91UloBAb5YPVQwg475Z2WHFYXPEt/lUK
         T6/HZcuSwU8yW2+UmuWO35KZhsKQiwVtWXkjgF2qRRAtckWD2e8oLBTN79p1SN/QHcnW
         7Uh4xe7so6Cqd7qKEDmvvrRascdDLOoqrIvrc/EG2mQZQ+psHahdwJODf9mSMG7e3iAc
         YsbDHn1TnIOPFghZt7+7fH3VFygNG03zx+ZaEi9ig2iZQKXArJGGL3lcd8Zm17vpvKUz
         3HrXlrqZP7xPR4bzLaCW//3VrzWzXe+zRkMPEdYxjUSXuGoeCwhL3CAY+2tdhsT2jvbp
         unPg==
X-Gm-Message-State: AGi0PuZozS+dR/g5Lw24rHrRBvmQMRFzMFFixaFM1VdazrWfeQxSIRJ/
        TyQW7DmBuk0sDVDgnIRb2fSDKQ==
X-Google-Smtp-Source: APiQypI9Qdzl3FHEOWr4U3hPDPJFhtn4Y3+xwR+HhV6XqnRiET+VZg6Rk0X/IKLivbJ7mZtbbldAEQ==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr5644114pjy.16.1588945931131;
        Fri, 08 May 2020 06:52:11 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o6sm1845540pfp.172.2020.05.08.06.52.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 06:52:10 -0700 (PDT)
Date:   Fri, 8 May 2020 21:51:59 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        zhengbin <zhengbin13@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: gpu: drm: Add MDP5 configuration for MSM8x36
 and its derivatives, such as MSM8939.
Message-ID: <20200508135157.GD30486@dragon>
References: <20200501205201.149804-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501205201.149804-1-konradybcio@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Fri, May 01, 2020 at 10:51:59PM +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Please write up some commit log.  Since this is based on msm8x16_config,
maybe document the differences from it in commit log?

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 70 ++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> index e3c4c250238b7..1c7de7d6870cf 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
> @@ -342,6 +342,75 @@ static const struct mdp5_cfg_hw msm8x16_config = {
>  	.max_clk = 320000000,
>  };
>  
> +static const struct mdp5_cfg_hw msm8x36_config = {
> +	.name = "msm8x36",
> +	.mdp = {
> +		.count = 1,
> +		.base = { 0x0 },
> +		.caps = MDP_CAP_SMP |
> +			0,
> +	},
> +	.smp = {
> +		.mmb_count = 8,
> +		.mmb_size = 10240,
> +		.clients = {
> +			[SSPP_VIG0] = 1, [SSPP_DMA0] = 4,
> +			[SSPP_RGB0] = 7, [SSPP_RGB1] = 8,
> +		},
> +	},
> +	.ctl = {
> +		.count = 3,
> +		.base = { 0x01000, 0x01200, 0x01400 },
> +		.flush_hw_mask = 0x4003ffff,
> +	},
> +	.pipe_vig = {
> +		.count = 1,
> +		.base = { 0x04000 },
> +		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP |
> +				MDP_PIPE_CAP_SCALE | MDP_PIPE_CAP_CSC |
> +				MDP_PIPE_CAP_DECIMATION,
> +	},
> +	.pipe_rgb = {
> +		.count = 2,
> +		.base = { 0x14000, 0x16000 },
> +		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP |
> +				MDP_PIPE_CAP_DECIMATION,
> +	},
> +	.pipe_dma = {
> +		.count = 1,
> +		.base = { 0x24000 },
> +		.caps = MDP_PIPE_CAP_HFLIP | MDP_PIPE_CAP_VFLIP,
> +	},
> +	.lm = {
> +		.count = 1,

From what I read on downstream 3.10 kernel, there should be two mixers
just like msm8x16.

	qcom,mdss-mixer-intf-off = <0x00045000>;
	qcom,mdss-mixer-wb-off = <0x00048000>;

> +		.base = { 0x44000 },
> +		.instances = {
> +				{ .id = 0, .pp = 0, .dspp = 0,
> +				  .caps = MDP_LM_CAP_DISPLAY, },
> +				},
> +		.nb_stages = 8,
> +		.max_width = 2048,

It should probably be 2560 from downstream below.

	qcom,max-mixer-width = <2560>;

> +		.max_height = 0xFFFF,
> +	},
> +	.pp = {
> +		.count = 1,
> +		.base = { 0x70000 },
> +	},
> +

For consistency, we may want to drop this newline.  And it looks like
there is a .ad block on msm8x36.

	qcom,mdss-ad-off = <0x0079000>;

> +	.dspp = {
> +		.count = 1,
> +		.base = { 0x54000 },
> +	},
> +	.intf = {
> +		.base = { 0x00000, 0x6a800, 0x6b000 },
> +		.connect = {
> +			[0] = INTF_DISABLED,
> +			[1] = INTF_DSI,
> +			[2] = INTF_DSI,
> +		},
> +	},
> +	.max_clk = 366670000,
> +};

Need a newline here.

Shawn

>  static const struct mdp5_cfg_hw msm8x94_config = {
>  	.name = "msm8x94",
>  	.mdp = {
> @@ -840,6 +909,7 @@ static const struct mdp5_cfg_handler cfg_handlers_v1[] = {
>  	{ .revision = 2, .config = { .hw = &msm8x74v2_config } },
>  	{ .revision = 3, .config = { .hw = &apq8084_config } },
>  	{ .revision = 6, .config = { .hw = &msm8x16_config } },
> +	{ .revision = 8, .config = { .hw = &msm8x36_config } },
>  	{ .revision = 9, .config = { .hw = &msm8x94_config } },
>  	{ .revision = 7, .config = { .hw = &msm8x96_config } },
>  	{ .revision = 11, .config = { .hw = &msm8x76_config } },
> -- 
> 2.26.1
> 
