Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74999C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABEF20870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgGAQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:41:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:59026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbgGAQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:41:45 -0400
IronPort-SDR: oRGzju7WHe0OZGl9LaqcDDbdoUmf2ARYMJRugeFBpjYbMBw8Eu8OEx7RZConph0xxhEzlG6KCg
 /kuTKAN/Fp3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="164667469"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="164667469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:41:44 -0700
IronPort-SDR: EoikpcP2W/7ALLzkZ2vGI5g9NRCpYQEm1C/trjn2wIx6E2LQzR+aA5EWw0+bhBo6hQ/J38cF8R
 tmrl0joXQgvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="313825910"
Received: from spandruv-mobl3.amr.corp.intel.com ([10.254.75.215])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2020 09:41:44 -0700
Message-ID: <d3d748b28e2ff540017129c1f3291fcaa68faa21.camel@linux.intel.com>
Subject: Re: [PATCH v2 4/5] thermal: core: genetlink support for
 events/cmd/sampling
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     rkumbako@codeaurora.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 09:41:44 -0700
In-Reply-To: <8526622b-cb31-4d40-95b6-e209b3101563@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <20200625144509.17918-4-daniel.lezcano@linaro.org>
         <73150ef4ca536368f087672b917dd9773417020e.camel@intel.com>
         <23458be6-1e5f-7397-4935-c5268b9f52a6@linaro.org>
         <171936e84c416d7647756d9b453ef2d4475ebdc8.camel@intel.com>
         <4c8abeb4ddff2355d9ba397f50b7844a7734c2e9.camel@linux.intel.com>
         <8526622b-cb31-4d40-95b6-e209b3101563@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 18:31 +0200, Daniel Lezcano wrote:
> On 01/07/2020 17:49, Srinivas Pandruvada wrote:
> > [...]
> > 
> > > Then I'd prefer we only introduce the events that are used or
> > > will be
> > > used soon, like the tz disable/enable, to avoid some potential
> > > dead
> > > code.
> > > We can easily add more events when they are needed.
> > > 
> > > Srinivas, do you have plan to use the trip add/delete events?
> > Yes and also trip modify.
> 
> Ok I will keep those then.
> 
> > Also I need to have one more event for heartbeat like event which
> > needs
> > confirmation from user space to hardware the user process
> > controlling
> > thermal is active not dead. So whenever hardware wants to check
> > health 
> > it will send an event, which user space should acknowledge
> 
> Could it be the opposite? The userspace sends periodically a message
> to
> tell it is alive instead of having the kernel asking the userspace?
> 
Kernel doesn't ask (there is no timer in the kernel). The HW/FW send
special event for confirmation and expects reply (This is upto the
vendors). So user space can't send randomly.

> Is it ok if we add this in a separate series ?
Yes.

Thanks,
Srinivas

> 
> 
> 

