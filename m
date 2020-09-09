Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E2921532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIIGF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:05:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:17843 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgIIGF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:05:57 -0400
IronPort-SDR: q93NnxIEpzV9PRIfttv+r/DkEEGjVpOfuhoKCInPMeTNiZM1JBRWOBoiwhjzbFtPIAMAiBLPTO
 kasNPDZDzt1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="138318994"
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="138318994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 23:05:57 -0700
IronPort-SDR: 4pdNsw0ohE71pVTYhIzAUE7J/bNUtGDMR1TPasdybVPyFKeVAt68sia7uoQWmZk6s0smyc6F8v
 acB8Bu4Mh7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,408,1592895600"; 
   d="scan'208";a="377762514"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2020 23:05:55 -0700
Date:   Wed, 9 Sep 2020 14:01:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
  for Intel FPGA PAC
Message-ID: <20200909060140.GB27300@yilunxu-OptiPlex-7050>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
 <20200829182405.GA27132@yilunxu-OptiPlex-7050>
 <20200908120356.GQ4400@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908120356.GQ4400@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > + * m10bmc_raw_read - read m10bmc register per addr
> > > > + * m10bmc_sys_read - read m10bmc system register per offset
> > > > + */
> > > > +static inline int
> > > > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > > > +		unsigned int *val)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > > > +	if (ret)
> > > > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > > > +			addr, ret);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > > > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > > 
> > > No unnecessary abstractions.
> > > 
> > > Just use the Regmap API directly please.
> > 
> > Could we keep the 2 definition?
> > 
> > For m10bmc_raw_read(), we make it to help print some error info if
> > regmap RW fail. So we don't have to write "if (ret) dev_err" every time
> > we use regmap.
> 
> How many call sites are there?

There are about 20 calls of the register read in m10bmc base driver and
sub device drivers. Most of them calls m10bmc_sys_read().
I prefer to keep the function for unified error log, but I'm also good
to follow your opinion. How do you think?

I also realize that it is not necessary that we define so many
m10bmc_raw_bulk_read/bulk_write/update_bits ... which are not frequently
used. We could change them.

> 
> > For m10bmc_sys_read(), the offset of BMC system registers could be
> > configured by HW developers (The MAX 10 is an CPLD, it could be easily
> > reprogrammed). And the HW SPEC will not add the offset when describing
> > the addresses of system registers. So:
> > 1. It makes the definition of system registers in code align with HW SPEC.
> > 2. It makes developers easier to make changes when the offset is adjusted
> >    in HW (I've been told by HW guys, it is sometimes necessary to adjust
> >    the offset when changing RTL, required by Altera EDA tool - Quartus).
> 
> Make sure you justify this for the function(s) you keep.

Yes, I could add some comments.

Thanks,
Yilun
