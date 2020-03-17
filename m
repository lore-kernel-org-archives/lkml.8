Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6FFC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB0820674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btpoRs8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCQHUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:20:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40968 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:20:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id s11so19513433qks.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouHG8X5VLgVrqETt8TrgCftKEZvZjS1NbNMqN8mQtnY=;
        b=btpoRs8U6qL2P1IbzZOIXJj4J4/UqbRPd2JReBhHMrI3P2fbdO14I4+UK9IOEFqhWu
         pK21R6P5qwnKt1auTWSOvbI500W/EondJvKmdWBRauObtZdn4H34pHw9F8Ns2neOmptu
         ZshJehZx2StP439V7K5+F1Ryn6elK4SjSP91obaCGRLY+GEAb9BXKr9K9z+b1iJzKWDq
         hrrqjb77pRJzoqWgoWVdbn9T/4iaAT+6NLPgzsCiqemOeSJSojcWoTV8ahJ9zP6mOPmk
         bEpFyU7Hh6qLqMGTPT7rUrxce07ltuUUGB78Yf8vE35YSZ/YOiK5D6SFTF+KP9lddQ2M
         FI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ouHG8X5VLgVrqETt8TrgCftKEZvZjS1NbNMqN8mQtnY=;
        b=SBeuO8x0gnRg3MtzeeWmmNPUdexvat7/AWGpV6ZYnCVO/HqtlzPGoy3FVlEbkGQk1j
         Me1GXWHJg+D8dWA50t59nw6HMI7AiP38u2cD04PhoqzjMWLPcUqRb9pBJSGH2ZamoTuo
         5L+maQycwZsz+ywUz30OUxHV1mIHN2vL8dHmn9ZObE8Ws7jGnc8ioNe7UuH9CZqEBUsm
         /fijd/421i9N+dZ4y4nSG6ItAKkdE4236bGAliypPKjPmte/DJjPEBCJIN8wEMygiQgT
         IskXsnnYaW3GCQDQLRYxdUteznb6y7fNgtoY/36eGmdEkVvHjDRUY0uB6QczTqhuhs7t
         /mTQ==
X-Gm-Message-State: ANhLgQ2PWbr28rofsrHuv1xasoJkk+AnPlinLWk4QiUVndnTtH1K0pzS
        0emJkX5TI3LnmP/Z2WDRLvlnlE8O
X-Google-Smtp-Source: ADFU+vt3jedIxsMvR8GCPR/VxvaoO/EG4X0qZ19HXpsOw3CPwCPQb94DZn1alKp+6+tHN0OTsFzXxg==
X-Received: by 2002:a05:620a:22f7:: with SMTP id p23mr3430110qki.4.1584429611908;
        Tue, 17 Mar 2020 00:20:11 -0700 (PDT)
Received: from localhost.localdomain (179.186.61.135.dynamic.adsl.gvt.net.br. [179.186.61.135])
        by smtp.gmail.com with ESMTPSA id n74sm1374378qke.125.2020.03.17.00.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 00:20:11 -0700 (PDT)
From:   Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8192u: Replaces symbolic permissions with octal permissions
Date:   Tue, 17 Mar 2020 07:19:59 +0000
Message-Id: <20200317071959.556-1-c.cantanheide@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves following checkpatch.pl issue:
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider
using octal permissions '0444'.

Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 89dd1fb0b..9e222172b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -613,13 +613,13 @@ static void rtl8192_proc_init_one(struct net_device *dev)
 	if (!dir)
 		return;
 
-	proc_create_single("stats-rx", S_IFREG | S_IRUGO, dir,
+	proc_create_single("stats-rx", S_IFREG | 0444, dir,
 			   proc_get_stats_rx);
-	proc_create_single("stats-tx", S_IFREG | S_IRUGO, dir,
+	proc_create_single("stats-tx", S_IFREG | 0444, dir,
 			   proc_get_stats_tx);
-	proc_create_single("stats-ap", S_IFREG | S_IRUGO, dir,
+	proc_create_single("stats-ap", S_IFREG | 0444, dir,
 			   proc_get_stats_ap);
-	proc_create_single("registers", S_IFREG | S_IRUGO, dir,
+	proc_create_single("registers", S_IFREG | 0444, dir,
 			   proc_get_registers);
 }
 
-- 
2.20.1

