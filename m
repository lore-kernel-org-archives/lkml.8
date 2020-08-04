Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2259C2075F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgHDOIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:08:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:53396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgHDOIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:08:41 -0400
IronPort-SDR: XS8qljxKVgjYQavCgI8MnETloa6u60JwZmBS6EoSpsreRNU+86kX8Z1VldaZgKDoVgpURhVuek
 vDNhf6Jhp/qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237173706"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="237173706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 07:08:41 -0700
IronPort-SDR: jpVdsLPzPtpjw2/cTI6dzHctykOsudeBCyXp9XKBMoS4rFelUd68/jIuqJ52axOOw5S+7ClqQx
 Cmd23apcxHOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="396582659"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Aug 2020 07:08:35 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Aug 2020 17:08:34 +0300
Date:   Tue, 4 Aug 2020 17:08:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200804140834.GR1375436@lahna.fi.intel.com>
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:58:17AM -0300, Daniel Gutson wrote:
> Currently, the intel-spi-pci driver tries to unconditionally set
> the SPI chip writeable. After discussing in the LKML, the original
> author decided that it was better  to remove the attempt.
> 
> Context, the intel-spi has a module argument that controls
> whether the driver attempts to turn the SPI flash chip writeable.
> The default value is FALSE (don't try to make it writeable).
> However, this flag applies only for a number of devices, coming from the
> platform driver, whereas the devices detected through the PCI driver
> (intel-spi-pci) are not subject to this check since the configuration
> takes place in intel-spi-pci which doesn't have an argument.
> 
> This patch removes the code that attempts to turn the SPI chip writeable.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
