Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFCC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249052075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpr2JJJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbgDNOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389948AbgDNOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:23:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B6C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wPN9C12OUgRHT5wOxy6lkdGl1h0WkKc0+KofaN40gH4=; b=gpr2JJJL8REA96K8q7jX1tBreC
        PXdcdYWV1utfJtdBGRvmV9Vq25Y3OO3q2kGzsEZwHNkjb7YKQsC2WLpdGa45Ji9ksKvYdwnfWoP18
        jbvIles0Ew/cwBvbhxEJuwVcROGTWeiO+k8wvatXODKOFObUaBdSb6yG0yTplbV0uIx9arpvC0Rp+
        JjSnWwxCHA0o0A89iAx3webn/Gly7dmDZEjo/RsJZNm6c4BP6aTOU4RvXTpj9wwwcE7TKShhmnwpl
        k1NARRz2EtwzBjEOMHSyZeBm21TchzRD6UuycI556w/MuLoRLVptmYVAW4Cf3aDnjhsapOyHxF6aT
        lkdqwMBg==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMSz-00021k-Mf; Tue, 14 Apr 2020 14:23:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firmware: arm_sdei: remove unused interfaces
Date:   Tue, 14 Apr 2020 16:23:01 +0200
Message-Id: <20200414142302.448447-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414142302.448447-1-hch@lst.de>
References: <20200414142302.448447-1-hch@lst.de>
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
index 334c8be0c11f..bdd6461647d7 100644
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
index 0a241c5c911d..5f9fb1d95d51 100644
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
2.25.1

