Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED81C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3A8206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5phTAFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgG0Lea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgG0Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:34:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:34:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so9334804pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNqhCNDlCGUtCAIGEpVKu7Yf2JbLRnex9E/c2kvaRMU=;
        b=K5phTAFWN3kjl7VrGX1CgYEcmO2i98sCFsKKox4k9cGyakQxg2fUNWE8z/IdaMD/jQ
         bHa0WvBfMEsvSaxiADuEsIgTgwlquBAK4u5qwF3hE7yCG0TOoOq9+bXvjfOqRZU+Lv9f
         kRL1Tm77psFMKmiUXAW4BHQZOGn+DsjUedrbAKE5CWL7jZRi5IZ5gEGOYf/8I1WoVBcD
         9CK/9j12pWS6Fj9C3Q1yjDTd2bk6lg7x8QLT6wOZNoyGpr8jgWH4qxqHWogheTK9sRx+
         bIcQfFT/eijakt+m/58ZDpLgC155wnl0cL2B3ziL4jS3RC2KII+m80eaCtP7mA5hHCwd
         M7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KNqhCNDlCGUtCAIGEpVKu7Yf2JbLRnex9E/c2kvaRMU=;
        b=qbanEpo6xM8iWP4ILWHLcnOSKz75V3+51SAT9SWGbyrHGnLpEj0Oc+c2SSDOZrObh/
         3piXYsK1rxRH9fafLBwYgaRYnfifsAnagHqb6PR9Efr0pVYjxpCBWf7QzuZRzo/D0TH+
         rdyKRGvGX0zDJaAfHWZk/lXHBRb11smucqsiikx+5bE/kALjKiOwybMzOqLPXwJ9E72Z
         8VFqhINO06TFmxJ88ubTS2kkQm19cm9HNbnBKVOgkDEmsaz7BgByRbWAI29f7nC2gDDw
         j3FlR8G15PootkgT1e+1qjHkkr2+yaq0lTtVGd8/mHx2YAkoCakA7e58mW5uNzudVegK
         Sxvg==
X-Gm-Message-State: AOAM530u4USFZscyKUzry7APA/aTsL7qg+CGFrtq3UjXoNEZe77XZr7j
        cKE7TD9Mey1YpLfKhdsm2HU=
X-Google-Smtp-Source: ABdhPJyCPw66QDcmbO7zc3bT3A4gwVP1DzGsqVEBWHUCBDup8AUIaYQmeQlikAORr0+2lJMWvInjEQ==
X-Received: by 2002:a62:7546:: with SMTP id q67mr2784040pfc.210.1595849667651;
        Mon, 27 Jul 2020 04:34:27 -0700 (PDT)
Received: from pc.domain.name ([103.10.31.103])
        by smtp.gmail.com with ESMTPSA id n15sm14520534pgs.25.2020.07.27.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 04:34:27 -0700 (PDT)
From:   Yadav Lamichhane <tuxomega1@gmail.com>
To:     christian.brauner@ubuntu.com
Cc:     serge@hallyn.com, linux-kernel@vger.kernel.org,
        Yadav Lamichhane <tuxomega1@gmail.com>
Subject: [PATCH] userns: Fix a kernel coding style issue
Date:   Mon, 27 Jul 2020 17:18:23 +0545
Message-Id: <20200727113323.79720-1-tuxomega1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a brace around if-else statement and for loop.

Signed-off-by: Yadav Lamichhane <tuxomega1@gmail.com>
---
 kernel/user_namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..7703753cac97 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -118,9 +118,8 @@ int create_user_ns(struct cred *new)
 	ns->owner = owner;
 	ns->group = group;
 	INIT_WORK(&ns->work, free_user_ns);
-	for (i = 0; i < UCOUNT_COUNTS; i++) {
+	for (i = 0; i < UCOUNT_COUNTS; i++)
 		ns->ucount_max[i] = INT_MAX;
-	}
 	ns->ucounts = ucounts;

 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
@@ -1156,12 +1155,10 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	if (strncmp(pos, "allow", 5) == 0) {
 		pos += 5;
 		setgroups_allowed = true;
-	}
-	else if (strncmp(pos, "deny", 4) == 0) {
+	} else if (strncmp(pos, "deny", 4) == 0) {
 		pos += 4;
 		setgroups_allowed = false;
-	}
-	else
+	} else
 		goto out;

 	/* Verify there is not trailing junk on the line */
--
2.26.2

