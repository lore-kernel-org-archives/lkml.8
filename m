Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451022137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgIGDsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:48:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:50798 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgIGDsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:48:31 -0400
IronPort-SDR: 89/j3eGLihNz5b/dITDGkQrkbhmGTszcQBOniSBYIw0LM5EBqWldQhtd3s0qdCaIlYxJSHwnBL
 dROukhcPZhNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="158932740"
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="158932740"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 20:48:29 -0700
IronPort-SDR: 2p1st/nZI1B7u5B+v36cxaiKIgpbX0ySNt4CUN6qG9TZZMMQ4L6Drf2FfAZN6yvpTnirN6RQ0K
 N+jkVQzaberA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,400,1592895600"; 
   d="scan'208";a="377086248"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2020 20:48:29 -0700
Received: from [10.255.167.17] (vramuthx-MOBL1.gar.corp.intel.com [10.255.167.17])
        by linux.intel.com (Postfix) with ESMTP id 5589E58077A;
        Sun,  6 Sep 2020 20:48:25 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v9 0/2] phy: Add USB PHY support on Intel LGM SoC
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
        balbi@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <e61406f7-8198-29c7-3dd4-c7960d19d3ce@linux.intel.com>
Date:   Mon, 7 Sep 2020 11:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828022312.52724-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, Vinod,

   Kindly, can you please merge it if there's no further comments.
   Rob given Reviewed-by tag to USB-PHY  dt_schema YAML patch.
   Philipp Zabel given Reviewed-by tag to USB-PHY driver patch.
   Please consider and do the needful.

Regards
Vadivel

On 28/8/2020 10:23 am, Ramuthevar,Vadivel MuruganX wrote:
> The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
> Requires minimal external components, a single resistor, for best operation.
> Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
> ---
> v9:
>    - Vinod review comments update
>    - remove depends on USB_SUPPORT
>    - replace ret variable by 0 in return statement
>    - replace dev_info by dev_dbg
>    - handle ret and extcon_get_state separately
> v8-resend:
>    - Correct the typo error in my previous patch
> v8:
>    - Rebase to V5.9-rc1
> v7:
>    - No Change
> v6:
>    - No Change
> v5:
>    - As per Felipe and Greg's suggestion usb phy driver reviewed patches
>      changed the folder from drivers/usb/phy to drivers/phy
>    - Reviewed-By tag added in commit message
> v4:
>    - Andy's review comments addressed
>    - drop the excess error debug prints
>    - error check optimized
>    - merge the split line to one line
> v3:
>    - Andy's review comments update
>    - hardcode return value changed to actual return value from the callee
>    - add error check is fixed according to the above
>    - correct the assignment in redundant
>    - combine the split line into one line
> v2:
>    - Address Phillip's review comments
>    - replace devm_reset_control_get() by devm_reset_control_get_exclusive()
>    - re-design the assert and deassert fucntion calls as per review comments
>    - address kbuild bot warnings
>    - add the comments
> v1:
>    - initial version
> ---
> dt-bindings: usb: Add USB PHY support for Intel LGM SoC
> v9:
>    - No Change
> v8-resend:
>    - No change
> v8:
>    - No Change
> v7:
>    - Fixed the bot issue: usb-phy@e7e00000: '#phy-cells' is a required property
> v6:
>    - Fixed the bot issue.
>    - replace node-name by usb-phy@ in example
> v5:
>    - Reviewed-By tag added
> v4:
>    - No Change
> v3:
>    - No Change
> v2:
>    - No Change
> v1:
>    - initial version
>   
> Ramuthevar Vadivel Murugan (2):
>    dt-bindings: phy: Add USB PHY support for Intel LGM SoC
>    phy: Add USB3 PHY support for Intel LGM SoC
> 
>   .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |  58 +++++
>   drivers/phy/Kconfig                                |  10 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-lgm-usb.c                          | 281 +++++++++++++++++++++
>   4 files changed, 350 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>   create mode 100644 drivers/phy/phy-lgm-usb.c
> 
