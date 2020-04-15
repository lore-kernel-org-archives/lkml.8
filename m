Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB74C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5535E206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441082AbgDOGCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:02:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:32283 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441080AbgDOGCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:02:05 -0400
IronPort-SDR: Xdzih+kU46ceIYw9T+hfpavmsDBJtylee84zd1JoMTUPmUKaBaMClpq5IwBw5vNC6cXwo9y7He
 oBhBrXAEO65g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 23:02:03 -0700
IronPort-SDR: XI465BG+7j67qXFLT9dIcHvFNQBQDHurw6IfghYezG/NpWEdYCVIsNDT2k6ZC1QusTyPJdtTbR
 h6Ep06sJKl6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="332402681"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2020 23:02:03 -0700
Received: from [10.214.160.145] (unknown [10.214.160.145])
        by linux.intel.com (Postfix) with ESMTP id 218755802C9;
        Tue, 14 Apr 2020 23:01:56 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        anders.roxell@linaro.org, masonccyang@mxic.com.tw,
        piotrs@cadence.com, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com
References: <20200414022433.36622-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200414092132.525053f1@collabora.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <bb9d2f29-acef-cc1b-8606-bbb38b488cce@linux.intel.com>
Date:   Wed, 15 Apr 2020 14:01:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414092132.525053f1@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

     Thank you so much for review comments and your time...

On 14/4/2020 3:21 pm, Boris Brezillon wrote:
> Hello Ramuthevar,
>
> On Tue, 14 Apr 2020 10:24:33 +0800
> "Ramuthevar,Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
>> +	lgm_host->chip.legacy.read_byte = lgm_read_byte;
>> +	lgm_host->chip.legacy.read_buf = lgm_read_buf;
>> +	lgm_host->chip.legacy.write_buf = lgm_write_buf;
>> +	lgm_host->chip.legacy.select_chip = lgm_select_chip;
>> +	lgm_host->chip.legacy.dev_ready = lgm_dev_ready;
>> +	lgm_host->chip.legacy.cmd_ctrl = lgm_cmd_ctrl;
>> +	lgm_host->chip.legacy.chip_delay = 30;
>> +	lgm_host->chip.legacy.dummy_controller.ops = &lgm_nand_controller_ops;
>> +
> Seriously, what's not clear in [1]? Okay, let's say you overlooked this
> comment, isn't the name of the field explicit enough? We received a
> few other drivers implementing the legacy interface in the last few
> months so maybe there's something to improve on our end (update the
> doc, move legacy drivers to a legacy sub-dir?).
Understood the legacy to latest implementation based ->exec_op(), Thanks!
>
> Back to more constructive comment now: please implement ->exec_op() to
> replace those legacy hooks.

Agreed, will do the implementation of exec_op() hook and update the patches.

Regards
Vadivel
>
> Regards,
>
> Boris
>
> [1]https://elixir.bootlin.com/linux/v5.7-rc1/source/include/linux/mtd/rawnand.h#L987
