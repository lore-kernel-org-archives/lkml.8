Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D35C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A1C20775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijalJuL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGPDLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgGPDLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:11:30 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46112C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:11:30 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so4111389pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QLoWBC0BJ34kcTABjgpHRAC9g5IOexIa4Kkz6/GXqs8=;
        b=ijalJuL9PGxOrIsrIUwPgLKAwFP9kmsjcYbHNxc+aaEXHPHVEkxRH3D1TxMn6YtWdc
         fJ59p1EBxUmbvlDi6KkjStMofhrvt+csKuX+vs4IRMq89BiKJpFo1Pv+VCZbxIVqSVyt
         1MR3LlWOesnrBBGsGbCIPxBAl385jEJ5PGRYdY9yjUur0FWod5qyRE2EsdVO0mtkdR1y
         EGuy5zC+fPrlDlnH57JJKjUi6l3pS7HtepmEuMBQWrnSAw5QCRELuXsqUaVTdnvNoIrl
         5yPDdkvrtTlungl+Ra/JF7QjuVjtZSSa+aq10gZtIzEzqUspziaFnWYDMwOO3CAOQwTm
         a3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLoWBC0BJ34kcTABjgpHRAC9g5IOexIa4Kkz6/GXqs8=;
        b=V4c0vYyoZP5kXvAreue2v5VAyA+5OV38pX1MvweNgyEAd9lrF/Dd/MA9m8k5BETDTH
         FfgC8KchPdJRqfXnKT5enR/3GAeIFzHE30MiunKtZ/+RlBz/ZjJqDRFKQy0ayvnxxXpZ
         JEal3d4MtIgtg1/ap43Vd1LYeYFviePXYx9ZFt8V856Bfq8g9ommZjzlpuSWAdPRos9l
         2ruIBW9M56R6UmhCuSDB7Bie0nTo3XTG57n78RilnVxv2AGcwVgZoyMShwR/g6XaWJJM
         Ij485VkvzP4vuBPVFyMk0RS7wI2xlsLl7lPyVxZSvO6vG6jkn6mK2e8TcAsfZvd/mSDv
         EWjg==
X-Gm-Message-State: AOAM530sOB5xp8AYGrb589Bg4lljvbBi7/HR+9Z2ORUyarAipYia4psU
        gfKywzrK+xRpCis6AgqirMk5
X-Google-Smtp-Source: ABdhPJx8qzuAcYQYs9VvKUu35phOkt2EJG4oIBl/MnxUezG+NMCCfUn3ns+lQahCvc6jA5gHENh/oA==
X-Received: by 2002:a62:e712:: with SMTP id s18mr1936293pfh.224.1594869089523;
        Wed, 15 Jul 2020 20:11:29 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d89:fed1:9157:c271:c363:4849])
        by smtp.gmail.com with ESMTPSA id az13sm3165742pjb.34.2020.07.15.20.11.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 20:11:28 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:41:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] mhi: fix doubled words and struct image_info kernel-doc
Message-ID: <20200716031124.GC3271@Mani-XPS-13-9360>
References: <cab64692-31f6-5a2b-a540-aa434d35f9a9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cab64692-31f6-5a2b-a540-aa434d35f9a9@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:29:32PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop doubled word "table" in kernel-doc.
> Fix syntax for the kernel-doc notation for struct image_info.
> Note that the bhi_vec field is private and not part of the kernel-doc.
> 
> Drop doubled word "device" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to mhi-next!

Thanks,
Mani

> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Hemant Kumar <hemantk@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  include/linux/mhi.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/mhi.h
> +++ linux-next-20200714/include/linux/mhi.h
> @@ -85,13 +85,15 @@ enum mhi_ch_type {
>  };
>  
>  /**
> - * struct image_info - Firmware and RDDM table table
> - * @mhi_buf - Buffer for firmware and RDDM table
> - * @entries - # of entries in table
> + * struct image_info - Firmware and RDDM table
> + * @mhi_buf: Buffer for firmware and RDDM table
> + * @entries: # of entries in table
>   */
>  struct image_info {
>  	struct mhi_buf *mhi_buf;
> +	/* private: from internal.h */
>  	struct bhi_vec_entry *bhi_vec;
> +	/* public: */
>  	u32 entries;
>  };
>  
> @@ -593,7 +595,7 @@ int mhi_async_power_up(struct mhi_contro
>  
>  /**
>   * mhi_sync_power_up - Start MHI power up sequence and wait till the device
> - *                     device enters valid EE state
> + *                     enters valid EE state
>   * @mhi_cntrl: MHI controller
>   */
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
> 
