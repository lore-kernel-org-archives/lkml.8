Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F001DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD9821941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIJSma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:42:30 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49720 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgIJSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:41:47 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 180CB20039;
        Thu, 10 Sep 2020 20:41:42 +0200 (CEST)
Date:   Thu, 10 Sep 2020 20:41:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        lukas@mntmn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 0/5] Add support for iMX8MQ Display Controller
 Subsystem
Message-ID: <20200910184141.GD893045@ravnborg.org>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
 <20200828083620.6m5yhcv7rg5tckzh@fsr-ub1864-141>
 <e882838158cb9e81440c8cdeb25d80bf3310e8a8.camel@pengutronix.de>
 <20200831112445.t4xfz33avdyx5w6p@fsr-ub1864-141>
 <f46d44f38008d214951994a340814570c182cc15.camel@pengutronix.de>
 <CAKMK7uG7s1j+k0WPq8H4OcTD0jP2_LpTy0SBw0RtP-ij1OS7Mw@mail.gmail.com>
 <20200910080432.26dleo5wxybsacvl@fsr-ub1864-141>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910080432.26dleo5wxybsacvl@fsr-ub1864-141>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=EC8lkJN9LEwtObD5xQsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu

> > > I've tested this together with a hacked up eDP bridge driver stack on
> > > my boards. The testing hasn't been really in-depth, but things seem to
> > > work fine. I have now pushed the whole series into drm-misc-next.
> > 
> > Something doesn't compile too well
> > 
> > ERROR: modpost: "__aeabi_ldivmod"
> > [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
> > ERROR: modpost: "__aeabi_uldivmod"
> > [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
> 
> Oops... :/ I guess we need an ARM64 dependency in Kconfig. No
> 32bit NXP SoC uses this particular display controller. So, that should
> fix the compilation issue on 32bit.

Build coverage for ARM64 is an OK short term fix.

Please fix the driver so we can build test it for all architectures.
The chance to miss something when refactoring if only build for ARM64
is too high. The fix can land when it is ready, and is not urgent.

	Sam
