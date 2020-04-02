Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560DC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91B1206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 11:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbgDBLpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:41878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbgDBLpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:45:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D98C1045;
        Thu,  2 Apr 2020 04:45:38 -0700 (PDT)
Received: from [10.57.59.199] (unknown [10.57.59.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 209B43F68F;
        Thu,  2 Apr 2020 04:45:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] soc: rockchip: Register a soc_device to retrieve
 revision
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, geert@linux-m68k.org,
        kernel@collabora.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200401153513.423683-1-mylene.josserand@collabora.com>
 <20200401153513.423683-2-mylene.josserand@collabora.com>
 <5143930.cPWVAAQKI9@diego>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4844d3ba-87fa-51f4-0a56-3131e390589a@arm.com>
Date:   Thu, 2 Apr 2020 12:45:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5143930.cPWVAAQKI9@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-01 5:34 pm, Heiko Stübner wrote:
[...]
> The possible problem I see here is clocking and power-domain of the hdmi
> controller in corner-cases. In the past we already had a lot of fun with
> kexec, which also indicates that people actually use kexec productively.
> 
> So while all clocks are ungated and all power-domains are powered on first
> boot, on a system without graphics the pclk+power-domain could be off when
> doing a kexec into a second kernel, which then would probably hang here.

Just to be that guy, how about kdump, where entry to the second kernel 
is predicated on there *not* being a nice clean shutdown? ;)

IMO relying on any particular bootloader behaviour in the kernel is 
fairly fragile - U-Boot has a lot more latitude in assuming it's running 
straight out of reset than Linux does. If we're not going to trust the 
DT to correctly describe the SoC variant in the first place, then it's 
somewhat questionable whether we should trust it for indirectly 
identifying the SoC variant either - it would seem a lot more robust to 
just map the known physical addresses to run a canned sequence of 
register writes that puts things in a known-good state (on the basis 
that this has to run before the 'real' drivers for those things are up, 
and thus can't interfere with them).

Robin.

> Of course with the hdmi-pclk being sourced from hclk_vio we run into a
> chicken-egg-problem, as we need pclk_hdmi_ctrl to register hclk_vio at all.
> 
> So I guess one way out of this could be to
> - amend rk3288_clk_shutdown() to also ungate the hdmi-pclk on shutdown
> - add a shutdown mechanism to the power-domain driver so that it can
>    enable PD_VIO on shutdown
> 
>> +
>> +	if (readl_relaxed(hdmi_base + RK3288_HDMI_REV_REG)
>> +	    == RK3288W_HDMI_REV)
> 
> nit: a nicer look would be something like
> 	val = readl_relaxed(hdmi_base + RK3288_HDMI_REV_REG);
> 	if (val == RK3288W_HDMI_REV)
> 
>> +		revision = RK3288_SOC_REV_RK3288W;
>> +	else
>> +		revision = RK3288_SOC_REV_RK3288;
>> +
>> +	iounmap(hdmi_base);
>> +
>> +	return revision;
>> +}
>> +
>> +static const char *rk3288_socinfo_revision(u32 rev)
>> +{
>> +	const char *soc_rev;
>> +
>> +	switch (rev) {
>> +	case RK3288_SOC_REV_RK3288:
>> +		soc_rev = "RK3288";
>> +		break;
>> +
>> +	case RK3288_SOC_REV_RK3288W:
>> +		soc_rev = "RK3288w";
> 
> can we maybe use lower-case letters for all here?
> 
>> +		break;
>> +
>> +	case RK3288_SOC_REV_NOT_DETECT:
>> +		soc_rev = "";
>> +		break;
>> +
>> +	default:
>> +		soc_rev = "unknown";
>> +		break;
>> +	}
>> +
>> +	return kstrdup_const(soc_rev, GFP_KERNEL);
>> +}
>> +
>> +static const struct of_device_id rk3288_soc_match[] = {
>> +	{ .compatible = "rockchip,rk3288", },
>> +	{ }
>> +};
>> +
>> +static int __init rk3288_soc_init(void)
> 
> as noted at the top, I'd really like to see this more generalized so that
> other socs can just hook in there with a revision callback in a
> rockchip_soc_data struct.
> 
> 
>> +{
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +	struct device_node *np;
>> +
>> +	np = of_find_matching_node(NULL, rk3288_soc_match);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +	if (!soc_dev_attr)
>> +		return -ENOMEM;
>> +
>> +	soc_dev_attr->family = "Rockchip";
>> +	soc_dev_attr->soc_id = "RK32xx";
> 
> nit: rk3288 instead of "32xx" please
> 
>> +
>> +	np = of_find_node_by_path("/");
>> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
>> +	of_node_put(np);
>> +
>> +	soc_dev_attr->revision = rk3288_socinfo_revision(rk3288_revision());
>> +
>> +	soc_dev = soc_device_register(soc_dev_attr);
>> +	if (IS_ERR(soc_dev)) {
>> +		kfree_const(soc_dev_attr->revision);
>> +		kfree_const(soc_dev_attr->soc_id);
>> +		kfree(soc_dev_attr);
>> +		return PTR_ERR(soc_dev);
>> +	}
>> +
>> +	dev_info(soc_device_to_device(soc_dev), "Rockchip %s %s detected\n",
>> +		 soc_dev_attr->soc_id, soc_dev_attr->revision);
> 
> nit: dev_dbg should be enough, that information doesn't really matter for
> most people, as it's only relevant to clock internals.
> 
> 
> Heiko
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
