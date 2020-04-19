Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15844C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 22:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BED218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDSWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 18:20:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:43066 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSWUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 18:20:42 -0400
IronPort-SDR: YarkP1peTj8pJ7DIXHjLJ++DrfDCHRVCYRgbAaudPInYeTp7P3vRN23Klse9O51CmJ0qoeerVe
 qDnLIMV0njzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 15:20:42 -0700
IronPort-SDR: iMyrqd0w9kkDgNJOqMuBhbWjtqKbPncMEvlvXXKhv/G3fplHyqe9BIQAcCQusETU+x7wl+zSaq
 U4QSkck0WrNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,404,1580803200"; 
   d="scan'208";a="246747551"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2020 15:20:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jQIIq-001v70-5G; Mon, 20 Apr 2020 01:20:40 +0300
Date:   Mon, 20 Apr 2020 01:20:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        anders.roxell@linaro.org, masonccyang@mxic.com.tw,
        piotrs@cadence.com, robh+dt@kernel.org, linux-mips@vger.kernel.org,
        hauke.mehrtens@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com
Subject: Re: [PATCH v2 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200419222040.GJ185537@smile.fi.intel.com>
References: <20200417082147.43384-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200417082147.43384-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200418105533.477ce529@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418105533.477ce529@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 10:55:33AM +0200, Boris Brezillon wrote:
> On Fri, 17 Apr 2020 16:21:47 +0800
> "Ramuthevar,Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> 
> > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

> > +static const struct of_device_id lgm_nand_match[] = {
> > +	{ .compatible = "intel,lgm-nand", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, lgm_nand_match);
> 
> You probably have a missing "depends on OF" in your Kconfig.

Since it's using device property API, dependency is not needed.

-- 
With Best Regards,
Andy Shevchenko


