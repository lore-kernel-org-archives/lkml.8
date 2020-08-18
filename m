Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BDF20789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597739504;
	bh=cjUtFFEhvcQwQkw1VVlJuHM2ITwJUHRyNQQzIFZR3Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1jlXoeDbkxD1ZIybdiO8EEycv1dWoYTa+CVVFrbvufhqz0nOMRec5acXCm6kWOh5k
	 jieTVU/cnCyZVAE7kVwU9o67SkKLL8h4VSMGbOAPFJPkXhnRhbz/wEMm6Hwh5Fw4lh
	 Tjy1drYKzquYUonFJDgOFpO5SFEQ69BmeLrLMRyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgHRIbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgHRIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:31:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CACB2067C;
        Tue, 18 Aug 2020 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597739500;
        bh=cjUtFFEhvcQwQkw1VVlJuHM2ITwJUHRyNQQzIFZR3Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rS9YImYIwCC+kc9eRT1/QzM2OjBOFNhgOyh7n7hkABGdbsnSLinFAOHFB5Z4HTCiK
         mChIGSni7plQROsSHXIiVtJcPO2ivbqH/f9kXEoeAWTdKJ5mHMrB7KUQoho54RI7uN
         BSxuKNU76veor9YUNXy4RG9R7Tq7Yrb6nXaK/YHE=
Date:   Tue, 18 Aug 2020 14:01:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] soundwire: add definition for maximum number of ports
Message-ID: <20200818083136.GX2639@vkoul-mobl>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-2-yung-chuan.liao@linux.intel.com>
 <20200818063538.GV2639@vkoul-mobl>
 <DM6PR11MB4074A817AEBB4636095581F2FF5C0@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4074A817AEBB4636095581F2FF5C0@DM6PR11MB4074.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 06:53, Liao, Bard wrote:
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Tuesday, August 18, 2020 2:36 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; tiwai@suse.de;
> > broonie@kernel.org; gregkh@linuxfoundation.org; jank@cadence.com;
> > srinivas.kandagatla@linaro.org; rander.wang@linux.intel.com;
> > ranjani.sridharan@linux.intel.com; hui.wang@canonical.com; pierre-
> > louis.bossart@linux.intel.com; Kale, Sanyog R <sanyog.r.kale@intel.com>; Lin,
> > Mengdong <mengdong.lin@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 1/2] soundwire: add definition for maximum number of
> > ports
> > 
> > On 18-08-20, 01:47, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >
> > > A Device may have at most 15 physical ports (DP0, DP1..DP14).
> > >
> > > Signed-off-by: Pierre-Louis Bossart
> > > <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > > Reviewed-by: Guennadi Liakhovetski
> > > <guennadi.liakhovetski@linux.intel.com>
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > ---
> > >  include/linux/soundwire/sdw.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/soundwire/sdw.h
> > > b/include/linux/soundwire/sdw.h index 76052f12c9f7..0aa4c6af7554
> > > 100644
> > > --- a/include/linux/soundwire/sdw.h
> > > +++ b/include/linux/soundwire/sdw.h
> > > @@ -38,7 +38,8 @@ struct sdw_slave;
> > >  #define SDW_FRAME_CTRL_BITS		48
> > >  #define SDW_MAX_DEVICES			11
> > >
> > > -#define SDW_VALID_PORT_RANGE(n)		((n) <= 14 && (n) >= 1)
> > > +#define SDW_MAX_PORTS			15
> > > +#define SDW_VALID_PORT_RANGE(n)		((n) <
> > SDW_MAX_PORTS && (n) >= 1)
> > 
> > What is the use of this one if we are allocating all ports always, Also, I dont
> > see it used in second patch?
> 
> It is used in drivers/soundwire/stream.c and drivers/soundwire/debugfs.c.

Ah overlooked that it is modified, pls ignore this comment

-- 
~Vinod
