Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51402C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08CFC2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIJKgD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbgIJKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:35:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB9DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:35:30 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kGJvD-0000Cq-K0; Thu, 10 Sep 2020 12:35:19 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kGJvB-0005Vf-7c; Thu, 10 Sep 2020 12:35:17 +0200
Message-ID: <b113e2f455f7770fc4852437b1bf3c40c8bc853e.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com
Date:   Thu, 10 Sep 2020 12:35:17 +0200
In-Reply-To: <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
         <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-09 at 14:52 +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature
> sensor(TS), voltage monitor(VM) & process detector(PD)
> modules. Add driver to support MR75203 PVT controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
[...]
> +static int mr75203_probe(struct platform_device *pdev)
> +{
> +	const struct hwmon_channel_info **pvt_info;
> +	u32 ts_num, vm_num, pd_num, val, index, i;
> +	struct device *dev = &pdev->dev;
> +	u32 *temp_config, *in_config;
> +	struct device *hwmon_dev;
> +	struct pvt_device *pvt;
> +	int ret;
> +
> +	pvt = devm_kzalloc(dev, sizeof(*pvt), GFP_KERNEL);
> +	if (!pvt)
> +		return -ENOMEM;
> +
> +	ret = pvt_get_regmap(pdev, "common");
> +	if (ret)
> +		return ret;
> +
> +	pvt->rst = devm_reset_control_get(dev, NULL);

Please use devm_reset_control_get_exclusive().

regards
Philipp
