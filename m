Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2985720885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWxatR3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGDOfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGDOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:35:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67674C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 07:35:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc15so5457162pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldDzD6j1Ghnm14TJPHt+NFHPYq/kJXWHkRtC3KR9Jqo=;
        b=lWxatR3CydK82tXUBLsIuuBMcL/c3ZNFYVQEczjmDaezp/1m6I/njfL94zsnxIkYiJ
         WwLVgCeRj9qBIgKVAgMJC6TZzNg7eQeG7AMhJSENg992QjpdrXSAB5b0u0Bw/NGryice
         QLSuEiQbbsv6iV3HSAJNAs8Nsr1NhaWvA0pSfjBqjOYENyg9oUnGRrT9jR7JkuMpy/V5
         A9njRJa4IyJ9TV+RcrIURMDfLMC99ZvX1XzxwUPP9oHlmIKR/oZL0zxqeDLrgSbf/0wO
         Gy4SMYWSMNGX55lKdJwvKwFeTA4r8I360YUOXLIWvMJy2E5sPBno3oDNhCysWWcLNqQz
         GzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldDzD6j1Ghnm14TJPHt+NFHPYq/kJXWHkRtC3KR9Jqo=;
        b=pJW5mjwz/PSQFNAXIqQOsUSjwKT8I1NDeud9XLQp8iLhcK/Srgfv1yZRqBqsX2MaBg
         0lmalrf4jFkumnj5hM9of79i5EKDDru3CE/CvUyX7dukHP+Jj49WeJqn2lfZA3WnRFIC
         uaX5WV0DErAqupUwYCD7reSnb+CF0i1mlkpjGGBxcby3XAFP02E/jyuPQC6PcagSv0kr
         G1sEtRXr2rKoHoCuS3d0quj9ly7a5v5UliyNhFWsd1klXt9aaQPLW0r2klOfSaEo6qba
         PmwKmAIW1kuX0xOzJaWMMJpTnrAXGnQ00iBNYTQzsK5EMb+lbkRAUiJsZgcmSwQ3DXLG
         Q4wg==
X-Gm-Message-State: AOAM533RC+bYQZfbb5lOWOPZ6XlCzY+JsFXq40YQdXkDyoDlvN7fZEyo
        vUYFgaXq99SOR/zidj1ndS+D
X-Google-Smtp-Source: ABdhPJysN8fh7LoTfPGTTiQj5wIK/aKwxWQ7RwVppIPe90kMuwiMighz1Ms86yre6kmUCvW+mtRF3Q==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr42982907pjb.106.1593873350593;
        Sat, 04 Jul 2020 07:35:50 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:680:29c6:d74:dc5c:e13f:c458])
        by smtp.gmail.com with ESMTPSA id s22sm14371481pgv.43.2020.07.04.07.35.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 07:35:49 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:05:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] bus: mhi: core: Abort suspends due to outgoing
 pending packets
Message-ID: <20200704143544.GB3066@Mani-XPS-13-9360>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
 <1593448782-8385-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593448782-8385-3-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:35AM -0700, Bhaumik Bhatt wrote:
> Add the missing check to abort suspends if a client has pending outgoing
> packets to send to the device. This allows better utilization of the MHI
> bus wherein clients on the host are not left waiting for longer suspend
> or resume cycles to finish for data transfers.
> 

Just one nitpick: Please always use the terms 'client drivers' referring to the
MHI client drivers in the kernel and 'client devices' referring to the physical
MHI client devices. The term 'client' creates ambiguity.

> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 7960980..661d704 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -686,7 +686,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
>  		return -EIO;
>  
>  	/* Return busy if there are any pending resources */
> -	if (atomic_read(&mhi_cntrl->dev_wake))
> +	if (atomic_read(&mhi_cntrl->dev_wake) ||
> +	    atomic_read(&mhi_cntrl->pending_pkts))
>  		return -EBUSY;
>  
>  	/* Take MHI out of M2 state */
> @@ -712,7 +713,8 @@ int mhi_pm_suspend(struct mhi_controller *mhi_cntrl)
>  
>  	write_lock_irq(&mhi_cntrl->pm_lock);
>  
> -	if (atomic_read(&mhi_cntrl->dev_wake)) {
> +	if (atomic_read(&mhi_cntrl->dev_wake) ||
> +	    atomic_read(&mhi_cntrl->pending_pkts)) {
>  		write_unlock_irq(&mhi_cntrl->pm_lock);
>  		return -EBUSY;
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
