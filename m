Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A1B20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kHPN16FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgEDQmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgEDQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:42:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BAFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rC2aC4IsKb6ZOzTfvApS5ZVu3eXJi5votbx7fH6tBMo=; b=kHPN16FXlCXibD2aN2YwAEJgBz
        YGCfQSSe5gfsJ9Z8j98ElfBn0DYW1+kLfDXOt4Squ6NNw9xEt3GMHVfdJzHoe8zZO3ekTBwEVvsqI
        XF30kNEsoFuOv3OkorOZ7vLW8w3uLepB61I+cqx4d4Juej8Z0yTWnApaT3eT1ljwJ3RWK0acjfmfc
        pSVhsv3gWR4oQDKupcxZThEJhQcPK6W0w3SLd4fTUpe0oqqsOwPBOdursYYqv6Z+J1gGDjv9ovekG
        Pmn2Vaa6ljGyCx+cbr9oZ0bWVs2ecjZh+r8EA04Xa10eD96TbBuWS5X0uRYPhP4rDNVUsbQBGnkmI
        DVMbZHrw==;
Received: from [2001:4bb8:18c:10bd:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVeAk-0005hh-1d; Mon, 04 May 2020 16:42:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_sdei: remove unused interfaces
Date:   Mon,  4 May 2020 18:42:24 +0200
Message-Id: <20200504164224.2842960-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The export symbols to register/unregister and enable/disable events
aren't ever used outside of arm_sdei.c, so mark them static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firmware/arm_sdei.c | 13 +++++--------
 include/linux/arm_sdei.h    | 15 ---------------
 2 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 334c8be0c11fb..bdd6461647d74 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -400,7 +400,7 @@ static void _local_event_enable(void *data)
 	sdei_cross_call_return(arg, err);
 }
 
-int sdei_event_enable(u32 event_num)
+static int sdei_event_enable(u32 event_num)
 {
 	int err = -EINVAL;
 	struct sdei_event *event;
@@ -429,7 +429,6 @@ int sdei_event_enable(u32 event_num)
 
 	return err;
 }
-EXPORT_SYMBOL(sdei_event_enable);
 
 static int sdei_api_event_disable(u32 event_num)
 {
@@ -447,7 +446,7 @@ static void _ipi_event_disable(void *data)
 	sdei_cross_call_return(arg, err);
 }
 
-int sdei_event_disable(u32 event_num)
+static int sdei_event_disable(u32 event_num)
 {
 	int err = -EINVAL;
 	struct sdei_event *event;
@@ -471,7 +470,6 @@ int sdei_event_disable(u32 event_num)
 
 	return err;
 }
-EXPORT_SYMBOL(sdei_event_disable);
 
 static int sdei_api_event_unregister(u32 event_num)
 {
@@ -502,7 +500,7 @@ static int _sdei_event_unregister(struct sdei_event *event)
 	return sdei_do_cross_call(_local_event_unregister, event);
 }
 
-int sdei_event_unregister(u32 event_num)
+static int sdei_event_unregister(u32 event_num)
 {
 	int err;
 	struct sdei_event *event;
@@ -533,7 +531,6 @@ int sdei_event_unregister(u32 event_num)
 
 	return err;
 }
-EXPORT_SYMBOL(sdei_event_unregister);
 
 /*
  * unregister events, but don't destroy them as they are re-registered by
@@ -603,7 +600,8 @@ static int _sdei_event_register(struct sdei_event *event)
 	return err;
 }
 
-int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
+static int sdei_event_register(u32 event_num, sdei_event_callback *cb,
+		void *arg)
 {
 	int err;
 	struct sdei_event *event;
@@ -643,7 +641,6 @@ int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg)
 
 	return err;
 }
-EXPORT_SYMBOL(sdei_event_register);
 
 static int sdei_reregister_event_llocked(struct sdei_event *event)
 {
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 0a241c5c911d8..5f9fb1d95d515 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -22,21 +22,6 @@
  */
 typedef int (sdei_event_callback)(u32 event, struct pt_regs *regs, void *arg);
 
-/*
- * Register your callback to claim an event. The event must be described
- * by firmware.
- */
-int sdei_event_register(u32 event_num, sdei_event_callback *cb, void *arg);
-
-/*
- * Calls to sdei_event_unregister() may return EINPROGRESS. Keep calling
- * it until it succeeds.
- */
-int sdei_event_unregister(u32 event_num);
-
-int sdei_event_enable(u32 event_num);
-int sdei_event_disable(u32 event_num);
-
 /* GHES register/unregister helpers */
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb);
-- 
2.26.2

