Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733D8C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A01A20882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/IQKKA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgAJXZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:25:18 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:40058 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgAJXZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:25:13 -0500
Received: by mail-qk1-f169.google.com with SMTP id c17so3581381qkg.7;
        Fri, 10 Jan 2020 15:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BR//wDhqmO4v94OfCxbZnOUWsdDMuWQeBVXCu/WbhJg=;
        b=M/IQKKA/iv4Op1bVFVEm3tdJKx7uen+EkTvvPNDVXg6MmETrAZ/Tnb4HvDXRChVXpb
         I6FWnM2kKGHlbUOgGpcrehQ3GSIiy7LSyXaBYLegqizbDREi+4kygXWK5qS9FmM69lbC
         JWn+TW4UPGScK4Ha6XQFcv4m/D85NO0jeGia0UN6Np+ot7EWQEY2Yz5DsF7fqtotnrXF
         5/RhVCMdXqIh91W8t8K9B0qa3fGcom7JKZv1wS/w9Hp571fSm1C0e9GaqDuf/ECbXkBi
         YcQycMsT9yke8kjiX6hpijV4i2dX1F4L/ZGmrG8r5iE5gXGoAETLJ6oI6q/ILrqUxWSY
         Ec5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BR//wDhqmO4v94OfCxbZnOUWsdDMuWQeBVXCu/WbhJg=;
        b=hlgaoit8zICLcdKgaK79tHSxeR4YvPkiC+MTDyFX97jMd2doUkRuA4qVmsRDxYQr3D
         dGOrpi+6yjvr0CTx480kDVmJU0M3NadT4O/bDBNmJTW62ssMwAe6Y0FX7ddEXwDHfXAo
         IkIMptRKupu/XdzpXr9N65TzGiEeDPS0kmKtCdBP7sVEb8gDEZWZr2JISulVZlQLAzo2
         /VNFG5epjMQE3kGT+jmW0+E59QFL7tUqv5mPs0bOsv9LBj/0aDuiMLOAxegAnA+3Bw7M
         91fd6Z0v50OLTQ6UUvtvEiKBXZLs+XhCFxk3lID7fZVRAir49pzMH/Hujxfd78cU+UZG
         n37Q==
X-Gm-Message-State: APjAAAX4a+Rm9VFd4gH346WJXIQCvaBEG4UE/1hTBF+/Lbj6mibm7qop
        GWnbxevln1L0+WXmkAodcxY=
X-Google-Smtp-Source: APXvYqzdYfbSFXdQZUqhGqRV79qCQuXv+GPfRbBQgkTOVNeaz6ymoJ7d4jhmQuDOoTWNXVc77uj8Pw==
X-Received: by 2002:a37:6047:: with SMTP id u68mr1061561qkb.389.1578698712194;
        Fri, 10 Jan 2020 15:25:12 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:25:11 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 9/9] Documentation: nfs: fault_injection: convert to ReST
Date:   Fri, 10 Jan 2020 20:24:31 -0300
Message-Id: <f7b0cf8fb1159a668f75ce82a581e7590568c2b8.1578697871.git.dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1578697871.git.dwlsalmeida@gmail.com>
References: <cover.1578697871.git.dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Convert fault_injection.txt to ReST and move it to admin-guide.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 .../nfs/fault_injection.rst}                                 | 5 +++--
 Documentation/admin-guide/nfs/index.rst                      | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/{filesystems/nfs/fault_injection.txt => admin-guide/nfs/fault_injection.rst} (98%)

diff --git a/Documentation/filesystems/nfs/fault_injection.txt b/Documentation/admin-guide/nfs/fault_injection.rst
similarity index 98%
rename from Documentation/filesystems/nfs/fault_injection.txt
rename to Documentation/admin-guide/nfs/fault_injection.rst
index f3a5b0a8ac05..eb029c0c15ce 100644
--- a/Documentation/filesystems/nfs/fault_injection.txt
+++ b/Documentation/admin-guide/nfs/fault_injection.rst
@@ -1,6 +1,7 @@
+===================
+NFS Fault Injection
+===================
 
-Fault Injection
-===============
 Fault injection is a method for forcing errors that may not normally occur, or
 may be difficult to reproduce.  Forcing these errors in a controlled environment
 can help the developer find and fix bugs before their code is shipped in a
diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 3601a708f333..6b5a3c90fac5 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -12,3 +12,4 @@ NFS
     nfs-idmapper
     pnfs-block-server
     pnfs-scsi-server
+    fault_injection
-- 
2.24.1

