Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D4CC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3472071E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580349694;
	bh=a4KWsJRiuNAu+S0um97LfdSQg/QjtCJtt53SgVg+TF8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LB02KH+JbIJ6ncP3WR7qKTrZCmAX5pbcy3uTKzQj73duhsoVF9p1p/Eclf8Dq351v
	 Fj6GxElReIW80HUyU6atj3cRctlIMTwRnuUsd8n0Gw3bzTLAeKyCbZ+u4a4Nq1Na6A
	 fMKe6uEIHaaT5g12+bahds+G8VfKancneybeyLEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgA3CBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:01:34 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42449 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgA3CBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:01:33 -0500
Received: by mail-io1-f68.google.com with SMTP id n11so2141724iom.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 18:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLmNga7Fg92j7Wp0mHpBfgEy1+qMj+VIGuo+fS2/qk=;
        b=a+JuYJP7DExfh7Xj7D1MP+WDtc/4pqFZPRUg5vQnLk8/ZyMguwk24cOHfvPd/+sGjo
         h/Bex96QHbUA/Do6IBNm3aQUtZ0/MIKqTX6OzyaprNtd5rcC2BwqmSEmVBo/H2cKZlIX
         UwRdkikLwwWO0ZxE/cPRXFdIK2yswvPPSnjfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLLmNga7Fg92j7Wp0mHpBfgEy1+qMj+VIGuo+fS2/qk=;
        b=mzY6agxfJm/Rk6w5q8u4uOTzNONbldflqOLvA4ajS8dXVsm7/lxnGffa3myx88+WVe
         jM7PKmqusOCZIg8PlF24eOw8PPA5hT6n3SlIuAG3g5hzKjtKB59hbtLaofLJ9K378XwM
         PjxexWqQLecVI9CRpj37/r9QnJQywr08JqIiwmSL0M/y+ehPdEx24eVBYqebGpy2nSza
         uUYZEJE617QGtFhH18+haTq3RlfhvCnctEZcdhXvRdkdO6Hd591aexYJk+P/kRh9CaQo
         iZApaUWAzOSbDxyK7tefOq3tYd5b/oYo3bktqQ0ELOOK///45QfKgNwRA4N5Tpov+k4Q
         6+ZQ==
X-Gm-Message-State: APjAAAW34uDItBljlTIXaLG7GA2IZgQBIZuIFdCvc1qBEiqbFJxO3ZZB
        W1w8ULe9xBa0+1ARpzGdRZIBsA==
X-Google-Smtp-Source: APXvYqwIZP1v3iiH4xKUKmxt616Y3bG9d/QnCJDyKghwbYBWw8lWb+GqRRh4rI20P6dDFb83B1oLRQ==
X-Received: by 2002:a6b:c742:: with SMTP id x63mr2231819iof.162.1580349692648;
        Wed, 29 Jan 2020 18:01:32 -0800 (PST)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n17sm1306437ile.68.2020.01.29.18.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 18:01:31 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     jmorris@namei.org, serge@hallyn.com, mpe@ellerman.id.au,
        zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com,
        yuehaibing@huawei.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] security/integrity: Include __func__ in messages for easier debug
Date:   Wed, 29 Jan 2020 19:01:29 -0700
Message-Id: <20200130020129.15328-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change messages to messages to make it easier to debug. The following
error message isn't informative enough to figure out what failed.

Couldn't get size: 0x800000000000000e

Change messages to include function information.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 .../integrity/platform_certs/load_powerpc.c     | 14 ++++++++------
 security/integrity/platform_certs/load_uefi.c   | 17 ++++++++++-------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index a2900cb85357..621454148fbc 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -25,7 +25,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
 
 	rc = secvar_ops->get(key, keylen, NULL, size);
 	if (rc) {
-		pr_err("Couldn't get size: %d\n", rc);
+		pr_err("%s: Couldn't get size: %d\n", __func__, rc);
 		return NULL;
 	}
 
@@ -36,7 +36,7 @@ static __init void *get_cert_list(u8 *key, unsigned long keylen, uint64_t *size)
 	rc = secvar_ops->get(key, keylen, db, size);
 	if (rc) {
 		kfree(db);
-		pr_err("Error reading %s var: %d\n", key, rc);
+		pr_err("%s: Error reading %s var: %d\n", __func__, key, rc);
 		return NULL;
 	}
 
@@ -69,23 +69,25 @@ static int __init load_powerpc_certs(void)
 	 */
 	db = get_cert_list("db", 3, &dbsize);
 	if (!db) {
-		pr_err("Couldn't get db list from firmware\n");
+		pr_err("%s: Couldn't get db list from firmware\n", __func__);
 	} else {
 		rc = parse_efi_signature_list("powerpc:db", db, dbsize,
 					      get_handler_for_db);
 		if (rc)
-			pr_err("Couldn't parse db signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse db signatures: %d\n",
+				__func__, rc);
 		kfree(db);
 	}
 
 	dbx = get_cert_list("dbx", 4,  &dbxsize);
 	if (!dbx) {
-		pr_info("Couldn't get dbx list from firmware\n");
+		pr_info("%s: Couldn't get dbx list from firmware\n", __func__);
 	} else {
 		rc = parse_efi_signature_list("powerpc:dbx", dbx, dbxsize,
 					      get_handler_for_dbx);
 		if (rc)
-			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse dbx signatures: %d\n",
+				__func__, rc);
 		kfree(dbx);
 	}
 
diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index 111898aad56e..c3cf6575abc1 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -44,7 +44,7 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 
 	status = efi.get_variable(name, guid, NULL, &lsize, &tmpdb);
 	if (status != EFI_BUFFER_TOO_SMALL) {
-		pr_err("Couldn't get size: 0x%lx\n", status);
+		pr_err("%s: Couldn't get size: 0x%lx\n", __func__, status);
 		return NULL;
 	}
 
@@ -55,7 +55,7 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
 	status = efi.get_variable(name, guid, NULL, &lsize, db);
 	if (status != EFI_SUCCESS) {
 		kfree(db);
-		pr_err("Error reading db var: 0x%lx\n", status);
+		pr_err("%s: Error reading db var: 0x%lx\n", __func__, status);
 		return NULL;
 	}
 
@@ -85,13 +85,14 @@ static int __init load_uefi_certs(void)
 	if (!uefi_check_ignore_db()) {
 		db = get_cert_list(L"db", &secure_var, &dbsize);
 		if (!db) {
-			pr_err("MODSIGN: Couldn't get UEFI db list\n");
+			pr_err("%s: MODSIGN: Couldn't get UEFI db list\n",
+				__func__);
 		} else {
 			rc = parse_efi_signature_list("UEFI:db",
 					db, dbsize, get_handler_for_db);
 			if (rc)
-				pr_err("Couldn't parse db signatures: %d\n",
-				       rc);
+				pr_err("%s: Couldn't parse db signatures: %d\n",
+				       __func__, rc);
 			kfree(db);
 		}
 	}
@@ -103,7 +104,8 @@ static int __init load_uefi_certs(void)
 		rc = parse_efi_signature_list("UEFI:MokListRT",
 					      mok, moksize, get_handler_for_db);
 		if (rc)
-			pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse MokListRT signatures: %d\n",
+				__func__, rc);
 		kfree(mok);
 	}
 
@@ -115,7 +117,8 @@ static int __init load_uefi_certs(void)
 					      dbx, dbxsize,
 					      get_handler_for_dbx);
 		if (rc)
-			pr_err("Couldn't parse dbx signatures: %d\n", rc);
+			pr_err("%s: Couldn't parse dbx signatures: %d\n",
+				__func__, rc);
 		kfree(dbx);
 	}
 
-- 
2.20.1

