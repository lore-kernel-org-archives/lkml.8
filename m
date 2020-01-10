Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86EC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22D520866
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1Z059DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgAJXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:25:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38414 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbgAJXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:25:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id n15so3545190qtp.5;
        Fri, 10 Jan 2020 15:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xk8upTGYpLiwWJz4OqX3lOVzD+11JcT9lOysezL8+cQ=;
        b=K1Z059DAsEtF0G8X2GilAXpTrtpfymy3K2xd89WFLmI8MhCCbvRX01MVt5p59J8Nm5
         AEa8rNWj7NB6ktyH/gdpkpPNq9QfRMgHKpikuMQ6HRca7c8zN63TSdia5eE7+K5zTw0u
         VoeE5FvpnAEjbER2upOqoPf7AlbgXCT86K92OlhoMYfspl0XZ+RKH86DJM3Od34vUKmR
         pEgIR0AJCfumcrqIg1s+13RQ84aK+8SIHhpABIMn7MkMIpE/5HgaH7GYlOhoa+GEt48I
         J9hIcvk58U06zGyR1gPDtn4c1GPiKf2vdmM+luR6Eql6CZZ62ThNKBr5/1lseeSiQekI
         pNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xk8upTGYpLiwWJz4OqX3lOVzD+11JcT9lOysezL8+cQ=;
        b=Q+FTFvhGrvUzhp2/FtfDCg7bSiKzsVZtqZpK1JIL1M7ZPMTMI9IXzqGlYioiZ2BXQq
         LYhj+Jwsv5WdFOJt3IaxamOpk4Vq9Si6l4JTDOsk8FB3iK+tAuKcajr2lbG4jvd4431C
         +Yef6ypFJlfGtdgcL7Q5bfTAiTMrg3dwH/zN5Z2CgseeWfEVhlJUGqgOQ2I2xRzYr8Pd
         J6SG3RHEUk+6RfiYgCI8yJEcr3ou3ozDFA+T4Zs8g2ur2szPW1Cw1NuZQax2m1wQKNGx
         j3heQV5BFWji3+zA8isqWKihALiwo31azIyOMh4P17KJvw5HroWZh1bGBa0p4Y9HSiko
         jaCA==
X-Gm-Message-State: APjAAAWoVtgIZrvopOm346zOpKGoViVP+x7wlVWfbYv5emibFWt44Czq
        VkbPLz/bF/IYvY7auZMLm+s=
X-Google-Smtp-Source: APXvYqzE/g9FThs68kBo67G97dyaEtLTX25gh5Etw58UQyT5B6XgHYM8ZBe2g0/Kt0Mb+EdVUziOew==
X-Received: by 2002:aed:3f32:: with SMTP id p47mr4786924qtf.374.1578698706848;
        Fri, 10 Jan 2020 15:25:06 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:25:06 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 7/9] Documentation: nfs: convert pnfs-block-server to ReST
Date:   Fri, 10 Jan 2020 20:24:29 -0300
Message-Id: <c06903760e690c16d9df92f5e75f80381d6326d8.1578697871.git.dwlsalmeida@gmail.com>
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

Convert pnfs-block-server.txt to ReST and move it to admin-guide.
Content remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |  1 +
 .../nfs/pnfs-block-server.rst}                | 25 +++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)
 rename Documentation/{filesystems/nfs/pnfs-block-server.txt => admin-guide/nfs/pnfs-block-server.rst} (80%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 8376d5225fc2..365f42a611a4 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -10,3 +10,4 @@ NFS
     nfs-rdma
     nfsd-admin-interfaces
     nfs-idmapper
+    pnfs-block-server
diff --git a/Documentation/filesystems/nfs/pnfs-block-server.txt b/Documentation/admin-guide/nfs/pnfs-block-server.rst
similarity index 80%
rename from Documentation/filesystems/nfs/pnfs-block-server.txt
rename to Documentation/admin-guide/nfs/pnfs-block-server.rst
index 2143673cf154..b00a2e705cc4 100644
--- a/Documentation/filesystems/nfs/pnfs-block-server.txt
+++ b/Documentation/admin-guide/nfs/pnfs-block-server.rst
@@ -1,4 +1,6 @@
+===================================
 pNFS block layout server user guide
+===================================
 
 The Linux NFS server now supports the pNFS block layout extension.  In this
 case the NFS server acts as Metadata Server (MDS) for pNFS, which in addition
@@ -22,16 +24,19 @@ If the nfsd server needs to fence a non-responding client it calls
 /sbin/nfsd-recall-failed with the first argument set to the IP address of
 the client, and the second argument set to the device node without the /dev
 prefix for the file system to be fenced. Below is an example file that shows
-how to translate the device into a serial number from SCSI EVPD 0x80:
+how to translate the device into a serial number from SCSI EVPD 0x80::
 
-cat > /sbin/nfsd-recall-failed << EOF
-#!/bin/sh
+	cat > /sbin/nfsd-recall-failed << EOF
 
-CLIENT="$1"
-DEV="/dev/$2"
-EVPD=`sg_inq --page=0x80 ${DEV} | \
-	grep "Unit serial number:" | \
-	awk -F ': ' '{print $2}'`
+.. code-block:: sh
 
-echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
-EOF
+	#!/bin/sh
+
+	CLIENT="$1"
+	DEV="/dev/$2"
+	EVPD=`sg_inq --page=0x80 ${DEV} | \
+		grep "Unit serial number:" | \
+		awk -F ': ' '{print $2}'`
+
+	echo "fencing client ${CLIENT} serial ${EVPD}" >> /var/log/pnfsd-fence.log
+	EOF
-- 
2.24.1

