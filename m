Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42552074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/XwCED6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgGQS5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgGQS5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:02 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F6C0619D4;
        Fri, 17 Jul 2020 11:57:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z63so9694112qkb.8;
        Fri, 17 Jul 2020 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HE4dUHHpdZXvPh2mUviKYGtL/i1tJMEQSm9OTqPGgng=;
        b=q/XwCED6UbEQVHMr1+ZJ+He5mlxlLmvp9oF+F0XkX1X7aaEOLAhGI2+PlzBQ4aw+bS
         qlbLvL99mP7gmrpRmDRfkTKIcchOF8B8f74yOTi5yTeS9GMqnH3epVA3wqKISAs4lM8C
         cmmZ42zP5B0+xaKdNgWdCHxJvSm+BasODiWXG2iMxJx+CoJL6LWRVDS5NxijTR2g92Wy
         IhsK8FtQ7opqPvfryc8acEY8eYgHAAqT17FDqAUt1dU694FEqlJg1MTSp0ZqJfNYgLLv
         tWT6LZOdiARBgvJWTl2sSSzht+Xw33btyL9lbjg0lMbRlekLWqgZuDM/DHUp+5CbLFnf
         dRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HE4dUHHpdZXvPh2mUviKYGtL/i1tJMEQSm9OTqPGgng=;
        b=dws9BSR2GZnsEFXnMqy6BJPSNvCpMDHOgOiv/lAW05AcFftrBjNlFI8/nv90PWPQ+o
         VSl4YbmhAqHY54nLO15BhPZptddG1TPcomlTj6coeDJnEcTa4Xlzq7NDPiE8wyeasi/4
         SCWCNEhLgRJfBeXZ4Y7M+M9qRdi6pMN85mUwoe122kZiCN13ElAC8qxnqrsxOT/LMGb/
         1Fp1uZYOP9XEp4raAvSjgNeB7HztdkHZF8qjRMMl76WNtEdd+jxxmbjQ1bkTltleGeOP
         pxDRdl+7at2Xhn4hyOVyUIXPKlg3h/eb6Co6bvzFcXUjudPtFvmkP/O4/iq46sGdAs7b
         OTLg==
X-Gm-Message-State: AOAM531mhGqz/j68dQW5JS4/Q5E8lkA/Dl6W6xXPNXYejqiyapo0FdFM
        vZdo2exFKGEqHR5UCIOKgB4=
X-Google-Smtp-Source: ABdhPJz8JypdOqkBDlVre+r9pIzv87BFlDCYF9VwfGBol2nEJlWu3I3zuZoGRlZaQiI8fIfDtDCuHw==
X-Received: by 2002:a05:620a:2409:: with SMTP id d9mr10768334qkn.36.1595012221859;
        Fri, 17 Jul 2020 11:57:01 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:01 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] Documentation: serial_core.c: uart_get_rs485_mode: Fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:04 -0300
Message-Id: <20200717185624.2009393-5-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

warning: Excess function parameter 'dev' description in
'uart_get_rs485_mode'

warning: Excess function parameter 'rs485conf' description in
'uart_get_rs485_mode'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf903881..97df0c0e30e9b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3289,8 +3289,6 @@ EXPORT_SYMBOL(uart_remove_one_port);
 
 /**
  * uart_get_rs485_mode() - retrieve rs485 properties for given uart
- * @dev: uart device
- * @rs485conf: output parameter
  *
  * This function implements the device tree binding described in
  * Documentation/devicetree/bindings/serial/rs485.txt.
-- 
2.27.0

