Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3108C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCBB206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIJKmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:42:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:57014 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgIJKmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:42:22 -0400
IronPort-SDR: OkLs0y3qncGHzch1ayqndDUu20zMT031PONAuIQDEO/Ch73fk3vye6YtZdT/GnIUf/dni4729Y
 Glsh97Q9x6ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146212063"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="146212063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 03:42:20 -0700
IronPort-SDR: Wp6FjaA7MVpu0ej/9UBiIVN3UVOB2GV5sui+4rvhO8AuYtubmhVdbh+ONlwyM6/7EGaWyomwT5
 C3qh0znhT3yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="407723770"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2020 03:42:19 -0700
Received: from [10.215.160.12] (rtanwar-MOBL.gar.corp.intel.com [10.215.160.12])
        by linux.intel.com (Postfix) with ESMTP id A68F3580039;
        Thu, 10 Sep 2020 03:42:16 -0700 (PDT)
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
To:     Philipp Zabel <p.zabel@pengutronix.de>, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <b113e2f455f7770fc4852437b1bf3c40c8bc853e.camel@pengutronix.de>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <e0392219-a9aa-169b-a1eb-44644392f06f@linux.intel.com>
Date:   Thu, 10 Sep 2020 18:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b113e2f455f7770fc4852437b1bf3c40c8bc853e.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2020 6:35 pm, Philipp Zabel wrote:
> On Wed, 2020-09-09 at 14:52 +0800, Rahul Tanwar wrote:
>> PVT controller (MR75203) is used to configure & control
>> Moortec embedded analog IP which contains temprature
>> sensor(TS), voltage monitor(VM) & process detector(PD)
>> modules. Add driver to support MR75203 PVT controller.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
> [...]
>> +static int mr75203_probe(struct platform_device *pdev)
>> +{
>> +	const struct hwmon_channel_info **pvt_info;
>> +	u32 ts_num, vm_num, pd_num, val, index, i;
>> +	struct device *dev = &pdev->dev;
>> +	u32 *temp_config, *in_config;
>> +	struct device *hwmon_dev;
>> +	struct pvt_device *pvt;
>> +	int ret;
>> +
>> +	pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
>> +	if (!pvt)
>> +		return -ENOMEM;
>> +
>> +	ret = pvt_get_regmap(pdev, "common");
>> +	if (ret)
>> +		return ret;
>> +
>> +	pvt->rst = devm_reset_control_get(dev, NULL);
> Please use devm_reset_control_get_exclusive().

Well noted. Missed that, thanks.

Regards,
Rahul

