Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD50C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C6520746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgEDI0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:26:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:54449 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgEDI0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:26:31 -0400
IronPort-SDR: XQIVl0/Bn8yvL4NUBo0x5gFprq8qvbI6jo7wE8ww0m0SPKARHnET8RkFwv0vVlifBzmvqWgGXV
 FX735Q6My5Zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 01:26:30 -0700
IronPort-SDR: iq1OWIfDRKrB1y2rxCIyDlf5oKIG4N9U67C5R9LClqCkGbscwnvAJCk1MABKmq5eGL58XVTahl
 cxxI6TFv7Bgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="460952773"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2020 01:26:30 -0700
Received: from [10.215.163.15] (ekotax-mobl.gar.corp.intel.com [10.215.163.15])
        by linux.intel.com (Postfix) with ESMTP id 2BD3B580609;
        Mon,  4 May 2020 01:26:26 -0700 (PDT)
Subject: Re: [PATCH v7 3/3] phy: intel: Add driver support for ComboPhy
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
 <20200504072923.GN1375924@vkoul-mobl>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <f12e76ac-e0fd-4afa-e1cd-2b90f175adfd@linux.intel.com>
Date:   Mon, 4 May 2020 16:26:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504072923.GN1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2020 3:29 PM, Vinod Koul wrote:
> On 30-04-20, 15:15, Dilip Kota wrote:
>
>> +enum {
>> +	PHY_0,
>> +	PHY_1,
>> +	PHY_MAX_NUM
> PHY_MAX_NUM = PHY_1?
Driver is using it for no. of PHYs/maximum PHY id.

Code snippets:

struct intel_combo_phy {
...
         struct reset_control    *phy_rst;
         struct reset_control    *core_rst;
         struct intel_cbphy_iphy iphy[PHY_MAX_NUM];
...
}

....

static int intel_cbphy_create(struct intel_combo_phy *cbphy)
{
         struct phy_provider *phy_provider;
         struct device *dev = cbphy->dev;
         struct intel_cbphy_iphy *iphy;
         int i;

         for (i = 0; i < PHY_MAX_NUM; i++) {

...

>
>> +static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
>> +					  u32 mask, u32 val)
>> +{
>> +	u32 reg_val;
>> +
>> +	reg_val = readl(base + reg);
>> +	reg_val &= ~mask;
>> +	reg_val |= FIELD_PREP(mask, val);
>> +	writel(reg_val, base + reg);
> bypassing regmap here... why?
It is not regmap address, one of the below two addresses are passed to 
this function.

struct intel_combo_phy {
...
         void __iomem            *app_base;
         void __iomem            *cr_base;
...
}


>
>> +static int intel_cbphy_calibrate(struct phy *phy)
>> +{
>> +	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
>> +	struct intel_combo_phy *cbphy = iphy->parent;
>> +	void __iomem *cr_base = cbphy->cr_base;
>> +	int val, ret, id;
>> +
>> +	if (cbphy->phy_mode != PHY_XPCS_MODE)
>> +		return 0;
>> +
>> +	id = PHY_ID(iphy);
>> +
>> +	/* trigger auto RX adaptation */
>> +	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
>> +			       ADAPT_REQ_MSK, 3);
>> +	/* Wait RX adaptation to finish */
>> +	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
>> +				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
>> +	if (ret)
>> +		dev_err(cbphy->dev, "RX Adaptation failed!\n");
> you want to continue her and not return error?

Next step is stopping the Adaptation, it should be done in both error 
and success case.

Regards,
Dilip

