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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C65DC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC220866
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rubp6YBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgAJXZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:25:15 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:43410 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgAJXZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:25:10 -0500
Received: by mail-qv1-f53.google.com with SMTP id p2so1581722qvo.10;
        Fri, 10 Jan 2020 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APIIct3N0R8QchxFnn4VxAewqgWseTMk/OomcP8BgHQ=;
        b=rubp6YBUHBHKJlStId2ueiybZ2dE81kZYpYtLnh1ozoDIiwGnbULIM8lhn7tyrtYB6
         Jpa5510Kd1P6US5fRPN5JJwsHOFbP4vk7RFz7/Z2G/IA1N6/hM+AHrZUqYYeLRo3vF4h
         cS0iNqB4xRIItAhDqhjFLP4sLZ2B0w+TIzTw+Q7j+cQR3Tx2+NgCYy0EYLSIC8NGFhuC
         zkpnwXjoeFOH32uj3+u4kLzsQEHoZVH0pHH9EVjat3v7P4N95XL0mHCK81I+tg87uH2N
         t4Ay6zlZSJXtQJBvlZNw3/0ohZ+dytFIJHIJrvDpGm+XbhAVDXIXxIIya/l/hM4WeOJr
         5kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APIIct3N0R8QchxFnn4VxAewqgWseTMk/OomcP8BgHQ=;
        b=fJOhsg+yaKfMRdDwDs9Or5+YBOlVuvvJfuUz1nFGnQkX3YgIkUwZqoeZzi4YBTtevE
         IOweCT/F7yuwPUBbDisikfG/caRnOenHRMI07qyfrqjOc+44Q6SCBlf9HjVJvkF6Gw8q
         ML8wU3D1vhRNeRKLtkGklpQiw0JOWWjZGPpKtnXCBHs5cqev5Vsrdc7d3t+kq2lgj3Sd
         xyVkRw+jQBraTCnIf/9LsNpdO1laHhI9/+WCqKrLmbuU96xQXtjH3UvAsUcv1Ogw8opG
         7+TVn1NSQ1c9BLI8/fZAulkSTRsfCzICT4a49nuNG/3DjvqXP0L7+PvYszgvOzKmf+bT
         CCIQ==
X-Gm-Message-State: APjAAAVN+pK3uAm8Uc7jtx8EgHjzovwXVrF3fLnmh0OwfVcJwSTi88eH
        3z4ydvHfQQykifzMetPq5hs=
X-Google-Smtp-Source: APXvYqw24IkI5R+Qnyv4XBr4naZprro/1HggkyT1vXPUns4tWePdzTJRBDos50aSe1mhilBveihDsQ==
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr1099862qvg.197.1578698709516;
        Fri, 10 Jan 2020 15:25:09 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:25:09 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 8/9] Documentation: nfs: pnfs-scsi-server: convert to ReST
Date:   Fri, 10 Jan 2020 20:24:30 -0300
Message-Id: <5c4b8af41ca0a427a3987535815bccf47a65d320.1578697871.git.dwlsalmeida@gmail.com>
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

Convert pnfs-scsi-server to ReST and move it to admin-guide. Content
remains mostly unchanged.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst                          | 1 +
 .../nfs/pnfs-scsi-server.rst}                                    | 1 +
 2 files changed, 2 insertions(+)
 rename Documentation/{filesystems/nfs/pnfs-scsi-server.txt => admin-guide/nfs/pnfs-scsi-server.rst} (97%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 365f42a611a4..3601a708f333 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -11,3 +11,4 @@ NFS
     nfsd-admin-interfaces
     nfs-idmapper
     pnfs-block-server
+    pnfs-scsi-server
diff --git a/Documentation/filesystems/nfs/pnfs-scsi-server.txt b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
similarity index 97%
rename from Documentation/filesystems/nfs/pnfs-scsi-server.txt
rename to Documentation/admin-guide/nfs/pnfs-scsi-server.rst
index 5bef7268bd9f..d2f6ee558071 100644
--- a/Documentation/filesystems/nfs/pnfs-scsi-server.txt
+++ b/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -1,4 +1,5 @@
 
+==================================
 pNFS SCSI layout server user guide
 ==================================
 
-- 
2.24.1

