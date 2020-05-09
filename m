Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5007BC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8021582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dnfj+2/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgEIFvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgEIFvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:51:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BCC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:51:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k19so1672162pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7J14h8CQ4Hdlv2EGA4N6V5LG3UgDFLVGj7NWGLwpvk=;
        b=Dnfj+2/60PmyIQt2csjXMt8i2o54WXeGTO8eZ6Ex0lG9CHbGA9EDmaWkQFPezQhPjp
         4ZVQDy+hOdxtUjq7sbZkgDr0h/H7CuuQ5DgLK2HPcVPI4z6kk5cwIExS/g0Ko/rRRKVF
         aF4DQfx2jx3+LPuropTSa5zr2KMisz/iBmEHWcDlt82oO+eZL1Kby7gniFfE9lUclWZB
         XXor8Cxli6endELvYO13zk6sEcZoONuF2RxBamijTUZVKvLvhUv/4+wZfkIdvNhuqECE
         7s4yAIIksGbOmTGmNK0y20tLaXXfmtt6rU9yn8qecGr2vgW5DXrWNwmqwL6Bdxd6jARj
         7aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7J14h8CQ4Hdlv2EGA4N6V5LG3UgDFLVGj7NWGLwpvk=;
        b=UfZOJgxUhb0ZQvN1PJaSjJjWkzYyZMl7QpVtgqyergIeTG2TeR2WxmOrCXDYGmvuHP
         MxnuyPBDKOeTM9uUbPnw2t3vMVVpRNnbAnUXRjrZrfoI2L/VKAJxTKp/rYydnAqXybsr
         PAgdxoSB+tmkuHreFofoPeiAL/B3o/3e4ARS4DliXwwjp5T4zVPv6NALaYsqDb6DddxG
         UJsCn/hZNKeC1HgJ6rhyf+g5UzARGvC/9MVlDEQWfgcns2/2Zo8U4QS9/okePLbzcHcg
         ytb8qG2a96u+LxCSzytDqScMZf/9pjgv9b+6n0/LoUcE8QafasF4ivV1qtTmlL1UywUg
         2tmg==
X-Gm-Message-State: AGi0PuY3GWDCbQ1W0Fz2SFYIcICvoIfji+rhnDTJqQqWjYdWLE7BZwxX
        VSYYZyktg8jUkMNz5T50GySd
X-Google-Smtp-Source: APiQypJs4NKtooznLYGK1Q0CNpQutjyoho0fhsR6ECi52CWVViTnzjebfvATF+x86awlTWrsVMHT5A==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr5531576plc.52.1589003477838;
        Fri, 08 May 2020 22:51:17 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id u13sm3750292pjb.45.2020.05.08.22.51.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:51:17 -0700 (PDT)
Date:   Sat, 9 May 2020 11:21:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 8/8] bus: mhi: core: Ensure non-zero session or
 sequence ID values are used
Message-ID: <20200509055110.GH5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:48PM -0700, Bhaumik Bhatt wrote:
> While writing any sequence or session identifiers, it is possible that
> the host could write a zero value, whereas only non-zero values should
> be supported writes to those registers. Ensure that the host does not
> write a non-zero value for them and also log them in debug messages. A
> macro is introduced to simplify this check and the existing checks are
> also converted to use this macro.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c     | 15 +++++++--------
>  drivers/bus/mhi/core/internal.h |  1 +
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 80e4d76..0b38014 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -43,10 +43,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
>  		      lower_32_bits(mhi_buf->dma_addr));
>  
>  	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
> -	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
> -
> -	if (unlikely(!sequence_id))
> -		sequence_id = 1;
> +	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
>  
>  	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
>  			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
> @@ -189,7 +186,9 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  		return -EIO;
>  	}
>  
> -	dev_dbg(dev, "Starting AMSS download via BHIe\n");
> +	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
> +	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
> +		sequence_id);
>  	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
>  		      upper_32_bits(mhi_buf->dma_addr));
>  
> @@ -198,7 +197,6 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
>  
>  	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
>  
> -	sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
>  	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
>  			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
>  			    sequence_id);
> @@ -246,14 +244,15 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
>  		goto invalid_pm_state;
>  	}
>  
> -	dev_dbg(dev, "Starting SBL download via BHI\n");
> +	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
> +	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
> +		session_id);
>  	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
>  		      upper_32_bits(dma_addr));
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
>  		      lower_32_bits(dma_addr));
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
> -	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
>  	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
>  	read_unlock_bh(pm_lock);
>  
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 0965ca3..80b32c2 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -452,6 +452,7 @@ enum mhi_pm_state {
>  #define PRIMARY_CMD_RING		0
>  #define MHI_DEV_WAKE_DB			127
>  #define MHI_MAX_MTU			0xffff
> +#define MHI_RANDOM_U32_NONZERO(bmsk)	(prandom_u32_max(bmsk) + 1)
>  
>  enum mhi_er_type {
>  	MHI_ER_TYPE_INVALID = 0x0,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
