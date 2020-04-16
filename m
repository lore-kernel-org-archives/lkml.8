Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB42C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4121744
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drsDOG2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441234AbgDPIPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441085AbgDPIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:05:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944DC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:05:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so3732596wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DTVGiSK03P6onmyASsObJNfq8+3T4lgM4B2+WW6QaCY=;
        b=drsDOG2NcJ/inBonm+c5W3bUUMqyD+e/xq4Nn2bd7g31XzVFAblp1LeH9CAM+mVxRq
         OOhDG/FVL+Nqx3BYBQ0gAy45kbWORkgeXfcocWTrccEjMYoHaa773bp4VcS55dW6EYxn
         0yuOVkST5dYZ8AhvsJKyoRJ/sBSfC5siAV2pFgQPVbQSr1LQBML/iMDQ8DDR8tmp6caw
         JqSTBKu+6pffnSns91off5WEl8VZf1Gq65Kkt5BUfT05hGqF3lTExP+6Ya0g+kmRn1Ym
         DJMJliKq6u/l+8idfmmu4s6BcZXM6JkKlLkUV28/DmLFNGURuMhagF8Kl2Lp7JdBqlu+
         wiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DTVGiSK03P6onmyASsObJNfq8+3T4lgM4B2+WW6QaCY=;
        b=AmTMDJuO6oBM3IDJQFycd4HBT9aNlvMPcK4D3VrL8qV8BP11RHXS617mCE3j7i0QqL
         V1wQTR5Z5hHQAxIuCqlsBVgjX3HaHAz00n5vyJJ9Ne9rhuZnAwjYKQs81s6EYdc/ihh3
         vSa1ahTwaiwS48TeYB/5nJVYdlGj3xhRao80odu0Pah7J74NXMGpNbZMvRH/6OipCdmk
         dveTpYjennYfwMGTXdnrXrEvTYRkPfqPUALeToustVuTIiYvkxRyFK2E1tbDBcduVDfw
         +bg8W373Th2AJKTQ/jh86uQ7CGOq/p5/RewN2ljSqQVt/YiVApcnHW2ooD5DVptXnStX
         adTQ==
X-Gm-Message-State: AGi0PubFBP9DGTMYPaINP40XF7CyzpwK5OY9itHHHnl679t9h3IJxeyT
        EqHsQbYm/50S2ueFPXLHRnSSI05P2NA=
X-Google-Smtp-Source: APiQypJIeFvIypgtJ2FKxu3qCheY3/cc/NBCP8LP2sh5UGGw4ZWmK1SSxzEBq6xItYvS2vj95A/WaQ==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr3721230wmg.32.1587024331115;
        Thu, 16 Apr 2020 01:05:31 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id t67sm2686116wmg.40.2020.04.16.01.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:05:30 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:06:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND v2 PATCH 2/2] mfd: da9063: Add support for latest DA
 silicon revision
Message-ID: <20200416080631.GV2167633@dell>
References: <cover.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
 <f468a3c56496edf3641b41cbd7797b344c8a99dc.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f468a3c56496edf3641b41cbd7797b344c8a99dc.1586162737.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Apr 2020, Adam Thomson wrote:

> This update adds new regmap tables to support the latest DA silicon
> which will automatically be selected based on the chip and variant
> information read from the device.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/da9063-i2c.c        | 91 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/mfd/da9063/core.h |  1 +
>  2 files changed, 82 insertions(+), 10 deletions(-)

Can this patch be applied on its own?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
