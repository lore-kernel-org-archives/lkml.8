Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7292B21481
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 02:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="byDU+17H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIHCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 22:19:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9674 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgIHCTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 22:19:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f56e9a60000>; Mon, 07 Sep 2020 19:17:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 19:19:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 19:19:24 -0700
Received: from [10.19.100.126] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 02:19:17 +0000
Subject: Re: [PATCH v2 11/12] usb: host: xhci-tegra: unlink power domain
 devices
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-12-jckuo@nvidia.com> <20200831124214.GG1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <a05503a2-f904-d3ca-fb79-31e97f8e6630@nvidia.com>
Date:   Tue, 8 Sep 2020 10:19:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831124214.GG1689119@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599531431; bh=u8KgNCAXAoUbdHuK5OzrRoXywcCujwYAMhAAkLqoZ6I=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=byDU+17H2hl6TC36CMM5n987u45GdJqX+rM27XA5pgzVxZP4tm1lgBXhNCtdE0Ax/
         TNDB6X/TlAI27sS64i6R1P6e/awMZKvYf/9KkswbJt1MQUugOJeeNhT3Z98pnFHSnA
         PFmCtk0ZMVd+ewPIUq2JhQvvDVFdrS9xdMR9lLXnrqeC3lX0KoIZkvYpXnV3vfdou1
         Vjvtmy5F78oWHv57pE++EWeo8h5F31zIiPpOyaH0paT/4xmdGcHku/DxV14379ulGC
         onDC0d7jeJU1ogL0LzvhWok9pmEcx17mtEXrNGyyxoq8R5fDkE+VnHbbVrHkR7e6Oq
         Gj4H09dSe6ziA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 8:42 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 12:40:42PM +0800, JC Kuo wrote:
>> This commit unlinks xhci-tegra platform device with ss/host power
>> domain devices. Reasons for this change is - at elpg entry, phy
>> sleepwalk and wake configuration need to be done before powering
>> down ss/host partitions, and phy need be powered off after powering
>> down ss/host partitions. Sequence looks like roughly below:
>>
>>   tegra_xusb_enter_elpg() -> xhci_suspend()
>>                           -> enable phy sleepwalk and wake if needed
>>                           -> power down ss/host partitions
>>                           -> power down phy
>>
>> If ss/host power domains are linked to xhci-tegra platform device, we
>> are not able to perform the sequence like above.
>>
>> This commit introduces:
>>   1. tegra_xusb_unpowergate_partitions() to power up ss and host
>>      partitions together. If ss/host power domain devices are
>>      available, it invokes pm_runtime_get_sync() to request power
>>      driver to power up partitions; If power domain devices are not
>>      available, tegra_powergate_sequence_power_up() will be used to
>>      power up partitions.
>>
>>   2. tegra_xusb_powergate_partitions() to power down ss and host
>>      partitions together. If ss/host power domain devices are
>>      available, it invokes pm_runtime_put_sync() to request power
>>      driver to power down partitions; If power domain devices are not
>>      available, tegra_powergate_power_off() will be used to power down
>>      partitions.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/usb/host/xhci-tegra.c | 202 +++++++++++++++++++---------------
>>  1 file changed, 111 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
>> index 934be1686352..ce6526c2caf6 100644
>> --- a/drivers/usb/host/xhci-tegra.c
>> +++ b/drivers/usb/host/xhci-tegra.c
>> @@ -249,8 +249,6 @@ struct tegra_xusb {
>>  
>>  	struct device *genpd_dev_host;
>>  	struct device *genpd_dev_ss;
>> -	struct device_link *genpd_dl_host;
>> -	struct device_link *genpd_dl_ss;
>>  
>>  	struct phy **phys;
>>  	unsigned int num_phys;
>> @@ -814,36 +812,12 @@ static void tegra_xusb_phy_disable(struct tegra_xusb *tegra)
>>  
>>  static int tegra_xusb_runtime_suspend(struct device *dev)
>>  {
>> -	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> -
>> -	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
>> -	tegra_xusb_clk_disable(tegra);
>> -
>>  	return 0;
>>  }
>>  
>>  static int tegra_xusb_runtime_resume(struct device *dev)
>>  {
>> -	struct tegra_xusb *tegra = dev_get_drvdata(dev);
>> -	int err;
>> -
>> -	err = tegra_xusb_clk_enable(tegra);
>> -	if (err) {
>> -		dev_err(dev, "failed to enable clocks: %d\n", err);
>> -		return err;
>> -	}
>> -
>> -	err = regulator_bulk_enable(tegra->soc->num_supplies, tegra->supplies);
>> -	if (err) {
>> -		dev_err(dev, "failed to enable regulators: %d\n", err);
>> -		goto disable_clk;
>> -	}
>> -
>>  	return 0;
>> -
>> -disable_clk:
>> -	tegra_xusb_clk_disable(tegra);
>> -	return err;
>>  }
>>  
>>  #ifdef CONFIG_PM_SLEEP
>> @@ -1019,10 +993,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
>>  static void tegra_xusb_powerdomain_remove(struct device *dev,
>>  					  struct tegra_xusb *tegra)
>>  {
>> -	if (tegra->genpd_dl_ss)
>> -		device_link_del(tegra->genpd_dl_ss);
>> -	if (tegra->genpd_dl_host)
>> -		device_link_del(tegra->genpd_dl_host);
>>  	if (!IS_ERR_OR_NULL(tegra->genpd_dev_ss))
>>  		dev_pm_domain_detach(tegra->genpd_dev_ss, true);
>>  	if (!IS_ERR_OR_NULL(tegra->genpd_dev_host))
>> @@ -1048,20 +1018,88 @@ static int tegra_xusb_powerdomain_init(struct device *dev,
>>  		return err;
>>  	}
>>  
>> -	tegra->genpd_dl_host = device_link_add(dev, tegra->genpd_dev_host,
>> -					       DL_FLAG_PM_RUNTIME |
>> -					       DL_FLAG_STATELESS);
>> -	if (!tegra->genpd_dl_host) {
>> -		dev_err(dev, "adding host device link failed!\n");
>> -		return -ENODEV;
>> +	return 0;
>> +}
>> +
>> +static int tegra_xusb_unpowergate_partitions(struct tegra_xusb *tegra)
>> +{
>> +	struct device *dev = tegra->dev;
>> +	bool use_genpd;
>> +	int rc;
>> +
>> +	use_genpd = of_property_read_bool(dev->of_node, "power-domains");
> 
> I don't think that's technically correct. Just because a "power-domains"
> property exists in DT doesn't mean any power domains are necessarily
> attached to the device. I think you'll need to check for something like
> 
> 	if (dev->pm_domain)
> 
> here.
> 
Thanks Thierry. I will do so in the next revision.
> Thierry
> 
