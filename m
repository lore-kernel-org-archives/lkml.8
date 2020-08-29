Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A884C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F97206F0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgH2S2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 14:28:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:31036 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgH2S2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 14:28:09 -0400
IronPort-SDR: WcDrpoMHtCI4q8gekK8PGC3jF6+8WGhXMZ9R3iZnmGgaRUmezgg0NV86mrUDs/Pcr1872bQbLy
 /sPKevw2c0Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9728"; a="136869677"
X-IronPort-AV: E=Sophos;i="5.76,368,1592895600"; 
   d="scan'208";a="136869677"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2020 11:28:08 -0700
IronPort-SDR: ZOEeWUBHKSNtHlgpsFggnAEf5zpyr/ROlykY7zKoIEJXO13uS8SZO9PCiKmb/IwOqfbU31dcHX
 YvDrhWCvAwEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,368,1592895600"; 
   d="scan'208";a="300591706"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 29 Aug 2020 11:28:05 -0700
Date:   Sun, 30 Aug 2020 02:24:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
  for Intel FPGA PAC
Message-ID: <20200829182405.GA27132@yilunxu-OptiPlex-7050>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
 <20200828100236.GF1826686@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828100236.GF1826686@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments, I'll fix them. Some comments inline.

On Fri, Aug 28, 2020 at 11:02:36AM +0100, Lee Jones wrote:
> On Wed, 19 Aug 2020, Xu Yilun wrote:
> 
> 
> > +enum m10bmc_type {
> > +	M10_N3000,
> > +};
> 
> Seems over-kill.  Will there be others?

There will be another version of the BMC which support the Intel PAC
D5005. The functionalities are similar with N3000. So I defined the
device type enum here.

> > +static ssize_t bmc_version_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> 
> Does this line up to the '(' in code?

Yes, It does.

> 
> > +	struct intel_m10bmc *m10bmc = dev_get_drvdata(dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = m10bmc_sys_read(m10bmc, M10BMC_BUILD_VER, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sprintf(buf, "0x%x\n", val);
> 
> Is this safe?  Have you considered snprintf()?

It formats a 32 bits value to string, so the strlen should be 8 chars at
most. So I think it should be safe here.

I see in Documentation/filesystems/sysfs.rst:
- show() must not use snprintf() when formatting the value to be
  returned to user space. If you can guarantee that an overflow
  will never happen you can use sprintf() otherwise you must use
  scnprintf().

And seeing from this mail https://lkml.org/lkml/2019/4/25/1050
Greg is discouraging use of scnprintf for sysfs attributes where it's not
needed.

> > +}
> > +static DEVICE_ATTR_RO(bmcfw_version);
> > +
> > +static struct attribute *m10bmc_attrs[] = {
> > +	&dev_attr_bmc_version.attr,
> > +	&dev_attr_bmcfw_version.attr,
> > +	NULL,
> > +};
> 
> Can this be const?

Seems we can not const this pointer or this array.

If we const the array, static const struct attribute *m10bmc_attrs[],
then:
	error: initialization from incompatible pointer type

If we const the pointer, static struct attribute * const m10bmc_attrs[],
then:
	warning: initialization discards ‘const’ qualifier from pointer
		 target type

> 
> > +static struct attribute_group m10bmc_attr_group = {
> > +	.attrs = m10bmc_attrs,
> > +};
> 
> Can this be const?

Yes, we can const it.

> 
> > +static const struct attribute_group *m10bmc_dev_groups[] = {
> > +	&m10bmc_attr_group,
> > +	NULL
> 
> > +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
> > +{
> > +	unsigned int v;
> > +
> > +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> > +			    &v))
> > +		return -ENODEV;
> 
> Please break functions out of if statements.
> 
> Does m10bmc_raw_read() return 0 on success?

Yes, this function just wrappered the regmap_read()

> 
> Seems odd for a read function.
> 
> > +	if (v != 0xffffffff) {
> > +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
> > +		return -ENODEV;
> > +	}
> 
> The only acceptable version is -1?

As mentioned by Tom, this is a check if the board is using a very old legacy
bmc version, the driver doesn't mean to support this old legacy bmc
version.


> > +	case M10_N3000:
> > +		cells = m10bmc_pacn3000_subdevs;
> > +		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > +		break;
> > +	default:
> > +		return -ENODEV;
> > +	}
> 
> Will there be other versions?

There will be a M10_D5005, we haven't fully prepared the code yet, but I
mean to reserve the place for it.

> > + * m10bmc_raw_read - read m10bmc register per addr
> > + * m10bmc_sys_read - read m10bmc system register per offset
> > + */
> > +static inline int
> > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > +		unsigned int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > +	if (ret)
> > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > +			addr, ret);
> > +
> > +	return ret;
> > +}
> > +
> > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> 
> No unnecessary abstractions.
> 
> Just use the Regmap API directly please.

Could we keep the 2 definition?

For m10bmc_raw_read(), we make it to help print some error info if
regmap RW fail. So we don't have to write "if (ret) dev_err" every time
we use regmap.

For m10bmc_sys_read(), the offset of BMC system registers could be
configured by HW developers (The MAX 10 is an CPLD, it could be easily
reprogrammed). And the HW SPEC will not add the offset when describing
the addresses of system registers. So:
1. It makes the definition of system registers in code align with HW SPEC.
2. It makes developers easier to make changes when the offset is adjusted
   in HW (I've been told by HW guys, it is sometimes necessary to adjust
   the offset when changing RTL, required by Altera EDA tool - Quartus).

Thanks,
Yilun

> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
