Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71A1205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="weNETtUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:01:16 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51182 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgHMUBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:01:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597348875; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=UsZ9oa+Cd0gRFgLsFWWij3Ap/jvnyK+JkhohZUp+X94=; b=weNETtUxSrj98riWSz/iC2FgZb+vpTtrBnoyw5YN3LK0AZDeCbhjnyyVLQyO28RrwglKug3P
 BjwdOJ8YjyKi+w0uU7IxDrfca2EQ0rIJXipnOERiByHX+240Dj1/nfNeSuuLdDoDJLRRz+a5
 vLUxJMUew0LuDQ8eIXdTtoq/twg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f359bdd03528d4024d1bc11 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 20:00:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ABA77C433CB; Thu, 13 Aug 2020 20:00:28 +0000 (UTC)
Received: from localhost (unknown [202.46.22.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 495D4C433C6;
        Thu, 13 Aug 2020 20:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 495D4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     mcgrof@kernel.org, tiwai@suse.de, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH v2] firmware_loader: fix memory leak for paged buffer
Date:   Fri, 14 Aug 2020 01:30:22 +0530
Message-Id: <1597348822-17762-1-git-send-email-prsood@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <3f9dac61-1ba5-1a44-1d08-75666c9398bc@codeaurora.org>
References: <3f9dac61-1ba5-1a44-1d08-75666c9398bc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() is being called on paged buffer allocated
using alloc_page() and mapped using vmap().

Freeing of pages in vfree() relies on nr_pages of
struct vm_struct. vmap() does not update nr_pages.
It can lead to memory leaks.

Fixes: ddaf29fd9bb6 ("firmware: Free temporary page table after vmapping")
Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/firmware.h |  2 ++
 drivers/base/firmware_loader/main.c     | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 933e2192..d08efc7 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -142,10 +142,12 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 void fw_free_paged_buf(struct fw_priv *fw_priv);
 int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
 int fw_map_paged_buf(struct fw_priv *fw_priv);
+bool fw_is_paged_buf(struct fw_priv *fw_priv);
 #else
 static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
 static inline int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
 static inline int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
+static inline bool fw_is_paged_buf(struct fw_priv *fw_priv) { return false; }
 #endif
 
 #endif /* __FIRMWARE_LOADER_H */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ca871b1..36bf455 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -252,9 +252,11 @@ static void __free_fw_priv(struct kref *ref)
 	list_del(&fw_priv->list);
 	spin_unlock(&fwc->lock);
 
-	fw_free_paged_buf(fw_priv); /* free leftover pages */
-	if (!fw_priv->allocated_size)
+	if (fw_is_paged_buf(fw_priv))
+		fw_free_paged_buf(fw_priv);
+	else if (!fw_priv->allocated_size)
 		vfree(fw_priv->data);
+
 	kfree_const(fw_priv->fw_name);
 	kfree(fw_priv);
 }
@@ -268,6 +270,11 @@ static void free_fw_priv(struct fw_priv *fw_priv)
 }
 
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
+bool fw_is_paged_buf(struct fw_priv *fw_priv)
+{
+	return fw_priv->is_paged_buf;
+}
+
 void fw_free_paged_buf(struct fw_priv *fw_priv)
 {
 	int i;
@@ -275,6 +282,8 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
 	if (!fw_priv->pages)
 		return;
 
+	vunmap(fw_priv->data);
+
 	for (i = 0; i < fw_priv->nr_pages; i++)
 		__free_page(fw_priv->pages[i]);
 	kvfree(fw_priv->pages);
@@ -328,10 +337,6 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
 	if (!fw_priv->data)
 		return -ENOMEM;
 
-	/* page table is no longer needed after mapping, let's free */
-	kvfree(fw_priv->pages);
-	fw_priv->pages = NULL;
-
 	return 0;
 }
 #endif
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

