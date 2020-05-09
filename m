Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0FC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5824924953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNJZQ5HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgEIFrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgEIFrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:47:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F972C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:47:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1675341plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/yoZMw/csZG9378ylgmFfEOD6Yssweon0M3fBvHbHK4=;
        b=FNJZQ5HZUaPxE28SnsrTEl2DDogWCrWl9WUp4pg/NzaHdJ1JkRCdeBsv+l2H4HQL1o
         jnO8mKbCWBKFfFNlCBQX2I3ziQUl/iyvfXMixa6dBDV6MrMCK7LSjCipIUPp/1Za0t6n
         ApFcHSvRv8mE/SAcCqYZtrdgC1Yru800fYtz9mPLo6YCIYjsTxFRiMtqrngmOFiX5e1V
         yKWj+jQbbicTbR013B4VF/4vUf1wgmRENBPQpoGu2zppXsy9ry9l3OEnto5tI4P3d+Uy
         FGfbvtF7zg4kPbn7fTxtbh7HyY5FmezZsTLJ/WmQ93WMMnj2ZfU8ISKjIq5fYvmN0OrU
         S7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/yoZMw/csZG9378ylgmFfEOD6Yssweon0M3fBvHbHK4=;
        b=SZcLIWwwf+gmADwptQl3cVH3UQoKM+sy0deR6dSEbh8OJ7KPDnaGSBae2YFQxWGyt4
         XECy1VuvitLJQL1cK5qYaAUMLqIEnq73rPIp6qA5ztfPSiCXxmAEO3+lf88Qe1blAuOj
         e0n/+rmhlRwgujonvczFiagwFgIgUpXqXMfoees5B0f+Rd2S8AsPgkk0qWydv9Bnwmlh
         mTyJ9U2iDvC0dGP0W9//qFLofw9TQ/p7MWmQL4y0CBXspK7eQMSBLulzYv+A4iYU9EbO
         coH7FUrWerbtGy0m28S1+6QFxTP09wYGdNQuGpSwp5mBEDYegT54REQ9rpMn2ahqifYC
         HhJA==
X-Gm-Message-State: AGi0PuajOilxl7lOJKvdvOUrSDbEDqMihcLUrprTaowZiqX2eNxjUeHU
        6vywdYfJ+ZpLhulIzsYAAQga
X-Google-Smtp-Source: APiQypLSjkRRfbp1wcjhaiRd24/GPOqPVbwvJhnhSiERFBaJxN6ILJXzKKWzI1Yz0T5GgpEhyDz0Pw==
X-Received: by 2002:a17:90a:9f92:: with SMTP id o18mr9836413pjp.180.1589003254513;
        Fri, 08 May 2020 22:47:34 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e0c:55d2:2cb4:da01:ad1e:6ad9])
        by smtp.gmail.com with ESMTPSA id gv24sm3793304pjb.6.2020.05.08.22.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 22:47:33 -0700 (PDT)
Date:   Sat, 9 May 2020 11:17:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org
Subject: Re: [PATCH v7 2/8] bus: mhi: core: Cache intmod from mhi event to
 mhi channel
Message-ID: <20200509054727.GB5845@Mani-XPS-13-9360>
References: <1588991208-26928-1-git-send-email-bbhatt@codeaurora.org>
 <1588991208-26928-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588991208-26928-3-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:26:42PM -0700, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> Driver is using zero initialized intmod value from mhi channel when
> configuring TRE for bei field. This prevents interrupt moderation to
> take effect in case it is supported by an event ring. Fix this by
> copying intmod value from associated event ring to mhi channel upon
> registering mhi controller.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index eb2ab05..1a93d24 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -863,6 +863,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  		mutex_init(&mhi_chan->mutex);
>  		init_completion(&mhi_chan->completion);
>  		rwlock_init(&mhi_chan->lock);
> +
> +		/* used in setting bei field of TRE */
> +		mhi_event = &mhi_cntrl->mhi_event[mhi_chan->er_index];
> +		mhi_chan->intmod = mhi_event->intmod;
>  	}
>  
>  	if (mhi_cntrl->bounce_buf) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
