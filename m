Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A28C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE306215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIIIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:33:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:20695 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIIdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:33:47 -0400
IronPort-SDR: lb5ns/Thwp9sgI1XRLPXwt7iEgesGVycuxcnBnYHqQAPFY2i+ryc/sXJXSTPZhv8J+a+rJUSZd
 qDElLPqIZ0wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222496062"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="222496062"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 01:33:46 -0700
IronPort-SDR: cpi5SoaFuZf4vJUtvAmBWGnqKlUO+eVPMSqB/cbUPSJZ/HNe4QZ8yVxG3iA4gQIrUf8J6iJp6r
 53FdVwHKuN8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="300081735"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 09 Sep 2020 01:33:43 -0700
Date:   Wed, 9 Sep 2020 16:29:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
  for Intel FPGA PAC
Message-ID: <20200909082929.GA23764@yilunxu-OptiPlex-7050>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
 <20200829182405.GA27132@yilunxu-OptiPlex-7050>
 <20200908120356.GQ4400@dell>
 <20200909060140.GB27300@yilunxu-OptiPlex-7050>
 <20200909073140.GC4400@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909073140.GC4400@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:31:40AM +0100, Lee Jones wrote:
> On Wed, 09 Sep 2020, Xu Yilun wrote:
> 
> > > > > > + * m10bmc_raw_read - read m10bmc register per addr
> > > > > > + * m10bmc_sys_read - read m10bmc system register per offset
> > > > > > + */
> > > > > > +static inline int
> > > > > > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > > > > > +		unsigned int *val)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > > > > > +	if (ret)
> > > > > > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > > > > > +			addr, ret);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > > > > > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > > > > 
> > > > > No unnecessary abstractions.
> > > > > 
> > > > > Just use the Regmap API directly please.
> > > > 
> > > > Could we keep the 2 definition?
> > > > 
> > > > For m10bmc_raw_read(), we make it to help print some error info if
> > > > regmap RW fail. So we don't have to write "if (ret) dev_err" every time
> > > > we use regmap.
> > > 
> > > How many call sites are there?
> > 
> > There are about 20 calls of the register read in m10bmc base driver and
> > sub device drivers. Most of them calls m10bmc_sys_read().
> > I prefer to keep the function for unified error log, but I'm also good
> > to follow your opinion. How do you think?
> 
> Avoidable abstraction is one of my pet hates.  However,
> unified/centralised error handling is a valid(ish) reason for
> abstraction to exist.  Do you really need to know which read failed?
> Is there a case where a read from only a particular register would
> fail where others succeed?

I think it do helps we know which read failed in the first place when
communication error happens between FPGA & BMC.

Generally, if the error happens randomly on all registers, it may be the
problem of SPI bus.

But it is possible in some case error happens on some registers while
others are fine. The BMC has a internal Avalon mmio bus inside, and sub devices
connect on the bus. But the sub devices may response to the bus read/write
request differently according to hardware design. Once I run into a case
that the sub device stucks on one particular register read for long time
cause it prepares data so slowly. And the driver always timeout on that
register.

Thanks,
Yilun

> 
> > I also realize that it is not necessary that we define so many
> > m10bmc_raw_bulk_read/bulk_write/update_bits ... which are not frequently
> > used. We could change them.
> 
> Yes please.
> 
