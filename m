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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB97EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856F42078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRgt5XvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHQILU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHQILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A95C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so7441574pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QaP8DINxDsuq2i3hJ8sJPBp0gJbGxyzKBcVj40ZfIHk=;
        b=bRgt5XvQ3AUktQa2vCokcQj+MeQZPYkIk6vnFPw6IBG+xcRxtqne9ZNSgBv9LDra+p
         7NfbPuWxZCqrbXVZeEcef6x/YdwYhClCbJeJtvk7Suw0KyDoZNAqJv3Fs5x3Ug4kk9oQ
         eisa0G+cHHV5rnB6t55SztjvZq57qsh5wgujX77NsrE2ylqkiBB3qtQhttoqg/ubjuTR
         uTtCl9eBBFQiN74Tv9V2IQPD9Zv+OeHMNonaPYbfTKsVwkjDfpU+6iU/tZjETQGvOVIh
         SzewaHsipx7KzhS7KVefaNhX5A94UAkH2ObH+6CkFOyc3U/eDyULBxyYU40ZmHhEgwAe
         1owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QaP8DINxDsuq2i3hJ8sJPBp0gJbGxyzKBcVj40ZfIHk=;
        b=DXANzwOfcbsVYqUieaSHENKiBPoPlMd8Nq4LGPcuszZRT4E/7JippLsQrJ1ZItx6Fc
         6zr1gcyDa4Zq81yYahTduBTnNAQufdOLb75FSzJ+VH1hWglSKaEBVzTQ4/k+7BPEsirI
         BJfqBdu6XE5tDFpUvxk4eHVLY4d3AqXQYRAbzstJpMh8dtYfkbJ1t1Gh/CtuYSGR3C5l
         YjWMackMEDL+JVQYCnVabZuJ9oE3Vd2Rla4mQOUWUOSr4xcQ9iso5vTlb1fwpeHgHD9f
         K29GYFqklzaAUYYlV3z0YbH1n+GzHsLWGYV2cZq87clIrxEc01gYfcMuFqDYJ8hBnywj
         B0Dg==
X-Gm-Message-State: AOAM532Y9pWDAw4LyuV2/S5dZnP0AkCtBW8ZX+jMMv6k+IGNrtCKG2eK
        T7zl7qmmWJEJfUKJCjU7v8g=
X-Google-Smtp-Source: ABdhPJwWx9U4dwEOuvx8zZZhWSxZrW/QTfZvVwvzjU7vTTOa870r6Mdybq2AgvVeVI1eNan7GZHkLw==
X-Received: by 2002:a17:90a:ec0c:: with SMTP id l12mr11456530pjy.90.1597651863782;
        Mon, 17 Aug 2020 01:11:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:11:03 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, heiko@sntech.de,
        matthias.bgg@gmail.com
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        inux-mediatek@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 13/19] crypto: picoxcell: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:35 +0530
Message-Id: <20200817080941.19227-14-allen.lkml@gmail.com>
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

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/crypto/picoxcell_crypto.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index dac6eb37fff9..a394d51f8d44 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1136,9 +1136,9 @@ static int spacc_req_submit(struct spacc_req *req)
 		return spacc_ablk_submit(req);
 }
 
-static void spacc_spacc_complete(unsigned long data)
+static void spacc_spacc_complete(struct tasklet_struct *t)
 {
-	struct spacc_engine *engine = (struct spacc_engine *)data;
+	struct spacc_engine *engine = from_tasklet(engine, t, complete);
 	struct spacc_req *req, *tmp;
 	unsigned long flags;
 	LIST_HEAD(completed);
@@ -1648,8 +1648,7 @@ static int spacc_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	tasklet_init(&engine->complete, spacc_spacc_complete,
-		     (unsigned long)engine);
+	tasklet_setup(&engine->complete, spacc_spacc_complete);
 
 	ret = devm_add_action(&pdev->dev, spacc_tasklet_kill,
 			      &engine->complete);
-- 
2.17.1

