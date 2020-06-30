Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711CC2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apeVYBO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgF3VEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3VEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:04:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:04:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so10496949pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xNBGyQANiqILlDq1wBEsbi38cozHmh/XihUuNGYycM0=;
        b=apeVYBO1IzE4K9q8w8l/ssG5Lfbnwat+ekTKnOAvohkItLv2DT6zmG6j7IO5lU/uZh
         M5Y0zfUVbhHZdGcXd0QzwbZpGvwH/LFDaHSwd0fJC3DLpLGfsx0RFEDDJWMtUBrQIrYe
         /6FXjUxRIpNjpdkQK+tL2I8sJRzV9KSaIlPV6J/uZtGRJvXfBimGWsoS5feUqI0JfDOP
         Fj5EWmXMpOESrikQePf0W3hFYRcj/QSy4ULxQzARLKt4gDahSVvwHBboMp+be6jPWefV
         on56aQwYPeI7AmM+1VqzimoQKB6KE3asb0iN1HfIy9RBKhDw5QkzwbkEAV5V6uFuyGf2
         tUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xNBGyQANiqILlDq1wBEsbi38cozHmh/XihUuNGYycM0=;
        b=f8NaQrtleTA7vbCb6M20eXpTfWrm4j9zGp4RZ6At/UVeo6EgpWV5XyEJtFfLJAOSR6
         0OlK1HXajQHBe4qhoxcoKL3+H8jJtd4To1uzkBB+7rcO2zLSt/uSwJrF4IUTTzVTRVs2
         8Bt8Zo8mwLhwBF5iA1K01iH2e6AZnqDKvkwZsxUly68DCrlAl1tq2V4h8eBVpRDkv0Oz
         IYUqTNdI2z2RvDLzSeXIoU+E2RXlVoBoikYo1+M3PGCi0EZRsPP/Yas+wNdHrPB656Qq
         E7RXg4Mndhcj433Ibq7BIbGAkW7x1Lx6nsGNwwFqx9CKq8Zhsb5/7ixH3ThRyi9hqAO9
         WvHQ==
X-Gm-Message-State: AOAM530yIz5d+ZQ73HNZGCUhW0utUgxkUH4Olvfk7tPYmjGaYAlQNUHq
        Gca7klU9rZPC0uFl31PxZ88=
X-Google-Smtp-Source: ABdhPJw7UQDcd11OnB7gP5fyr6hOiKF7tfXRYP0rVvN43PiGmFgzFZN8xB7xJQUnsTns4SmS0btXSw==
X-Received: by 2002:a65:5682:: with SMTP id v2mr16489451pgs.231.1593551083729;
        Tue, 30 Jun 2020 14:04:43 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id 204sm3623211pfc.18.2020.06.30.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:04:43 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:04:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Sia Jee Heng <jee.heng.sia@intel.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Message-ID: <20200630210441.GA3710423@ubuntu-s3-xlarge-x86>
References: <20200617010232.23222-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617010232.23222-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:02:32PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  In file included from sound/soc/intel/keembay/kmb_platform.c:14:
>  sound/soc/intel/keembay/kmb_platform.h:9:9: warning: 'KMB_PLATFORM_H_'
>  is used as a header guard here, followed by #define of a different
>  macro [-Wheader-guard]
>  #ifndef KMB_PLATFORM_H_
>          ^~~~~~~~~~~~~~~
>  sound/soc/intel/keembay/kmb_platform.h:10:9: note: 'KMB_PLATFORMP_H_'
>  is defined here; did you mean 'KMB_PLATFORM_H_'?
>  #define KMB_PLATFORMP_H_
>          ^~~~~~~~~~~~~~~~
>          KMB_PLATFORM_H_
>  1 warning generated.
> 
> Fix the typo so that the header guard works as intended.
> 
> Fixes: c5477e966728 ("ASoC: Intel: Add KeemBay platform driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1053
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  sound/soc/intel/keembay/kmb_platform.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/keembay/kmb_platform.h b/sound/soc/intel/keembay/kmb_platform.h
> index 29600652d8f4..6bf221aa8fff 100644
> --- a/sound/soc/intel/keembay/kmb_platform.h
> +++ b/sound/soc/intel/keembay/kmb_platform.h
> @@ -7,7 +7,7 @@
>   */
>  
>  #ifndef KMB_PLATFORM_H_
> -#define KMB_PLATFORMP_H_
> +#define KMB_PLATFORM_H_
>  
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
> 
> base-commit: 27f70ec4fa0e0f419031f1b8d61b1a788244e313
> -- 
> 2.27.0
> 

Ping? This is a rather trivial patch.

Cheers,
Nathan
