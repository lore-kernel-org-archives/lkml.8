Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B327AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94467206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgEVM1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:27:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:36757 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgEVM1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:27:32 -0400
IronPort-SDR: B5suJ2e4qlICuhbp2xgbBEasQr73qr3vp6aF9i6r6y230YHFKjkXJoMDHWj1FQRN2wrdCztuca
 VJvOPoheGMiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:27:30 -0700
IronPort-SDR: NWN5dJDnXUsXQ04oQAKBsYU5gIqJK6FUXRe2aHRdhrhd52IyQKR9HNREhdbx+cfpvDIsKi3bIJ
 boHtr1ha77rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="265415473"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2020 05:27:17 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jc6lh-008EFe-DI; Fri, 22 May 2020 15:27:17 +0300
Date:   Fri, 22 May 2020 15:27:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tali Perry <tali.perry1@gmail.com>
Cc:     ofery@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, kfting@nuvoton.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, wsa@the-dreams.de,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 2/3] i2c: npcm7xx: Add Nuvoton NPCM I2C controller
 driver
Message-ID: <20200522122717.GB1634618@smile.fi.intel.com>
References: <20200522113312.181413-1-tali.perry1@gmail.com>
 <20200522113312.181413-3-tali.perry1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522113312.181413-3-tali.perry1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:33:11PM +0300, Tali Perry wrote:
> Add Nuvoton NPCM BMC I2C controller driver.

I thought we are waiting for Wolfram finishing his review...


In any case see couple of comments below.

...


> +#ifdef CONFIG_DEBUG_FS

Now, do we need the rest of DEBUG_FS guards?

> +	if (status) {
> +		if (bus->rec_fail_cnt == ULLONG_MAX) {
> +			dev_dbg(bus->dev, "rec_fail_cnt reach max, reset to 0");

> +			bus->rec_fail_cnt = 0;

It's redundant, since we will anyway roll over when incrementing.
https://stackoverflow.com/q/18195715/2511795

> +		}
> +		bus->rec_fail_cnt++;
> +	} else {
> +		if (bus->rec_succ_cnt == ULLONG_MAX) {
> +			dev_dbg(bus->dev, "rec_succ_cnt reach max, reset to 0");

> +			bus->rec_succ_cnt = 0;

Ditto.

> +		}
> +		bus->rec_succ_cnt++;
> +	}
> +#endif

...

> +static int npcm_i2c_remove_bus(struct platform_device *pdev)
> +{
> +	unsigned long lock_flags;
> +	struct npcm_i2c *bus = platform_get_drvdata(pdev);
> +
> +	spin_lock_irqsave(&bus->lock, lock_flags);
> +	npcm_i2c_disable(bus);
> +	spin_unlock_irqrestore(&bus->lock, lock_flags);
> +	i2c_del_adapter(&bus->adap);

> +	debugfs_remove_recursive(bus->debugfs);

This should be in reversed order, i.e. you inited last in ->probe(), thus
should remove first in ->remove().

> +	return 0;
> +}

...

> +static int __init npcm_i2c_init(void)
> +{
> +	struct dentry *dir;
> +
> +	dir = debugfs_create_dir("i2c", NULL);

> +	if (IS_ERR_OR_NULL(dir))

IS_ERR() is redundant. And NULL already being checked inside i2c_init_debugfs()
or how do you call it?

> +		return 0;
> +
> +	npcm_i2c_debugfs_dir = dir;
> +	return 0;
> +}
> +
> +static void __exit npcm_i2c_exit(void)
> +{
> +	debugfs_remove_recursive(npcm_i2c_debugfs_dir);
> +}

> +
> +module_init(npcm_i2c_init);
> +module_exit(npcm_i2c_exit);

Slightly better to attach to the respective function, like other macros above
do.

-- 
With Best Regards,
Andy Shevchenko


