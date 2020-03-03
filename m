Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4098A20873
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCCIlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:41:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:15545 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgCCIlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:41:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 00:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,510,1574150400"; 
   d="scan'208";a="412668418"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2020 00:41:20 -0800
Received: from [10.226.39.43] (unknown [10.226.39.43])
        by linux.intel.com (Postfix) with ESMTP id 1DA54580479;
        Tue,  3 Mar 2020 00:41:17 -0800 (PST)
Subject: Re: [PATCH v4 3/3] phy: intel: Add driver support for ComboPhy
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <4e55050985ef0ab567415625f5d14ab1c9b33994.1583127977.git.eswara.kota@linux.intel.com>
 <20200302111901.GT1224808@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <b0f7742d-7d61-9743-4047-c5352dd7495d@linux.intel.com>
Date:   Tue, 3 Mar 2020 16:41:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200302111901.GT1224808@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/2020 7:19 PM, Andy Shevchenko wrote:
> On Mon, Mar 02, 2020 at 04:43:25PM +0800, Dilip Kota wrote:
>> ComboPhy subsystem provides PHYs for various
>> controllers like PCIe, SATA and EMAC.
> Thanks for an update, my (few minor) comments below.
>
> ...
>
>> +enum intel_phy_mode {
>> +	PHY_PCIE_MODE = 0,
>> +	PHY_XPCS_MODE,
>> +	PHY_SATA_MODE
>  From here it's not visible that above is the only possible values.
> Maybe in the future you will have another mode.
> So, I suggest to leave comma here...
There won't be no further modes,...
i can still add the comma at all the places pointed.
>
>> +};
>> +enum intel_combo_mode {
>> +	PCIE0_PCIE1_MODE = 0,
>> +	PCIE_DL_MODE,
>> +	RXAUI_MODE,
>> +	XPCS0_XPCS1_MODE,
>> +	SATA0_SATA1_MODE
> ...and here...
>
>> +};
>> +
>> +enum aggregated_mode {
>> +	PHY_SL_MODE,
>> +	PHY_DL_MODE
> ...and here.
>
>> +};
> ...
>
>> +static int intel_cbphy_iphy_cfg(struct intel_cbphy_iphy *iphy,
>> +				int (*phy_cfg)(struct intel_cbphy_iphy *))
>> +{
>> +	struct intel_combo_phy *cbphy = iphy->parent;
>> +	struct intel_cbphy_iphy *sphy;
>> +	int ret;
>> +
>> +	ret = phy_cfg(iphy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (cbphy->aggr_mode != PHY_DL_MODE)
>> +		return 0;
>> +
>> +	sphy = &cbphy->iphy[PHY_1];
> Do you really need temporary variable here?
Can be removed, i will update in the next patch.
>
>> +
>> +	return phy_cfg(sphy);
>> +}
> ...
>
>> +	if (!cbphy->init_cnt) {
> 	if (init_cnt)
> 		return 0;
>
> ?

Sure, will do the same.


Thanks,
Dilip

>> +		clk_disable_unprepare(cbphy->core_clk);
>> +		intel_cbphy_rst_assert(cbphy);
>> +	}
>> +
>> +	return 0;
