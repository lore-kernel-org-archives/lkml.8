Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86054C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6133C2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAikv23Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgGFHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGFHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:13:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E839BC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 00:13:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so39588160wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RMGnvxquvbu4QyMyyHqPaCsBLX3LZtSdXGrqjMwfS7E=;
        b=AAikv23ZIqKM8pfJvjReSBC3OGv4L4hsLmToMzvt7T4/lJmoiQ+k4CdAGRb0cV7S2W
         5X8g98k0ELBNX7r3ltxzvzV7Us/w7LOjcAmp/SXbx8utOSJSEuFc7U0259FgO+PDubaM
         k24kALm57sxDO8COLitP2s3SUPG757vsPnwL9+lCTMT28+RB1XbGNbSOw46k+xJDdaBB
         VuFjAMTV3L6YEJCKAgb19Z1QDdVmigQUrNGym9PJiCpMP5CfkmNXCk2xvhJegjTQQ3vX
         WUTgp7t8gDULlaBYcJc9JBvRnTkdKprktwjq6xQVSs0pSfm931CCLVe8qirXmhGyS+aQ
         R6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RMGnvxquvbu4QyMyyHqPaCsBLX3LZtSdXGrqjMwfS7E=;
        b=XU5UIQb3YdQklNBqy3hK1ebSfqbkVnA/sl1gCkUrXUvv2eyd/O2aZEbhRLTs0v2JrK
         s3B0NnulXbnNZ31+EUIa7oxw0Fo+/oa64cg5UDzUGY1V5O6Xq3dwUDXYue47WwHL3Sum
         YfRM6HkPQ9+rYfpC1Ykj+4hy+469l2HHVEU/dGJ5WHqa4gJXi5wtRtJqvb3M9JdcFBfe
         WsonyHCplZ1H71KPbaCZOMKnTG//UlZlthynDzVPVNon/i2A3DMv8NBNDu4YRPL4vHXr
         6hzSwiOvy7PgP9WXkP/+J++zpUXE+tjeDaHVeq5gavQwLQrmwZrBhcMz4zb3eKKTt1SA
         wwBQ==
X-Gm-Message-State: AOAM532jBS6apCQdgaatytGYAHTfVXMW80MxUPyZOhDUHVF6QvF87Dmm
        Wxh6ukQQts8qdUXYLWEMlHkGHQ==
X-Google-Smtp-Source: ABdhPJzbRa4dAsAzugKpjzOIhWptwA1zAERFnuxhOgrcEveqI1bRWNiT7yGNRTf9jNNznRD5lbePTw==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr46518594wro.110.1594019605697;
        Mon, 06 Jul 2020 00:13:25 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id d13sm22969218wrq.89.2020.07.06.00.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:13:24 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:13:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Software Engineering <sbabic@denx.de>
Subject: Re: [PATCH 5/8] backlight: ili922x: Add missing kerneldoc
 description for ili922x_reg_dump()'s arg
Message-ID: <20200706071322.GB2821869@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624145721.2590327-6-lee.jones@linaro.org>
 <20200625094318.h6t22gkgi5d7wbv4@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625094318.h6t22gkgi5d7wbv4@holly.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Daniel Thompson wrote:

> On Wed, Jun 24, 2020 at 03:57:18PM +0100, Lee Jones wrote:
> > Kerneldoc syntax is used, but not complete.  Descriptions required.
> > 
> > Prevents warnings like:
> > 
> >  drivers/video/backlight/ili922x.c:298: warning: Function parameter or member 'spi' not described in 'ili922x_reg_dump'
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Software Engineering <sbabic@denx.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/video/backlight/ili922x.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
> > index cd41433b87aeb..26193f38234e7 100644
> > --- a/drivers/video/backlight/ili922x.c
> > +++ b/drivers/video/backlight/ili922x.c
> > @@ -295,6 +295,8 @@ static int ili922x_write(struct spi_device *spi, u8 reg, u16 value)
> >  #ifdef DEBUG
> >  /**
> >   * ili922x_reg_dump - dump all registers
> > + *
> > + * @spi: pointer to the controller side proxy for an SPI slave device
> 
> Similar to previous... and I also noticed that there are several other
> existing @spi descriptions in this file and it would be good to make
> them consistent.

I've fixed this and applied the patch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
