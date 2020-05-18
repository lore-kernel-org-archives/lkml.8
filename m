Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E52C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF648206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VCHeNapr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgERNtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:49:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40954 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgERNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:49:45 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04IDnbe5096804;
        Mon, 18 May 2020 08:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589809777;
        bh=GwQF3k6O8rIzhSQ8vh0/BGxUXW9aYuYmfPlGt47XLWE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VCHeNaprJpzW3fNJuEpINNJ8qSs3LKApqpvpKoEtIcXdV4DqdJvnSr/RKu5gLOLWf
         gN2/OAJX27+MJgfvK09sskNhrsriORYC0LKY4LNDruVdkVy4Wmu1dgEv7bXa8y2sL+
         D57a0HTQjBnZtIX5dpyUKLjfW93NaWENPC5fckH4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IDnbQN130491;
        Mon, 18 May 2020 08:49:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 08:49:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 08:49:36 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IDnXZX048504;
        Mon, 18 May 2020 08:49:34 -0500
Subject: Re: [RESEND PATCH v8 0/3] Add Intel ComboPhy driver
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <chuanhua.lei@linux.intel.com>,
        <qi-ming.wu@intel.com>, <yixin.zhu@intel.com>
References: <cover.1589530082.git.eswara.kota@linux.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1d58e6e6-4860-dbde-1b9e-e0804180cddb@ti.com>
Date:   Mon, 18 May 2020 19:19:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1589530082.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dilip,

On 5/15/2020 1:43 PM, Dilip Kota wrote:
> This patch series adds Intel ComboPhy driver, respective yaml schemas
> 
> Changes on v8:
>   As per PHY Maintainer's request add description in comments for doing
>   register access through register map framework.
> 
> Changes on v7:
>   As per System control driver maintainer's inputs remove
>     fwnode_to_regmap() definition and use device_node_get_regmap()

Can you fix this warning and resend the patch?
drivers/phy/intel/phy-intel-combo.c:229:6: warning: ‘cb_mode’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
  ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/phy/intel/phy-intel-combo.c:204:24: note: ‘cb_mode’ was declared here
  enum intel_combo_mode cb_mode;
                        ^~~~~~~

Thanks
Kishon
>     
> Changes on v6:
>   Rebase patches on the latest maintainer's branch
>   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7
> Dilip Kota (3):
>   dt-bindings: phy: Add PHY_TYPE_XPCS definition
>   dt-bindings: phy: Add YAML schemas for Intel ComboPhy
>   phy: intel: Add driver support for ComboPhy
> 
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
>  drivers/phy/intel/Kconfig                          |  14 +
>  drivers/phy/intel/Makefile                         |   1 +
>  drivers/phy/intel/phy-intel-combo.c                | 632 +++++++++++++++++++++
>  include/dt-bindings/phy/phy.h                      |   1 +
>  5 files changed, 749 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>  create mode 100644 drivers/phy/intel/phy-intel-combo.c
> 
