Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B40C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ACD204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/VqFuA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHGTcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:32:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8CC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:32:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so1577252pls.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XQSiBQuzuoq0Nc6sDX6CraIWCZ02E2YEld555TDkY8=;
        b=n/VqFuA/xbZ1NQ6mklq+CUuneA3WANMe3N77xQZsSToas2wL8SzDg/vbAmXxCYuqtK
         7q8Gh2RGwQKH58rdoLOk/6LqaPO9pZYj2iugNs7LyLcpnZNffJ5Di823wWSoxewih58v
         glLV05mtOy33k029ezoii9IEXZJVFhhYepBAeO38mLPExRF9NdnElbloU2KUwgP1xQRe
         hSDJ7UWYep390oqkwa740/rz49X8eczRx2aSisrl2AIKZnu8TB25MOue1mznucYxgryB
         zPi5nWPbdaYz46KBYYfYdQKKhn1gpTu+Dssr2xGxm0QzdPCqoy2xTuJIkfmTZizURfDw
         odQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4XQSiBQuzuoq0Nc6sDX6CraIWCZ02E2YEld555TDkY8=;
        b=WBFGwR5KbsjjEIhdmStERC12A9I8mZC3wJDb3UJ1Gdjyd/Rxw8mBFtBBuvElg73Xtd
         5JZG83WBNNxr1MIDscNvjC6qv5CLVARePcr1YluD9GcwcDZ7VUOQzzuF5RHLzjQdtMDv
         WI5ae3JW1PDK7BGNpIckDbB8G0GAMwghnUD45hC9766kq032UniFWoEW0wGI2d7Jb96N
         KSfaUPJTsvNFAo08YcwMjsj4fObt+/Yucrfft/ct9eZRpLB/SpOd9rmjld3Xd/5MJYjT
         xH32ykTLJ+HsCPcVW9D4g8Ht7cuc9hpdo566O0OYdBVIyzGIkb+6XBQwcU1eU0SisjUE
         JX2Q==
X-Gm-Message-State: AOAM531nviQL/mxZ2qnrKaQ+GBBju2ZQlh47w+s4VMO649i1aY9ISZgN
        9mJ/EENCKn3759372xdR8Ms=
X-Google-Smtp-Source: ABdhPJxmsYRraF/q5e7jeWzroxFh6jSAuaD6Bdv3PUTKbtE7Z78/UiCsln+hb7UVD9/5yLQ3Um0ZUA==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr13215462plr.116.1596828754133;
        Fri, 07 Aug 2020 12:32:34 -0700 (PDT)
Received: from athina.mtv.corp.google.com ([2620:15c:211:0:a28c:fdff:fee1:f370])
        by smtp.gmail.com with ESMTPSA id r7sm13762489pfl.186.2020.08.07.12.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:32:33 -0700 (PDT)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux UM Mailing List <linux-um@lists.infradead.org>
Subject: [PATCH] uml - fix incorrect assumptions about max pid length
Date:   Fri,  7 Aug 2020 12:32:26 -0700
Message-Id: <20200807193226.921195-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

Fixes: is_umdir_used - pid filename too long

pids are no longer limited to 16-bits, bump to 32-bits,
ie. 9 decimal characters.  Additionally sizeof("/") already
returns 2 - ie. it already accounts for trailing zero.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Linux UM Mailing List <linux-um@lists.infradead.org>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
---
 arch/um/os-Linux/umid.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 9e16078a4bf8..1d7558dac75f 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -97,7 +97,7 @@ static int remove_files_and_dir(char *dir)
 	while ((ent = readdir(directory)) != NULL) {
 		if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
 			continue;
-		len = strlen(dir) + sizeof("/") + strlen(ent->d_name) + 1;
+		len = strlen(dir) + strlen("/") + strlen(ent->d_name) + 1;
 		if (len > sizeof(file)) {
 			ret = -E2BIG;
 			goto out;
@@ -135,7 +135,7 @@ static int remove_files_and_dir(char *dir)
  */
 static inline int is_umdir_used(char *dir)
 {
-	char pid[sizeof("nnnnn\0")], *end, *file;
+	char pid[sizeof("nnnnnnnnn")], *end, *file;
 	int dead, fd, p, n, err;
 	size_t filelen;
 
@@ -217,10 +217,10 @@ static int umdir_take_if_dead(char *dir)
 
 static void __init create_pid_file(void)
 {
-	char pid[sizeof("nnnnn\0")], *file;
+	char pid[sizeof("nnnnnnnnn")], *file;
 	int fd, n;
 
-	n = strlen(uml_dir) + UMID_LEN + sizeof("/pid\0");
+	n = strlen(uml_dir) + UMID_LEN + sizeof("/pid");
 	file = malloc(n);
 	if (!file)
 		return;
-- 
2.28.0.236.gb10cc79966-goog

