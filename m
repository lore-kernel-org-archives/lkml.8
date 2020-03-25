Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01903C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C794E20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTcpa9AH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCYWBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:01:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:01:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so5431335wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K21ukMg2rSrNdWu0B2OE9Pp6GqyZFADsw1I/2vin0js=;
        b=LTcpa9AH2U87sh+x8mjTD9zy5yhGvEAkoGFgATTjGhqIBrLRQApxp4ieCmAG+RQyt7
         DTSOaztlg4f30UsNAF+G0M4lE/RpfdqeZGlgsFVH7l2gHeKTw95Z6g3alnbEAhMhwysl
         50D03Z7uE/On28h3CNk1ezIr3QWJURibdBcx/BhFNwOU1lwbU71dehjuZU0NOgJmFtmX
         UE40E3PtwKsAEj0j0PtSkLz0Scs4ZUki4SuWmeltmD31S9OlKaB6rdvwUbAj4MR4ydUB
         UgHJ+SDIjSc9k+5bjmHBvXVbYqx+IAqF7Zi0EW1irVFJsC3ip6KZJ6jazcKD/BAII5Mh
         uC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K21ukMg2rSrNdWu0B2OE9Pp6GqyZFADsw1I/2vin0js=;
        b=fHCSiXs0YY7Fe0pkWh1FM52afY55OhbDUZ6yijosmgo1v/MkEAOXlOPRVRnxGOcM9m
         mVIFA7daHeFiDeGT8Wcgse0JHDKjKSzU/9uRVaQyZkyKxwsI5N01bps/JYkjYBmTePKR
         f1DbcgKjhID9di+tp2oCkkVoqXklXe50qWMiTiEBex/3pkt08F3Blg9rkT5xfp4/vlBU
         gyjj+wH851tsYsWb/cCHTWJ08wNCBOOVxxZsdcQGRGP6z6hRKJ8vaurs6k9iLghJ6OdL
         fPF1SyeUZCxAp1DAm5efH82C6UgnHZRjKTzYlDpoAySRNpGYMbv3cL7ojoSLlJndJqoj
         iXdQ==
X-Gm-Message-State: ANhLgQ2b3ZMWhWP1FvOnsK6heqx0r2WqXV/lhb1lRPbv8cUm4oGGPAJi
        iv+PYLct+Z/WE6RfgUft+18=
X-Google-Smtp-Source: ADFU+vv/fvbyUFtUVKnn+VBzvNOvnYxDeCpTO3pOrA0paN4gZFnT0GqdHLFuizR6+NNWjfSMpsVD2Q==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr5849821wrt.203.1585173701248;
        Wed, 25 Mar 2020 15:01:41 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-140-180.002.204.pools.vodafone-ip.de. [2.204.140.180])
        by smtp.gmail.com with ESMTPSA id u8sm403538wrn.69.2020.03.25.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:01:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: cleanup long line in odm.c
Date:   Wed, 25 Mar 2020 22:59:40 +0100
Message-Id: <20200325215940.9225-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup line over 80 characters by removing unnecessary parentheses.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index a6eb9798b6f8..ed1a6ea0eecf 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -590,7 +590,7 @@ void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
 	if (pDM_Odm->bLinked) {
 		if (pDM_Odm->RSSI_Min > 25) {
 			CurCCK_CCAThres = 0xcd;
-		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
+		} else if (pDM_Odm->RSSI_Min <= 25 && pDM_Odm->RSSI_Min > 10) {
 			CurCCK_CCAThres = 0x83;
 		} else {
 			if (FalseAlmCnt->Cnt_Cck_fail > 1000)
-- 
2.25.1

