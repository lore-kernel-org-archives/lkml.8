Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C054C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7475E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198535;
	bh=+MuCIbyR++NZWrbz6ckxm4mC9ZSU2sDaXve+JGekCIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TkpYRAfm0rGX1S242VQTfCEvvbczaPt36DgA6I4/3g1URMqa1kKicEwpB0oHu3MGf
	 4qhMBPPh1Po40KcYv5tbUPbEa+w1Gsjnis9gDWmgkESgxY4NAPkR+W4Sf50idp3+g2
	 PI8qRFKEEOGqS0Y9OKZX54z3HGZSXUIQ/rwFxAtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392829AbgAPR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:29:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392779AbgAPR3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:29:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84FD9246FB;
        Thu, 16 Jan 2020 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195778;
        bh=+MuCIbyR++NZWrbz6ckxm4mC9ZSU2sDaXve+JGekCIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPx7U92spo0r4WZKJZkoJ9OJQnZCH2ExYlyqGwZffAtowtbUeuXpqYf6WAfv/wcp+
         D3MxAYQU9rdfZKOYnLfEMVIpTtjLqG4Gs7gR1VXwCrtN+dQzWy4ckQOEEyDY8YKKFZ
         mQ8QimK124zGze1wadJN1fg9wL6DYjO3edIEcdAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 303/371] net: aquantia: Fix aq_vec_isr_legacy() return value
Date:   Thu, 16 Jan 2020 12:22:55 -0500
Message-Id: <20200116172403.18149-246-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 31aefe14bc9f56566041303d733fda511d3a1c3e ]

The irqreturn_t type is an enum or an unsigned int in GCC.  That
creates to problems because it can't detect if the
self->aq_hw_ops->hw_irq_read() call fails and at the end the function
always returns IRQ_HANDLED.

drivers/net/ethernet/aquantia/atlantic/aq_vec.c:316 aq_vec_isr_legacy() warn: unsigned 'err' is never less than zero.
drivers/net/ethernet/aquantia/atlantic/aq_vec.c:329 aq_vec_isr_legacy() warn: always true condition '(err >= 0) => (0-u32max >= 0)'

Fixes: 970a2e9864b0 ("net: ethernet: aquantia: Vector operations")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 5fecc9a099ef..bb2894a333f2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -310,15 +310,13 @@ irqreturn_t aq_vec_isr_legacy(int irq, void *private)
 {
 	struct aq_vec_s *self = private;
 	u64 irq_mask = 0U;
-	irqreturn_t err = 0;
+	int err;
 
-	if (!self) {
-		err = -EINVAL;
-		goto err_exit;
-	}
+	if (!self)
+		return IRQ_NONE;
 	err = self->aq_hw_ops->hw_irq_read(self->aq_hw, &irq_mask);
 	if (err < 0)
-		goto err_exit;
+		return IRQ_NONE;
 
 	if (irq_mask) {
 		self->aq_hw_ops->hw_irq_disable(self->aq_hw,
@@ -326,11 +324,10 @@ irqreturn_t aq_vec_isr_legacy(int irq, void *private)
 		napi_schedule(&self->napi);
 	} else {
 		self->aq_hw_ops->hw_irq_enable(self->aq_hw, 1U);
-		err = IRQ_NONE;
+		return IRQ_NONE;
 	}
 
-err_exit:
-	return err >= 0 ? IRQ_HANDLED : IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 cpumask_t *aq_vec_get_affinity_mask(struct aq_vec_s *self)
-- 
2.20.1

