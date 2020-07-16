Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB86C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D920D206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqYpIMN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgGPOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgGPOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:41:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB3C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:41:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so11855103wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sN2LdCbI27V4TnKB9wh8afeVJvtWYQtUpnWRsMz8Zks=;
        b=LqYpIMN9wvmgA1DTp8rlOpEaMotfR07FK2SWTADyQCqbT19CPZ+por9zowh4KhkuM/
         Mn4hmjtiXAn7q5b90eYyVNs+rWXcN/K2DGyqZZs6+40darqkzapC0/NA04voUvVWYhZ0
         XUUL8VdXPHybbNzitMTmz539tmfjM+Zmk63ahQNmOILUxI84F/KeV48nSGRLt7rsbcJ1
         g68Ru5UK8DMeSbLFkZ7W9WOvut/9slSCu+zdaBH1y5jK5lIW4aBUe+ZSgnftwQxv/cX9
         MXzxIVEEhNj9PUXaIH3Zpk5pC8dHXfcPoFkzVLdCd/Ol2alhnf7L9SkJXaGfrT16NAXx
         c5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sN2LdCbI27V4TnKB9wh8afeVJvtWYQtUpnWRsMz8Zks=;
        b=t8hSBxfDakgUVXWmxuE17tDAi68KqQ2ztSWPYHDLAkwoRb8mkfdvA5vCbaRvHzq+Qi
         k6nt21rQKMwwYodEVBGPgHzeZvaUi/e+YgD2+V9OpoXJ9JinCT97CRMe9nA/A6nXLBEC
         EmAK5pf4pXxDDC5ShM+FKl4/L83E839M4SPyJ40JYMgwBOxVkjMdV2O7p5XtY2fcDcRg
         iiKgaLDGLLZbtsGk0LNJGnS6OwaH7nYJDxJ/ZboPUflg50gp2lLJpKokJvdrCyBx+VMK
         JIbWQWgbfg+mQlIfZHRD2X3Jfba/AL0ZOqYIkoOCJts+UYo6NWinQWLBFFtsr/2aqLdp
         8MpA==
X-Gm-Message-State: AOAM531WlyOZtXtvac6lAsHGjJcG1QWt/fJDNN4lkofJc/enVSydrPG0
        vSPGpxBMxHXlypEH5KGZpXfJq4H9sSo=
X-Google-Smtp-Source: ABdhPJwBq2ThH8soqX/E9iFm4UIc9XoMt2M8Wu9RmHhIzpOafZNxt0SByhM1GnyBn70DrOfRHlBySA==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr4413392wmk.127.1594910514584;
        Thu, 16 Jul 2020 07:41:54 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id p4sm9414957wrx.63.2020.07.16.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:41:53 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:41:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>
Subject: Re: [PATCH] mfd: remove smsc-ece1099 MFD driver
Message-ID: <20200716144151.GT3165313@dell>
References: <20200701212348.8085-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701212348.8085-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jul 2020, Michael Walle wrote:

> This MFD driver has no user. The keypad driver of this device never made
> it into the kernel. Therefore, this driver is useless. Remove it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  Documentation/driver-api/index.rst        |   1 -
>  Documentation/driver-api/smsc_ece1099.rst |  60 -------------
>  drivers/mfd/Kconfig                       |  12 ---
>  drivers/mfd/Makefile                      |   1 -
>  drivers/mfd/smsc-ece1099.c                |  87 ------------------
>  include/linux/mfd/smsc.h                  | 104 ----------------------
>  6 files changed, 265 deletions(-)
>  delete mode 100644 Documentation/driver-api/smsc_ece1099.rst
>  delete mode 100644 drivers/mfd/smsc-ece1099.c
>  delete mode 100644 include/linux/mfd/smsc.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
