Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEDDC433F1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B635C22B4D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNDYW5Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgGSXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgGSXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:49 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB92C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:49 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e4so13008925oib.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6ImSZQBi9E2vjSaQ5mua6BbErK1cGhsRPgNZtApqoY=;
        b=FNDYW5CslI5BryzWhGSnkXM/HS5fTgyD1LeMuo22nz8XimzJ1kH1pCqTw/4EIFKVBS
         uwzza8rtIV2oOf/RfLsKdorCA28YB0jCIBZK0oZA2XeDdwLsK6aeVRTBGdxLiIlb4Tqd
         BpV6IoNtlo05LxYhEip/NJnylSw8d0EKPmgr3A+1w5YJlc/vGtr16sOQDIg/jKQPx3ut
         I0PQuP/z92747WHopFZOz46VF4sJGj+sEvQBmTlSV+AnABZQRThQW0LqiKYZVEXGmXOC
         XNs/p6yUUXzCJMLx5UjJ4Ww7rekAqgUF+qOt8REJlI0A0o5s8pw2zG4NRq/Hqet50eDn
         CdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6ImSZQBi9E2vjSaQ5mua6BbErK1cGhsRPgNZtApqoY=;
        b=lLtKN5tdwpWf4SAWRM48TERjZoTgc9Uhmyx7o+UVP7LZX0qaOFZmtPGnP4xVC0zpge
         IZ2UOy8wpeSBqpeBxVri/IqJJpjF8bQVvA2TUc8ob2JsLVVV4ACtQhhCPpDyffpKrqCQ
         yA6W+c9bSo9q9wiA3rdJiOF0axA5WgGVcOHm+j+g08kFY6CgvNkdGvnVR9ha4f4KgPtj
         4dxVz2HRIWGxbfYOqzm2hoSe8oG9DdcgZ6p6kpGavF7oih9BjCELnIBM6ispj2+DpT3i
         m/kBy3xJLM8XHhceAXe13h8SYW6oXpuGkVdVNlottoBfiGgkMdrkSb+OdMno0DpH/H5l
         jGgg==
X-Gm-Message-State: AOAM533lqMtSbIVdHy6r0sRRrMd5W0QniMTPkLKfwCZuLsZg6ga7DXE8
        ZM+ykuTLiNG5gld1xMawftQ=
X-Google-Smtp-Source: ABdhPJwEwALiRh3bDk05iS7DxjN6/p5aRqP2NKKJ3WeQbgfGXAmxMAg1LpnCcDsemA/LfFRgs2ohyw==
X-Received: by 2002:a05:6808:486:: with SMTP id z6mr16494808oid.56.1595200308501;
        Sun, 19 Jul 2020 16:11:48 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:47 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 17/18] dyndbg: shorten our logging prefix, drop __func__
Date:   Sun, 19 Jul 2020 17:10:57 -0600
Message-Id: <20200719231058.1586423-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For log-message output, reduce column space consumed by current
pr_fmt by dropping __func__ and shortening "dynamic_debug" to
"dyndbg".  This improves readability on narrow consoles, and better
matches other kernel boot info messages.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c72bb4d2eb7e..e87b630bd793 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
+#define pr_fmt(fmt) "dyndbg: " fmt
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.26.2

