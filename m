Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED08C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgGVOgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:36:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:18459 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgGVOgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:36:08 -0400
IronPort-SDR: aQEyGysVT7Jwc6T3JMd3XNGteO8WCibRd37uw7PrwWJgSM32RwY6vv8pNvqSNK2lr4CxhaSCxx
 cj/QHmMjkoTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="130415735"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="130415735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 07:36:08 -0700
IronPort-SDR: 0fDA+wFM2VhH/FNuai2oBdG5m5IqSLN3WBVI03QvuIPscpFFKfhz8xwTE0a1wZJbBU1K9LeRhM
 TUEYRGTotjNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="392692686"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 22 Jul 2020 07:36:05 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 22 Jul 2020 17:36:04 +0300
Date:   Wed, 22 Jul 2020 17:36:04 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor.Ambarus@microchip.com
Cc:     alexander.sverdlin@nokia.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ibr@ilbers.de
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Simulate WRDI command
Message-ID: <20200722143604.GQ5180@lahna.fi.intel.com>
References: <282e1305-fd08-e446-1a22-eb4dff78cfb4@nokia.com>
 <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c17892-24ec-a690-96ca-d2238b8925d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 22, 2020 at 02:28:30PM +0000, Tudor.Ambarus@microchip.com wrote:
> + Mika
> 
> Hi, Mika,
> 
> Would you please review the patch from below?

Sure, there is minor comment below.

> 
> Thanks!
> 
> On 7/22/20 5:01 PM, Alexander Sverdlin wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > 
> > After spi_nor_write_disable() return code checks were introduced in the
> > spi-nor front end intel-spi backend stopped to work because WRDI was never
> > supported and always failed.
> > 
> > Just pretend it was sucessful and ignore the command itself. HW sequencer
> > shall do the right thing automatically, while with SW sequencer we cannot
> > do it anyway, because the only tool we had was preopcode and it makes no
> > sense for WRDI.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: bce679e5ae3a ("mtd: spi-nor: Check for errors after each Register Operation")
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > ---
> >  drivers/mtd/spi-nor/controllers/intel-spi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > index 61d2a0a..134b356 100644
> > --- a/drivers/mtd/spi-nor/controllers/intel-spi.c
> > +++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
> > @@ -612,6 +612,14 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
> >                 return 0;
> >         }
> > 
> > +       /*
> > +        * We hope that HW sequencer will do the right thing automatically and
> > +        * with the SW seuencer we cannot use preopcode any way, so just ignore
                           ^^^^^^^^
Typo, should be sequencer.

Otherwise looks good to me.
