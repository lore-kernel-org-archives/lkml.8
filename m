Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66236C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471DD21582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyGHzyzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgEIFsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:48:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA750C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:48:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so5243631pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sefbJeuE9bceWVc5piWZHKKI8lGGlQE1DzhL9x9tEv8=;
        b=CyGHzyzHz1NYt/YbkkRmZ85+ZKZhdv2itwGseGwxD9HA3brvvte10may37D+HiiNPY
         5cHJzkWh/w8s7lY3iCEYbOtnHWFEdlLVTTHXgixJincufMcW8USg7ARoG2xI+4PwmbFx
         LPRKrsWpPKjpMIM5xDMGJKmyATOLw0KkFQs8lYPdtaj35AyMWMQHMVlDFylSmjMa7kv9
         MJm0yrlBBgNwSJu/egj5HW7beXS2pSrnNJslPAzDaU4XV2S+wME1DsMPY0fXpaVMG+jg
         P99Dbwjs6kJW5J/w0rWlXTWlVHbctvEHwe0uoktQ2Phslu/SzdURZ2MvscJ3Zyh/X5qE
         7HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sefbJeuE9bceWVc5piWZHKKI8lGGlQE1DzhL9x9tEv8=;
        b=iQ8pSN9vwiThmCePCE1Ir7Xz2rRlPCu8hnbWrqMkBWyXzNY6htnL8ZqT+lkfOlrICU
         8WhP0GlnEBPfpJ+gBn+Hdu2b2hHsxmtJBZLCB5i/9MJjF0WPjqiO+sEBToxMFVH5RGbS
         4jAiBjDmTJX1/ugASwSxD1sEws6SeozHaUaKLC9MXuZevD5MGMNdIdIrDMy8XOREvnRV
         9EhKvj3kGKKCTmrWcmI9ABbN15eALkL7Vm+0KDKK6j9fNd5JXFIN3YHTYgHZZ+rT6Jse
         Kf67iG4pBpqqh3LNm37JAmwGLf3PWREbO6biSE0s2ERbfSqgmiVs6epNIS4DKDRvUxJ6
         HfKA==
X-Gm-Message-State: AGi0PuYzWFIrrjTb7o/ELoSuLJndZiSCRvjSj/DNOIeSrn+HxnOZMwWE
        LKJlmqkN3ZQwvzyncZDTapCp
X-Google-Smtp-Source: APiQypLVq1jhB2WdfP85ib2n8Zt42eX2/MQ39H3iVKsGeW8xtubnbzzDtke6XwTjC03eW5Ip+9etCA==
X-Received: by 2002:a17:902:70c2:: with SMTP id l2mr5667200plt.112.1589003333226;
        Fri, 08 May 2020 22:48:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id u8sm3742470pjy.16.2020.05.08.22.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:48:52 -0700 (PDT)
Date:   Sat, 9 May 2020 11:18:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 3/8] bus: mhi: core: Add range check for channel id
 received in event ring
Message-ID: <20200509054847.GC5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-4-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-4-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:43PM -0700, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> MHI data completion handler function reads channel id from event
> ring element. Value is under the control of MHI devices and can be
> any value between 0 and 255. In order to prevent out of bound access
> add a bound check against the max channel supported by controller
> and skip processing of that event ring element.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 605640c..30798ec 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -775,9 +775,18 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  		}
>  		case MHI_PKT_TYPE_TX_EVENT:
>  			chan = MHI_TRE_GET_EV_CHID(local_rp);
> -			mhi_chan = &mhi_cntrl->mhi_chan[chan];
> -			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
> -			event_quota--;
> +
> +			WARN_ON(chan >= mhi_cntrl->max_chan);
> +
> +			/*
> +			 * Only process the event ring elements whose channel
> +			 * ID is within the maximum supported range.
> +			 */
> +			if (chan < mhi_cntrl->max_chan) {
> +				mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
> +				event_quota--;
> +			}
>  			break;
>  		default:
>  			dev_err(dev, "Unhandled event type: %d\n", type);
> @@ -820,14 +829,23 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>  
>  		chan = MHI_TRE_GET_EV_CHID(local_rp);
> -		mhi_chan = &mhi_cntrl->mhi_chan[chan];
> -
> -		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
> -			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
> -			event_quota--;
> -		} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
> -			parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
> -			event_quota--;
> +
> +		WARN_ON(chan >= mhi_cntrl->max_chan);
> +
> +		/*
> +		 * Only process the event ring elements whose channel
> +		 * ID is within the maximum supported range.
> +		 */
> +		if (chan < mhi_cntrl->max_chan) {
> +			mhi_chan = &mhi_cntrl->mhi_chan[chan];
> +
> +			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
> +				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
> +				event_quota--;
> +			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
> +				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
> +				event_quota--;
> +			}
>  		}
>  
>  		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
