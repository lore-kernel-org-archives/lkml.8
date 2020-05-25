Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5704FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FDD207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590400989;
	bh=QWmuTSIms62P0ZYptnY7ALuk/JmBEu/4ATlRN4c6WG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=My2eIUfq3bk+Pp1wmFsep6M1vSGsq9JSxV41I2Za0Uxy7UcyVogKQo/HPyFvP6BXJ
	 RCf8GP606ETYSKu3XJMTtGOY5ofnkWLh8So6621RAkg1XOTFcVUh3l3NwiAb0YhnW/
	 +/pdWo8pal87YnV2+d7vNB0/46OBBfxLv/RfTfl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbgEYKDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389398AbgEYKDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:03:06 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBA22078B;
        Mon, 25 May 2020 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590400986;
        bh=QWmuTSIms62P0ZYptnY7ALuk/JmBEu/4ATlRN4c6WG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YoeaMU/SbkGTLQ6xEGnChjsBOp7rUe0dCs/y8iSUU/j0luFmUeT6GKsjn3haZyRtj
         esNhyCzUmzfMJr3FIkTfhh/xvomBTNj9kwLz2NvBBCfjaLAU+uPkfumTxgUwvYIC1p
         YCGQ1+5H4EtfEf49lgv2DmL8Doeg63qBXnKuGnxE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jd9wm-00F7o7-Fo; Mon, 25 May 2020 11:03:04 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs
Date:   Mon, 25 May 2020 11:02:59 +0100
Message-Id: <159040068512.385398.8830285697021452481.b4-ty@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521223500.834-1-valentin.schneider@arm.com>
References: <20200521223500.834-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, valentin.schneider@arm.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 23:35:00 +0100, Valentin Schneider wrote:
> (E)PPIs are per-CPU interrupts, so we want each CPU to go and enable them
> via enable_percpu_irq(); this also means we want IRQ_NOAUTOEN for them as
> the autoenable would lead to calling irq_enable() instead of the more
> appropriate irq_percpu_enable().
> 
> Calling irq_set_percpu_devid() is enough to get just that since it trickles
> down to irq_set_percpu_devid_flags(), which gives us IRQ_NOAUTOEN (and a
> few others). Setting IRQ_NOAUTOEN *again* right after this call is just
> redundant, so don't do it.
> 
> [...]

Applied to irq/irqchip-next, thanks!

[1/1] irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs
      commit: cc86432aa8cc5a81f99d79eea2a29099da694df3

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


