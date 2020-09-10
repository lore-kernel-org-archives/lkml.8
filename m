Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D2F20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgIJJqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:46:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:20464 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgIJJqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:46:48 -0400
IronPort-SDR: RSFpXgk9nZww271BvcZdqf6JzrEkhi+O5Ko2odDr/hsTxWMliyZblIykJogBk82WmgrxTRoZ2L
 EobltJLnNAPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="176562609"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="176562609"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 02:46:28 -0700
IronPort-SDR: XJWYxuPu2GWVcdPC1X7jIACq/yOg+98XSsMf6itNFjMakvjQbmI6JPAEK9khdqPzls+soUVDIq
 uVnblaCZrVLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="334124576"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 02:46:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kGJ9q-00FeiO-8e; Thu, 10 Sep 2020 12:46:22 +0300
Date:   Thu, 10 Sep 2020 12:46:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
Message-ID: <20200910094622.GO1891694@smile.fi.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <a3b95ea8-372b-4f03-0c04-62ee9384fafb@roeck-us.net>
 <c72665ba-b594-bbb0-00c5-ed763233d609@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72665ba-b594-bbb0-00c5-ed763233d609@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:27:11PM +0800, Tanwar, Rahul wrote:
> On 9/9/2020 11:05 pm, Guenter Roeck wrote:
> > On 9/8/20 11:52 PM, Rahul Tanwar wrote:

...

> >> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct pvt_device *pvt = platform_get_drvdata(pdev);
> > I am quite at loss how this is supposed to work. Platform driver
> > data is not initialized with a pointer to struct pvt_device at this point.
> > How does this code not crash ? What am I missing ?
> 
> Big mistake on my part. Last minute change based on internal review feedback
> about moving platform_set_drvdata() at the end of probe. I will fix it in v2.
> Thanks.

Since IIRC it was me who suggested this I should say that reviewer can make
mistakes, on the other hand contributor should have had known their code to
refuse certain changes.

-- 
With Best Regards,
Andy Shevchenko


