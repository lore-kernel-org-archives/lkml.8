Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B11C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB1322273
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgDFNEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:04:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:38938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbgDFNEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:04:13 -0400
IronPort-SDR: +mhhf4WQP/SOB1Ta8CdjRhM1ZgY58ZFTaMegAJPWy5ftTob5Bv2JRnncIvTiocCh/DogKCPJPr
 XWIa5mzz2CWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 06:04:01 -0700
IronPort-SDR: M1yeWc4dK0ciV2kr3dpLZnL49hrexu8/JdeW3lQVODOoJAXpSHu0mzrDSeCBWFBGHIqkApSY9t
 jtVqmRz9IVjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,351,1580803200"; 
   d="scan'208";a="424350736"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2020 06:03:59 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jLRQ1-00GBQE-Vd; Mon, 06 Apr 2020 16:04:01 +0300
Date:   Mon, 6 Apr 2020 16:04:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fengping yu <fengping.yu@mediatek.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] Add support for MediaTek keypad
Message-ID: <20200406130401.GV3676135@smile.fi.intel.com>
References: <20200405020114.14787-1-fengping.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200405020114.14787-1-fengping.yu@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 10:01:13AM +0800, Fengping yu wrote:
> 
> This patchset add support to MediaTek matrix keypad.

Seems it has not addressed comments I gave.

> 
> Change since V2:
> - remove extra space and redundant lines
> - update keypad devicetree document debounce time unit
> - change to use devm_platform_ioremap_resource() to simplify resource management
> - use bitmap to store and check keypad state
> 
> fengping.yu (2):
>   add dt-binding document for MediaTek Keypad
>   add MediaTek keypad driver
> 
>  .../devicetree/bindings/input/mtk-kpd.txt     |  61 +++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/input/keyboard/Kconfig                |   7 +
>  drivers/input/keyboard/Makefile               |   1 +
>  drivers/input/keyboard/mtk-kpd.c              | 258 ++++++++++++++++++
>  5 files changed, 328 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mtk-kpd.txt
>  create mode 100644 drivers/input/keyboard/mtk-kpd.c
> 
> --
> 2.18.0
> 

-- 
With Best Regards,
Andy Shevchenko


