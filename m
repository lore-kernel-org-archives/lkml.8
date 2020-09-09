Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216A9208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Va+sTT+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIGY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:24:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E64C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 23:24:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so1119471wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QwOgiz0la2lW+MPNuLPbMDFXBufd/C6oqQTrDXatv7U=;
        b=Va+sTT+WzIFWRx/K5Lj5vHbarDK1lmhCqQ1T6l/xcmeehc80itY01O2+3myDiFjgGy
         XinVZn7Cwck54Ns+eMvRgdfuUmE5huycCuonomHBMqwR4bDKgwzl71Lc+76HDhrc7g7E
         JLd1wIYLFo9pt5yf0QyCc+07vS3Q642anLDuBb4kFvyCv5MNwAVgKSU2l/KPuzUO1fsR
         bO4COfZNyLeqqpOap7Mu5GFGQDEiheHrESVGoAx+b8URmY0if5r2yqsUf7aLUVMzX1Cd
         xzhJUVzdf8q7gkp9FDRKaJBBkuFoxvAy952eyphcriaudfkwPMp2kb56NIRYHxxKC7xZ
         CRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QwOgiz0la2lW+MPNuLPbMDFXBufd/C6oqQTrDXatv7U=;
        b=TjAnwVyHhh6nfVd8Ewa1VDlzljvt64sL51t8MB6yCxP8nTOuHrhDP0ocNajmgCitZJ
         H6KFAKjCjT10xwbgA9UGiiZ1NxLqfAuEvsB9IXeO6GdeBP6N4bREGAK4Q5BtIuxM1w5T
         6SDIfrNUaYeLxb7/RZdcEp3ZEQGylTt+a9MbnxkEWQoYE4XKtLm+MQw6QA1He7j5btT0
         kG0W1RAGCZZP//BSsy2SgG9U8OoXDzNPG9RB9sjXLIiCKjTUGl68TlIWMK99/FTigZRE
         lLE9bFQbP552ojA8hjAMZA2OiJ945n2AHcc5m4qtOgcH0e3ZopAdt2sIvLN9nkdkREdQ
         2WmQ==
X-Gm-Message-State: AOAM532kpZyu79uaVv4+1zgFPum7JcAZQIhgRZtcyXvHtgF2PtOsxwkC
        nG+pi4BWCMMocFM9/LSs3OgUIw==
X-Google-Smtp-Source: ABdhPJxQ/e6wXVD4JfcDlhllnc42oPWziLCTzGOT5XcSIPehHnpUeCw3YOjcVnxlpKlXB+PBXplP9g==
X-Received: by 2002:a1c:f018:: with SMTP id a24mr1817860wmb.7.1599632665279;
        Tue, 08 Sep 2020 23:24:25 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id k24sm2323434wmj.19.2020.09.08.23.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 23:24:24 -0700 (PDT)
Date:   Wed, 9 Sep 2020 07:24:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH v2] mailbox: sti: fix struct description warnings
Message-ID: <20200909062423.GX4400@dell>
References: <20200909051219.4531-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909051219.4531-1-avolmat@me.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020, Alain Volmat wrote:

> Fix formating of struct description to avoid warning highlighted
> by W=1 compilation.

Apologies for not mentioning this before, but it would be nice to have
the warning quoted in the commit message.

> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: fixes tag removed
> 
>  drivers/mailbox/mailbox-sti.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The patch itself looks fine however:

Reviewed-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
> index 2baf69a0b81c..0f2bc09c364d 100644
> --- a/drivers/mailbox/mailbox-sti.c
> +++ b/drivers/mailbox/mailbox-sti.c
> @@ -36,7 +36,7 @@
>  #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
>  
>  /**
> - * STi Mailbox device data
> + * struct sti_mbox_device - STi Mailbox device data
>   *
>   * An IP Mailbox is currently composed of 4 instances
>   * Each instance is currently composed of 32 channels
> @@ -60,7 +60,7 @@ struct sti_mbox_device {
>  };
>  
>  /**
> - * STi Mailbox platform specific configuration
> + * struct sti_mbox_pdata - STi Mailbox platform specific configuration
>   *
>   * @num_inst:	Maximum number of instances in one HW Mailbox
>   * @num_chan:	Maximum number of channel per instance
> @@ -71,7 +71,7 @@ struct sti_mbox_pdata {
>  };
>  
>  /**
> - * STi Mailbox allocated channel information
> + * struct sti_channel - STi Mailbox allocated channel information
>   *
>   * @mdev:	Pointer to parent Mailbox device
>   * @instance:	Instance number channel resides in

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
