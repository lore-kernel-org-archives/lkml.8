Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3993C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA76F20825
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598425338;
	bh=M5Et+sNUR2nj/RmUbPme9QTKTvS/vWmlIg/6Kw079BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AfHYuxiC3gO38Yn7S5NWq7faX2QEFQ+DpzM8ooNydrF7lQhOCiDJb5znRN1aS+qb0
	 l5tuQSrOZYPHqgEXdDfQIIPQu4ZJ2NTx4tW/YRpOncvrO90hgMxgIMTbOn6kGmtEfA
	 OduL2mUE9JaXPHuYRA+02wggmkijBgyYh+KqfcPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHZHCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:02:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44414 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgHZHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:00:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id c15so620126wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 00:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RHWmtyQkL2Gd7DQBgRTCb7zJvVv0AbfFavH+YrU+dDE=;
        b=k94ZV2KI5xbc/l5DBwfp4ArwcBaJJqFNQ5rMqDeBm7JqsWetwF8gKA4I90Ez3MYHks
         weWQeygbA6GQp+krrJcOLP9gRxvOZDfPDLc9diqC28Y3/6bypvYVZki9qr5jjykIVGaF
         qWkoQQ1zVQNVY5fGPVm7YSxx/g5ZYliv3ITl5aiaGVUudSZKl3C89WrqzY8y6Jt2bSNI
         OCTi2St4hPoABFCw8GjOB2RfGKYQE+tWFE5FLvyadVAL5v/U45P7cZPQ03B9RDz1xcMn
         2stYjr3u7Ry3VLKCfTZcx3PeRorcCBTwyynrVfdCgJaDx81IF+ovrYzx2H6U9HqNGWPL
         pdEg==
X-Gm-Message-State: AOAM532n54Dtt4CME9nLECNmfshJRLubZu1x80fHXXouZx7YXPIUxIot
        6WUGa9iUMvQ54Znr4UA81Oc=
X-Google-Smtp-Source: ABdhPJywWnmjvr7ryXpthx0BBDXvxzqXt1J69LWiqXq4Np8F+Hf4lfRnLQwtvfows6TLUo07slvldA==
X-Received: by 2002:adf:f289:: with SMTP id k9mr14252752wro.203.1598425238303;
        Wed, 26 Aug 2020 00:00:38 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id z6sm3079983wml.41.2020.08.26.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 00:00:37 -0700 (PDT)
Date:   Wed, 26 Aug 2020 09:00:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 5/9] extcon: extcon-ptn5150: Switch to GENMASK() for
 port attachment macro
Message-ID: <20200826070035.GE12271@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-6-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818065727.50520-6-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:57:23PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to GENMASK() macro for the port attachment.

Squash it.

Best regards,
Krzysztof

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 50fff148b772..31b7cbf1551d 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -38,9 +38,7 @@ enum ptn5150_reg {
>  #define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
>  #define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
>  
> -#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
> -#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
> -	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
> +#define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
>  
>  #define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
>  
> @@ -108,9 +106,8 @@ static void ptn5150_irq_work(struct work_struct *work)
>  			unsigned int port_status;
>  			unsigned int vbus;
>  
> -			port_status = ((reg_data &
> -					PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
> -					PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
> +			port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT,
> +						reg_data);
>  
>  			switch (port_status) {
>  			case PTN5150_DFP_ATTACHED:
> -- 
> 2.11.0
> 
