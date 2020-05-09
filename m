Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9739C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A739521582
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWpBbfDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgEIFtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:49:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC692C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:49:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so1667247plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UTsYNNg6/ImkBFmD+Mx+o8hefWjZHqjjHqjvwNd6AaI=;
        b=KWpBbfDNThXu0samEeWM29vOiWvpu8bLxOq8vtogPK4chc1jyMzdaIKh2bH3uXnPOJ
         O1/Z9EivVp8xAYBnw92K8gKiR9Jx97wf7m86eWMtdj91DMsdiV41QkFXwkfpzmaoG0iL
         ox+ZjcuLM4UJegbJ67vEC8n/GIV3Ilkq5ptfOAnRptAjC94Wk5ATFS0VzKiNz2PtaRtw
         XNtQt0bVmYUaeVm7KvwzHY3xEzVrCgHVK5xxmk1QlkhLJt7+5XwK9+JfT3BsRoEet2H4
         zPYFvlGMT73gmKk7Udha74SQogviTkysjoKmNK9EtzzRumTgUD0oWPr+84HkXuIPLPVr
         r7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UTsYNNg6/ImkBFmD+Mx+o8hefWjZHqjjHqjvwNd6AaI=;
        b=Bk7x8AAy3i5ryVlDtNohxIKe////4xf8g3vr4PgIFq8FjwjeC403AX9M7Xra+JR26K
         Mv74AXGpV9D7Y5OiSM4QvdC5dEN7kDwT+8cJrJliHKKWWyUMBaRsk5CUhbSdaWi7pEmy
         twCxt/6+G/rN0q1mrefk89kTDt3zM+eobGeZU/O6dUTgb8n5f/imp0KxMlhbWaJbdKq7
         sTJXIFAVoYQuweSvJdC0eCilWIz2uQp/F7MqLsiPIke43nbl0zuiXNdgd91C+/o5WqRJ
         14hdAg5MMBmrv+7MknhKj0TMcbhiTeMJR+S8BGTQLwwfpLNWdI9YdhGpqAgdc5B26Vmy
         LILQ==
X-Gm-Message-State: AGi0PubXBN/Q7hRyKwhY9p8zGSZYVpxbnCvCGiGisbtGRjVNpeA00k8J
        MRPPYf3xxqn5YVQiY+rNBmkx
X-Google-Smtp-Source: APiQypLLc1C6DFA08CoY4IdmL7MfLAuWYGg5shRu8jEKGB2/9SEa/nFSEdsrrOtjaYE1m/feRk2kzA==
X-Received: by 2002:a17:90a:8c9:: with SMTP id 9mr9910633pjn.183.1589003358252;
        Fri, 08 May 2020 22:49:18 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id gv7sm3824144pjb.16.2020.05.08.22.49.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:49:17 -0700 (PDT)
Date:   Sat, 9 May 2020 11:19:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 4/8] bus: mhi: core: Read transfer length from an
 event properly
Message-ID: <20200509054911.GD5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:44PM -0700, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> When MHI Driver receives an EOT event, it reads xfer_len from the
> event in the last TRE. The value is under control of the MHI device
> and never validated by Host MHI driver. The value should never be
> larger than the real size of the buffer but a malicious device can
> set the value 0xFFFF as maximum. This causes driver to memory
> overflow (both read or write). Fix this issue by reading minimum of
> transfer length from event and the buffer length provided.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 30798ec..6a80666 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -514,7 +514,10 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>  				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
>  
>  			result.buf_addr = buf_info->cb_buf;
> -			result.bytes_xferd = xfer_len;
> +
> +			/* truncate to buf len if xfer_len is larger */
> +			result.bytes_xferd =
> +				min_t(u16, xfer_len, buf_info->len);
>  			mhi_del_ring_element(mhi_cntrl, buf_ring);
>  			mhi_del_ring_element(mhi_cntrl, tre_ring);
>  			local_rp = tre_ring->rp;
> @@ -598,7 +601,9 @@ static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
>  
>  	result.transaction_status = (ev_code == MHI_EV_CC_OVERFLOW) ?
>  		-EOVERFLOW : 0;
> -	result.bytes_xferd = xfer_len;
> +
> +	/* truncate to buf len if xfer_len is larger */
> +	result.bytes_xferd = min_t(u16, xfer_len, buf_info->len);
>  	result.buf_addr = buf_info->cb_buf;
>  	result.dir = mhi_chan->dir;
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
