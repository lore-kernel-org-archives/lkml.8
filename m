Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF45C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 702D22073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgGAH5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:57:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:44764 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgGAH5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:57:20 -0400
IronPort-SDR: RbvJZxjHpjZrk6WqmuCskuvxwiNUE52EaVLZzGHDXihUzCGmzqjmBQIDkKgEtskB9sSgHKKThx
 jlXoa+uEm2qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146502495"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146502495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 00:57:20 -0700
IronPort-SDR: LH+m/jfBuCGxAcBnAxx84P6ZHKDTUjPlCGCSARjNovlubKAs7+e5S9JzOsnI63QPfHQEkEX2Vq
 F3LLedvVJwRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="425503221"
Received: from yumao-mobl1.ccr.corp.intel.com ([10.255.29.220])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2020 00:57:18 -0700
Message-ID: <766cbdeb2a0f9d9df4f68a71b4b0defd1e95e0be.camel@intel.com>
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev,
 tz and governor list
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 01 Jul 2020 15:57:17 +0800
In-Reply-To: <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
         <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
         <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 09:35 +0200, Daniel Lezcano wrote:
> On 30/06/2020 17:09, Zhang Rui wrote:
> > Hi, Daniel,
> > 
> > seems that you forgot to cc linux-pm mailing list.
> > 
> > On Tue, 2020-06-30 at 17:16 +0530, Amit Kucheria wrote:
> > > On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > > > 
> > > > The cdev, tz and governor list, as well as their respective
> > > > locks
> > > > are
> > > > statically defined in the thermal_core.c file.
> > > > 
> > > > In order to give a sane access to these list, like browsing all
> > > > the
> > > > thermal zones or all the cooling devices, let's define a set of
> > > > helpers where we pass a callback as a parameter to be called
> > > > for
> > > > each
> > > > thermal entity.
> > > > 
> > > > We keep the self-encapsulation and ensure the locks are
> > > > correctly
> > > > taken when looking at the list.
> > > > 
> > > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > > ---
> > > >  drivers/thermal/thermal_core.c | 51
> > > > ++++++++++++++++++++++++++++++++++
> > > 
> > > Is the idea to not use thermal_helpers.c from now on? It fits
> > > perfectly with a patch I have to merge all its contents to
> > > thermal_core.c :-)
> > 
> > I agree these changes should be in thermal_helper.c
> 
> Oh, actually I remind put those functions in the thermal_core.c file
> because they need the locks which are statically defined in there.
> 
> If the functions are moved to thermal_helper.c that will imply to
> export
> the locks outside of the file, thus breaking the self-encapsulation.
> 
> Do you want to move them out?

Then no. I don't have any objection of removing thermal_helper.c, so
you can just leave these functions in thermal_core.c

thanks,
rui
> 
> 

