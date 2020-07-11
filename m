Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE6CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94BCA20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMRj30qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgGKO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgGKO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 10:59:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A5C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 07:59:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so8739697wrs.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+5YJ4BXyiVlwCev/UR7kk6fTDXZ3Zt+Tj2RKUuxL+a8=;
        b=CMRj30qE68pT3/+9gTayn6Oxa3rw+6akAmiovWC9XLMF8VgQXxMOZFuuoGYKLYCp4A
         K5LlDsduDQhuHIZwqGaPynMi79PC3WUPu3gclwFmgrTl85ceQX9v+T7MUSt3E+Ni4mhR
         PzHs1OqIoy/MaAUiOsRe1+iljA6ikgK8cPQJTUcQrCvvfx6l0qWxgoSuOVnQo9tj/D9M
         Zlfg+hfCwLEH1/lAGpTXgdTughYytb6uaYSgdY6sHuQ4z5R3OOxSH+8ejyUXYLdONlGP
         /sfrrvDytwnnz6o+BL6G4y9T8+q4lGOjVVUvBne3WwPDs404QTJgcFUWkN+pTUtNvDEf
         1HAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+5YJ4BXyiVlwCev/UR7kk6fTDXZ3Zt+Tj2RKUuxL+a8=;
        b=Xv1LVzWMRL/efn1Vdqy9Rm8TJcR1/6fL2QD7al6gTMcd9goDQLHlg9yU2S0c+A/Vi5
         Q5hphy6miNrdaolFUvR+TZcT7KUeLOrqLq3Ul8AWZfZRWMC9sDFqL67s9pE+YfoEZlwT
         gM9W6spaArPzC5GIuSPc5QSdKQngFukqn8xweCtqGAQXEEFD/OVQqXLeZtSdgq/ye5oP
         Ox68GHbSsFQwvnItu4eZniuv0CeAf88tFMO/izv5ek1tHr/QD9gP3G9dGe9qLeYv46xX
         Fu4IX9XdCGSDXzJNMAWlDOVqBcp26m/sG/K17x+Pru81Us2HYDtwqJ7J5GyEG0WT2nD8
         K6iA==
X-Gm-Message-State: AOAM531BUJwuj2noEIEfauI/S2aQd9NNd6z8FbBXlvYPG+0UGIfGKDvt
        GMyPLgCHkhUDP4l0wV1Bd+vWeMo=
X-Google-Smtp-Source: ABdhPJzTCmgbsceK42zcfVRe0huxYhnfmTSIbqUca//xWYfyNJKm4Tei1PSmOI8Y4d9+upaWrmhyfw==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr69479724wru.88.1594479597634;
        Sat, 11 Jul 2020 07:59:57 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.169])
        by smtp.gmail.com with ESMTPSA id p25sm13157545wmg.39.2020.07.11.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 07:59:56 -0700 (PDT)
Date:   Sat, 11 Jul 2020 17:59:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rwsem: fix commas in initialisation
Message-ID: <20200711145954.GA1178171@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leading comma prevents arbitrary reordering of initialisation clauses.
The whole point of C99 initialisation is to allow any such reordering.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/rwsem.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -66,22 +66,22 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
-	, .dep_map = {					\
+	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
-	}
+	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
 #endif
 
 #ifdef CONFIG_DEBUG_RWSEMS
-# define __DEBUG_RWSEM_INITIALIZER(lockname) , .magic = &lockname
+# define __DEBUG_RWSEM_INITIALIZER(lockname) .magic = &lockname,
 #else
 # define __DEBUG_RWSEM_INITIALIZER(lockname)
 #endif
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
-#define __RWSEM_OPT_INIT(lockname) , .osq = OSQ_LOCK_UNLOCKED
+#define __RWSEM_OPT_INIT(lockname) .osq = OSQ_LOCK_UNLOCKED,
 #else
 #define __RWSEM_OPT_INIT(lockname)
 #endif
@@ -90,7 +90,7 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 	{ __RWSEM_INIT_COUNT(name),				\
 	  .owner = ATOMIC_LONG_INIT(0),				\
 	  .wait_list = LIST_HEAD_INIT((name).wait_list),	\
-	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock)	\
+	  .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
 	  __RWSEM_OPT_INIT(name)				\
 	  __DEBUG_RWSEM_INITIALIZER(name)			\
 	  __RWSEM_DEP_MAP_INIT(name) }
