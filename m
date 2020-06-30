Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47004C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE3B20720
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389226AbgF3PJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:09:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:16484 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgF3PJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:09:51 -0400
IronPort-SDR: ydKKbh6B1+NHPB+H4ToQnDJyA5gsPY5oC7mWzUSj4Re3/rtNw5lzOGC6JNRo6HZQ3AW3bGJf9g
 oVAbx5QF9SJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="211322148"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="211322148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 08:09:50 -0700
IronPort-SDR: O2E+r8o1TpeXh1xwXJHt/LXHo4xYjCmrsie9Kv6jlEax5NdR8GTXi6g7v7M1pAr+/bpJ7i2QKz
 nsquXpR8BCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="425236640"
Received: from unknown (HELO rzhang1-mobile) ([10.249.168.95])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 08:09:48 -0700
Message-ID: <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev,
 tz and governor list
From:   Zhang Rui <rui.zhang@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Jun 2020 23:09:47 +0800
In-Reply-To: <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel,

seems that you forgot to cc linux-pm mailing list.

On Tue, 2020-06-30 at 17:16 +0530, Amit Kucheria wrote:
> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> > 
> > The cdev, tz and governor list, as well as their respective locks
> > are
> > statically defined in the thermal_core.c file.
> > 
> > In order to give a sane access to these list, like browsing all the
> > thermal zones or all the cooling devices, let's define a set of
> > helpers where we pass a callback as a parameter to be called for
> > each
> > thermal entity.
> > 
> > We keep the self-encapsulation and ensure the locks are correctly
> > taken when looking at the list.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  drivers/thermal/thermal_core.c | 51
> > ++++++++++++++++++++++++++++++++++
> 
> Is the idea to not use thermal_helpers.c from now on? It fits
> perfectly with a patch I have to merge all its contents to
> thermal_core.c :-)

I agree these changes should be in thermal_helper.c

thanks,
rui
> 
> 
> >  drivers/thermal/thermal_core.h |  9 ++++++
> >  2 files changed, 60 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 2a3f83265d8b..e2f8d2550ecd 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -611,6 +611,57 @@ void
> > thermal_zone_device_rebind_exception(struct thermal_zone_device
> > *tz,
> >         mutex_unlock(&thermal_list_lock);
> >  }
> > 
> > +int for_each_thermal_governor(int (*cb)(struct thermal_governor *,
> > void *),
> > +                             void *data)
> 
> 
> > +{
> > +       struct thermal_governor *gov;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&thermal_governor_lock);
> > +       list_for_each_entry(gov, &thermal_governor_list,
> > governor_list) {
> > +               ret = cb(gov, data);
> > +               if (ret)
> > +                       break;
> > +       }
> > +       mutex_unlock(&thermal_governor_lock);
> > +
> > +       return ret;
> > +}
> > +
> > +int for_each_thermal_cooling_device(int (*cb)(struct
> > thermal_cooling_device *,
> > +                                             void *), void *data)
> > +{
> > +       struct thermal_cooling_device *cdev;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&thermal_list_lock);
> > +       list_for_each_entry(cdev, &thermal_cdev_list, node) {
> > +               ret = cb(cdev, data);
> > +               if (ret)
> > +                       break;
> > +       }
> > +       mutex_unlock(&thermal_list_lock);
> > +
> > +       return ret;
> > +}
> > +
> > +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *,
> > void *),
> > +                         void *data)
> > +{
> > +       struct thermal_zone_device *tz;
> > +       int ret = 0;
> > +
> > +       mutex_lock(&thermal_list_lock);
> > +       list_for_each_entry(tz, &thermal_tz_list, node) {
> > +               ret = cb(tz, data);
> > +               if (ret)
> > +                       break;
> > +       }
> > +       mutex_unlock(&thermal_list_lock);
> > +
> > +       return ret;
> > +}
> > +
> >  void thermal_zone_device_unbind_exception(struct
> > thermal_zone_device *tz,
> >                                           const char *cdev_type,
> > size_t size)
> >  {
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h
> > index 4e271016b7a9..bb8f8aee79eb 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -41,6 +41,15 @@ extern struct thermal_governor
> > *__governor_thermal_table_end[];
> >              __governor < __governor_thermal_table_end; \
> >              __governor++)
> > 
> > +int for_each_thermal_zone(int (*cb)(struct thermal_zone_device *,
> > void *),
> > +                         void *);
> > +
> > +int for_each_thermal_cooling_device(int (*cb)(struct
> > thermal_cooling_device *,
> > +                                             void *), void *);
> > +
> > +int for_each_thermal_governor(int (*cb)(struct thermal_governor *,
> > void *),
> > +                             void *thermal_governor);
> > +
> >  struct thermal_attr {
> >         struct device_attribute attr;
> >         char name[THERMAL_NAME_LENGTH];
> > --
> > 2.17.1
> > 

