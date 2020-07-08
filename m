Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5743C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA3720739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vEex7B05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGHHmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:42:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383BC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:42:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so39716007wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zLm2rrNY/P1iFEyvAZXKtr97lStg8qv5v/wgetsdpFs=;
        b=vEex7B05G5y1iygv/ohVu5raEK7ymKtpvYsY2XBzumAF2c4/SUjNXunQXWdSiBmuN5
         u+ilhJT/3jjddZzmBtWjANdox7i+CmV1H7UIXE2eKKynR/H6gHMecRaQ0CLtq8A948Ei
         hEBOlEiyZepgdnL5BUNVs8LOzrMlLAHIQsiFbgmt7yN2Hjz7rtNu9sTktvxWZ/SA6uBW
         8CXH/4JEN2DwnXbOOWolglCoyM+9zmFVl9wtQNqVnWWDMFgJgsV+hfALLQptYblPfWT/
         ka/Ra/1ViY+ksSBMZQj2QwLOs1YqLcqy2Yo+thvwKgyKrtiDs4xk9Sir2AMDdCmkmfuW
         TIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zLm2rrNY/P1iFEyvAZXKtr97lStg8qv5v/wgetsdpFs=;
        b=HyYgj/FkGV1rdUdB5MtXGx1BP0zTZlejjMeMYzXIVe/oirX9qIaja0F9xfTdVeRbhq
         A70jsBZB0w5Ai1LYdpQHlJiehn/RXux4POgyxh0M0cfFsaL2sHEya+QVM85UkwpV8VQL
         Epqq2h3tgaCGJ/R3pNZ0oUx/HcNhoDl/62CH7Iil89A6fT1rQt1eAiLlqZLmiBewFiIn
         mmb/Cz+t6egOItLonaA+KWKjRVBG+emqXsECODU/msuWfH4fd/FYXTVoGu9KEEM9r5/z
         XNHLl6wHqXDJznKtKP3LLG6TciBeesXqNwVuPLu99iktwwIMZmeVCHo4DXhtrMJ63Z9J
         oi+A==
X-Gm-Message-State: AOAM532z46GSum7djsGBIQ9uDYaAu4PLGvN9yVzT6rodZ8bXBz+/Eqg/
        XVBf7i3+goDfxV6gjhCXZAOctQ==
X-Google-Smtp-Source: ABdhPJwJACBLMUWDth5Oz10uveB1b+8QT918SIxv5bMSFZvhT3RCp60i/z3xW7rPfFGt18GjjZIitw==
X-Received: by 2002:adf:f203:: with SMTP id p3mr29076638wro.331.1594194167231;
        Wed, 08 Jul 2020 00:42:47 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id t2sm4692315wma.43.2020.07.08.00.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:42:46 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:42:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/10] Fix a bunch SCSI related W=1 warnings
Message-ID: <20200708074244.GP3500@dell>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
 <CY4PR04MB3751BE9A73158B811D163EADE7670@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200708065136.GL3500@dell>
 <CY4PR04MB3751007285A0EB45A206A95BE7670@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751007285A0EB45A206A95BE7670@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Damien Le Moal wrote:

> On 2020/07/08 15:51, Lee Jones wrote:
> > On Wed, 08 Jul 2020, Damien Le Moal wrote:
> > 
> >> On 2020/07/07 23:01, Lee Jones wrote:
> >>> This set is part of a larger effort attempting to clean-up W=1
> >>> kernel builds, which are currently overwhelmingly riddled with
> >>> niggly little warnings.
> >>>
> >>> There are a whole lot more of these.  More fixes to follow.
> >>
> >> Hi Lee,
> >>
> >> I posted a series doing that cleanup for megaraid, mpt3sas sd and sd_zbc yesterday.
> >>
> >> https://www.spinics.net/lists/linux-scsi/msg144023.html
> >>
> >> Probably could merge the series since yours touches other drivers too.
> > 
> > Do you have plans to fix anything else, or should I continue?
> 
> I only fixed the warnings for the drivers enabled on my test setup. No real plan
> to continue with other drivers for now.
> 
> My series did not touch aha, pcmcia and libfc, so these should still apply.

Great.  Thanks for letting me know.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
