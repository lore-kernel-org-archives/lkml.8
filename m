Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FAC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EAA20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgH1R4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:56:37 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:46838 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgH1R4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:56:36 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A12C6201C5;
        Fri, 28 Aug 2020 19:55:50 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:55:48 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH RFC v6 2/6] drm/sprd: add Unisoc's drm kms master
Message-ID: <20200828175548.GA660103@ravnborg.org>
References: <1595930879-2478-1-git-send-email-kevin3.tang@gmail.com>
 <1595930879-2478-3-git-send-email-kevin3.tang@gmail.com>
 <20200728204532.GC1277651@ravnborg.org>
 <CAFPSGXaXxr+Du0ptbBHguEPgoHULozSUb-rS3-61pef1fF6b-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFPSGXaXxr+Du0ptbBHguEPgoHULozSUb-rS3-61pef1fF6b-g@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=Gh0u76Fc2OF9ojEVt64A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin

> >
> > > +
> > > +     drm->dev_private = sprd;
> > dev_private is deprecated. Alwyas use upclassing.
> dev_private is deprecated ? I see everyone is still using it, so it
> will be deprecated in the future?
It is deprecated - and a lot of drivers is in need up an update to get
away from using it.

From the kernel-doc:

        /**
         * @dev_private:
         *
         * DRM driver private data. This is deprecated and should be left set to
         * NULL.
         *
         * Instead of using this pointer it is recommended that drivers use
         * drm_dev_init() and embed struct &drm_device in their larger
         * per-device structure.
         */
        void *dev_private;

> > > +     }
> > > +     /* with irq_enabled = true, we can use the vblank feature. */
> > > +     drm->irq_enabled = true;
> > Can drm_irq_install() be used?
> > Then this flag shall not be set by the driver, And the interrupt numbers on different Soc are not necessarily the same
> >
> We need to set "IRQ_NOAUTOEN" flag for CRTC IRQ, you can see that we
> manually turn the interrupt on and off by crtc
> atomic_enable/atomic_disable
> and the interrupt number on different Soc are not necessarily the
> same. So intall interrupt in kms maybe is not suitable for us...

Maybe drm_irq_install() does not fit the need here. But please take an
extra look as what is does is quite basic. And no need to roll your
own if there is available infrstructure that can be used.

But there is nothing wrong rolloing your own if needed.

	Sam
