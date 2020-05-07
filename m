Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE29C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A51820838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgEGF2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:28:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33266 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGF2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:28:36 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 633A92A242A;
        Thu,  7 May 2020 06:28:34 +0100 (BST)
Date:   Thu, 7 May 2020 07:28:31 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        anders.roxell@linaro.org, masonccyang@mxic.com.tw,
        robh+dt@kernel.org, linux-mips@vger.kernel.org,
        hauke.mehrtens@intel.com, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com
Subject: Re: [PATCH v5 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200507072831.1bf7f784@collabora.com>
In-Reply-To: <20200507001537.4034-3-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200507001537.4034-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200507001537.4034-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 May 2020 08:15:37 +0800
"Ramuthevar,Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> +	reg = readl(ebu_host->ebu + EBU_ADDR_SEL(ebu_host->cs_num));
> +	writel(reg | EBU_ADDR_MASK(5) | EBU_ADDR_SEL_REGEN,
> +	       ebu_host->ebu + EBU_ADDR_SEL(ebu_host->cs_num));

Seriously, did you really think I would not notice what you're doing
here? You're reading the previous value which either contains a default
mapping or has the mapping set by the bootloader, and write it back to
the register along with a new mask and the REGEN bit set (which
BTW is wrong since you don't mask out other fields before updating
them). This confirms that this Core -> FPI address translation exists
and has to be set properly, so please stop lying about that.
