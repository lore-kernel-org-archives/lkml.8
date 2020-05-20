Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E72C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894812065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6WCsxra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgETQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:44:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F5C061A0E;
        Wed, 20 May 2020 09:44:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so3123344wmc.5;
        Wed, 20 May 2020 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3jCtfz7Ic5XqdCt18jlvYpCTz0c7NtD54EbrgW/fLek=;
        b=e6WCsxraezDoLoAyCmCttY3zRFoX6sEkeD3cLMVBHcq5EdGuKD0yB/H4VQcn50JjJC
         TfqzlXYDug3yTT+a5wk5I178EDxYoo/rb5B/JQcbsYg2bkkcLUWa8VkkJ2ADg5b2JMG4
         khF+d62nXmIcNLz0Uky9ThDqflOL4iWUfQEw8yW0V0GJ29RS9aO6Wq+qPkY+EdWx4TH6
         qKcQU26TP1FV3i2WlMcXB36CoN6zPxDqGYkM19phZ2aQ9vnokL426ouVQia3CcNf5aw4
         Y5G/sgnsG3M7Fqjt0Spy7gfdgWWjlNaGT91TLZHNFKJnX+LTJYzbNOuZGfKLoDDNpJ0e
         UwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3jCtfz7Ic5XqdCt18jlvYpCTz0c7NtD54EbrgW/fLek=;
        b=MEMlXyhAc2O+z09mKvQg1TQ9NwgsyvYYMwT6s4sLFUyD7qLyFbyU2PNOSafB4Qpanc
         ZNnZvXwWqgrv/iv2lw4Yr7QbBvqZl+dgIFhIoPwunSSL+l002guTEqQtANrncyNNXCQ0
         i/iGr7x+vSHPnf0X6nrWCaP3YeABGCMddazMQwoDiUB+r44bppLLFirNA61n+4Jk1Apx
         XrMRP3htGr9Bfr/eOgIT5TskUvSKof4CDG7bCL5ksPRXdQV+bfBb897BTvb4Yg8AahkL
         N4BUI+iydBGZzgmRucMtgh4ofYl5rZCWOiKebJpxujcOpcuG4qzIDugpTf4EFFNbmnyt
         Bc2g==
X-Gm-Message-State: AOAM531rpRNZLHot9maeZi2whqvPuv1StkRFDqxF8vVZNVpFbCaH5ev3
        zak2iHtqcamOyoa1LBJ+s+ErUBJO
X-Google-Smtp-Source: ABdhPJw/gfgIM9TbfRNf1ZQUpGl1c44L8viKUblBw+jRA59LyVatuKwFObnWJY8z+jjTg6MgwkRq1Q==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr5715413wmg.105.1589993053745;
        Wed, 20 May 2020 09:44:13 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id v5sm3381242wrr.93.2020.05.20.09.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:44:13 -0700 (PDT)
Message-ID: <5f5b6a08acc94089caf3f9969579a45c4744c7b3.camel@gmail.com>
Subject: Re: [PATCH] w1_therm: Free the correct variable
From:   Akira shimahara <akira215corp@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Wed, 20 May 2020 18:44:11 +0200
In-Reply-To: <20200520120019.GA172354@mwanda>
References: <20200520120019.GA172354@mwanda>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mercredi 20 mai 2020 à 15:00 +0300, Dan Carpenter a écrit :
> The problem is that we change "p_args" to point to the middle of the
> string so when we free it at the end of the function it's not freeing
> the same pointer that we originally allocated.
> 
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis.  I guess it must not cause too much of a problem
> at run time?
> 
>  drivers/w1/slaves/w1_therm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index cc4b88056b33..a6c85e486671 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -1526,8 +1526,9 @@ static ssize_t alarms_store(struct device *device,
>  	int temp, ret = -EINVAL;
>  	char *token = NULL;
>  	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
> -	char *p_args = kmalloc(size, GFP_KERNEL);
> +	char *p_args, *orig;
>  
> +	p_args = orig = kmalloc(size, GFP_KERNEL);
>  	/* Safe string copys as buf is const */
>  	if (!p_args) {
>  		dev_warn(device,
> @@ -1611,7 +1612,7 @@ static ssize_t alarms_store(struct device *device,
>  
>  free_m:
>  	/* free allocated memory */
> -	kfree(p_args);
> +	kfree(orig);
>  
>  	return size;
>  }

I tested it on several devices to be safe, no issue at runtime.
Sorry for the mistake and thanks for the fix.

Akira Shimahara

