Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C60C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7FD20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJYNe2yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGMTPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGMTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:15:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E63EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:15:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so875498wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLRZ9qpTJixANaJXhzQcebqMHUZZudD8UhTxU+6Cj1A=;
        b=vJYNe2yQUDGkF+YAq88b5Obetolzl9a59Km8DPVhMwrLlxjULOKQF0ykX0/T063BKe
         M7xoQENya6e2mAHycpH/22g6vAyms6e4MCOrnL3KO7N/KiKiEg+8RVg2kzEiGe3+FHA+
         yId+MWYKSD13yxXKGveazWhKGqq9ya8GUZaeDbTpA+3/QM+HnVxPikAe5QDtur9fsgXN
         PJdUJvPLGdYo7ze5DnfpBkpuxpQjOowT43eaAbdCXLrwbK8t/D5Msl6yh1mUPrM/L/It
         iONewwidWdtacdyjaASW50/VL0eGiguIHiu0WKuevBQi0/0A7B9fFWU4VGGHah192mbT
         6cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qLRZ9qpTJixANaJXhzQcebqMHUZZudD8UhTxU+6Cj1A=;
        b=DN7svnDp9NZ4D7urmzk17aXwob3XtlKB9rG4i2wwQhfZREz0cWjT2OxaNbW6q4pnk+
         s97uo0q8e/8q4+sYxQGLj0ZGjCL5aKwY4PYMcMK+015i6RW8d4A6GQHIEQxTPO24Z8Zy
         GyyN6W/wPz6MB2FB0/iWwXOBUx4YV8HjAbMe3VOkS+KJI3+8oKJqdp0l13dFuPK1GlfY
         vcvg12suo0878sS6nN8ZR7eTk76BwUqBmpOILw22Y184lhpRagS6vPRkdz2m8gmRJZCm
         76WOaASb4RRTAeDS1TjksaPsbx5OujY/feHpZDJPKeDFaEY/evQcWX85VFRGMa+PoRZD
         Ua9A==
X-Gm-Message-State: AOAM533439+c7GSMkQboMDLb3N2AxchJ2tBqOct5tDeHkTluIWZzanZy
        PZIsTTPiEoCpIbrZrplQupw=
X-Google-Smtp-Source: ABdhPJxHFwCKiZIWJgCMrB6VK9Qn4soHdbhhqubKZCErj4fWR2AFQL1EiFvZUn2oVMEIY+nuoaTO4A==
X-Received: by 2002:a1c:345:: with SMTP id 66mr846794wmd.31.1594667750842;
        Mon, 13 Jul 2020 12:15:50 -0700 (PDT)
Received: from garrit-VirtualBox.fritz.box ([94.31.102.44])
        by smtp.gmail.com with ESMTPSA id z1sm25407600wru.30.2020.07.13.12.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:15:50 -0700 (PDT)
From:   Garrit Franke <garritfranke@gmail.com>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Garrit Franke <garritfranke@gmail.com>
Subject: [PATCH] kobject: remove unused kobject action
Date:   Mon, 13 Jul 2020 21:15:10 +0200
Message-Id: <20200713191509.342466-1-garritfranke@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that the KOBJ_MAX action is never used. Does it serve any
purpose, or can it be removed? As far as I know, Kobjects shouldn't be
used for drivers and more higher level abstraction layers, so I figured
it isn't used by user-provided code either.

Regards
Garrit Franke

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 include/linux/kobject.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 6cba088bee24..fd99c5d2d8b7 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -58,8 +58,7 @@ enum kobject_action {
 	KOBJ_ONLINE,
 	KOBJ_OFFLINE,
 	KOBJ_BIND,
-	KOBJ_UNBIND,
-	KOBJ_MAX
+	KOBJ_UNBIND
 };
 
 struct kobject {
-- 
2.25.1

