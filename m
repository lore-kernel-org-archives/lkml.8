Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CB4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B760820759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595837706;
	bh=eXy/m7JHLeCOts1JoHZUSOPXrsnh+SvaKm23EURb5gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVQ2lkJgUk5voNsnUimBlbPo/Vp0HkEVgnWWRVq49XgqLjbQChfYJiA8xsLzqOOBv
	 pA81qz5J+UJlSTm6b20dRlEzryUX0TIfKUDrsRjCE5YhvsG3F5T1LlrgZ8RmAUeZwO
	 /k9FjT933DSA/lOUIFhU7p+IChM6c6H/OOg1sVXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgG0IPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0IPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:15:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AB72070B;
        Mon, 27 Jul 2020 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595837702;
        bh=eXy/m7JHLeCOts1JoHZUSOPXrsnh+SvaKm23EURb5gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdnkLiFuG7mLHxg/eVJz8zjbPBL9E07Ttn5dB5bjjcnTnYO8p6EN7omVNMTKe3gUa
         5yOY7DLhCQFMBjFYgwjfxXA6Ljprk174qd3bZPvPIsQII8J+B03itxlOUVaZb5dCN6
         plOjwAFohCe2I6lj6KUV95qtaKYi6+bZO8tW3Qzc=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzyHl-00FENM-8d; Mon, 27 Jul 2020 09:15:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     tglx@linutronix.de, Joakim Zhang <qiangqing.zhang@nxp.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, Zenghui Yu <yuzenghui@huawei.com>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com,
        wangjingyi11@huawei.com, wanghaibin.wang@huawei.com,
        kuhn.chenqun@huawei.com
Subject: Re: [PATCH] irqchip/gic-v4.1: Use GFP_ATOMIC flag in allocate_vpe_l1_table()
Date:   Mon, 27 Jul 2020 09:14:49 +0100
Message-Id: <159583764131.244522.1925786531384349855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630133746.816-1-yuzenghui@huawei.com>
References: <20200630133746.816-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: tglx@linutronix.de, qiangqing.zhang@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, yuzenghui@huawei.com, kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com, wangjingyi11@huawei.com, wanghaibin.wang@huawei.com, kuhn.chenqun@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 21:37:46 +0800, Zenghui Yu wrote:
> Booting the latest kernel with DEBUG_ATOMIC_SLEEP=y on a GICv4.1 enabled
> box, I get the following kernel splat:
> 
> [    0.053766] BUG: sleeping function called from invalid context at mm/slab.h:567
> [    0.053767] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/1
> [    0.053769] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3+ #23
> [    0.053770] Call trace:
> [    0.053774]  dump_backtrace+0x0/0x218
> [    0.053775]  show_stack+0x2c/0x38
> [    0.053777]  dump_stack+0xc4/0x10c
> [    0.053779]  ___might_sleep+0xfc/0x140
> [    0.053780]  __might_sleep+0x58/0x90
> [    0.053782]  slab_pre_alloc_hook+0x7c/0x90
> [    0.053783]  kmem_cache_alloc_trace+0x60/0x2f0
> [    0.053785]  its_cpu_init+0x6f4/0xe40
> [    0.053786]  gic_starting_cpu+0x24/0x38
> [    0.053788]  cpuhp_invoke_callback+0xa0/0x710
> [    0.053789]  notify_cpu_starting+0xcc/0xd8
> [    0.053790]  secondary_start_kernel+0x148/0x200
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v4.1: Use GFP_ATOMIC flag in allocate_vpe_l1_table()
      commit: d1bd7e0ba533a2a6f313579ec9b504f6614c35c4

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


