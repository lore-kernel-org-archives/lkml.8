Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFD9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FF121741
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVhMKBNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHUSQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUSQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:16:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9957C061573;
        Fri, 21 Aug 2020 11:16:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so1381941pgl.3;
        Fri, 21 Aug 2020 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAdEaEjeYhWoIRsv5NhY8Eb13xqjLds4zMTi8Wir4/A=;
        b=VVhMKBNhclcnysISqqi95OuRgWsyDiHowOUGeJoKVjU5pb2gp2hK8e6xv9gt89ozso
         lN1Pz/djEb1YesvQNk5a2fepxDVQkJuOBczVmu0MQXxGdg2a9ruBSsCvTYG6ZO2s6yON
         r05x5Y2Ay3Qtnt2GgIjQd7vW0Uzaxo7pAmqHWZEIapwV61YtODI264Hv4SS2s7hn+rex
         9id0T39Dh/Y9RxUGGLtBP8oas4qdl/hqNX9O5OngcMpa7F9p/59zwwH4Hd6McNxhI/xv
         A7oJmkq73w8YdQx4XfhVNDJc424DHdFCYdmMNrixJINEUMuNt0DCjyphHuji/0rQGXJJ
         wfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAdEaEjeYhWoIRsv5NhY8Eb13xqjLds4zMTi8Wir4/A=;
        b=hWhlL2zXWSjDo3xWbPstANQS7dLynMGgvpXcGdYbkv1gTPGsvDemhFt8KW9dWuvAqY
         yK4HxxKpnsq7qya/1xCkToNC675P8pgG+nfYGJRuzU3gL8qSWoDq9+s+Zgeqtcv2OGs7
         njzPBqjyV1DGvucS8TDGUFZYK8avkqxGg5moTFrI+pO/CKNGrRR0BD0Dxb5QltwsGpa9
         88/EhiGgthEsCUVVncjVmdSANAbzvVvTMeinH0zBocYmPaxuKMGDvHhIqHMxDe899/ar
         ummP65cf4T31c42VZwsX2oUWMHIlwEpB8EzKageY+volo2DA4NJSE8uvLAVlsDrgAAsP
         Hdhw==
X-Gm-Message-State: AOAM533wGM98NUnuY2zI6eNOZcL3vBnynpBbW+rWICWWelxLyuchLrFv
        00c90HLqFU0e3p36X4cUaKzemdfjINT9UA==
X-Google-Smtp-Source: ABdhPJyICfXx/9MPdKCwjTwM7/avrjZgcE7FixrSzeL8lnCFqLOr9s1o0spU0Lo3BqSmch+Ey141lg==
X-Received: by 2002:a63:af51:: with SMTP id s17mr3229241pgo.286.1598033786842;
        Fri, 21 Aug 2020 11:16:26 -0700 (PDT)
Received: from jaguar.thds.mooo.com (061239037006.ctinets.com. [61.239.37.6])
        by smtp.gmail.com with ESMTPSA id a13sm3158152pfo.49.2020.08.21.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:16:26 -0700 (PDT)
From:   Kenneth Chan <kenneth.t.chan@gmail.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     laforge@gnumonks.org, Kenneth Chan <kenneth.t.chan@gmail.com>
Subject: [PATCH 2/9] replace ACPI prints with pr_*() macros
Date:   Sat, 22 Aug 2020 02:14:26 +0800
Message-Id: <20200821181433.17653-3-kenneth.t.chan@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
References: <20200821181433.17653-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ACPI prints with pr_*() macros for consistency with other platform
devices.

Clean up obsolete ACPI_HOTKEY_COMPONENT code.


Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 47 ++++++++-----------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 21cdc2149a10..7170c36577bf 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -13,6 +13,7 @@
  *
  * ChangeLog:
  *	Aug.18, 2020	Kenneth Chan <kenneth.t.chan@gmail.com>
+ *			replace ACPI prints with pr_*() macros
  *		-v0.97	add support for cdpower hardware switch
  *		-v0.96	merge Lucina's enhancement
  *			Jan.13, 2009 Martin Lucina <mato@kotelna.sk>
@@ -124,12 +125,6 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/platform_device.h>
 
-#ifndef ACPI_HOTKEY_COMPONENT
-#define ACPI_HOTKEY_COMPONENT	0x10000000
-#endif
-
-#define _COMPONENT		ACPI_HOTKEY_COMPONENT
-
 MODULE_AUTHOR("Hiroshi Miura, David Bronaugh and Harald Welte");
 MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Let's Note laptops");
 MODULE_LICENSE("GPL");
@@ -255,8 +250,7 @@ static inline int acpi_pcc_get_sqty(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		return s;
 	else {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SQTY\n"));
+		pr_err("evaluation error HKEY.SQTY\n");
 		return -EINVAL;
 	}
 }
@@ -271,21 +265,19 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	status = acpi_evaluate_object(pcc->handle, METHOD_HKEY_SINF, NULL,
 				      &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "evaluation error HKEY.SINF\n"));
+		pr_err("evaluation error HKEY.SINF\n");
 		return 0;
 	}
 
 	hkey = buffer.pointer;
 	if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
+		pr_err("Invalid HKEY.SINF\n");
 		status = AE_ERROR;
 		goto end;
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "SQTY reports bad SINF length\n"));
+		pr_err("SQTY reports bad SINF length\n");
 		status = AE_ERROR;
 		goto end;
 	}
@@ -295,8 +287,7 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 		if (likely(element->type == ACPI_TYPE_INTEGER)) {
 			pcc->sinf[i] = element->integer.value;
 		} else
-			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-					 "Invalid HKEY.SINF data\n"));
+			pr_err("Invalid HKEY.SINF data\n");
 	}
 	pcc->sinf[hkey->package.count] = -1;
 
@@ -563,8 +554,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 	rc = acpi_evaluate_integer(pcc->handle, METHOD_HKEY_QUERY,
 				   NULL, &result);
 	if (ACPI_FAILURE(rc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "error getting hotkey status\n"));
+		pr_err("error getting hotkey status\n");
 		return;
 	}
 
@@ -579,8 +569,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	if (!sparse_keymap_report_event(hotk_input_dev,
 					result & 0xf, result & 0x80, false))
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unknown hotkey event: %d\n", result));
+		pr_err("Unknown hotkey event: 0x%04llx\n", result);
 }
 
 static void acpi_pcc_hotkey_notify(struct acpi_device *device, u32 event)
@@ -659,15 +648,13 @@ static int acpi_pcc_init_input(struct pcc_acpi *pcc)
 
 	error = sparse_keymap_setup(input_dev, panasonic_keymap, NULL);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to setup input device keymap\n"));
+		pr_err("Unable to setup input device keymap\n");
 		goto err_free_dev;
 	}
 
 	error = input_register_device(input_dev);
 	if (error) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Unable to register input device\n"));
+		pr_err("Unable to register input device\n");
 		goto err_free_dev;
 	}
 
@@ -693,9 +680,6 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
-			  pcc->sticky_mode));
-
 	return acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_mode);
 }
 #endif
@@ -712,14 +696,13 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	num_sifr = acpi_pcc_get_sqty(device);
 
 	if (num_sifr < 0 || num_sifr > 255) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr out of range"));
+		pr_err("num_sifr out of range");
 		return -ENODEV;
 	}
 
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Couldn't allocate mem for pcc"));
+		pr_err("Couldn't allocate mem for pcc");
 		return -ENOMEM;
 	}
 
@@ -738,15 +721,13 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Error installing keyinput handler\n"));
+		pr_err("Error installing keyinput handler\n");
 		goto out_sinf;
 	}
 
 	if (!acpi_pcc_retrieve_biosdata(pcc)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				 "Couldn't retrieve BIOS data\n"));
 		result = -EIO;
+		pr_err("Couldn't retrieve BIOS data\n");
 		goto out_input;
 	}
 	/* initialize backlight */
-- 
2.17.5

