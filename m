Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8D4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5E21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgCCKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:22:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:44175 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgCCKWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:22:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 02:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="351793990"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Mar 2020 02:22:23 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Mar 2020 12:22:22 +0200
Date:   Tue, 3 Mar 2020 12:22:22 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor.Ambarus@microchip.com
Cc:     bbrezillon@kernel.org, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at, joel@jms.id.au, andrew@aj.id.au,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, matthias.bgg@gmail.com,
        vz@mleia.com, michal.simek@xilinx.com, ludovic.barre@st.com,
        john.garry@huawei.com, tglx@linutronix.de,
        nishkadg.linux@gmail.com, michael@walle.cc, dinguyen@kernel.org,
        thor.thayer@linux.intel.com, swboyd@chromium.org,
        opensource@jilayne.com, kstewart@linuxfoundation.org,
        allison@lohutok.net, jethro@fortanix.com, info@metux.net,
        alexander.sverdlin@nokia.com, rfontana@redhat.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/23] mtd: spi-nor: Move Intel bits out of core.c
Message-ID: <20200303102222.GL2540@lahna.fi.intel.com>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200302180730.1886678-13-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302180730.1886678-13-tudor.ambarus@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 06:07:51PM +0000, Tudor.Ambarus@microchip.com wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> Create a SPI NOR manufacturer driver for Intel chips, and move the
> Intel definitions outside of core.c.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
