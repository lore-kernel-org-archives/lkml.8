Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECE820719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:27:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:10481 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgHCK1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:27:15 -0400
IronPort-SDR: 9jwBHqog9KLWoOggEYh55zbnv8MF7AKv248tvbzaM2mkJ3KH4QQoVC0tNEpQHG75rOKh4kXceE
 +3/hBebNutSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="170177126"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="170177126"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 03:27:15 -0700
IronPort-SDR: H9lYg74O1xebpaI6b6EZdRmjDAQPlOpwirNhgyZ2s0cdTHeBTHCu2D1Fq/0HrZRTKlhci/g4ng
 B8Ov6ZIjMLCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="396009806"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Aug 2020 03:27:11 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Aug 2020 13:27:11 +0300
Date:   Mon, 3 Aug 2020 13:27:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci
 attempts to turn the SPI flash chip writeable
Message-ID: <20200803102711.GK1375436@lahna.fi.intel.com>
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200803095720.GC1375436@lahna.fi.intel.com>
 <CAD2FfiFt6=OueX3E0g2ckPU+7F69yCmM0+bzF_6UD1sd4E_k_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiFt6=OueX3E0g2ckPU+7F69yCmM0+bzF_6UD1sd4E_k_A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:18:12AM +0100, Richard Hughes wrote:
> On Mon, 3 Aug 2020 at 10:57, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > I think instead of this we should simply make it so that the driver
> > never tries to make the chip writable.
> 
> I think this is a good idea, but I wasn't sure if it was an acceptable
> behaviour change. Should the driver still try to set BCR_WPD when
> writing an image (i.e. defer the setting of write enable until later),
> or just not set the BCR register at all? I think your last comment was
> the latter, but wanted to check.

I would say not set it at all. I think it was (my) mistake to set it in
the first place.
