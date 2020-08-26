Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5BB2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598425168;
	bh=Ka1kAaipWuTwjoqlztGK2uAGclVuJ9Iz2rdApaYaelY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wWFcX6P1BWtHXmvYASBah2rw6+wZuRJ6p7sCebBYVscJvBl8S3QCHaDv80wl8XqFv
	 TjnKWywGzUn7MVNVbZjosL3acgEOpPRMr5Kgxuzq6l+ga4v0eG7Rs4EINTB5zULOms
	 yb4QKsQnvvu9DcDRGiertm4IhaWxpvpHvwG/v224=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHZG70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 02:59:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36266 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgHZG7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:59:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id z9so649202wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 23:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LsFhoOeroVCTGv0q4/82tJt3Y+47dDgfCwFCYURdTmM=;
        b=d5niNRXm3RiAzHBuiur6oWXheJa7TpEPWwY9fnUKqZDcX9tCJlSrpBFgM3nBHZt2cN
         Jw07/TiQV8fM+RMS6icwo6XWX2OZyrFsmwPM701X5j74lnPBf0Ldum1t5Z5aswO9ZwMe
         5eewE031ETsEGwRBH0kxLDW9Dz7IAzd8TWIViIhV071jkOfxztMQeMELEjl9QbdGrnhh
         0qcj808gN8L8XeI+nIVOEe36jJLHAv0+13gpLFLp0E6MHulWdcrQSUDd20P8eGJlKylE
         +oc45T3qEp3OmPo7PXYOnU+qQMkaCelggvhn4hiAD7ABFuJYzeeJmVjAan9vQWA+Ugk/
         4L+g==
X-Gm-Message-State: AOAM532nOMUw0VVFnemSYpkj+A4JH2TLEQSE9Zxhu4v+3DcChojBN1a1
        286B9nuC4QunYAqqJo5H0r3kacQ7rZk=
X-Google-Smtp-Source: ABdhPJz18WY6fjuZBOTqnKg+vFWYIxyaZ+BiKJL8zvZ3tuKTUX34Hoacl/uxam8wJYFWVeLxXgXVGw==
X-Received: by 2002:a1c:a70c:: with SMTP id q12mr5542296wme.89.1598425163265;
        Tue, 25 Aug 2020 23:59:23 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id q5sm3565928wrp.60.2020.08.25.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 23:59:22 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:59:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 2/9] extcon: extcon-ptn5150: Switch to GENMASK() for
 VBUS detection macro
Message-ID: <20200826065920.GB12271@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-3-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:20PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to GENMASK() for VBUS detection macro.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

This is too simple change, should be squashed with 1, 3, 4 and 5.

There is no point to split each change a define to use BIT or GENMASK.

Best regards,
Krzysztof

> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 5d9a8767646b..c816a6c1e05c 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -42,9 +42,7 @@ enum ptn5150_reg {
>  #define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
>  	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
>  
> -#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
> -#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
> -	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
> +#define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
>  
>  #define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
>  #define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
> @@ -130,9 +128,8 @@ static void ptn5150_irq_work(struct work_struct *work)
>  			case PTN5150_UFP_ATTACHED:
>  				extcon_set_state_sync(info->edev, EXTCON_USB,
>  						false);
> -				vbus = ((reg_data &
> -					PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
> -					PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
> +				vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION,
> +						 reg_data);
>  				if (vbus)
>  					gpiod_set_value(info->vbus_gpiod, 0);
>  				else
> -- 
> 2.11.0
> 
