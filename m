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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A685DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A212078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQU4vn0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgHQILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgHQIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E5C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so7850173pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0lVeVyUi928a7/fzs7+FY0tXKdsKnkp78ZmUm5IzGsw=;
        b=hQU4vn0G9qzRlCq6N+seXKFofQkuPKmULu4dD8/Hg7tm7u1tpybameqU+4C8/8NYLx
         hTCGmVlt+mhyfLFNFkwDYCFAKTNUWqG6fpFauhqiSwY93BJiDTh9xBJZO5t4OefFqIq4
         to5E49yEXe+Gah/XLnEkfF2zg65G51qXM2REKPgJvRNaACb1/WqAM18QK8RcvJqRzBqE
         NNTvDPryPR9KRt9ocGHgk+qQq+DR3FD4bVP4e2mvo0gGGufCOEV7HgBZTPRBYQKGODUR
         obOoFk/pQpJ4cd2zjNT/NdUJA1bMPXhdGkFOjbEhoVpprDMmKcRlyLCmipfdMlD28lex
         Af9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0lVeVyUi928a7/fzs7+FY0tXKdsKnkp78ZmUm5IzGsw=;
        b=E4/DsdUNC52CmUW5daI8IztG4btKBKmwdlDN8z0bx3nQHPV8nQvdhkH0bhf9aY7pOR
         1FJ80jFrWvsEtxHTkBOBUFBMH1IddAWQp2F3s2/seTSL6ucUz43ecPrYpJDat6eygUXz
         a7tlljBGaXoEJ8+08ZhBJjARI1bBXC4WimGTJ7pWKo7/Ct47ekoAObkv0bPIIT0O1AzJ
         hhKWQ7/5Ks9V0ZtT7j5zNUJDCV57H6i+lo9ii4ry4bZIX8xZMZmnwfvFES7BDPPmAO0E
         fyse1Y9QNbF6uV4aciGyy/8+4K8iyszdcVH9ZfB5LO/YdSFM5V2ahiYW6HvpIEzv5qoT
         BlVw==
X-Gm-Message-State: AOAM531azJEYok1kAR80ARK6PXk/aReBhZhEZAsnYJ9R0v1NGn//U6SM
        WQxeacJu0g1Z8n/KxbRKXhA=
X-Google-Smtp-Source: ABdhPJw356CtYnI45KdkYTDa3IIDMQEWrcBTSATYq3hf/G3Zjs0kV6xnzKLETPtBU1XVb0/XiQEYqA==
X-Received: by 2002:a62:8cd3:: with SMTP id m202mr10164425pfd.184.1597651850205;
        Mon, 17 Aug 2020 01:10:50 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:49 -0700 (PDT)
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
Subject: [PATCH 10/19] crypto: ixp4xx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:32 +0530
Message-Id: <20200817080941.19227-11-allen.lkml@gmail.com>
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
 drivers/crypto/ixp4xx_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index f478bb0a566a..31a584940022 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -414,7 +414,7 @@ static void irqhandler(void *_unused)
 	tasklet_schedule(&crypto_done_tasklet);
 }
 
-static void crypto_done_action(unsigned long arg)
+static void crypto_done_action(struct tasklet_struct *unused)
 {
 	int i;
 
@@ -497,7 +497,7 @@ static int init_ixp_crypto(struct device *dev)
 		goto err;
 	}
 	qmgr_set_irq(RECV_QID, QUEUE_IRQ_SRC_NOT_EMPTY, irqhandler, NULL);
-	tasklet_init(&crypto_done_tasklet, crypto_done_action, 0);
+	tasklet_setup(&crypto_done_tasklet, crypto_done_action);
 
 	qmgr_enable_irq(RECV_QID);
 	return 0;
-- 
2.17.1

