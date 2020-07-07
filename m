Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30052C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5E02063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfqqS+lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGGIDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGGIDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:03:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0820DC08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:03:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so44139204wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mMZpUKfqpJCdbAhsZp+bXjqEnQ4z2yPe16N+eOasptM=;
        b=CfqqS+lWIiN0P+noAXvDnsJP+vvKJH1pGpe6wR/eDn+gDpTDB6XlzvA1O82fWtEMno
         Ki7iRep7tGg2zVXbSxW27Q950XkwGmY2uQBXwEAsbViVMf/cldEOS2mX30FrDp8KTKyK
         a57MleK0nWcnTlQ/TsoFxGTvUHatmaqb65XI6F4BpZ6d7Nv0cK9fzhJ2V7pnYfq6iKc7
         M8qAuVUB4WjUSdt97tDmgEZY4HpyexXnpJPOTG4mLJF/fQcIIuqeHasmLXgoAaea2Luu
         AITsf8jPhP0+M1Jx3eP3yAP/AE4ZG5UxcPnSH8Y5idwstO/Dc9K2lFQ74GY1Aynb17LO
         gC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mMZpUKfqpJCdbAhsZp+bXjqEnQ4z2yPe16N+eOasptM=;
        b=dHfkxm5hcXU6LQMIhNxOUXKW/6pnBs2NUpXVMQ/ln7o2fN2ykAWV9M6KDm5S5hgNep
         QaN/78d1lB2u3fUiBBvtyhzqJ6dgktak1rCDNuDJDCd3Tog6776fCeuP1Cb8GylCs4ly
         7bWlRImiGowhj1emtYoZpJTNT3aqw7mxupfdVJpVp101NgKUUiJ4UuYyFZuIPN1c8hKW
         akOQ7bozC6mEy+29hkLNy5pbFNimFnfj0Qx4LwezvdvqNVpYz8OvJrvf0FfqVgd0o8CW
         kBbFO++Lg88HhaNG1xgm58TKGarRgYNxqWmxtB4loZgrK6lC8F/DCXwLyl2Q3LXv0cDB
         YZOA==
X-Gm-Message-State: AOAM533s8efOWfuTrFkEqUUknkH8q0YtcuT9L+GBwLFSfWKobVSa43MP
        q6365zM6Xvlf0HslM11lrseVmA==
X-Google-Smtp-Source: ABdhPJwcpPtoD7n14Ffrr43fIwA5zL6dutKmKygss05H+0o2d5I4bzNNKViRKd4dKqbjeRyRASpwzw==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr53367032wrx.106.1594108993639;
        Tue, 07 Jul 2020 01:03:13 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id 12sm2340143wmg.6.2020.07.07.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:03:12 -0700 (PDT)
Date:   Tue, 7 Jul 2020 09:03:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH 04/30] usb: misc: sisusbvga: sisusb_init: Mark all
 'static const' arrays as __maybe_unused
Message-ID: <20200707080311.GE3500@dell>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
 <20200703174148.2749969-5-lee.jones@linaro.org>
 <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af66b6e94a26ebd500c1376631891b0bdd0912f0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020, Joe Perches wrote:

> On Fri, 2020-07-03 at 18:41 +0100, Lee Jones wrote:
> > drivers/usb/misc/sisusbvga/sisusb_init.h is included by a few
> > source files.  Most of which do not use the majority of the
> > shared static const arrays which have been declared.  This
> > causes the build system to spew 100's of warnings.
> > 
> > Fixes the following W=1 kernel build warning(s) - and a whole lot more:
> > 
> >  In file included from drivers/usb/misc/sisusbvga/sisusb.c:54:
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:695:34: warning: ‘SiSUSB_VCLKData’ defined but not used [-Wunused-const-variable=]
> >  695 | static const struct SiS_VCLKData SiSUSB_VCLKData[] = {
> >  | ^~~~~~~~~~~~~~~
> > [10's of lines snipped]
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:206:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
> >  206 | static const unsigned char SiS_VGA_DAC[] = {
> >  | ^~~~~~~~~~~
> > [10's of lines snipped]
> >  drivers/usb/misc/sisusbvga/sisusb_init.h:171:29: warning: ‘ModeIndex_1280x1024’ defined but not used [-Wunused-const-variable=]
> >  171 | static const unsigned short ModeIndex_1280x1024[] = { 0x3a, 0x4d, 0x00, 0x65 };
> >  | ^~~~~~~~~~~~~~~~~~~
> > [10's of lines snipped]
> 
> They are not __maybe_unused, they _are_ used.

Actually, it looks like all of the ModeIndex_* table are *not* used,
so those will be removed.

> I think these instead should be moved to where
> they are used instead of being declared in an
> #include file.

The remaining tables are many and large, so stuffing them into the
source file does not seem like the correct thing to do.  Instead I
shall move them to their own "sisusb_tables.h" include file where they
can be referenced only by the file(s) which make use of them.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
