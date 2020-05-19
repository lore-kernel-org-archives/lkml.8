Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934DB206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgESD4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:56:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:1478 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgESD4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:56:45 -0400
IronPort-SDR: 3flFwuEZPmHp1nw+j2k3UBerhlRwCdUjKU6YlEL5SIOL8hQKSFRNk7YF1f0mVC2tr0tOPReENC
 gOo2ThwUFZmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 20:56:44 -0700
IronPort-SDR: QFxRRniFx2tfaqKTiqe2/A9xXbhaFfZ1jvxhEj2bJAnqaKK53FIltX99ThRNHxjpRnNEdjPdPQ
 ieiRoQO9fuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="264172224"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 18 May 2020 20:56:44 -0700
Received: from [10.213.130.67] (ekotax-mobl.gar.corp.intel.com [10.213.130.67])
        by linux.intel.com (Postfix) with ESMTP id 43E8F5802C9;
        Mon, 18 May 2020 20:56:42 -0700 (PDT)
From:   Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [RESEND PATCH v8 0/3] Add Intel ComboPhy driver
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1589530082.git.eswara.kota@linux.intel.com>
 <1d58e6e6-4860-dbde-1b9e-e0804180cddb@ti.com>
Message-ID: <3e7e3f45-1441-84bd-a218-63847363d9ff@linux.intel.com>
Date:   Tue, 19 May 2020 11:56:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1d58e6e6-4860-dbde-1b9e-e0804180cddb@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2020 9:49 PM, Kishon Vijay Abraham I wrote:
> Dilip,
>
> On 5/15/2020 1:43 PM, Dilip Kota wrote:
>> This patch series adds Intel ComboPhy driver, respective yaml schemas
>>
>> Changes on v8:
>>    As per PHY Maintainer's request add description in comments for doing
>>    register access through register map framework.
>>
>> Changes on v7:
>>    As per System control driver maintainer's inputs remove
>>      fwnode_to_regmap() definition and use device_node_get_regmap()
> Can you fix this warning and resend the patch?
> drivers/phy/intel/phy-intel-combo.c:229:6: warning: ‘cb_mode’ may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>    ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
>    ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/intel/phy-intel-combo.c:204:24: note: ‘cb_mode’ was declared here
>    enum intel_combo_mode cb_mode;
>                          ^~~~~~~
I noticed this warning while preparing the patch.
It sounds like false warning because:
1.) "cb_mode" is initialized in the switch case based on the "mode = 
cbphy->phy_mode;"
2.) cbphy->phy_mode is initialized during the probe in 
"intel_cbphy_fwnode_parse()" with one of the 3 values.
PHY_PCIE_MODE, PHY_SATA_MODE, PHY_XPCS_MODE.
3.) There is no chance of "cbphy->phy_mode" having different value.
4.) And "cb_mode" will be initialized according to the "mode = 
cbphy->phy_mode;"
5.) Hence, there is no chance of "cb_mode" getting accessed uninitialized.

Regards,
Dilip
> Thanks
> Kishon
>>      
>> Changes on v6:
>>    Rebase patches on the latest maintainer's branch
>>    https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7
>> Dilip Kota (3):
>>    dt-bindings: phy: Add PHY_TYPE_XPCS definition
>>    dt-bindings: phy: Add YAML schemas for Intel ComboPhy
>>    phy: intel: Add driver support for ComboPhy
>>
>>   .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
>>   drivers/phy/intel/Kconfig                          |  14 +
>>   drivers/phy/intel/Makefile                         |   1 +
>>   drivers/phy/intel/phy-intel-combo.c                | 632 +++++++++++++++++++++
>>   include/dt-bindings/phy/phy.h                      |   1 +
>>   5 files changed, 749 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>   create mode 100644 drivers/phy/intel/phy-intel-combo.c
>>
