Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD57C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9692073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwIJTQBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGXHP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGXHP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:15:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BCC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so4599092pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC0ci2DhDfgePNa/vZJrm+2m6aiXsL39LhLmpYhtep0=;
        b=jwIJTQBQ+HWUkP2NpurV5dxnMGxrWMVOaT7EUeAt/1xnOED8Jmb/ZzDb0XUzPO46T5
         jzUPEvUnRXcWPkMwTdkn87O8qj3EOxSMMXcUkbNm4jt2IZFXFX6RLfUeP9cEcBVfC8qk
         vmYaKlkAx/eSpk2lEoaxyMhpSO4s+8ZDUclVRuXu1t2v628ssIBLpmJz7W8tb7+7fNkf
         WUP3D+Jk9EgH/4lhD3MidlhXq5ntMOhBmiCDIeCHPZzKWpZIV7IyvDJMU/1tI0sz57B/
         5bRKoe+POyIY6/eXuf1MBG64VOsaVkCEgWv367G81AiJHzMFLPUPFsbvfaxcyDk0mYIZ
         yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EC0ci2DhDfgePNa/vZJrm+2m6aiXsL39LhLmpYhtep0=;
        b=IV0p38Q/uWaXuhe2tWA+BMQrtDxcQa4I6gjKfKuGC1J9B9PU7ziJUtpsqGw5NDEhki
         PW5XHAeQPb5AjFpndylJaEIcV2lLTzGuQUDoIstgh2JkCykESLtiD66WSBjH/2Y5macf
         eCM3Kf4YWEVp1R9ZyYyuMRhkB8Xa98jtV03F4szPVvF/mFagKUReGnLwYe9V5mMTK7yo
         E0Rsz77Upziu8UXKd22p4dFAOXfcBB9RJoidM9TCEDr+Wsq0x93yQ3VNoHygdBpjq5wT
         fUtzcdVGRLcXNnopb7haQ/PfZAZOzHMEJd2MKdSC99KomTkSYT47MgpdrKgIJnh5dBup
         Cw5w==
X-Gm-Message-State: AOAM532fdC/3i4EXJgNc1DHNIlsP19wQL8g2w95/HTIYdnb6aVtX4t+j
        kR2NZJnZD1rZOzmYsig1XQc=
X-Google-Smtp-Source: ABdhPJz0dHQZpci2WbryWFU8Gj6ifsOaIxPpXAbvIjMsjGra6WY6jsbV7VA7vjB3JlnoeQv5Yz+Emg==
X-Received: by 2002:a63:9201:: with SMTP id o1mr6678759pgd.99.1595574958107;
        Fri, 24 Jul 2020 00:15:58 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id e20sm5206216pfl.212.2020.07.24.00.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:15:56 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     linux-fsi@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joachim Fenkes <FENKES@de.ibm.com>,
        linux-kernel@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Joachim Fenkes <fenkes@de.ibm.com>
Subject: [PATCH 2/2] fsi/sbefifo: Fix reset timeout
Date:   Fri, 24 Jul 2020 16:45:18 +0930
Message-Id: <20200724071518.430515-3-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724071518.430515-1-joel@jms.id.au>
References: <20200724071518.430515-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joachim Fenkes <FENKES@de.ibm.com>

On BMCs with lower timer resolution than 1ms, msleep(1) will take
way longer than 1ms, so looping 10k times won't wait for 10s but
significantly longer.

Fix this by using jiffies like the rest of the code.

Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-sbefifo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 655b45c1f6ba..3ad9510ad4a4 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -325,6 +325,7 @@ static int sbefifo_up_write(struct sbefifo *sbefifo, __be32 word)
 static int sbefifo_request_reset(struct sbefifo *sbefifo)
 {
 	struct device *dev = &sbefifo->fsi_dev->dev;
+	unsigned long end_time;
 	u32 status, timeout;
 	int rc;
 
@@ -341,7 +342,8 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
 	}
 
 	/* Wait for it to complete */
-	for (timeout = 0; timeout < SBEFIFO_RESET_TIMEOUT; timeout++) {
+	end_time = jiffies + msecs_to_jiffies(SBEFIFO_RESET_TIMEOUT);
+	while (!time_after(jiffies, end_time)) {
 		rc = sbefifo_regr(sbefifo, SBEFIFO_UP | SBEFIFO_STS, &status);
 		if (rc) {
 			dev_err(dev, "Failed to read UP fifo status during reset"
@@ -355,7 +357,7 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
 			return 0;
 		}
 
-		msleep(1);
+		cond_resched();
 	}
 	dev_err(dev, "FIFO reset timed out\n");
 
-- 
2.27.0

