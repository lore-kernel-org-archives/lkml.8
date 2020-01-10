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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE704C33CA5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CAF20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw0R5Qf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgAJXZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:25:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35364 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgAJXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:25:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id z76so3606563qka.2;
        Fri, 10 Jan 2020 15:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ebLONtqGmJ0g8QdilfQ195Nw3+a7aEVgDzipjzqmmg=;
        b=Gw0R5Qf1xKXXTYVfJYyHt9pm3m2q6WScg95V7llejc0l4Q2N+oP4MQPRYS8ezT3PIm
         QFpU/vL8PQ20hnbn0zuLGZNIIt4yGdDoCX5MFNQNuQLydU7E5ysrIodBDOwReKMwOW8Z
         KjsXmg6knosGz6L+B8wUYXuT//ewjBreJLPz5TDKtxO9NzaUIW4G8RSNrafq7dWLYYMN
         jtU2VaAp3I8A18fsCQZJFWP8EGHUbeenjLRTrsWJVk+fZfwS2c5qjhGdj1iYf6ZU7tSK
         f2djpx0814aYvPaX9sEP9Ycz1k6unfxJ+2mci+5QPxLD4x3lcrhsIMAvW3kz9UA5libJ
         gOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ebLONtqGmJ0g8QdilfQ195Nw3+a7aEVgDzipjzqmmg=;
        b=GhXzhbAni6Q4d7fEamYbiEyMkQzIjDKmZJD8o4lK/2LNXtNHA3lNqJCOnPZkcpxH7w
         IKzDYflW+45NAdecxHzitEakGt9dBjNm8qkGViKHWhOGskbqaZO9+4MN+MnTwVuTYMx8
         w3e/DmmrFAVNkk6eNw70ZftLc7roAp825zMLhTr8pb5erxWbDkapyvCgkchLyXzF70DP
         4UHquSdDnyQIcUcE7w48NWNUx5leoud6wXWsRTzLOJcfAT9YtBFTCPIqh02g8LEMtOTm
         djnjbzFREpdtcYFG80Lp6DxWyRTHARb2g9qZPwabfwncbRZu7Guqb0+N5LEF4VZqtrdz
         aZ2A==
X-Gm-Message-State: APjAAAVEPPOGkZyfvVXlbLIc1LQUr3eG1T1CUhiN1Ck8WcMxQ18PIxGb
        VolyFZfelzIzKfsRcvbdcjM=
X-Google-Smtp-Source: APXvYqy7ABNVa/nl93DGqZ+C/GmsUunJhoaqIoi4I7mOCqz92jlqlubPJp4tKWefhsXUvBQefSjjOA==
X-Received: by 2002:a05:620a:1001:: with SMTP id z1mr958143qkj.99.1578698701428;
        Fri, 10 Jan 2020 15:25:01 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id i2sm1774752qte.87.2020.01.10.15.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:25:01 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab+samsung@kernel.org, corbet@lwn.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 5/9] Documentation: convert nfsd-admin-interfaces to ReST
Date:   Fri, 10 Jan 2020 20:24:27 -0300
Message-Id: <d471305e9c96dec38f18d2ff816fca2269a88e29.1578697871.git.dwlsalmeida@gmail.com>
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

Convert nfsd-admin-interfaces to ReST and move it into admin-guide.
Content remains mostly untouched.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 Documentation/admin-guide/nfs/index.rst       |  1 +
 .../nfs/nfsd-admin-interfaces.rst}            | 19 +++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)
 rename Documentation/{filesystems/nfs/nfsd-admin-interfaces.txt => admin-guide/nfs/nfsd-admin-interfaces.rst} (70%)

diff --git a/Documentation/admin-guide/nfs/index.rst b/Documentation/admin-guide/nfs/index.rst
index 875a96fe9d04..e0b2f4260ad7 100644
--- a/Documentation/admin-guide/nfs/index.rst
+++ b/Documentation/admin-guide/nfs/index.rst
@@ -8,3 +8,4 @@ NFS
     nfs-client
     nfsroot
     nfs-rdma
+    nfsd-admin-interfaces
diff --git a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
similarity index 70%
rename from Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
rename to Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
index 56a96fb08a73..c05926f79054 100644
--- a/Documentation/filesystems/nfs/nfsd-admin-interfaces.txt
+++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
@@ -1,5 +1,6 @@
+==================================
 Administrative interfaces for nfsd
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+==================================
 
 Note that normally these interfaces are used only by the utilities in
 nfs-utils.
@@ -13,18 +14,16 @@ nfsd/threads.
 Before doing that, NFSD can be told which sockets to listen on by
 writing to nfsd/portlist; that write may be:
 
-	- an ascii-encoded file descriptor, which should refer to a
-	  bound (and listening, for tcp) socket, or
-	- "transportname port", where transportname is currently either
-	  "udp", "tcp", or "rdma".
+	-  an ascii-encoded file descriptor, which should refer to a
+	   bound (and listening, for tcp) socket, or
+	-  "transportname port", where transportname is currently either
+	   "udp", "tcp", or "rdma".
 
 If nfsd is started without doing any of these, then it will create one
 udp and one tcp listener at port 2049 (see nfsd_init_socks).
 
-On startup, nfsd and lockd grace periods start.
-
-nfsd is shut down by a write of 0 to nfsd/threads.  All locks and state
-are thrown away at that point.
+On startup, nfsd and lockd grace periods start. nfsd is shut down by a write of
+0 to nfsd/threads.  All locks and state are thrown away at that point.
 
 Between startup and shutdown, the number of threads may be adjusted up
 or down by additional writes to nfsd/threads or by writes to
@@ -34,7 +33,7 @@ For more detail about files under nfsd/ and what they control, see
 fs/nfsd/nfsctl.c; most of them have detailed comments.
 
 Implementation notes
-^^^^^^^^^^^^^^^^^^^^
+====================
 
 Note that the rpc server requires the caller to serialize addition and
 removal of listening sockets, and startup and shutdown of the server.
-- 
2.24.1

