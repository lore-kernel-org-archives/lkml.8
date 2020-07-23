Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D101C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66022065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGWGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:22:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:60207 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgGWGW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:22:56 -0400
IronPort-SDR: xsfGA3PQb2iIrV4jbF0K3s7tdxNozigc1cWfO0yld/ybn7Hyy25qFc6kQ19uEWs3vmFH/cT1MO
 wPPqPv/Y5Pgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149647804"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="149647804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 23:22:56 -0700
IronPort-SDR: +qBj/sN4MZPxY4m7ng2TpFYlzzbCueatcNMUHjax+5NgP4EWq9ePx1xDHyQ5suWmKcEKgGGEce
 hBvcKx79NNbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="392904286"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jul 2020 23:22:53 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 23 Jul 2020 09:22:52 +0300
Date:   Thu, 23 Jul 2020 09:22:52 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor.Ambarus@microchip.com
Cc:     alexander.sverdlin@nokia.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ibr@ilbers.de
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Message-ID: <20200723062252.GR5180@lahna.fi.intel.com>
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
 <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
 <20200722143604.GQ5180@lahna.fi.intel.com>
 <99e3f6c7-e9a6-584c-883a-0882f5137b7b@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e3f6c7-e9a6-584c-883a-0882f5137b7b@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 03:18:50PM +0000, Tudor.Ambarus@microchip.com wrote:
> On 7/22/20 5:36 PM, Mika Westerberg wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi,
> > 
> > On Wed, Jul 22, 2020 at 02:28:30PM +0000, Tudor.Ambarus@microchip.com wrote:
> >> + Mika
> >>
> >> Hi, Mika,
> >>
> >> Would you please review the patch from below?
> > 
> > Sure, there is minor comment below.
> > 
> >>
> >> Thanks!
> >>
> >> On 7/22/20 5:01 PM, Alexander Sverdlin wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> >>>
> >>> After spi_nor_write_disable() return code checks were introduced in the
> >>> spi-nor front end intel-spi backend stopped to work because WRDI was never
> >>> supported and always failed.
> >>>
> >>> Just pretend it was sucessful and ignore the command itself. HW sequencer
> >>> shall do the right thing automatically, while with SW sequencer we cannot
> >>> do it anyway, because the only tool we had was preopcode and it makes no
> >>> sense for WRDI.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: bce679e5ae3a ("mtd: spi-nor: Check for errors after each Register Operation")
> >>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> >>> ---
> >>>  drivers/mtd/spi-nor/controllers/intel-spi.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> >>> index 61d2a0a..134b356 100644
> >>> --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> >>> +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> >>> @@ -612,6 +612,14 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
> >>>                 return 0;
> >>>         }
> >>>
> >>> +       /*
> >>> +        * We hope that HW sequencer will do the right thing automatically and
> >>> +        * with the SW seuencer we cannot use preopcode any way, so just ignore
> >                            ^^^^^^^^
> > Typo, should be sequencer.
> > 
> > Otherwise looks good to me.
> > 
> 
> It looks good to me too. Should I add your R-b tag when applying?
> I can fix the typo.

Sure. Thanks!
