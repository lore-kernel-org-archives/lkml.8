Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0943C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36B7207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgHSG6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:58:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:29640 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgHSG6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:58:45 -0400
IronPort-SDR: QEgpoTTnnMkEDWCT7mowxzyeQu3AqxfAKML93F0IeXg5x2rkYPocK2SodPqhoIiv9wy1qmKPpd
 ei4gQEX/McEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="173107488"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="173107488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 23:57:26 -0700
IronPort-SDR: mpXpKRmaLdaHbRyBhNIUX8gOdfa2tGzXchNdovhuh6Zk9QzF9XL14EXa4z+iNhNamAMOSSCJ7u
 BbEn9v8VddRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="400736106"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 18 Aug 2020 23:57:22 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Aug 2020 09:57:21 +0300
Date:   Wed, 19 Aug 2020 09:57:21 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI
 flash chip writable
Message-ID: <20200819065721.GA1375436@lahna.fi.intel.com>
References: <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com>
 <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
 <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
 <CAFmMkTF9eVm0tpOKEy2rzdX=Scr3RwqHDFy_i24R3F5ok-4=eA@mail.gmail.com>
 <CAK8P3a3mf8_Y4DWe3WuBO-Xo0N4Jj=-rrtFzD6w0TriGZPu1_g@mail.gmail.com>
 <CAFmMkTFzmC=aY0gR6urLu-8Oq8aeHBUWi-TodG8XhXKCcC057A@mail.gmail.com>
 <CAK8P3a13N_wNORz_3cYHTN8t29pPrY+dJ+g+1Ga_MmG1TmrUQw@mail.gmail.com>
 <CAFmMkTGm3pMsBzEenYOsRbhOZKFhbHiZ5LxPyVmTdYTTRpKzVQ@mail.gmail.com>
 <CAK8P3a2_RV33kiJ0c34aopZ4iG7LYBR-u=-+BbC+Upyjh1T0Eg@mail.gmail.com>
 <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTHqQO1Gj7VeXr4Y_Umb1KzZc2Pf=1pDQvPPpb_XeAFPqQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:55:59PM -0300, Daniel Gutson wrote:
> > If you care about other (malicious) code writing to the driver, please explain
> > what the specific attack scenario is that you are worried about, and
> > why you think
> > this is not sufficient. What code would be able to write to the device
> > if not the
> > device driver itself?
> 
> Maybe Mika can answer this better, but what I'm trying to do is to
> limit the possibility of
> damage, as explained in the Kconfig:
> "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
> "Say N here unless you know what you are doing. Overwriting the
>   SPI flash may render the system unbootable."

Right, the PCI part of the driver unconditionally (and wrongly) tried to
set the chip writeable.

What this whole thing tries to protect is that the user does not
accidentally write to the flash chip. It contains BIOS and other
important firmware so touching it (if it is not locked in the BIOS side)
may potentially brick the system. That's why we also require that
command line parameter so the user who knows what he or she is doing can
enable it for writing.

Actually thinking about this bit more, to make PCI and the platform
parts consistent we can make the "writeable" control this for the PCI
part as well. So what if we add a callback to struct intel_spi_boardinfo
that the PCI driver populates and then the "core" driver uses to enable
writing when "writeable" is set to 1.
