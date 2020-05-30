Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64914C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305B9208A7
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uwGG9xxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgE3Cz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgE3Cz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:55:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65613C03E969;
        Fri, 29 May 2020 19:55:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so1948205pll.6;
        Fri, 29 May 2020 19:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CdjRzSLuSxdNQv4Fy/DVTwbAer3PT1/PyJX0XOYAdI8=;
        b=uwGG9xxjFgXIoH2AhNGEZHm8vi/Oj3qBxj+eiVdAJAG+2A3+4WlG49qD/YqwMSGfuK
         A/dY6zGtDSTOocmqQdLMBr0XVqLUiJ0kH866NkdvZqraIuCGhSIoH60lHyYVi/hu+WyF
         bJ3kleTuhomiZ/yUdaCb0eM0e/VM75ZX3xNQ/EiyneIr/M1BNP+BvjttpJCLlgB4e+8f
         YI4UW3ORk/2RjgV9+eCadAjxNcJTy77A462TEtEEprlkoVJtChi4w/DYACQjWm9/p4J4
         rzmm8rIMxMaCvQ0MdTh+2R+m0X+au4eFY2vhlahBAzGIFiYBo+F6stHuDuTaRl34Y+5u
         puGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CdjRzSLuSxdNQv4Fy/DVTwbAer3PT1/PyJX0XOYAdI8=;
        b=i22N+n3pYca8k9tvuFO9bdOnLzi4LfTEZkrAipbopEuvaoauoKDd4L4CggdknVhBQ+
         kiYqGn3wIwJPStwycItfbL02hmHHarc3wjDavLCXcZGEvWAPaJtCvR/oX4+slszbMYJy
         tFQVjRqR8FcKiTqYQNt/p6rBLKDVt/akjEM94Eu4YRcPfW3phoJgruTeb9jZvzFL/O1S
         Oq9aG4BuMkqd8QbpemiGPS6K/DPoTVb22lPkQtt1d1Hgxd2ujeqk6/7BWyaqTGFjycbt
         DXm0CiBGlPknx1TxxneEZSqJPj6Uo2BOjrdNl6drcuMySmBhy4n+JeKqWqr6lT2S2QOo
         wLZw==
X-Gm-Message-State: AOAM531eRgZ9PTHHQmFuM+61MxRQvju5plX3Iy/rTcpUtAg/Nr92WCmF
        UyTCYdlJ/DYycemsDjaHbkw=
X-Google-Smtp-Source: ABdhPJxuWfMwbpudVyes0d/7k96w4zqeY7CYoSCL6/wC0SOuddrFsF1PiwqVWIuOMpbvU2ETNY96mg==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22mr11361146plo.24.1590807356637;
        Fri, 29 May 2020 19:55:56 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id o201sm8932310pfd.115.2020.05.29.19.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 19:55:55 -0700 (PDT)
Date:   Fri, 29 May 2020 19:55:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/9] staging: media: atomisp: declare 'struct device'
 before using it
Message-ID: <20200530025553.GA1367069@ubuntu-s3-xlarge-x86>
References: <20200529200031.4117841-1-arnd@arndb.de>
 <20200529200031.4117841-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200031.4117841-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:00:24PM +0200, Arnd Bergmann wrote:
> In some configurations, including this header leads to a warning:
> 
> drivers/staging/media/atomisp//pci/sh_css_firmware.h:41:38: error: declaration of 'struct device' will not be visible outside of this function [-Werror,-Wvisibility]
> 
> Make sure the struct tag is known before declaring a function
> that uses it as an argument.
> 
> Fixes: 9d4fa1a16b28 ("media: atomisp: cleanup directory hierarchy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/staging/media/atomisp/pci/sh_css_firmware.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_firmware.h b/drivers/staging/media/atomisp/pci/sh_css_firmware.h
> index f6253392a6c9..317559c7689f 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_firmware.h
> +++ b/drivers/staging/media/atomisp/pci/sh_css_firmware.h
> @@ -37,6 +37,7 @@ extern unsigned int sh_css_num_binaries;
>  char
>  *sh_css_get_fw_version(void);
>  
> +struct device;
>  bool
>  sh_css_check_firmware_version(struct device *dev, const char *fw_data);
>  
> -- 
> 2.26.2
> 
