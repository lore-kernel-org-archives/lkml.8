Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94327C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F90E206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgG3OFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:05:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:56869 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgG3OFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:05:32 -0400
IronPort-SDR: VQua/VvMDd41gixSrCSS2LIP89sXhsmHyIa6tFqiccmHYw2pWz0G0L/s7MDjOCM83TRJCJcPoO
 qu/bNagWS82w==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="151576390"
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="151576390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 07:05:31 -0700
IronPort-SDR: AKMJJFBIu5jr1ICXQg/l15EcfQe1U+2usRVL1x101NMBT65GfY0bumP4Ofzw57U69i6KNoF2LP
 m6Gi7LZfe75g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,414,1589266800"; 
   d="scan'208";a="490668091"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2020 07:05:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1k19BW-004xm1-PS; Thu, 30 Jul 2020 17:05:26 +0300
Date:   Thu, 30 Jul 2020 17:05:26 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] gpio: dwapb: Add max GPIOs macro
Message-ID: <20200730140526.GL3703480@smile.fi.intel.com>
References: <20200730135536.19747-1-Sergey.Semin@baikalelectronics.ru>
 <20200730135536.19747-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730135536.19747-5-Sergey.Semin@baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:55:30PM +0300, Serge Semin wrote:
> Add a new macro DWAPB_MAX_GPIOS which defines the maximum possible number
> of GPIO lines corresponding to the maximum DW APB GPIO controller port
> width. Use the new macro instead of number literal 32 where it's
> applicable.

Since it's a modified version of what I sent earlier, perhaps Suggested-by?

-- 
With Best Regards,
Andy Shevchenko


