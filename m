Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD784C352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A5206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406550AbgDNHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406537AbgDNHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:21:38 -0400
X-Greylist: delayed 993 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 00:21:38 PDT
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3681C0A3BDC;
        Tue, 14 Apr 2020 00:21:38 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 147262A14A0;
        Tue, 14 Apr 2020 08:21:37 +0100 (BST)
Date:   Tue, 14 Apr 2020 09:21:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        anders.roxell@linaro.org, masonccyang@mxic.com.tw,
        piotrs@cadence.com, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200414092132.525053f1@collabora.com>
In-Reply-To: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200414022433.36622-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ramuthevar,

On Tue, 14 Apr 2020 10:24:33 +0800
"Ramuthevar,Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> +	lgm_host->chip.legacy.read_byte = lgm_read_byte;
> +	lgm_host->chip.legacy.read_buf = lgm_read_buf;
> +	lgm_host->chip.legacy.write_buf = lgm_write_buf;
> +	lgm_host->chip.legacy.select_chip = lgm_select_chip;
> +	lgm_host->chip.legacy.dev_ready = lgm_dev_ready;
> +	lgm_host->chip.legacy.cmd_ctrl = lgm_cmd_ctrl;
> +	lgm_host->chip.legacy.chip_delay = 30;
> +	lgm_host->chip.legacy.dummy_controller.ops = &lgm_nand_controller_ops;
> +

Seriously, what's not clear in [1]? Okay, let's say you overlooked this
comment, isn't the name of the field explicit enough? We received a
few other drivers implementing the legacy interface in the last few
months so maybe there's something to improve on our end (update the
doc, move legacy drivers to a legacy sub-dir?).

Back to more constructive comment now: please implement ->exec_op() to
replace those legacy hooks.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v5.7-rc1/source/include/linux/mtd/rawnand.h#L987
