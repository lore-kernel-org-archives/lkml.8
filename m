Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8EE22522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583866171;
	bh=Z+esqeekOvcK2NlG82c5Na805Zd2SVU9aa9FMtHbcgI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vCyG+nR5cMjQKiNa58fHvfXKnOQsvVf71ys8rgBEvIFFFICQUO5ZpLyN0MAl+Ia4Z
	 PUrm9O/lyjx58yVZLb+qxGufKawtF7LhR6fTEEWC9PfXzmFroTv7rJ2gkGbqfAvF5k
	 kjGLW3gE7d4QAZFQqDDCYDDud6GwnjN4g5ocbTaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCJSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgCJSt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:49:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F18C208C3;
        Tue, 10 Mar 2020 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583866169;
        bh=Z+esqeekOvcK2NlG82c5Na805Zd2SVU9aa9FMtHbcgI=;
        h=From:To:Cc:Subject:Date:From;
        b=e2UggPeF8iA59akyJ483DNpcLE+EGJD1P244SZYW9oLCBJ7O2l2FGNT1KnYCOMYCi
         rP12B1uIXWZj22kFXhhzqtz6KvszfbarvaZoxP3xNrdr8vcMlseCBC27SyRgel3sbe
         z6pkEo+rEIArhs2H0UuUmMmuuvO2qNFu9IE+WAsQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBjwV-00Bi6k-Lr; Tue, 10 Mar 2020 18:49:27 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King <linux@arm.linux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/4] irqchip: Random irq_retrigger fixes
Date:   Tue, 10 Mar 2020 18:49:17 +0000
Message-Id: <20200310184921.23552-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, linux@arm.linux.org.uk, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I was investigating some ugly retrigger locking issues (see patch 4),
I managed to find three occurences of irq_retrigger callbacks that return
the wrong value, leading to a SW retrigger on top of the HW one.

Not really a big deal, but definitely worth fixing.

Marc Zyngier (4):
  irqchip/atmel-aic: Fix irq_retrigger callback return value
  irqchip/atmel-aic5: Fix irq_retrigger callback return value
  ARM: sa1111: Fix irq_retrigger callback return value
  irqchip/gic-v4: Provide irq_retrigger to avoid circular locking
    dependency

 arch/arm/common/sa1111.c         | 7 +++++--
 drivers/irqchip/irq-atmel-aic.c  | 2 +-
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 4 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.20.1

