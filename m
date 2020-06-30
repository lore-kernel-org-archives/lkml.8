Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D97AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345A1206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjQ5sEe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbgF3Nwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbgF3Nvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6784C08C5DE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so20281313wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8/OUfoNrwMRghF2Xm56r8amPV/zzR8eJyRX/3dxUYA=;
        b=BjQ5sEe1VUAWTyNZ9XCItu/X9mKXJ4kknIGy/dde60ssxdqPtrClkggPQn61sQFEbG
         ZUl/ATV6/LFDcAgqoPPcLSkAboYweOHujXM1A5aKjPVBj7Ey/vvrUbmwspN3CgjiX4XL
         uwtDzStDFzZSD08soxa7wHv3g/K/Irn5cBopE8MRlfY2fifczF1z9Qaa+QJUV30gBkrs
         o7NiVh+ah6uS2kdMqKwC+173SkiLajl5xtvRPO0lk/yDTw2bdI3hoMMgdKuMxQSiNNof
         KyQCmMWv9CY76fq7cqJIEhGstnyIIWy2OTk8+E5hvmDKKg7UnIWox7KMDxkAJ6RZLCRy
         4+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8/OUfoNrwMRghF2Xm56r8amPV/zzR8eJyRX/3dxUYA=;
        b=Fl4V1r79cuDAGR+FEPI2r/HWxu9SI/TzhGqNJaBvJ83/gm1GI0pc453dOyaB4aLoi9
         s+il/7FDIA1ga4SjYxm04cV6cSO0vsIWpZl50DX1xgFZZOS6bNmd6ezFZWUdPxRXqGek
         LvVQRyAzx5uckiUg/BeQdNQu2T8vDTd5j2VafxH065eqtyY79/eZ7llqU/W/ZLmwDJJq
         PuZ13iRduX1V38+O78EXN1ms0w3UQAPIO6XkcRaaQK5B9S8J14u1IhDdpmaQ3JVKbvSr
         xnFz4mpdHvg1HESxru7153gJe3sDd6bCyeD4YqxQUjJA0wArjtMgzks+yzKL5vwYiUcx
         Mefg==
X-Gm-Message-State: AOAM532B6CHDN/WgBgTFngW3EE24/BnnNlWrL+s7/Ro2VIta2AwjVVk4
        WNLUxiWDUNhAp7tOhkcL6jNuxQ==
X-Google-Smtp-Source: ABdhPJyIQqjsDwJKis+cJUwdYmBjCkdXP25GxIOWJOEk9ecH3aDPL+QaOTZCX36CbfPBbD5MpTV9yw==
X-Received: by 2002:adf:e948:: with SMTP id m8mr22555359wrn.398.1593525093406;
        Tue, 30 Jun 2020 06:51:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 18/30] misc: mic: scif: scif_api: Remove set but unused variable 'read_size'
Date:   Tue, 30 Jun 2020 14:50:58 +0100
Message-Id: <20200630135110.2236389-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'read_size' appears to have been assigned, but never used since the
SCIF messaging and node enumeration APIs were introduced in 2015.
Makes sense to simply remove it.

Fixes the following W=1 warning:

 drivers/misc/mic/scif/scif_api.c: In function ‘_scif_recv’:
 drivers/misc/mic/scif/scif_api.c:1000:6: warning: variable ‘read_size’ set but not used [-Wunused-but-set-variable]
 1000 | int read_size;
 | ^~~~~~~~~

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/scif/scif_api.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/scif_api.c
index 781217c030a63..d7faffdd87e92 100644
--- a/drivers/misc/mic/scif/scif_api.c
+++ b/drivers/misc/mic/scif/scif_api.c
@@ -997,7 +997,6 @@ static int _scif_send(scif_epd_t epd, void *msg, int len, int flags)
 
 static int _scif_recv(scif_epd_t epd, void *msg, int len, int flags)
 {
-	int read_size;
 	struct scif_endpt *ep = (struct scif_endpt *)epd;
 	struct scifmsg notif_msg;
 	int curr_recv_len = 0, remaining_len = len, read_count;
@@ -1017,8 +1016,7 @@ static int _scif_recv(scif_epd_t epd, void *msg, int len, int flags)
 			 * important for the Non Blocking case.
 			 */
 			curr_recv_len = min(remaining_len, read_count);
-			read_size = scif_rb_get_next(&qp->inbound_q,
-						     msg, curr_recv_len);
+			scif_rb_get_next(&qp->inbound_q, msg, curr_recv_len);
 			if (ep->state == SCIFEP_CONNECTED) {
 				/*
 				 * Update the read pointer only if the endpoint
-- 
2.25.1

