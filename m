Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B0FC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695B220672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGUDuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:50:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:19298 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgGUDuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:50:24 -0400
IronPort-SDR: LeaxCREqBpNwJ1VzedhPfGNGNXpsZWDRKicQ8SilmBBUxRB0CQQrdsTOIksa/Ta4lHOGSVU7bH
 FWyOucN2sa2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137545709"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="137545709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 20:50:23 -0700
IronPort-SDR: /5XVtmUxVOAjLvfPM7pFQIbvZL+4s8LLGFglLW4KaEq8z7NF1SHp30/MisacreC+3NaIYSZZeA
 G260C8MNucVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="310084736"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2020 20:50:20 -0700
Date:   Tue, 21 Jul 2020 11:47:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v2 3/3] mfd: intel-m10-bmc: add Max10 BMC chip support
  for Intel FPGA PAC
Message-ID: <20200721034713.GB17091@yilunxu-OptiPlex-7050>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-4-git-send-email-yilun.xu@intel.com>
 <20200717181609.GB905@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717181609.GB905@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 07:16:09PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2020 at 06:42:54PM +0800, Xu Yilun wrote:
> 
> > +static const struct spi_device_id m10bmc_spi_id[] = {
> > +	{ "m10-n3000", M10_N3000 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> 
> > +static struct spi_driver intel_m10bmc_spi_driver = {
> > +	.driver = {
> > +		.name = "intel-m10-bmc",
> > +		.dev_groups = m10bmc_dev_groups,
> > +	},
> > +	.probe = intel_m10_bmc_spi_probe,
> > +	.id_table = m10bmc_spi_id,
> > +};
> 
> > +module_spi_driver(intel_m10bmc_spi_driver);
> 
> This device has no ACPI information - how will it be instantiated?

In our case, The m10-bmc is connected to the intel FPGA (PAC N3000),
which uses the Device Feature List (DFL) mechanism to enumerate features
(devices) on FPGA. Each feature in DFL has a feature_id. And for this
m10-n3000 feature (feature_id = 0xd), it contains a spi-altera & a
m10-n3000 chip. So the DFL subsystem would help enumerate the info.

Recently I added the platform data for slave information in spi-altera,
to support this use case.

Thanks,
Yilun
