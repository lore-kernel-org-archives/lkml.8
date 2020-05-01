Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD05BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1081208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgEAQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:05:27 -0400
Received: from foss.arm.com ([217.140.110.172]:43224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:05:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B893530E;
        Fri,  1 May 2020 09:05:26 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5BC3F68F;
        Fri,  1 May 2020 09:05:24 -0700 (PDT)
Date:   Fri, 1 May 2020 17:05:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        "harb@amperecomputing.com" <harb@amperecomputing.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Message-ID: <20200501160521.GB24840@bogus>
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-6-sudeep.holla@arm.com>
 <426ff8ab-9c13-4301-a91e-989c19c4ff58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426ff8ab-9c13-4301-a91e-989c19c4ff58@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:25:27PM +0100, John Garry wrote:
> On 30/04/2020 12:48, Sudeep Holla wrote:
> > +static int __init smccc_soc_init(void)
> > +{
> > +	struct device *dev;
> > +	int ret, soc_id_rev;
> > +	struct arm_smccc_res res;
> > +	static char soc_id_str[8], soc_id_rev_str[12];
> > +
> > +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
> > +		return 0;
> > +
> > +	ret = smccc_soc_id_support_check();
> > +	if (ret)
> > +		return ret;
> > +
> > +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
> > +
> > +	ret = smccc_map_error_codes(res.a0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	soc_id_version = res.a0;
> > +
> > +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
> > +
> > +	ret = smccc_map_error_codes(res.a0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	soc_id_rev = res.a0;
> > +
> > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > +	if (!soc_dev_attr)
> > +		return -ENOMEM;
> > +
> > +	sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
> > +	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> > +
> > +	soc_dev_attr->soc_id = soc_id_str;
> > +	soc_dev_attr->revision = soc_id_rev_str;
> > +
> > +	soc_dev = soc_device_register(soc_dev_attr);
> > +	if (IS_ERR(soc_dev)) {
> > +		ret = PTR_ERR(soc_dev);
> > +		goto free_soc;
> > +	}
> > +
> > +	dev = soc_device_to_device(soc_dev);
> > +
>
> Just wondering, what about if the platform already had a SoC driver - now it
> could have another one, such that we may have multiple sysfs soc devices,
> right?
>

Yes I had a quick look at that.

1. Such platform has option not to implement this SOC_ID if it doesn't
   really require it.

2. If the firmware starts implementing it on some variants, then we can
   distinguish them with compatibles and blacklist them from the other
   SoC driver if having both is an issue

3. SoC bus layer supports adding multiple SoC ID driver and it may show
   up as /sys/devices/soc<n> which may or may not be fine. But this
   happens only if neither [1] nor [2] is done. I am happy to see if there's
   any solution for this. Any suggestions ?

--
Regards,
Sudeep
