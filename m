Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A162C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61312080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgGWBd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:33:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:56828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgGWBd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:33:26 -0400
IronPort-SDR: B/xjspGd1kxHgIv5kVlLm3b/aGEQ+obFf/EaAtZipob+rIgVJcVf7gQvWwk6bQC9jM7R6Qiooo
 e12HLDok+Mpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="130009611"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="130009611"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 18:33:26 -0700
IronPort-SDR: voMgbNdBHnZbws5Za9ehfWUa347euf/ah5ea3r74CuXLQPqwSIGb78/oYSkQvI94Nm8zX5VQye
 E7vjV8Ox4b7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="272161970"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jul 2020 18:33:24 -0700
Date:   Thu, 23 Jul 2020 09:30:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 1/3] regmap: add Intel SPI Slave to AVMM Bus Bridge
  support
Message-ID: <20200723013013.GA1951@yilunxu-OptiPlex-7050>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-2-git-send-email-yilun.xu@intel.com>
 <20200717181508.GA905@sirena.org.uk>
 <20200720171131.GA18829@yilunxu-OptiPlex-7050>
 <20200722113202.GK4845@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722113202.GK4845@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 12:32:02PM +0100, Mark Brown wrote:
> On Tue, Jul 21, 2020 at 01:11:31AM +0800, Xu Yilun wrote:
> > On Fri, Jul 17, 2020 at 07:15:08PM +0100, Mark Brown wrote:
> 
> > > there looks to be a lot of abstraction layers simply within the software
> > > here which make things hard to follow.  At the very least there doesn't
> 
> > We need to follow the 3 layers protocol for register accessing. On SPI
> > slave side, spi-avmm HW finishes the whole protocol encoding/decoding
> > work. But on host side, no dedicated IP block is designed. So host need
> > to handle all the protocol work by SW. This introduces the complexity of
> > the driver.
> 
> > We don't introduce any extra software layers, just follows the
> > definition of 3 layers in HW spec. But I know reviewing the detail of the
> > protocol is tedious. Maybe I should put more comments about what part of
> > SPEC should be referenced for some piece of code. Hope this makes the
> > review work easier.
> 
> You don't need to reflect all the layers that the system has in the
> software, if some of the layers are always used together with no
> possibility of replacing them then it can make sense to collapse them in
> software.  That did seem to be the case here.

OK. I understand your point.

> 
> > > > +config REGMAP_SPI_AVMM
> > > > +	tristate
> > > > +	depends on SPI
> 
> > > Note that for selected symbols dependencies don't take effect.
> 
> > I see. So should I change something here? I see the same case for other
> > regmap options.
> 
> It's fine, just be aware that you still need to have appropriate
> dependencies and selects in the user.

OK. Thanks for the reminding.

> 
> > > > +/* The input is a trans stream in trans_buf, format a phy stream in phy_buf. */
> > > > +static void pkt_phy_tx_prepare(char *trans_buf, unsigned int trans_len,
> > > > +			       char *phy_buf, unsigned int *phy_len)
> > > > +{
> > > > +	unsigned int i;
> > > > +	char *b, *p;
> > > > +
> > > > +	b = trans_buf;
> > > > +	p = phy_buf;
> 
> > > I'm not seeing any bounds checking on the size of an operation in this
> > > function and I think I'd expect some, similarly for a lot of the other
> > > I/O operations.
> 
> > I have caculated and allocated 2 buffers that are large enough to
> > contain any possible data stream for regmap_bus.max_raw_read/write. See
> > the definition of TRANS_BUF_SIZE & PHY_BUF_SIZE.
> 
> > So maybe we don't have to check the length?
> 
> This isn't at all clear looking at the code, perhaps it would be clearer
> with fewer layers of abstraction but at the minute it's a lot of effort
> to confirm if it's safe.

OK. I'll add the check.

> 
> > > > +	if (spi->bits_per_word != 8 && spi->bits_per_word != 32)
> > > > +		return ERR_PTR(-EINVAL);
> 
> > > Most controllers support configurable bits per word (and modes) - you
> > > shouldn't be rejecting things based on whatever the default happens to
> > > be.
> 
> > I'm not sure if it is good that the spi_avmm_regmap_init changes the
> > configuration of spi devices silently.
> 
> That's the expected usage.
> 
> > In my current implementation, the spi device driver should be aware and
> > choose the right spi setup before trying to init the regmap. Would it be
> > too hard for other drivers to use it?
> 
> It'd be duplicated effort in all the users, if the only way to use the
> bus is with this configuration then simply saying that they're using the
> bus should be enough.

OK. I could add the spi_setup on init.
