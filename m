Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B91721548
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945195;
	bh=Ci+2swfFDkzxgZVxS88vGgMTtLNa6R7R5ssmpAF3+EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jVPqUyQbEYquDQxV5+tMmC52JsKmT8GhF+HMXfgIaCPlhVnHTdJyQMmgw/NsACfzX
	 V+5yApyDiLICrDd/8MCCO/GZ721U/SP4KHmbb+VJqbmryht3+0vXWBBG/p/J7PrqA7
	 hqpBZFzFNkuf3TbPsUeJDB9mD54Eh/vj4qY3fVRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392850AbgFWUqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392837AbgFWUqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:46:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931FA20781;
        Tue, 23 Jun 2020 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945183;
        bh=Ci+2swfFDkzxgZVxS88vGgMTtLNa6R7R5ssmpAF3+EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHrHIlAiUBgTLHMmCzm/VH/z8eyQmK2+nu1qeAntUT9DjUVuO9VYCl+krO6wCZltR
         YsFnt2LntRKpsLx0oo14OyIkkqkrQyqXuUWILQYM4E9cVm2A0HbOwjDFLnG+BLoY0H
         FHrW2yr8+U9VjEGWHS1PIPt5kRMcEEwwTESo/5Pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 040/136] s390/qdio: put thinint indicator after early error
Date:   Tue, 23 Jun 2020 21:58:16 +0200
Message-Id: <20200623195305.669742935@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 29d6b5222f1cd..0f8d13288611e 100644
--- a/drivers/s390/cio/qdio.h
+++ b/drivers/s390/cio/qdio.h
@@ -377,7 +377,6 @@ static inline int multicast_outbound(struct qdio_q *q)
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
index 831a3a0a2837b..4dc1108069d4a 100644
--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -270,17 +270,19 @@ int __init tiqdio_register_thinints(void)
 
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



