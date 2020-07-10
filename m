Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE58C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC8D2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAATVEU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgGJUDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:03:16 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:03:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lx13so7357110ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Jqzgq/n7wZOMhEb7Tg22T6QZFTnibrfQPhy0seMwny8=;
        b=mAATVEU/9s9QTVzCtRmel63BGpFvAbckGZX8DQs98U4Ed/wGKOM2IHiyTcfpDy6bV0
         kqjGwe1Qbc7vtfM8U+iAw9fgfzRTuOgFlcorbwVvc3AHIK+Dp4ct99soP3eEFinfbYYD
         No07MUNe+SqZVN5EdesnxKx009fHbQ1Uqk8LKQm3Z+Za5/CKnpHDNdSe+3JM86kGZuTo
         jF36VoG93bouykU8phSakCazF+jtFAyelOBrj8HH0Y0bPu5fBKQ+g9YdiHpc/FOCl+xL
         Mj6EThe3tze7s7r22nPzRifnYp57dAwQTgEIp016nR8LWBvD6KjzMGe7tr2ppvddc5ZX
         0UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Jqzgq/n7wZOMhEb7Tg22T6QZFTnibrfQPhy0seMwny8=;
        b=e7UBnEiqXfXjzT1tGE7Wq3j56ePG+0tjJFmuMAPSWdAFQs/qSBWrWohju+bx8hzzuS
         1yGB61g25KZ9lWYdDB4eOVoJJy1MJPzn7yK/RnHydO/vj69U5FXZDdJbArSFpcKarcmC
         U7YDdO6Z6vyyYh0IKbqQ+DdwJVpYtSgiyGhNmPSsv3qZs4Ed72XFOnnzmNLoRAgCfwtz
         rSw3wJtcTG2QLSlCU2Sauh3mmbpIBAkYc40iORAnc2jGdGYt9G1j1slTfHLlegsYA/37
         qFUP+YYAj+/D8tzbLZryI9TYL+Ojqlcur6nNNT2EKseGzg8GODDI04epN4GBE3x0w7bZ
         kPJg==
X-Gm-Message-State: AOAM533X42RvbDu0a9uh9FWyoxcogttERZ7X2slNoYd2RRTWoGeQbo2O
        w84bDZRzKCcyZF3vlXaWvCiiNH8=
X-Google-Smtp-Source: ABdhPJx6sV2JvLYwqvkGcTbdtJPOTPhaC5RFA+2jMQ2CZb3bOzHoYlAGduULrtwziUqeCtEGFzylPA==
X-Received: by 2002:a17:906:1414:: with SMTP id p20mr61470353ejc.247.1594411395239;
        Fri, 10 Jul 2020 13:03:15 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.22])
        by smtp.gmail.com with ESMTPSA id ce19sm4236133ejb.24.2020.07.10.13.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:03:14 -0700 (PDT)
Date:   Fri, 10 Jul 2020 23:03:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ipc: uninline functions
Message-ID: <20200710200312.GA960353@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two functions are only called via function pointers, don't bother
inlining them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 ipc/sem.c |    3 +--
 ipc/shm.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -585,8 +585,7 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 /*
  * Called with sem_ids.rwsem and ipcp locked.
  */
-static inline int sem_more_checks(struct kern_ipc_perm *ipcp,
-				struct ipc_params *params)
+static int sem_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params)
 {
 	struct sem_array *sma;
 
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -711,8 +711,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 /*
  * Called with shm_ids.rwsem and ipcp locked.
  */
-static inline int shm_more_checks(struct kern_ipc_perm *ipcp,
-				struct ipc_params *params)
+static int shm_more_checks(struct kern_ipc_perm *ipcp, struct ipc_params *params)
 {
 	struct shmid_kernel *shp;
 
