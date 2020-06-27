Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7162DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEC921548
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 11:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593256109;
	bh=VNdAAGYLRyag3MwdJZ0VrV51pye7OyQAfy2JLn/IyDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y7HG6itIpKfwuhVPv8g4Mfsszl4CXkKnooQonkz/7FOzT/HBZCEktl9IUPov9PD+a
	 O1iq2ZzMBO7rC5mhNBCFug424/pEpBPixo4BRGgXp+cdzv6JeL2QcJ0tiLdssmVya+
	 ZHKG70kBlryqSlR9eHQBRgJj/YlTS8+nGvZSgklU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgF0LIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 07:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgF0LIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 07:08:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB2A20B80;
        Sat, 27 Jun 2020 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593256101;
        bh=VNdAAGYLRyag3MwdJZ0VrV51pye7OyQAfy2JLn/IyDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFdzUa7pKHXxg1BXLmnmt/J4Y/yCDsaa6UQIAOXYDNhkhNlK3N2e96oqKnQtYtkQf
         N2l7mpPh1+yWvS9lepwuzribE7XpQYPO1ZlwNZ4drDOCgDKRuouZZetzyJoKaYPM0m
         0biPzPAF9UNVVEzlaJJW6ZTrardb5D+P7HxCt7IE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jp8h1-006s0z-L5; Sat, 27 Jun 2020 12:08:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Perepech <andrew.perepech@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] irqchip/irq-mtk-sysirq: replace spinlock with raw_spinlock
Date:   Sat, 27 Jun 2020 12:08:01 +0100
Message-Id: <159325548742.93134.3774851842783687845.b4-ty@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074445.3579-1-brgl@bgdev.pl>
References: <20200615074445.3579-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jason@lakedaemon.net, matthias.bgg@gmail.com, brgl@bgdev.pl, tglx@linutronix.de, andrew.perepech@mediatek.com, linux-mediatek@lists.infradead.org, stephane.leprovost@mediatek.com, linux-arm-kernel@lists.infradead.org, pedro.tsai@mediatek.com, bgolaszewski@baylibre.com, fparent@baylibre.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 09:44:45 +0200, Bartosz Golaszewski wrote:
> This driver may take a regular spinlock when a raw spinlock
> (irq_desc->lock) is already taken which results in the following
> lockdep splat:
> 
> =============================
> [ BUG: Invalid wait context ]
> 5.7.0-rc7 #1 Not tainted
> -----------------------------
> swapper/0/0 is trying to lock:
> ffffff800303b798 (&chip_data->lock){....}-{3:3}, at: mtk_sysirq_set_type+0x48/0xc0
> other info that might help us debug this:
> context-{5:5}
> 2 locks held by swapper/0/0:
>  #0: ffffff800302ee68 (&desc->request_mutex){....}-{4:4}, at: __setup_irq+0xc4/0x8a0
>  #1: ffffff800302ecf0 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xe4/0x8a0
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7 #1
> Hardware name: Pumpkin MT8516 (DT)
> Call trace:
>  dump_backtrace+0x0/0x180
>  show_stack+0x14/0x20
>  dump_stack+0xd0/0x118
>  __lock_acquire+0x8c8/0x2270
>  lock_acquire+0xf8/0x470
>  _raw_spin_lock_irqsave+0x50/0x78
>  mtk_sysirq_set_type+0x48/0xc0
>  __irq_set_trigger+0x58/0x170
>  __setup_irq+0x420/0x8a0
>  request_threaded_irq+0xd8/0x190
>  timer_of_init+0x1e8/0x2c4
>  mtk_gpt_init+0x5c/0x1dc
>  timer_probe+0x74/0xf4
>  time_init+0x14/0x44
>  start_kernel+0x394/0x4f0
> 
> [...]

Applied to irq/irqchip-5.9:

[1/1] irqchip/irq-mtk-sysirq: Replace spinlock with raw_spinlock
      commit: 6eeb997ab5075e770a002c51351fa4ec2c6b5c39

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.

