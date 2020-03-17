Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F4CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8D6205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhlO5uUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCQNcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:32:23 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:36627 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgCQNcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:32:23 -0400
Received: by mail-pf1-f175.google.com with SMTP id i13so11976804pfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xrGpJ3uq41Cliav35Ssgq9YTTLCKw7NF05owbZD6QOo=;
        b=uhlO5uUC3kpL2LshNir8nZNSSZErKSwrjw+MK/VFt65aSVxTY28AecN0G/0AmJ7Mnx
         sdpbnUoMBD8FW1YBhkHCSdgMoL1d0vU4Gf/djIMc8XoeDyMr+32km9ZmPlGF0LFPZGml
         Cd3C2cLA2JTbsLWPwbWPi/Ecyoh8ZhdHg8/sFMuc5UfBWx7zhR5flhL811gTgUyVta4e
         Wr9ntdwILfMye+R1yqAWEp1bUPy1X7OMGG6kVtIEsgXkYTHkIGlDa4CeoJn/clV9RcqQ
         yQ7EGcUVCrBlV0ko+LkuAxl/hOD6rzMlF0tOIF86DjcTYh/+2BLyzyCp0lFL8JISQTud
         /dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xrGpJ3uq41Cliav35Ssgq9YTTLCKw7NF05owbZD6QOo=;
        b=id6U4DsN99PnTWlKB1AJZile193Jy8mXCsNZlaBuGnM44ytxhuhKCTEgP5uB+Cf1m0
         pejZg5VMnEhFsliUkKV+9XndobamU1nKA+/qN5knNsIrLgSAo2sVYKtbi61hBRYJor+4
         VnG8+0muW+woZzn9UapXI0IO4DWsEd5s74fqqTrPbuvUkeYu/SnNihQhUkSPbB9j+AdU
         tTpUWByJ9QTLh1ZRHbdeUlxOgMXkPXXAkVtw+6peN09sJmr2nH504Dodvl3tQxxyNrfj
         ga7mXoGY986iQy605IyXHBZ4vXagY9r4VF4+eQ5xo5PTSJZAxHM1lK6SBqjA1NPmFFBs
         fhfQ==
X-Gm-Message-State: ANhLgQ3aRMnpP9oX1cP0ikAs0QNN3h9EhUCLeJHeoUie+tCtaUbtJ/SP
        l5PgRdu5+GBu6cjwFnMlgxg=
X-Google-Smtp-Source: ADFU+vt1izRmjOATNr4bmCOuKXWdfwAmBG1m896l3Gz2MajMDZDek6TbURKRAy0pVgZzntU2DKVrLg==
X-Received: by 2002:a65:6446:: with SMTP id s6mr5276204pgv.5.1584451942216;
        Tue, 17 Mar 2020 06:32:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w11sm3179088pfn.4.2020.03.17.06.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:32:21 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] samples: Define dummy __NR_keyctl if undefined
Date:   Tue, 17 Mar 2020 06:32:19 -0700
Message-Id: <20200317133219.19248-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips:allmodconfig fails to build.

samples/watch_queue/watch_test.c: In function ‘keyctl_watch_key’:
samples/watch_queue/watch_test.c:34:17: error: ‘__NR_keyctl’ undeclared

Declare dummy __NR_keyctl if it is undefined to fix the problem.

Cc: David Howells <dhowells@redhat.com>
Fixes: 631ec151fd96 ("Add sample notification program")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 samples/watch_queue/watch_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 0eaff5dc04c3..ad11417a87f0 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -26,6 +26,9 @@
 #ifndef __NR_watch_devices
 #define __NR_watch_devices -1
 #endif
+#ifndef __NR_keyctl
+#define __NR_keyctl -1
+#endif
 
 #define BUF_SIZE 256
 
-- 
2.17.1

