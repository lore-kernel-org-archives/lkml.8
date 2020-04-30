Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B634EC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B9A20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD3JnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:43:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:60805 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgD3JnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:43:12 -0400
IronPort-SDR: k55GEfD4GdFAJloSy3uuYq3fIyDdSplgtsfvPv6mJ6v0DVCF/1jMRmL25pl/uKzDTVkmO0kCBH
 uJGW2FXDWndw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 02:43:11 -0700
IronPort-SDR: vubHm+YjJpL6zp9QzZo2x4W0201BX47D2rd0k8R/itcBXh7ne5IoOXOVZfX/CENQ8FfKP3ySMM
 zeO4ZixMOAmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="459515686"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 30 Apr 2020 02:43:11 -0700
Received: from [10.213.129.193] (ekotax-mobl.gar.corp.intel.com [10.213.129.193])
        by linux.intel.com (Postfix) with ESMTP id 5283058062D;
        Thu, 30 Apr 2020 02:43:08 -0700 (PDT)
Subject: Re: [PATCH v7 0/3] Add Intel ComboPhy driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <20200430082503.GA3118@dell>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <cbeeda50-1ac8-7b4e-2df5-94049b1cf6b9@linux.intel.com>
Date:   Thu, 30 Apr 2020 17:43:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200430082503.GA3118@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/2020 4:25 PM, Lee Jones wrote:
> On Thu, 30 Apr 2020, Dilip Kota wrote:
>
>> This patch series adds Intel ComboPhy driver, respective yaml schemas
>>
>> Changes on v7:
>>    As per System control driver maintainer's inputs remove
>>      fwnode_to_regmap() definition and use device_node_get_regmap()
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
>>   drivers/phy/intel/phy-intel-combo.c                | 627 +++++++++++++++++++++
>>   include/dt-bindings/phy/phy.h                      |   1 +
> Why have you sent this to me?
The main reason for this patch series is removing fwnode_to_regmap() and 
using device_node_get_regmap() compared to previous patch series.
This has been done as per your review comments.
To keep you updated that changes are done as per your review comments, 
sent to you along with PHY maintainers.

Regards,
Dilip
>
>>   5 files changed, 744 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>>   create mode 100644 drivers/phy/intel/phy-intel-combo.c
>>
