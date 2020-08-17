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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F056C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C60F2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsW5qw9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgHQILf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgHQILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:11:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E257FC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so7429959pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=70PFaXHmNSmd92XMUWhul5KjsiDucw6zRMXg1MiBgH8=;
        b=YsW5qw9NRQ980DmqR7I0AKAyBlH2mw3IDWiuDPiK5PcL9EeuX5xAwemDz4lY2v1H+P
         PHLtHkMDF/AgpV8+UThxQF2gm9LvzcooZzOrhwy7m7/cXDLWa7fAjMjJIT0aQTY1AsfO
         xzUZT6gI+uPaKAnyKPfueeZ6eMWqTqWJHtDTQOsluZCITK1RTA2F2ZvZ7wau4Ju0YVLS
         XBrkbMK4FSESTy616HPAaK1DxUqvvy/pNIMOqvuFftH9+V1h+EhuNNSdDVhY2vaG1Wxj
         Oikq55hNMBi3727bfh95NcVp5rIWsyWQ+wC8LWRXWIX9cPD/IESHUPUjsUGrC3isgP14
         clhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=70PFaXHmNSmd92XMUWhul5KjsiDucw6zRMXg1MiBgH8=;
        b=A1T0MJYUKnfMPblBqJkSg3TBRIqCsniP1aV/srXrOOIM2V0GduFdQ/zyKpEWyKRrf+
         IXCacdiZhJ0CEsfVSGyUOjtzT2saZz1LhV8/AtVn7IeSwKtsPRGk/mjtxAq0o6sZezym
         Jxrxb9CXF/XDhaU9Rm6AegBWd1xs8FgskH+JZ4dd4vw+VVvKfdCtOsdr8rtGSr0nSWhj
         XvR/RDNFgMG2A/ddxksLRSdWiu+IP4orC/ykcCBk2dwPcDDosdSgD2ON1zsCKZ2pDKBO
         MEpMHr88/DHDjBmnSjRnaASqqf67Jt1Wc2cfydSSTYXwjWiCD/XP2Kly0bm5Abf0jmM1
         Y1ow==
X-Gm-Message-State: AOAM532vczMcX+Jy/uRFDfKX81gRZUEsTClSscaxH1SyoeC2hi8nDzy/
        mV357ry0oCehBm+2ilYwKFA=
X-Google-Smtp-Source: ABdhPJxkJc7DyhK1mDYdyU2581enLqosMCxTakWV3V2k6PuHjYp2kxVpf+h+fHSOmD19Aql6dm5KyA==
X-Received: by 2002:a17:90a:24e6:: with SMTP id i93mr11415482pje.231.1597651871493;
        Mon, 17 Aug 2020 01:11:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:11:11 -0700 (PDT)
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
Subject: [PATCH 15/19] crypto: qce: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:37 +0530
Message-Id: <20200817080941.19227-16-allen.lkml@gmail.com>
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
 drivers/crypto/qce/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index cb6d61eb7302..0b171ef9e3b7 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -116,9 +116,9 @@ static int qce_handle_queue(struct qce_device *qce,
 	return ret;
 }
 
-static void qce_tasklet_req_done(unsigned long data)
+static void qce_tasklet_req_done(struct tasklet_struct *t)
 {
-	struct qce_device *qce = (struct qce_device *)data;
+	struct qce_device *qce = from_tasklet(qce, t, done_tasklet);
 	struct crypto_async_request *req;
 	unsigned long flags;
 
@@ -221,8 +221,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 		goto err_clks;
 
 	spin_lock_init(&qce->lock);
-	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
-		     (unsigned long)qce);
+	tasklet_setup(&qce->done_tasklet, qce_tasklet_req_done);
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
 	qce->async_req_enqueue = qce_async_request_enqueue;
-- 
2.17.1

