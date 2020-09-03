Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D34C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE35220709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599157953;
	bh=Xk7ANwQEUDdVwcEafwZ17QaNZ9ncSLQF0MOCl+r1vEQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xvxhaT9Ri6wnz3qweVNoB8wzZ9AIhT8/jwT/Af9GOK2CFTs3LdXa8Smh3QPP4Mi/4
	 xaxBsgkMiBeGjr5bNKgWOq0HgH7dNYdcjayzZ2zww9yqvlIow/25DS2blNl6oZnRlg
	 t2n4s2Cu5u+CY00lg1FmBIiue1uAinpuncK4gxao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgICSc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgICSc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:32:28 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B7120709;
        Thu,  3 Sep 2020 18:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599157948;
        bh=Xk7ANwQEUDdVwcEafwZ17QaNZ9ncSLQF0MOCl+r1vEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Zb6qS+jEMpKgcKdRy8YKYY+BW1jGpQMAx6pjWraBl5y2+vYOvm9W71bYEiS7peFNP
         1z3gKnGCWHORRXUrpRzzdbS1JBsUGQ3fh9zPootJRdxYQyA2i6XtTeCdWq84/MpZhd
         86X47MPsX+qWERHcAqDTQk1uRYRXJo5C2pZSnNoo=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDu25-008xrJ-WA; Thu, 03 Sep 2020 19:32:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: [PATCH v2 0/4] irqchip/gic: Generalize use of HW-based retriggering
Date:   Thu,  3 Sep 2020 19:32:02 +0100
Message-Id: <20200903183206.104838-1-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net, tglx@linutronix.de, valentin.schneider@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin recently pointed out that that relying on SW-based retrigger
with any of the GIC interrupt controllers is both inefficient and
slightly broken, as it messes the GIC's own state machine.

For this to work with the hierarchical irqchip model that the GIC
uses, we need check_irq_resend grow an understanding of hierarchies,
something it has been lacking for some time.

The 3 other patches simply implement the HW resend callbacks, and
finally prevent any SW resend for the GICs.

Unless anyone objects, I plan to take this into 5.10.

* From v1:
  - Dropped most of the patches in favour of a teaching the core
    kernel to use irq_chip_retriger_hierarchy()

Marc Zyngier (2):
  genirq: Walk the irq_data hierarchy when resending an interrupt
  irqchip/git-v3-its: Implement irq_retrigger callback for
    device-triggered LPIs

Valentin Schneider (2):
  irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
  irqchip/gic-v2, v3: Prevent SW resends entirely

 drivers/irqchip/irq-gic-v3-its.c |  6 ++++++
 drivers/irqchip/irq-gic-v3.c     | 12 +++++++++++-
 drivers/irqchip/irq-gic.c        | 12 +++++++++++-
 kernel/irq/resend.c              | 15 +++++++++++++--
 4 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.28.0

