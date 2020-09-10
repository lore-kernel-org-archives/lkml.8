Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AEDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC47320882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgIJJ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:59:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:59262 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgIJJ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:57:24 -0400
IronPort-SDR: IkdEGsVYDeaSHd5zC8Fd3i1SzO3AaG5IbjMmMP1R6K/khjivYSWoMVXbHcnPb2exhCI+sS6nzb
 a6wE20bz+Rlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="157782360"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="157782360"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 02:54:07 -0700
IronPort-SDR: 3iiISJzVPsvq7qAGyQ55MzatYYoTRWENmLKuHQylsst8Jd+oXMVzz4BqbMfT01Ckx2SBEsrYSy
 WfpwSu//TCFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="317858423"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 10 Sep 2020 02:54:01 -0700
Received: from [10.215.160.12] (rtanwar-MOBL.gar.corp.intel.com [10.215.160.12])
        by linux.intel.com (Postfix) with ESMTP id 87C22580223;
        Thu, 10 Sep 2020 02:53:58 -0700 (PDT)
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <a3b95ea8-372b-4f03-0c04-62ee9384fafb@roeck-us.net>
 <c72665ba-b594-bbb0-00c5-ed763233d609@linux.intel.com>
 <20200910094622.GO1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <457b8ff8-4093-3b82-5358-4b8460a1b012@linux.intel.com>
Date:   Thu, 10 Sep 2020 17:53:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910094622.GO1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2020 5:46 pm, Andy Shevchenko wrote:
> On Thu, Sep 10, 2020 at 03:27:11PM +0800, Tanwar, Rahul wrote:
>> On 9/9/2020 11:05 pm, Guenter Roeck wrote:
>>> On 9/8/20 11:52 PM, Rahul Tanwar wrote:
> ...
>
>>>> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name)
>>>> +{
>>>> +	struct device *dev = &pdev->dev;
>>>> +	struct pvt_device *pvt = platform_get_drvdata(pdev);
>>> I am quite at loss how this is supposed to work. Platform driver
>>> data is not initialized with a pointer to struct pvt_device at this point.
>>> How does this code not crash ? What am I missing ?
>> Big mistake on my part. Last minute change based on internal review feedback
>> about moving platform_set_drvdata() at the end of probe. I will fix it in v2.
>> Thanks.
> Since IIRC it was me who suggested this I should say that reviewer can make
> mistakes, on the other hand contributor should have had known their code to
> refuse certain changes.
>

Totally agree. Overlooked in a hasty change..

Regards,
Rahul

