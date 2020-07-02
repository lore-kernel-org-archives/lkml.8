Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48322088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgGBNxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:53:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:16559 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgGBNxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:53:36 -0400
IronPort-SDR: rWSoWPGb0DdeCuFSehYOl3MUqBWoKJT4niOxUWXm1R/5578LT13G4cyCa6O2uaHqVjRPEULf9E
 lLiFxdRcRnQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="126510129"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="126510129"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 06:53:36 -0700
IronPort-SDR: 0ejfvY1REXEbev1ZQh9h3OzQ+QSUB4qTVT2B+qKMn9fPJeSE/m88eB0gekiBcxSJ5ZPFYUQ1B+
 KLnpYB53kIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="482009276"
Received: from gxu8-mobl.amr.corp.intel.com ([10.249.168.57])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2020 06:53:33 -0700
Message-ID: <1a1026055597e0a5d29bb5788e290d50ccc4e0a7.camel@intel.com>
Subject: Re: [PATCH v2 1/5] thermal: core: Add helpers to browse the cdev,
 tz and governor list
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Jul 2020 21:53:33 +0800
In-Reply-To: <18b3139c-725a-017a-4bb1-367c306440b0@linaro.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
         <CAP245DVy+Z9D+6=-cX4TaGFoK-e2N+mWwOvNYOe_E9Fh=7vnaA@mail.gmail.com>
         <bed1d41f81f369e7123a2eab7fde3e81a3b063aa.camel@intel.com>
         <143d954f-2ecf-c4d3-cb7d-f2ea75da8276@linaro.org>
         <766cbdeb2a0f9d9df4f68a71b4b0defd1e95e0be.camel@intel.com>
         <18b3139c-725a-017a-4bb1-367c306440b0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 11:50 +0200, Daniel Lezcano wrote:
> On 01/07/2020 09:57, Zhang Rui wrote:
> 
> [ ... ]
> 
> > > Do you want to move them out?
> > 
> > Then no. I don't have any objection of removing thermal_helper.c,
> > so
> > you can just leave these functions in thermal_core.c
> 
> Shall I consider that as an ack for this patch ?
> 
sure.

Acked-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui
> 

