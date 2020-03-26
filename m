Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DC0C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED34F20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmDvDqxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZIpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:45:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35342 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:45:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so6699336wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 01:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtuFDgZ0vqDMcROewVgWRuk00REi/YD6SlgN8SN6u8c=;
        b=pmDvDqxzRcqHOg7IGXHP1JfirFjHaIj0rpzNdTljlxhF9QctKmdMnC8bFfETZA7Qpa
         An2IhPebf0b6I6ChrGrJxBGni3Wbf6geiB5Pp7jcpkE1pCzvrr1ISmI8oOYp38otlqsd
         TrRp2xdJhgGGIzbttrqrBCpGHNYQgmxZHj4f3qk5Y/xUQuTTtJtqgeK4X+2Wr2uI1s53
         eKUutdBd5cyx/JXQ3YJxkAqPqTTBq9frxjuiRyEDngtTO2iOHbWLjpI7+wIJj23IwuVw
         VnLWFiSJITXH4FW4DaMqgBRRyQRGUZ/Y9vs59pMWoUPFLFioU+xo5LxAnGR6GW+QuJhc
         zCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FtuFDgZ0vqDMcROewVgWRuk00REi/YD6SlgN8SN6u8c=;
        b=JfmHgHaJpBHsCx9/aX3C3Golh0hP6F1rGB2A9NlsJkfIWnxKZ6Odd+hfcsOt1YFG4/
         moK9DklI9ebuityzrfbp1jWWdU2rHQkxfKKbzZlDWy6+6UrBJwpvffzHuD7rUegQ55ok
         /i7i1heUNyxhBiZixHAnlGok2DUOGzSYaSxeHBFhPtSokNzAdLv0540UmAlRKQ7nUi3R
         6Lulxj5Wc0gZ+PXt8vKILBx9zx3OaPKFfS8UYokez/3RjmjbL8G6+nnng9TgAebwXPE4
         ZcmVlvsgr8JrneeoRBgoVtnJ1e0NjY8t7cASuU9RnNQGOlXVJxxLgdQtzDg8vCcmNMlu
         GFwA==
X-Gm-Message-State: ANhLgQ3KClrdmTw45gEpZnfsw8kijjOxyTe4nJSFGpGHs+VFlCACIqLt
        nzWVbV4nZiKqKGjrTeprFdU=
X-Google-Smtp-Source: ADFU+vuvM719ihlCXp1dFMBWr//VJetOFXISXzO7ZRXfA17cX8YOcabxYBQeF5ZvMY2a891dp47E+w==
X-Received: by 2002:a05:6000:11c2:: with SMTP id i2mr8580890wrx.210.1585212317665;
        Thu, 26 Mar 2020 01:45:17 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-140-180.002.204.pools.vodafone-ip.de. [2.204.140.180])
        by smtp.gmail.com with ESMTPSA id d13sm2595774wrv.34.2020.03.26.01.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:45:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: cleanup long line in odm.c
Date:   Thu, 26 Mar 2020 09:43:48 +0100
Message-Id: <20200326084348.15072-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup line over 80 characters by removing unnecessary test
'pDM_Odm->RSSI_Min <= 25'. The above test 'pDM_Odm->RSSI_Min > 25'
already guarantees that it is <= 25.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: Remove 'pDM_Odm->RSSI_Min <= 25' test.

 drivers/staging/rtl8188eu/hal/odm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index a6eb9798b6f8..698377ea60ee 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -590,7 +590,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 	if (pDM_Odm->bLinked) {
 		if (pDM_Odm->RSSI_Min > 25) {
 			CurCCK_CCAThres = 0xcd;
-		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
+		} else if (pDM_Odm->RSSI_Min > 10) {
 			CurCCK_CCAThres = 0x83;
 		} else {
 			if (FalseAlmCnt->Cnt_Cck_fail > 1000)
-- 
2.25.1

