Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD82208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgIIHtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:49:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:33039 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIIHtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:49:39 -0400
IronPort-SDR: xZG0TLYED3DQ3GYwqhvT0aI8PwVcEOBUi8wAu+7LlqaOAlqS4BOqE/mqgPGOFUQzwTt+25BnwL
 76u6sbBSYfmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="155764832"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="155764832"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 00:49:38 -0700
IronPort-SDR: ZW37UUCOy1QRW9RgXi/SN6w7f1IqMwGoNIL/LukNFw31uIiUoDpn1TkrrHibzmhz3xRQwpe4NY
 8NaQ6aNDvEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="286140168"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2020 00:49:36 -0700
Date:   Wed, 9 Sep 2020 15:45:21 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH] add the FPGA Device Feature List (DFL) EMIF support
Message-ID: <20200909074521.GB10039@yilunxu-OptiPlex-7050>
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <20200908090335.GA24693@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908090335.GA24693@pi3>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:03:35AM +0200, Krzysztof Kozlowski wrote:
> On Tue, Sep 08, 2020 at 04:27:24PM +0800, Xu Yilun wrote:
> > This patch depend on the patchsets: "Modularization of DFL private
> > feature drivers" & "add dfl bus support to MODULE_DEVICE_TABLE()"
> 
> The need for bus I understand but why it depends on the "Modularization
> of DFL private feature drivers"?

Sorry, maybe the titles of the two Patch 0 make confusion.

The patchset "Modularization of DFL private feature drivers" implements
the dfl bus.

The "add dfl bus support to MODULE_DEVICE_TABLE()" adds the support for
dfl driver module autoloading by changing script/mod. It creates the
dfl-bus.h head file that would be used in this driver.

> 
> Anyway I will need a stable tag with mentioned dependencies or this will
> wait for the next cycle.

OK. Maybe I sent it a little earlier. I could wait until the dependencies
are applied.

Thanks,
Yilun

> 
> Best regards,
> Krzysztof
> 
> 
> > 
> > https://lore.kernel.org/linux-fpga/1599488581-16386-1-git-send-email-yilun.xu@intel.com/
> > 
> > The driver supports the EMIF controller on Intel Programmable
> > Acceleration Card (PAC). The controller manages the on-board memory of
> > the PCIe card.
> > 
> > Xu Yilun (1):
> >   memory: dfl-emif: add the DFL EMIF private feature driver
> > 
> >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> >  drivers/memory/Kconfig                             |   9 +
> >  drivers/memory/Makefile                            |   2 +
> >  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
> >  4 files changed, 247 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> >  create mode 100644 drivers/memory/dfl-emif.c
> > 
> > -- 
> > 2.7.4
> > 
