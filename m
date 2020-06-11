Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3830B206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFKKj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:39:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:47919 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgFKKjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:39:52 -0400
IronPort-SDR: rvW4FZpXds/zgrK11PAcerrWa3MUF6c5bAK1d9tW0D2laaa2B2GBHO4HBJ7ednGs8FQbgi4Uqq
 U3XXfluWVsjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 03:39:51 -0700
IronPort-SDR: n1oDAK+8ZZRCo4XPJCfRE/6cleWAyxhiJPzudO4+U5xSV/Bp68ZuhzSbxXvQkATLEVN8eu6V0y
 T7NxhaoTxIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="380349596"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 11 Jun 2020 03:39:48 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 11 Jun 2020 13:39:47 +0300
Date:   Thu, 11 Jun 2020 13:39:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Luis Alberto Herrera <luisalberto@google.com>
Cc:     tudor.ambarus@microchip.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Message-ID: <20200611103947.GC247495@lahna.fi.intel.com>
References: <20200610224652.64336-1-luisalberto@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610224652.64336-1-luisalberto@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 10:46:49PM +0000, Luis Alberto Herrera wrote:
> This change reverts aba3a882a178: "mtd: spi-nor: intel: provide a range
> for poll_timout". That change introduces a performance regression when
> reading sequentially from flash. Logging calls to intel_spi_read without
> this change we get:
> 
> Start MTD read
> [   20.045527] intel_spi_read(from=1800000, len=400000)
> [   20.045527] intel_spi_read(from=1800000, len=400000)
> [  282.199274] intel_spi_read(from=1c00000, len=400000)
> [  282.199274] intel_spi_read(from=1c00000, len=400000)
> [  544.351528] intel_spi_read(from=2000000, len=400000)
> [  544.351528] intel_spi_read(from=2000000, len=400000)
> End MTD read
> 
> With this change:
> 
> Start MTD read
> [   21.942922] intel_spi_read(from=1c00000, len=400000)
> [   21.942922] intel_spi_read(from=1c00000, len=400000)
> [   23.784058] intel_spi_read(from=2000000, len=400000)
> [   23.784058] intel_spi_read(from=2000000, len=400000)
> [   25.625006] intel_spi_read(from=2400000, len=400000)
> [   25.625006] intel_spi_read(from=2400000, len=400000)
> End MTD read
> 
> Signed-off-by: Luis Alberto Herrera <luisalberto@google.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
