Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BE220734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="dO9rC6U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgFBRwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFBRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:52:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD53C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:52:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s1so13689357ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZgulanud4yuYVbSEY2anFOdC3z8THltqCrqmdc0mYo=;
        b=dO9rC6U35ZJVsEEqeyiT2wqhpSYN9ZFHMHcUxncLMNKJV//15BuMSc2wnN6tjCAEjn
         TGbDcIgy4BS7Dl6Cg5LOM9okR/1FIFpXnuFgZF/LIexlxoI3jpg6+QOS+Cg58yW6wyS0
         WKG1Dr+gmDrfMfj0ZKPlm+bWhBzIbkCDIV20Wt9UtHpsMOJ02zBPUAQKeii04sISDLAH
         OFTa8PehKlXok+f1TsVFQUCaXwQrxXJ1Fs8Rlms6BmuU2aMwAmixXfMXCSvFxUbiHbCB
         XNxz8DVWLPEzDOlU65p4syvY0bUbOKKy2msR0RdtwqXQE4eqWdmg7pTz1Q11FqLhyGlY
         +y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZgulanud4yuYVbSEY2anFOdC3z8THltqCrqmdc0mYo=;
        b=BRAa3Pk6UWD30QzKB302NuZn8MJqlyUwbf0oa95Zy8ywEa4/lXIipo+S5b+3xLtwfo
         VaEL8EMFkVdMSFZL/Np7kI4Or6ad3Tyhk4KpnkGfs5am6Y/+cYlUsqjQSjY3YEfn4Nl2
         gyLRxrpHeOtda/Yhs5wYnSy6La3z4Zsz5I8tbcHlF9tTMLebCHkLUuyW9bE9RDSBtbUE
         TMzesZ/RxxrP2f/2Ljz6j39jc9Zrzty4NjyoRusVw6michUEWAHV/INAnnHFM8mJpC0W
         gTNuCL44MV0i3jad/Gant0DuYUmExiJ6EG4EXJIWlmuMZrePd9Jsk2KXM0odkdRUX3N/
         /IAw==
X-Gm-Message-State: AOAM531IzRnKLIbfAywThEg2gKxP7ICTqT/QBLO4t13EEGH1rugx1bXu
        sHoMwFSXRRm3jVNuNbV3mHRuxoOn9BPdVvB/Gj/Lkg==
X-Google-Smtp-Source: ABdhPJyb9Q+yOpWaTEJsS6SMTCHwieIBoNC2oRXbg7gqhPZ+it4nX/xFtvhER8sXJsj/q7/Cf6w1wYITBiLYGaiqulI=
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr135042ljl.367.1591120352694;
 Tue, 02 Jun 2020 10:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <1aaadf9a5176591c891622cb00b0c50f42e569dc.1590594512.git-series.maxime@cerno.tech>
 <CADaigPWQdeTd2CGCK-yxq+TAU6xKMVsdZfhSVptn4RSENxpdxg@mail.gmail.com> <20200602125227.fe3mt5jnqd6u4pft@gilmour>
In-Reply-To: <20200602125227.fe3mt5jnqd6u4pft@gilmour>
From:   Eric Anholt <eric@anholt.net>
Date:   Tue, 2 Jun 2020 10:52:21 -0700
Message-ID: <CADaigPUYwmwcFDtH3ZtyDaGWvutAYSX=JuMhXh2EtfNVLU6iDQ@mail.gmail.com>
Subject: Re: [PATCH v3 015/105] drm/vc4: hvs: Boost the core clock during modeset
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:52 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Eric,
>
> On Wed, May 27, 2020 at 09:33:44AM -0700, Eric Anholt wrote:
> > On Wed, May 27, 2020 at 8:49 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > In order to prevent timeouts and stalls in the pipeline, the core clock
> > > needs to be maxed at 500MHz during a modeset on the BCM2711.
> >
> > Like, the whole system's core clock?
>
> Yep, unfortunately...
>
> > How is it reasonable for some device driver to crank the system's core
> > clock up and back down to some fixed-in-the-driver frequency? Sounds
> > like you need some sort of opp thing here.
>
> That frequency is the minimum rate of that clock. However, since other
> devices have similar requirements (unicam in particular) with different
> minimum requirements, we will switch to setting a minimum rate instead
> of enforcing a particular rate, so that patch would be essentially
> s/clk_set_rate/clk_set_min_rate/.

clk_set_min_rate makes a lot more sense to me.  r-b with that obvious
change. Thanks!
