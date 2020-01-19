Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2BC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6B2073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuaI0k04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgASIi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 03:38:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36756 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgASIi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 03:38:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id k3so13927102pgc.3;
        Sun, 19 Jan 2020 00:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wF5Xuv0BTk8kspnRMHwv06S9R1WiaH7h7B5fyMiJVfE=;
        b=KuaI0k04xG1w3emIXID5xrncuwYQPr3IY5G/LRCl1NmiB0Kr2gtdwDEH/eivqsR7I5
         X0U3OpzZoT7AWDzzHBQ8WFpfiuBs/X5ejj5185e55ECsu5htGmGeCnjc9zMgGCKkuvLJ
         ojVVvFx49yTRPCl5SlJadwfdzISLIi25BDYOc1B+K+qLUORpkzjRKzDYoA/K2Zdn1b3v
         Q1hMhdp7YGFzBnQ00qJ6LmhE2ilyQXu12EXbaci0ou5FwSzHmYLQyZ2I9SmFX6BVl/W+
         OS9UYDr3kdRGUfBuLvJbPeCwmF83/kvAjrv4xp0AU76UL64EbzkLbq3ZhLF2zgf5G73h
         Hzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wF5Xuv0BTk8kspnRMHwv06S9R1WiaH7h7B5fyMiJVfE=;
        b=ixAoJEBTmjfAs3La32svs9vNB+mhpl03C2KBXa5OTReUxL5xRsBmou1pqt3Xd1QSnY
         opUKB52x5NqyHErxEboM/X3BALir7Z7z44lERCx4iIq/mlKcN1un381YfGsoOBL/uqZz
         Kqquun7esGQmJGng1T+ZkOadq6Jf+elHqupPfs7sHoOxzRFjz1JBkD0WvV2tUGJ+7h4k
         /kOod5PcErWEsBquoZ0wagWzUkXvr2plA+5chffCvtV9Qw4ZYYhBVXgnsaVP2On4QwQZ
         hu9E6tWHDd3tPAOg2AHtHA98KWNwBk3pDnMEWgDFkwS/PMz34bxoY/kAAf/KSwMh2k2M
         3e4g==
X-Gm-Message-State: APjAAAU65UPlnjaQI976nE2ilAr81qd0J8BFDr5zQm/jsAfslAMCp7ek
        cKA4TfinPRrlb8oYOCI7Io8=
X-Google-Smtp-Source: APXvYqzHsje3/mGYYrrAh2rPZ9VrUoecCS35LeJGY9RQP/9xCL9LM49ZKJU0qgsqqaNlzxuGlIhoDw==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr55395739pgh.355.1579423138619;
        Sun, 19 Jan 2020 00:38:58 -0800 (PST)
Received: from localhost.localdomain ([119.28.24.183])
        by smtp.gmail.com with ESMTPSA id x8sm35690172pfd.76.2020.01.19.00.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 00:38:57 -0800 (PST)
From:   Lingpeng Chen <forrest0579@gmail.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lingpeng Chen <forrest0579@gmail.com>
Subject: [PATCH] Doc: networking: fix typo in Documentation/networking/tls.rst
Date:   Sun, 19 Jan 2020 16:38:39 +0800
Message-Id: <20200119083840.28714-1-forrest0579@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

klts_send_ctrl_message -> ktls_send_ctrl_message

Signed-off-by: Lingpeng Chen <forrest0579@gmail.com>
---
 Documentation/networking/tls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 8cb2cd4e2a80..fca2a7364223 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -132,7 +132,7 @@ using a record of type @record_type.
 .. code-block:: c
 
   /* send TLS control message using record_type */
-  static int klts_send_ctrl_message(int sock, unsigned char record_type,
+  static int ktls_send_ctrl_message(int sock, unsigned char record_type,
                                     void *data, size_t length)
   {
         struct msghdr msg = {0};
-- 
2.17.1

