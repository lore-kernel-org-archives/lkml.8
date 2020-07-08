Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903CE20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzmhrVMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGHHqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgGHHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:46:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936CC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:46:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so1881235wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=13tTeGa2nW6X4a+Xzt0nK3tFREb2ehmWIY4bBAwrwkc=;
        b=OzmhrVMOli7A5hNbR3fGy47aE+V6uJ2r1czZSGk/3KkO421wAC922Giw65d3B2JPWD
         X/ku26qUfk/i2caIjdfEHpdTsmnPmpPZDPi+XZdivhOS2HkB0BkJCo/6QqYn4vHtnWFA
         eoQiBiM0yflqSFLfyZ3YkmnQF1pEfYw6kmV6U05L6f9q010QhDxah8ITfFoOr6sr5CkP
         tNxI9+5c8enZ2T4Rzo0r+LrprvweE6UlGy+PzLm5cjZhpJ6cy5FopH/yZzqTjBK39VDt
         zCiX2BCn/9M5mMZjvBOGU2fki8enBseW7KJVFwyMCvZKxb+j9k39LnOwrAdvPf7wsz1R
         9NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=13tTeGa2nW6X4a+Xzt0nK3tFREb2ehmWIY4bBAwrwkc=;
        b=AurB94454B4d3CzH2liygJRSO5HIc8wPhpBscETETEG49VF5ZSBbJTgzaO/Il7v634
         ZMhg7MjuEZjTyHRvhBHae9X2MI7306LmYURpE3n7exb2ZKefsFDTMaPhxGCdnUhqQGlV
         s764G/TGsvaRCY6Tr8a5kGivD8kN/Q93DXSpiZRe9oymIdellmNrjOGEUW4ouaffRjjC
         8cyAAp8llGEg0IRwn/EdkfLzLfyy5f5jEgQZ+kxAAell6NxHlr4fnhJtGz8hByJe9Sbp
         6Z6D2flf6raxQj/5z/3aqBj+AE9zYrs7IhmoJEGfudq0wHRR8N9+WirdXxwFyqStPPDh
         d9mQ==
X-Gm-Message-State: AOAM530c/tOw7pX6CN+WmYkVafSSOX7b/MF4r48Hr8zTWwuCm3PllW6X
        14x5M6Mx6FDOFItVlDVEsUPY/g==
X-Google-Smtp-Source: ABdhPJzbse+FrEgNn3I9Se6w6hg140YTQ1T0f5FheDYB3sZ29GWUzqdNaf8egMfSUzlAtD6+dXiaBA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr8078098wme.139.1594194408880;
        Wed, 08 Jul 2020 00:46:48 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id t4sm4873009wmf.4.2020.07.08.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:46:48 -0700 (PDT)
Date:   Wed, 8 Jul 2020 08:46:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 09/10] scsi: libfc: fc_disc: Fix-up some incorrectly
 referenced function parameters
Message-ID: <20200708074646.GR3500@dell>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
 <20200707140055.2956235-10-lee.jones@linaro.org>
 <SN4PR0401MB359847D89233CFB550531B259B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB359847D89233CFB550531B259B670@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020, Johannes Thumshirn wrote:

> On 07/07/2020 16:01, Lee Jones wrote:
> > + * @disc:  The descovery context
> 
> s/descovery/discovery

Ah yes.  I can't even blame copy/paste for this!

I think this patch has been applied.  I will send up a follow-up.

Thank you!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
