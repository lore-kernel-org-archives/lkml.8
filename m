Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EFAC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A092220665
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgIKIq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:46:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:14967 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgIKIq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:46:56 -0400
IronPort-SDR: qogOanp7CK0wfk8A/OnPv81Wl+4WNauPMihVduL/9PjXvh5U4Zw9uglhsYtifY3rX64SA3H3vb
 IEkWBrTTV+/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="158754969"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="158754969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 01:46:54 -0700
IronPort-SDR: lMqADFKFwljOgFqx8vduhSixSs5mp1gTiaEgPnEu93lFcOin2U0rTbbUToUXpdDiA4BRWDFuDN
 X56/RAtxqjgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; 
   d="scan'208";a="506161956"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2020 01:46:51 -0700
Date:   Fri, 11 Sep 2020 16:42:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH] memory: dfl-emif: add the DFL EMIF private feature driver
Message-ID: <20200911084234.GB7802@yilunxu-OptiPlex-7050>
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <1599553645-26928-2-git-send-email-yilun.xu@intel.com>
 <20200908100102.GB24693@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908100102.GB24693@pi3>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I missed one comments, see inline.

On Tue, Sep 08, 2020 at 12:01:02PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 08, 2020 at 04:27:25PM +0800, Xu Yilun wrote:
> > This driver is for the EMIF private feature implemented under FPGA
> > Device Feature List (DFL) framework. It is used to expose memory
> > interface status information as well as memory clearing control.
> > 
> > The purpose of memory clearing block is to zero out all private memory
> > when FPGA is to be reprogrammed. This gives users a reliable method to
> > prevent potential data leakage.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> >  drivers/memory/Kconfig                             |   9 +
> >  drivers/memory/Makefile                            |   2 +
> >  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
> >  4 files changed, 247 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> >  create mode 100644 drivers/memory/dfl-emif.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > new file mode 100644
> > index 0000000..33d557e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > @@ -0,0 +1,25 @@
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It indicates if the calibration is failed on this
> > +		memory interface. "1" for calibration failure, "0" for OK.
> 
> "if the calibration failed"
> 
> > +		Format: %u
> > +
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read-only. It indicates if the initialization is complete on
> > +		this memory interface. "1" for initialization complete, "0"
> > +		for not yet.
> > +		Format: %u
> 
> "if the initialization completed"
> 
> > +
> > +What:		/sys/bus/dfl/devices/dfl_dev.X/infX_clear
> > +Date:		Sep 2020
> > +KernelVersion:	5.10
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Write-only. Writing "1" to this file will zero out all memory
> > +		data in this memory interface. Writing other values are
> > +		invalid.
> 
> "Writing of other values is invalid."
> 
> > +		Format: %u
> > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > index 8072204..fb0858f 100644
> > --- a/drivers/memory/Kconfig
> > +++ b/drivers/memory/Kconfig
> > @@ -215,6 +215,15 @@ config STM32_FMC2_EBI
> >  	  devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
> >  	  SOCs containing the FMC2 External Bus Interface.
> >  
> > +config FPGA_DFL_EMIF
> > +	tristate "DFL EMIF private feature support"
> > +	depends on FPGA_DFL && HAS_IOMEM
> 
> Cannot be compile tested without FPGA_DFL?

We need this FPGA_DFL dependency. The driver will use the
__dfl_driver_register(), which is defined in drivers/fpga/dfl.c, and
FPGA_DFL enables the compiling of dfl.c

Thanks,
Yilun
