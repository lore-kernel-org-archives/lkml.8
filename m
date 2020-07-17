Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D466C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F0207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGQPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:48:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60286 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgGQPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:48:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7B47200999;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D9F6120097A;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
Received: from fsr-ub1864-126.ea.freescale.net (fsr-ub1864-126.ea.freescale.net [10.171.82.212])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A028E20466;
        Fri, 17 Jul 2020 17:48:07 +0200 (CEST)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] bus: fsl-mc: use raw spin lock to serialize mc cmds
Date:   Fri, 17 Jul 2020 18:47:59 +0300
Message-Id: <20200717154800.17169-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717154800.17169-1-ioana.ciornei@nxp.com>
References: <20200717154800.17169-1-ioana.ciornei@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Replace the spinlock that serializes the MC commands with a raw
spinlock. This is needed for the RT kernel because there are MC
commands sent in interrupt context.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/mc-io.c  | 2 +-
 drivers/bus/fsl-mc/mc-sys.c | 4 ++--
 include/linux/fsl/mc.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 6ae48ad80409..a30b53f1d87d 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -82,7 +82,7 @@ int __must_check fsl_create_mc_io(struct device *dev,
 	mc_io->portal_phys_addr = mc_portal_phys_addr;
 	mc_io->portal_size = mc_portal_size;
 	if (flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
-		spin_lock_init(&mc_io->spinlock);
+		raw_spin_lock_init(&mc_io->spinlock);
 	else
 		mutex_init(&mc_io->mutex);
 
diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index 3221a7fbaf0a..85a0225db522 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -251,7 +251,7 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd)
 		return -EINVAL;
 
 	if (mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
-		spin_lock_irqsave(&mc_io->spinlock, irq_flags);
+		raw_spin_lock_irqsave(&mc_io->spinlock, irq_flags);
 	else
 		mutex_lock(&mc_io->mutex);
 
@@ -287,7 +287,7 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd)
 	error = 0;
 common_exit:
 	if (mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
-		spin_unlock_irqrestore(&mc_io->spinlock, irq_flags);
+		raw_spin_unlock_irqrestore(&mc_io->spinlock, irq_flags);
 	else
 		mutex_unlock(&mc_io->mutex);
 
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index cdb03aca2aef..a428c61ead6e 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -339,7 +339,7 @@ struct fsl_mc_io {
 		 * This field is only meaningful if the
 		 * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is set
 		 */
-		spinlock_t spinlock;	/* serializes mc_send_command() */
+		raw_spinlock_t spinlock; /* serializes mc_send_command() */
 	};
 };
 
-- 
2.25.1

