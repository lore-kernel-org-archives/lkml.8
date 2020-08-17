Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA8C2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2MQSO33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHQILo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgHQIL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D00C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so7322959pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2jlucAzcv0W9eM59+GUn2Gh+5IEHgp5g50ux6o6FWwQ=;
        b=t2MQSO33f1vjbVEQeuo3aU++uKHVnUyyrTtB3geB2I08q7ydG1kWWexSrXGDcLWNdv
         1DlHUBJ+biSN3baHJHgEWZwCeTElOGpgVYrWDI0Kt/zPqL3vkhdg3i/ZiLZdHXIFaczn
         +F2ygDuPckoakT4oIKq67rcj8g59qwcFwR24DHvn38NgRh0fQjl8TUE4mmLnwGxszJh2
         Np0X12q/PXnv5FYcMAJTQujiLVQdM6TsVxViUJGMM2vO8opwWf6WON7JoHHS6DMOZhKN
         JZvHL/ffslNv006PR5pAvZ6RuLuD1L5kS+I8cwnPyQlpfEWmuAQU/MTin6aK8Hy4YNza
         nfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2jlucAzcv0W9eM59+GUn2Gh+5IEHgp5g50ux6o6FWwQ=;
        b=cV0EojC94xyti99al8ltEBdj+Kf87sM34uSENtUDq9rEdd367Et4qsd+NOH6atZqAM
         VS24FU3dlPK7Wi4389Iin19PF1JqegI2wZ4nJvTq4lCSku7rOl3vfboiBAseUglHPhC6
         Tk1jXdm9J5QLTIOfKHGbdfCEElULOpRc88AgzxfcP4Y8+1nbvZ7oejmqG9zqGeN7e7Xa
         26teQQVHOjTwH6tiGs8ZSIuYQlM5U9/gy+RKcXMjMJin4qHGdA/zDy6z7qfWmLpHepI1
         c/gsypwkVKOA7DHABQmLodvceWTi1k7I4YkHaCUna9KarM483CAQv92shaeKd+Z9ekxm
         Xrzg==
X-Gm-Message-State: AOAM531VWla5ATLKA68v6j3I/qahx4ZejfJkXXLZOi461E2LRghz8i3/
        DoQqhv/OSy/cSWYQLIF/wNs=
X-Google-Smtp-Source: ABdhPJyjoI0JkeOWbU0bb5kX5eCoqltfYh3yZoAKu+OpTQJh7RAmgYhlWJE4RsqnMrAcaumgImJMNg==
X-Received: by 2002:a17:90a:5b:: with SMTP id 27mr10822949pjb.188.1597651886671;
        Mon, 17 Aug 2020 01:11:26 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:11:26 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 19/19] crypto: octeontx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:41 +0530
Message-Id: <20200817080941.19227-20-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817080941.19227-1-allen.lkml@gmail.com>
References: <20200817080941.19227-1-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index 228fe8e47e0e..515049cca9e3 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -17,11 +17,12 @@
 #define DRV_NAME	"octeontx-cptvf"
 #define DRV_VERSION	"1.0"
 
-static void vq_work_handler(unsigned long data)
+static void vq_work_handler(struct tasklet_struct *t)
 {
-	struct otx_cptvf_wqe_info *cwqe_info =
-					(struct otx_cptvf_wqe_info *) data;
-
+	struct otx_cptvf_wqe *cwqe = from_tasklet(cwqe, t, twork);
+	struct otx_cptvf_wqe_info *cwqe_info = container_of(cwqe,
+							typeof(*cwqe_info),
+							vq_wqe[0]);
 	otx_cpt_post_process(&cwqe_info->vq_wqe[0]);
 }
 
@@ -41,8 +42,7 @@ static int init_worker_threads(struct otx_cptvf *cptvf)
 	}
 
 	for (i = 0; i < cptvf->num_queues; i++) {
-		tasklet_init(&cwqe_info->vq_wqe[i].twork, vq_work_handler,
-			     (u64)cwqe_info);
+		tasklet_setup(&cwqe_info->vq_wqe[i].twork, vq_work_handler);
 		cwqe_info->vq_wqe[i].cptvf = cptvf;
 	}
 	cptvf->wqe_info = cwqe_info;
-- 
2.17.1

