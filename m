Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91618C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF720720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KETKesxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbgFYIDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390587AbgFYIDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:03:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853EC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:03:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so6130802wmn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0M8Y/ZNSXHt2pcvJaMnq9jm7EeSpBp7mRNluLRRdmdk=;
        b=KETKesxFm86ICb2fFOUJiGjNCAEbBZjL92c4QkfD/GqbqjQl7b8TszNs+54WN/0KRt
         5P2rS7jWeQWH7wsUV5Br8VFbTyYYVNU6dQTCB3WVg4LBOKKyPu0bSE82xwFjFvLyJVXS
         6KcpoeNo1FEyuzpFiFppZXiPNqJ9AOdR9Oom9whl7CwfHHRbdVxTx0nqm6A5cRm5LZd4
         PxNoqqBnARQTFofGB+80GKqi+RRVHdJdgrWZQdjpw+lHKX3xoNInpuHUMXBXiUjoIJU5
         ER92rajMEoZICS8y4YCEt2/PIAkxL3t7vRLPMkZjZdsi4PZmbEr/jdvbH3OE44Cd+lX7
         NzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0M8Y/ZNSXHt2pcvJaMnq9jm7EeSpBp7mRNluLRRdmdk=;
        b=idHuAKtM2uMC1CSAEakLWB8eIc0mx3SIRVobfwtXzQSCUKzzBW4ONv6smM9np2iogD
         2tHDIlQd7jkf4TCsTkqbEUSdyCbmi/I1m0jS5+P+R3O8VP0AKQS9840QVJpizWWkMflJ
         SL2biV2fmnI2p8+Jk5uoqVqQnERcUJFUBTWf/F4X8aFo+y2aXh+3x/LFx4T4V65tvyIa
         W0XESD5Pu8iyc39Q/38fFgar8l4jGbTb3q0qDJ5wKzOWzWCTnavAaq67UsZO8oG0QQN+
         ugAEwlNCqNmv/eekCOEchti21pdMTSjzVkKr7rqa/gIb7WMo8X2LxBdo2xunz5/oDJVI
         VUJw==
X-Gm-Message-State: AOAM531Od3kMWTzvWuiT2GJnVcDCJ33LLa/JTE4XHrCnsV4SR6nGuOiG
        68HKu2EVgFs/Zxnqu2fSt7n4Mw==
X-Google-Smtp-Source: ABdhPJzyKaUaIlRz/U+g6QVFvU1vbbyn/692EhhXT5aH0828ZYHfpZbkeM3vTyPCoD2vvAXE9IHqFw==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr2031841wme.107.1593072220241;
        Thu, 25 Jun 2020 01:03:40 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g144sm13671180wme.2.2020.06.25.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 01:03:38 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:03:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Message-ID: <20200625080337.GN954398@dell>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
 <20200624153216.GA1814806@ravnborg.org>
 <20200624154321.GH954398@dell>
 <20200624162446.GA1815586@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200624162446.GA1815586@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Sam Ravnborg wrote:

> Hi Lee.
> 
> On Wed, Jun 24, 2020 at 04:43:21PM +0100, Lee Jones wrote:
> > On Wed, 24 Jun 2020, Sam Ravnborg wrote:
> > 
> > > Hi Lee.
> > > 
> > > On Wed, Jun 24, 2020 at 03:57:13PM +0100, Lee Jones wrote:
> > > > Attempting to clean-up W=1 kernel builds, which are currently
> > > > overwhelmingly riddled with niggly little warnings.
> > > > 
> > > > Lee Jones (8):
> > > >   backlight: lms501kf03: Remove unused const variables
> > > >   backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
> > > 
> > > 
> > > >   backlight: ili922x: Add missing kerneldoc descriptions for
> > > >     CHECK_FREQ_REG() args
> > > >   backlight: ili922x: Remove invalid use of kerneldoc syntax
> > > >   backlight: ili922x: Add missing kerneldoc description for
> > > >     ili922x_reg_dump()'s arg
> > > I wonder why these warnings show up as nothing pulls in this .c file.
> > > Anyway I would suggest to drop using kerneldoc syntax for single drivers
> > > like this - and the benefit here is low.
> > > Now they are typed, otherwise this ahd been fine in a single patch.
> > 
> > What do you mean by 'nothing pulls it in'?
> There are no .rst files that includes any:
> .. kernel-doc:: drivers/video/backlight/ili922x.c
> 
> so I do not see how the kernel-doc comments will be used by any
> of the generated kernel-docs.

Looks like a common problem (if it is actually a problem):

 $ ./scripts/find-unused-docs.sh . | wc -l
 1476

The role of this patch-set is not to eradicate unused kerneldoc
headers, but to ensure they are formatted correctly.  W=1 builds
currently complain of ill formatted kerneldocs, which is currently
littering the build-log and masking some more important issues (which
I'm also trying to fix en route).

> > > >   backlight: backlight: Supply description for function args in existing
> > > >     Kerneldocs
> > > >   backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
> > > >   backlight: qcom-wled: Remove unused configs for LED3 and LED4
> > > 
> > > The other fixes looks good.
> > > They are all:
> > > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> > 
> > Thanks (although this should be Reviewed-by).
> > 
> > > >  drivers/video/backlight/backlight.c  | 2 ++
> > > >  drivers/video/backlight/ili922x.c    | 8 ++++++--
> > > >  drivers/video/backlight/lcd.c        | 1 +
> > > >  drivers/video/backlight/lm3630a_bl.c | 4 ++--
> > > >  drivers/video/backlight/lms501kf03.c | 8 --------
> > > >  drivers/video/backlight/qcom-wled.c  | 8 --------
> > > >  6 files changed, 11 insertions(+), 20 deletions(-)
> > > > 
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
