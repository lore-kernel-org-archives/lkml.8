Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA56BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9279420716
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBxbgy52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHPOwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHPOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:51:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F699C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:51:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id v22so10593483qtq.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=yo6OlECerivcrTTZJKS7ZSTtM/ay7Ma0TpI5jbubrg4=;
        b=UBxbgy52dsv0SOtPDSpRsT6sDw1VmOsVKxYOBCcmypxBL6Bv8kkMtDN/TVVMJeq+GS
         I6ctyozneEz7JOEvs0b9ACgNJt+JJFu4K4P8bGXqj7PzIybWaFT2b3vXDMkLeBKSUsnQ
         YL5S6DUc7SedwwSfg2909/+wbVEeluSXCvCmjkOxnA5KdYMet//f49T1n6UIcjsUZUAN
         32Jh5UM2hVQZkDxISGC9+Xm3T86X1fgGsuEl87RuhGJ7A+0xQHHrAlW+stef8BHhpu/B
         pS7WKdubWnUIJmPMOrflM2ivQhkt2PXYnCqQ8xZNbhTQuyQizOkXp1uyRHIjbXqx37WZ
         7OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=yo6OlECerivcrTTZJKS7ZSTtM/ay7Ma0TpI5jbubrg4=;
        b=hFRdOhJ8Zcv4hulqcMzzOBIsjhfpr8WT5K+HZjhEmU0K5JLaoLTGA/SOY4L6IZ+Wfs
         1Kmqh2O8AUOzcJcLS2eQPgYO6qBZu5hNiAgAxE6hEj5gY1BfuEpqbMNnfaDLpzFaWpoq
         v1xVKugDFj46LyauQg+8zgvZ/sjNKaepJyGlhshltckrfKNqr/oNLcwQWmnGV7DXpuYZ
         GLL7YQit/jnRDQsJBHOHylnRiMjCyqgbEtQWFSIVZ7fKo3OeKEKssGeoatzhNDM0bA0y
         WHyNE/VxSkL87lPsfqeHiwB626kK9PBtX2CW8qjhPdVWCQu47FjxekuuFI8RbYFDHyOH
         Hu+g==
X-Gm-Message-State: AOAM530Ng4tur9H6meCMtCvk1J64byW7FNRlLCXKbnBpq3fih6U60S1D
        atfTe4IuIfyTzSQWmsD5Lw/W9VrIYt8=
X-Google-Smtp-Source: ABdhPJy68mPDErnd2G9+c742obwbIJnC8gV8NgGp6qaB7zCtOoJZCtyBFFjTUjOZqHwKGSjAtNcV4w==
X-Received: by 2002:ac8:1948:: with SMTP id g8mr9978248qtk.354.1597589509829;
        Sun, 16 Aug 2020 07:51:49 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:55b1:56da:5396:836c])
        by smtp.googlemail.com with ESMTPSA id w12sm13808442qkj.116.2020.08.16.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 07:51:49 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS),
        nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drivers/nouveau_svm: fix bounds check in nouveau_svm_fault_buffer_dtor
Date:   Sun, 16 Aug 2020 10:51:41 -0400
Message-Id: <20200816145142.25062-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do the bounds check before accessing the buffer element.

Fixes: eeaf06ac1a558 ("drm/nouveau/svm: initial support for shared virtual memory")
Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 6586d9d39874..35d24946787d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -897,7 +897,7 @@ nouveau_svm_fault_buffer_dtor(struct nouveau_svm *svm, int id)
 	int i;
 
 	if (buffer->fault) {
-		for (i = 0; buffer->fault[i] && i < buffer->entries; i++)
+		for (i = 0; i < buffer->entries && buffer->fault[i]; i++)
 			kfree(buffer->fault[i]);
 		kvfree(buffer->fault);
 	}
-- 
2.17.1

