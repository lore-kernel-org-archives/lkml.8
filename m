Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD9DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAE0206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ous+18uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390890AbgF2VUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6CAC02E2CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so16716310wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhVnLd0r7raxgcyoOCULQKwhfsHJk9/wusjVrNWGYS4=;
        b=ous+18uFIcLaG4cRJ524/Q1ebFSiRNvabxyUHCwVUaiHeJAFRIwyphH3zHRsSz0qS9
         I5ONR3KmqwEOEL/VKlk9HPadqUmAq9XaRGcdladgrGuMDJF6qgEu6F8CckoAtv06KGIF
         3bjATAYVK/0qKDy3omdQMZlPnvhr7hDQovFKt/7+86+M7yFt0QYblSF+uvHDe+QzsSni
         9Ql/GNVVBEfWoOPONrJJJ7plhbru+0WlGgEssah/lUvnHKVpKZgryoy/1D9Mo50mDZ8Y
         sV3VnKgvzDfnBA9b6XtGg5Y4T4G24dfqY34pKwl9m+podVZRUNE9hbt/WluL86x2hc5l
         eO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhVnLd0r7raxgcyoOCULQKwhfsHJk9/wusjVrNWGYS4=;
        b=amY9vGdqWjCvV+2tnpbeF4Fk/FNk1tAONe9XlfWptYe4D68FJULI5LkeKwNEb2+wb7
         5lSzppFI49CxrZVzzP8IsdwnlJifxSYGCj92qfNmi0c65vDCA3aHkBs+wc1rEOTEnGI4
         SEnOo6NE2XKrn5nBNPHNXinIn7Xw9+Al2mG4CmAUcO9O/Hr4DCmOUMB9FbNQKAUdhiu0
         HuRdDo7L8uq3WVBnnOdHEYv2ztbOooSTMBz3mw2fHDIsosXGUi1GGR3ZpFs8V/ViNYOY
         DOpYU/FFEDNqonalRJ5n0DkuXiSXfyEMllVu0Qv4lK/Ms1g1JsSDIIODgdUJTe/E68qn
         ZShg==
X-Gm-Message-State: AOAM531FMVWyNe/2JbcE4zevAcVRshs9fIeyPC7zh+KZII9AbCFKzh81
        B/gVVl4ZIBfBXli8NNAunzTVKffrSeI=
X-Google-Smtp-Source: ABdhPJweOwERgUR+r9gh8XzakhlezA7hIvHmDKSA8UboEuprGSmmgnfQoX93xLHK/KaSO4JsEZHXOQ==
X-Received: by 2002:a5d:6603:: with SMTP id n3mr17730012wru.142.1593439492519;
        Mon, 29 Jun 2020 07:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 05/20] misc: habanalabs: irq: Repair kerneldoc formatting issues
Date:   Mon, 29 Jun 2020 15:04:27 +0100
Message-Id: <20200629140442.1043957-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 kernel builds report a lack of descriptions for various
function arguments.  In reality they are documented, but the
formatting was not as expected '@.*:'.  Instead, '-'s were
used as separators.

While we're here, the headers for functions various functions
were written in kerneldoc format, but lack the kerneldoc
identifier '/**'.  Let's promote them so they can gain access
to the checker.

This change fixes the following W=1 warnings:

 drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'eq_work' not described in 'hl_eqe_work'
 drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'hdev' not described in 'hl_eqe_work'
 drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'eq_entry' not described in 'hl_eqe_work'

Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/habanalabs/irq.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 4e77a73857793..6981d67153b11 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -13,9 +13,9 @@
  * struct hl_eqe_work - This structure is used to schedule work of EQ
  *                      entry and armcp_reset event
  *
- * @eq_work          - workqueue object to run when EQ entry is received
- * @hdev             - pointer to device structure
- * @eq_entry         - copy of the EQ entry
+ * @eq_work:          workqueue object to run when EQ entry is received
+ * @hdev:             pointer to device structure
+ * @eq_entry:         copy of the EQ entry
  */
 struct hl_eqe_work {
 	struct work_struct	eq_work;
@@ -23,7 +23,7 @@ struct hl_eqe_work {
 	struct hl_eq_entry	eq_entry;
 };
 
-/*
+/**
  * hl_cq_inc_ptr - increment ci or pi of cq
  *
  * @ptr: the current ci or pi value of the completion queue
@@ -39,7 +39,7 @@ inline u32 hl_cq_inc_ptr(u32 ptr)
 	return ptr;
 }
 
-/*
+/**
  * hl_eq_inc_ptr - increment ci of eq
  *
  * @ptr: the current ci value of the event queue
@@ -66,7 +66,7 @@ static void irq_handle_eqe(struct work_struct *work)
 	kfree(eqe_work);
 }
 
-/*
+/**
  * hl_irq_handler_cq - irq handler for completion queue
  *
  * @irq: irq number
@@ -142,7 +142,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/*
+/**
  * hl_irq_handler_eq - irq handler for event queue
  *
  * @irq: irq number
@@ -206,7 +206,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/*
+/**
  * hl_cq_init - main initialization function for an cq object
  *
  * @hdev: pointer to device structure
@@ -238,7 +238,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 	return 0;
 }
 
-/*
+/**
  * hl_cq_fini - destroy completion queue
  *
  * @hdev: pointer to device structure
@@ -269,7 +269,7 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
 	memset((void *) (uintptr_t) q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
 }
 
-/*
+/**
  * hl_eq_init - main initialization function for an event queue object
  *
  * @hdev: pointer to device structure
@@ -297,7 +297,7 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 	return 0;
 }
 
-/*
+/**
  * hl_eq_fini - destroy event queue
  *
  * @hdev: pointer to device structure
-- 
2.25.1

