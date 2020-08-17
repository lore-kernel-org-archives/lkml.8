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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C31207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1+ADZbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgHQIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgHQIKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:10:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE3C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so7442525pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AQ09dDtr3c2l1Roq0ne6URApsMSGN10hnLKyehD45Gs=;
        b=i1+ADZbM04yKV29bxvf14C4AfjR1DxtKP0yjjVyTUAFFhoVNvTltQu7x90fBPPNBC8
         uC7Eap5SUopZYFMtjxSgAXpcwXoKDoI6iOXQxnHSbuUd7T00NrbK6z43UYIYYUzrQBd8
         RQXP2LTtLIsM8avul4X6clc9gCOU80SMJ1ZzBtf3ctBER5/3dvW/KyYkSmTvsLkf0eIM
         qK2sp8D8YO9mUlrPy0KyWjPeLcj6POj4CfDy4F+2s8tk99v66wi63aJJjypppa026j4w
         mK/MTitnJ+ElSoei45gm/OH9DsTX03onLMmjXq0Zo0GO1cqCHRlKCVyudm7kXvDdcXCI
         HkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AQ09dDtr3c2l1Roq0ne6URApsMSGN10hnLKyehD45Gs=;
        b=dguo2kGOeU9VduMpN8s705QiZiaNS/awXvpByxaGYFLIFbk7f1gkRK6hUDRo8E6Yn4
         ehf/efIYwuz587VMmbMwGcnPw/Q/qSm4abIhIqtOaiz6ywc8BdssYDHRqq5u9w6sSxqH
         UohSiG/hz+KoFNetFNUGDwV5tKispA4a/iCXN33GvImRmcinLptQc93yW+meVzs93vob
         snjK4sc+5W//ROh042oGQ3swhz/dr1yOM1wg9MEQ4A3mPf0Rm3Jc+4+2i5z2u6vfg6Hz
         GIiFn/6xdktLE7rj0JVSXv5gP2Y4TWzadsyuf4MlUltahkT6PCf5y5Yt1C28oCeSHA+n
         IH/A==
X-Gm-Message-State: AOAM5321lCW6Uwm+2n6jsoJbqOTH6TuT4WG+r1fjED68vCv6gY1/ZJtq
        4oIdI3B2pKYgw412a4fsAA4=
X-Google-Smtp-Source: ABdhPJyaWmoUPigt5EzkuJiRyagPX4x/btPrL124BPaPGgcH3dgesfRQ26eVBtXL4hKJJ/AzDOuPrQ==
X-Received: by 2002:a17:902:c286:: with SMTP id i6mr9940453pld.219.1597651820779;
        Mon, 17 Aug 2020 01:10:20 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id 77sm18499751pfx.85.2020.08.17.01.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:10:20 -0700 (PDT)
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
Subject: [PATCH 04/19] crypto: caam: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 13:39:26 +0530
Message-Id: <20200817080941.19227-5-allen.lkml@gmail.com>
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
 drivers/crypto/caam/jr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index bf6b03b17251..4dc923736ba8 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -201,11 +201,10 @@ static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 }
 
 /* Deferred service handler, run as interrupt-fired tasklet */
-static void caam_jr_dequeue(unsigned long devarg)
+static void caam_jr_dequeue(struct tasklet_struct *t)
 {
 	int hw_idx, sw_idx, i, head, tail;
-	struct device *dev = (struct device *)devarg;
-	struct caam_drv_private_jr *jrp = dev_get_drvdata(dev);
+	struct caam_drv_private_jr *jrp = from_tasklet(jrp, t, irqtask);
 	void (*usercall)(struct device *dev, u32 *desc, u32 status, void *arg);
 	u32 *userdesc, userstatus;
 	void *userarg;
@@ -483,7 +482,7 @@ static int caam_jr_init(struct device *dev)
 		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
 		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
 
-	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
+	tasklet_setup(&jrp->irqtask, caam_jr_dequeue);
 
 	/* Connect job ring interrupt handler. */
 	error = devm_request_irq(dev, jrp->irq, caam_jr_interrupt, IRQF_SHARED,
-- 
2.17.1

