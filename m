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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B020820758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpOyiF8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHQIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgHQIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:32:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB2C061388;
        Mon, 17 Aug 2020 01:32:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so7353755pjb.2;
        Mon, 17 Aug 2020 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xlkl/Kq20mWjBqJTahwsbMlG2dOEwdXmK5fJnd50gLo=;
        b=TpOyiF8TvePjfIaV2pPgdU00ho11Lxcuva4WlR3WztWdTLMM4V6K6Nz2t9o+th+orG
         yYcschRIWGDYRIPnwuycLeXIqFfanckm6A5NtGqgm+UGmxcb2LZFoINvYz1KUvuVG3s1
         yKq2uHpNUHhben2hyR2x6xKvdFn2YCo437iS//033Y+3u/Itgwv36HbwGcmqyIKTJb8P
         i8e5tT+mSDiGOLjldRWCLFf6jLajq7nd5GCCJAeHJe0rWO3UJHh8grTjsJ9F48oaeYRO
         jQ8gSglyJhj4kOSFTYLKok9Qs+9pbO13Vvfhu/1f8remVThIhETPUBvYUYadmu15TCAe
         Chhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xlkl/Kq20mWjBqJTahwsbMlG2dOEwdXmK5fJnd50gLo=;
        b=uI+vFjeHR/wHZHwh6qY8pM7v84AUw5eoQQbx4nB43pCfwNWR2pZU8hE3SDzhnQJRID
         /3xM35tk3EZ+tW+zAHXthLXm+qqcKsurDrAGErseYuFMPc+CShFhjj7N1iDlPYSFT5gh
         eR501lo96ou73Hv0ZVLK2WfKY4OLUzAaMFmJ5d0F6kciXO1E4UeEZb3ID/7vMqN1hfzm
         JX15eZoD36Dkj9NIIywqwnqZmxqTeRYgbaKEAzV+/I9czT51Nl9Bj9ubr/nyx3DmaeiR
         UeBMZz1dVM04wUe4NKo4ieX39Kocuzxg+LBVbToOq8/gEEkmVToBD3q3igMyQ0eCyrMe
         a6aQ==
X-Gm-Message-State: AOAM532HI05vRMb/NRI6/TZM+RjHzdhjVPYXwOs6XanXhY9BB9ilXxXl
        zLpSNcptc8pb0LHa6xWU3vokqRn28dt79g==
X-Google-Smtp-Source: ABdhPJyR59sYahFbk9ZfPfA3CZb6ggVyJy1/S2SaP59Z5blhEvuaKWVpCFeQsNG2OLVLUGvxzzji5g==
X-Received: by 2002:a17:90b:124e:: with SMTP id gx14mr12038651pjb.225.1597653130105;
        Mon, 17 Aug 2020 01:32:10 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id b15sm18448351pft.116.2020.08.17.01.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:32:09 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     mchehab@kernel.org, maintainers@bluecherrydvr.com,
        patrice.chotard@st.com
Cc:     keescook@chromium.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 01/11] media: bt8xx: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:01:43 +0530
Message-Id: <20200817083153.22218-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817083153.22218-1-allen.lkml@gmail.com>
References: <20200817083153.22218-1-allen.lkml@gmail.com>
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
 drivers/media/pci/bt8xx/dvb-bt8xx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
index 02ebd43e672e..4cb890b949c3 100644
--- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
@@ -39,9 +39,10 @@ DVB_DEFINE_MOD_OPT_ADAPTER_NR(adapter_nr);
 
 #define IF_FREQUENCYx6 217    /* 6 * 36.16666666667MHz */
 
-static void dvb_bt8xx_task(unsigned long data)
+static void dvb_bt8xx_task(struct tasklet_struct *t)
 {
-	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *)data;
+	struct bt878 *bt = from_tasklet(bt, t, tasklet);
+	struct dvb_bt8xx_card *card = dev_get_drvdata(&bt->adapter->dev);
 
 	dprintk("%d\n", card->bt->finished_block);
 
@@ -777,7 +778,7 @@ static int dvb_bt8xx_load_card(struct dvb_bt8xx_card *card, u32 type)
 		goto err_disconnect_frontend;
 	}
 
-	tasklet_init(&card->bt->tasklet, dvb_bt8xx_task, (unsigned long) card);
+	tasklet_setup(&card->bt->tasklet, dvb_bt8xx_task);
 
 	frontend_init(card, type);
 
-- 
2.17.1

