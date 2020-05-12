Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B0C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D6220752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMRbs0PH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgELG5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725814AbgELG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:57:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7132DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:57:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x10so4990651plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xESt8YrdF5zA7OhTRZwQ+JJUIra4yQxemc2O867l028=;
        b=VMRbs0PHQWvOftRxUJW++79cw5PG5idWx50PkcZn+aKCIc29PQ60fCbNcQgFUNVVqk
         sdyIhki9WgY4wPnBnzXgJcOw69bSpnxwWWVQzpxPmYKuGEhSlR0vF2bnH2H0AGK7c06I
         d5X/wrA1QU/fshcMRO+pBIePVhV1NEO6W69zMuA3jj/U5N5DC7yckl3AGb4nZigsWzwP
         tT38ovAl+wpb68X/jPpChDDVu8QUBI3kaDX6tdm4lMQM+PZDWA3eKYeoLERgcPBFrDDG
         fLAQHTtX5B9ZatTMWnxQ6upKLw5az7B7ZJ5Pyg9lB+a2ZZ4fXfU7MiAimZurPAXbPiz2
         utWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xESt8YrdF5zA7OhTRZwQ+JJUIra4yQxemc2O867l028=;
        b=Bbi2LdmEwQAetuOK1+pWyacVgNaieXmi1rzoodBxxbDU7+rW6gTHPuxgci/MYAWSRP
         9D/k/VfUBbrON76Ph7pgdDqNh+4rBIcZXvNo9fpd2bE5a1wQcveSH1gopNjUz1prCKuF
         MMRUooXM3y6hGwKFduO3cA3IS+tCjDPKCErkHKHlTWSJGmSY+DeaeIGl9h5IQqkAs3GW
         Br8h8C0TJtqjRgF2y+PIdYhC/YlgxXNw4rT4PDF+aJtQ5rc69VQWIqGzaqxpqvvo6t47
         VOQst08WArltsOtfWWKdCJ2fuif3cKsuS5ZAuJYQetdtWvD73/3C0tRcjKBV4GW0uJoJ
         o2xQ==
X-Gm-Message-State: AGi0PuZUd+6Go/hJf/y5SuR0MaK/Mx4dHinB/nzcSTvMY9eQf2FIdjXA
        lnU0irWSFRwsYi7QVLtRCHpU
X-Google-Smtp-Source: APiQypIdRl4nB/2mZFYqstDYIZKg6KAQai2y8tkp/VYwtSTyd5EaZqNMdtCSHUciPW9Ml8VDxxqTwg==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr19040031plb.2.1589266640847;
        Mon, 11 May 2020 23:57:20 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id n23sm11709667pjq.18.2020.05.11.23.57.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:57:20 -0700 (PDT)
Date:   Tue, 12 May 2020 12:27:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 5/5] bus: mhi: core: Handle write lock properly in
 mhi_pm_m0_transition
Message-ID: <20200512065715.GG4928@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-6-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-6-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:09PM -0700, Hemant Kumar wrote:
> Take write lock only to protect db_mode member of mhi channel.
> This allows rest of the mhi channels to just take read lock which
> fine grains the locking. It prevents channel readers to starve if
> they try to enter critical section after a writer.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 345f197..de5abb2 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -288,14 +288,18 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
>  	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
>  		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
>  
> -		write_lock_irq(&mhi_chan->lock);
> -		if (mhi_chan->db_cfg.reset_req)
> +		if (mhi_chan->db_cfg.reset_req) {
> +			write_lock_irq(&mhi_chan->lock);
>  			mhi_chan->db_cfg.db_mode = true;
> +			write_unlock_irq(&mhi_chan->lock);
> +		}
> +
> +		read_lock_irq(&mhi_chan->lock);
>  
>  		/* Only ring DB if ring is not empty */
>  		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
>  			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
> -		write_unlock_irq(&mhi_chan->lock);
> +		read_unlock_irq(&mhi_chan->lock);
>  	}
>  
>  	mhi_cntrl->wake_put(mhi_cntrl, false);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
