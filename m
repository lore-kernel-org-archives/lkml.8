Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D00C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B9A2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNys3f76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgGPDBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgGPDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:01:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15059C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:01:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so3006574pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GPQxbwTXWhN79V6vWRx99MB+RvD215vLIPI8oltDITs=;
        b=QNys3f76fO3ArkQ+U5VKCzEsVFzThuhz6zGESkCJzCWv48Hn20rX6sbrqvMiXZmH0h
         8emf3+hAUEec4VwlSjakOG0ZUQPpWEeV9RtlnZANPtzBQS6jsTwfcZfrgODHToJBAU+Z
         QqZeqmpnSva1PaQhCQQpBA09o98pUGKIp+fZPLuk8pg3PaEktGanlA946ErEkY85CTqh
         XtBI9FpHu75vBCj+mchEeC+5UUJKIu1ZxDJbfnJLXhnRvAhMtuvdM2RNyyKiAYkkNUG7
         u1hBHZ+lNeypvSgt3AdCzOm6aj27OjOqfmedqtH96zkcJAzS+QhbYYy1UgU7zy8VpdVw
         duAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPQxbwTXWhN79V6vWRx99MB+RvD215vLIPI8oltDITs=;
        b=Ll9QW/mfg2pl5uQj4GOiBEk+Y6bSnvWw5Ccys5tbKNStXS/JrrtGYlyYF0ZRXl3VUn
         old7jTm0+HnQHCRKuYJppwXqjsCuCB62P8af0j1KJLiMROulQgFdNsg/u6ZP2zmq2g1t
         gljZTpMtuAzQt+KcSNftpaWchKjjoQ7QOSBh4z+HAO+FTlDzW9p2aMh4p0dH6de6JG/E
         5HRu7miM49LQj9BT/vAnzad2sDXd4VKJD19QIYrRbFtzSWygA/W+pw7dP0pLOO60yJpn
         nWZezD1j9po4Qe5nB/xCZCv/Z6F3lXrRpLz1InjlnqPAHxqb+w9XegneI8jqE1nYNg5Z
         qkEg==
X-Gm-Message-State: AOAM5316t85ko+BRvbzNR1HPu99GcONeOgZ0skVy08Arz8DmKYnJy93G
        X5TL851UmWIFFyntbxDEY5w7QDHpGw==
X-Google-Smtp-Source: ABdhPJyzi/egeBx/Sr3rQArvWkCqTJA764GFCwXdcJsxZl69YGlOGD2d4Qqo/A7HCaa3I213BOGucg==
X-Received: by 2002:a62:6305:: with SMTP id x5mr1903199pfb.81.1594868490574;
        Wed, 15 Jul 2020 20:01:30 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d89:fed1:9157:c271:c363:4849])
        by smtp.gmail.com with ESMTPSA id l16sm3224414pff.167.2020.07.15.20.01.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 20:01:30 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:31:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] mhi: fix doubled words and struct image_info kernel-doc
Message-ID: <20200716030124.GB3271@Mani-XPS-13-9360>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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
