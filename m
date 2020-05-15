Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7BEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7125C206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgEOLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:38:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:26982 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgEOLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:38:07 -0400
IronPort-SDR: uQ1tLTC1rZYOkZUYuzJTwjyM4Ig7eojPOXKbEz7k1M+XSpxxrRuBDTRMQ5lFZp9GCuVNfRY4W9
 nsbe1FAbxUMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:38:07 -0700
IronPort-SDR: 7syfHYZiSk8sdH8ji4fv9pM54Sp1BiN4RvBPVmxzksORhZghe3ut/diu/a4C7Nlf1zWtmcXfJu
 gIzg/VPBiymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="464877908"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 15 May 2020 04:38:05 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZYfI-006qgY-Gz; Fri, 15 May 2020 14:38:08 +0300
Date:   Fri, 15 May 2020 14:38:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] Add matrix keypad driver support for Mediatek SoCs
Message-ID: <20200515113808.GQ185537@smile.fi.intel.com>
References: <20200515062007.28346-1-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515062007.28346-1-fengping.yu@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:20:04PM +0800, Fengping Yu wrote:
> 
> Change since v7:
> - specify compatible property as const string
> - add maxItem in required property
> - squash keypad example nodes
> - sort header file with alphabetic order
> - align all define values and add MTK_ prefix to make more uniform
> - change debounce value to default 16ms if not specified in dts
> - remove extra braces
> - separate clk prepare as an internal driver function
> - add special compatible string
> - modify CONFIG_KEYBOARD_MTK_KPD=m to build keypad as ko module

You forgot to address at least some of my comments...

> 
> fengping.yu (3):
>   dt-bindings: Add keypad devicetree documentation
>   drivers: input: keyboard: Add mtk keypad driver
>   configs: defconfig: Add CONFIG_ng.yu (3):
>   dt-bindings: Add keypad devicetree documentation
>   drivers: input: keyboard: Add mtk keypad driver
>   configs: defconfig: Add CONFIG_KEYBOARD_MTK_KPD=m
> 
>  .../devicetree/bindings/input/mtk-kpd.yaml    |  94 +++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/input/keyboard/Kconfig                |   9 +
>  drivers/input/keyboard/Makefile               |   1 +
>  drivers/input/keyboard/mtk-kpd.c              | 231 ++++++++++++++++++
>  5 files changed, 336 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-kpd.yaml
>  create mode 100644 drivers/input/keyboard/mtk-kpd.c
> 
> --
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


