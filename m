Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7562920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462221;
	bh=22GcyC7muiffFtETFdjF2sD42yntUmJ9O0GxjhYMGP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2VwK30a6dr+o0YasJ6yluX+CmClOKNuV5e7RLMHy1i6l6btRf45IyICu8wtfguhg
	 gWEA3dyuPAuc6MS6/WHd3oejJU8JFvzLKFd8LY+J1GG7NWiqO+hlCvBBl7fTjRwgTX
	 vZCkRgzwXX9L1u9Osrv03k2NZ8x/P0/ov+8ipd9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgF2UXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732567AbgF2TZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3C42537B;
        Mon, 29 Jun 2020 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445243;
        bh=22GcyC7muiffFtETFdjF2sD42yntUmJ9O0GxjhYMGP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wcgbvXfJ4LR4MmOPZCA7+Isk4n+v5XwVnF8xQ1ZeI+iUT9LxPVR9LN4ouLmbEnulk
         cjmfGFO/7alLUNpXwJlDz12qa4sDYYeDkJ/ruXeZfBu7saUhdsZBTGP4q36S79KkjF
         N6d6evjfEPQZJwfjSAZJaSc+eMuitMwPvOmtY+rs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 027/191] s390/qdio: put thinint indicator after early error
Date:   Mon, 29 Jun 2020 11:37:23 -0400
Message-Id: <20200629154007.2495120-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 75e82bec6b2622c6f455b7a543fb5476a5d0eed7 ]

qdio_establish() calls qdio_setup_thinint() via qdio_setup_irq().
If the subsequent qdio_establish_thinint() fails, we miss to put the
DSCI again. Thus the DSCI isn't available for re-use. Given enough of
such errors, we could end up with having only the shared DSCI available.

Merge qdio_setup_thinint() into qdio_establish_thinint(), and deal with
such an error internally.

Fixes: 779e6e1c724d ("[S390] qdio: new qdio driver.")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/qdio.h         |  1 -
 drivers/s390/cio/qdio_setup.c   |  1 -
 drivers/s390/cio/qdio_thinint.c | 14 ++++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/qdio.h b/drivers/s390/cio/qdio.h
index 7e70f9298cc13..11f6ebd045456 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -376,7 +376,6 @@ static inline int multicast_outbound(struct qdio_q *q)
 extern u64 last_ai_time;
 
 /* prototypes for thin interrupt */
-void qdio_setup_thinint(struct qdio_irq *irq_ptr);
 int qdio_establish_thinint(struct qdio_irq *irq_ptr);
 void qdio_shutdown_thinint(struct qdio_irq *irq_ptr);
 void tiqdio_add_input_queues(struct qdio_irq *irq_ptr);
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index d0090c5c88e74..a64615a10352b 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -479,7 +479,6 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 	setup_queues(irq_ptr, init_data);
 
 	setup_qib(irq_ptr, init_data);
-	qdio_setup_thinint(irq_ptr);
 	set_impl_params(irq_ptr, init_data->qib_param_field_format,
 			init_data->qib_param_field,
 			init_data->input_slib_elements,
diff --git a/drivers/s390/cio/qdio_thinint.c b/drivers/s390/cio/qdio_thinint.c
index debe69adfc705..aecb6445a5671 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -268,17 +268,19 @@ int __init tiqdio_register_thinints(void)
 
 int qdio_establish_thinint(struct qdio_irq *irq_ptr)
 {
+	int rc;
+
 	if (!is_thinint_irq(irq_ptr))
 		return 0;
-	return set_subchannel_ind(irq_ptr, 0);
-}
 
-void qdio_setup_thinint(struct qdio_irq *irq_ptr)
-{
-	if (!is_thinint_irq(irq_ptr))
-		return;
 	irq_ptr->dsci = get_indicator();
 	DBF_HEX(&irq_ptr->dsci, sizeof(void *));
+
+	rc = set_subchannel_ind(irq_ptr, 0);
+	if (rc)
+		put_indicator(irq_ptr->dsci);
+
+	return rc;
 }
 
 void qdio_shutdown_thinint(struct qdio_irq *irq_ptr)
-- 
2.25.1

