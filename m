Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197E2221ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGNG4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:56:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:8313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgGNG4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:56:40 -0400
IronPort-SDR: vDQ8C2NA79zJsql6egR0wNe5XPyDaU2kO0nW8QtGySHY6vKlRcUNXESXrIFoVFw+37em4zUext
 vzmzxZz81Mxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148826705"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="148826705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 23:56:38 -0700
IronPort-SDR: znEllzvz59U1pi/w5kzWBPXAD5ZqLh2y2GHVbxyKxHuF276SxXROqNt3PASQGjpvpRD6Vzkvy6
 RGXZxKqHbmuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="269932666"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2020 23:56:35 -0700
Date:   Tue, 14 Jul 2020 14:52:28 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 1/2] mfd: intel-m10-bmc: add Max10 BMC chip support for
  Intel FPGA PAC
Message-ID: <20200714065228.GA24900@yilunxu-OptiPlex-7050>
References: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
 <1594614896-16606-2-git-send-email-yilun.xu@intel.com>
 <20200713091708.GC3500@dell>
 <20200714060520.GA27975@yilunxu-OptiPlex-7050>
 <20200714065043.GF3500@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714065043.GF3500@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 07:50:43AM +0100, Lee Jones wrote:
> On Tue, 14 Jul 2020, Xu Yilun wrote:
> 
> > On Mon, Jul 13, 2020 at 10:17:08AM +0100, Lee Jones wrote:
> > > On Mon, 13 Jul 2020, Xu Yilun wrote:
> > > 
> > > > This patch implements the basic functions of the BMC chip for some Intel
> > > > FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> > > > intel max10 CPLD.
> > > > 
> > > > This BMC chip is connected to FPGA by a SPI bus. To provide reliable
> > > > register access from FPGA, an Avalon Memory-Mapped (Avmm) transaction
> > > > protocol over the SPI bus is used between host and slave.
> > > > 
> > > > This driver implements the basic register access with the regmap framework.
> > > > The mfd cells array is empty now as a placeholder.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
> > > >  drivers/mfd/Kconfig                                |  13 +
> > > >  drivers/mfd/Makefile                               |   3 +
> > > >  drivers/mfd/intel-m10-bmc-main.c                   | 176 ++++
> > > 
> > > >  drivers/mfd/intel-spi-avmm.c                       | 904 +++++++++++++++++++++
> > > 
> > > This does not belong in MFD.
> > > 
> > > Please consider moving it to drivers/spi.
> > 
> > OK, I could make the intel-spi-avmm.c as a separate module in other
> > folder.
> > 
> > Since it is an implementation of regmap, is it better we move it to
> > drivers/base/regmap?
> 
> Either way, you need to speak to Mark Brown.

Thanks for your suggestion, I'll contact him.

Yilun.

> 
> > > >  drivers/mfd/intel-spi-avmm.h                       |  35 +
> > > >  include/linux/mfd/intel-m10-bmc.h                  |  57 ++
> > > >  7 files changed, 1203 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > > >  create mode 100644 drivers/mfd/intel-m10-bmc-main.c
> > > >  create mode 100644 drivers/mfd/intel-spi-avmm.c
> > > >  create mode 100644 drivers/mfd/intel-spi-avmm.h
> > > >  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> > > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
