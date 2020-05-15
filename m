Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AA72065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgEOLkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:40:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:32479 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgEOLkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:40:43 -0400
IronPort-SDR: BLVIduF9zAxdiLkiPEki+ME4jlxwifFFB3sPZdEIC4hHpnnxoMAZGM04F2TQAVIUIS9rThsR3y
 StSR0VKiZQzw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 04:40:43 -0700
IronPort-SDR: Zxm93dBj9QeuaxwdKrGE0EN+mN8jDYSRw9LLjluNBQVeEX+0HcpZst/qTiBxgupCSun+htzg6Y
 x2dIMorsXzvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="287758924"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 15 May 2020 04:40:40 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZYho-006qhy-8y; Fri, 15 May 2020 14:40:44 +0300
Date:   Fri, 15 May 2020 14:40:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] drivers: input: keyboard: Add mtk keypad driver
Message-ID: <20200515114044.GR185537@smile.fi.intel.com>
References: <20200515062007.28346-1-fengping.yu@mediatek.com>
 <20200515062007.28346-3-fengping.yu@mediatek.com>
 <20200515093016.rw5bmvoumgzvkqrc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515093016.rw5bmvoumgzvkqrc@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 11:30:16AM +0200, Marco Felsch wrote:
> On 20-05-15 14:20, Fengping Yu wrote:

...

> > +	depends on OF && HAVE_CLK
> 
> Please drop those deps and instead use:

+1

> depends on ARCH_MEDIATEK && ARM64

I would go even further
	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST

> There are still some missing deps:
> 
> select CONFIG_REGMAP_MMIO
> select INPUT_MATRIXKMAP

...

> > +#define MTK_KPD_DEBOUNCE_MAX_US		256000 /*256ms */
> 
> Thanks for aligning the defines but the 256ms comment is still useless
> as Andy already said.

Yes, it seems my comments partially (?) have been ignored.

-- 
With Best Regards,
Andy Shevchenko


