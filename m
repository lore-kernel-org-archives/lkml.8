Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8193C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A547C20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 21:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNeKxX1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgEWVND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 17:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387984AbgEWVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 17:13:03 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC34C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:13:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 19so15759436qtp.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2bby9cI45fyWKXrKxGRnCB0PRSUsYL3TkgfMjCuANdc=;
        b=dNeKxX1T//NGG+vd4uYpN00vNrJRS7onBOZtFFDXQPplWUpavI0ZRFPSGOxiUoCKkL
         9ulpdOjmwUdhFktPdMKioK1Z3sZ3cX6mcNzWzqRQYt9DojkHv6yMNNq2Zj6ftm0QcxN5
         tH72kJn7qHRu5p6FiMKXPNOPoYqeuSO7Kov2urHL6Cu7Y5R5AU+h5B0XXH0pmvozrnsU
         ZZz9aaLYUBrYvWwkE9PAdx6ghEB3KDmYt87ovSQ/mEq/geuIu8Sjd4Lre8fx/p1vboqD
         f+SqAQX9fJmbaZv1QCqR6bqAPfI+/yuHt4wpM1agiK+Va+I63YrWPRTtGFHFhbFrE5l4
         M30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2bby9cI45fyWKXrKxGRnCB0PRSUsYL3TkgfMjCuANdc=;
        b=p8GewW4dZ9dPC8IZW4IYL5Zi6rH7kiaVPehVPlhPOcPawlz5qx114LIvkTEofRBokT
         UKSrNBPRaGJPZA8q7J0LiJt6og3mgwjZfKdKPtJe/lcE2q4zaqyewmw4EOA6FtAXsL2u
         xCDL7Vz9endAW+AWSCQiv9uFCfiYEl85fZsAM4VyRtOuWSA4PFoQVdrzbYX52wtfbaWL
         kdbCm0tBMpE4f1UjKBAt5pdi2TRNqCikfwh5q4mCePrvcH7FwxRVnjbQtcG1T+7Kcub4
         rowclloDtemAIj+RIDnBww1g2CUgsRXzXRtdmsEpCqAVfVVYyE3tVBTAs8tmGvGrTuhB
         7NQw==
X-Gm-Message-State: AOAM530ojqojoCoRWLLFIE/ApZ7z3HEEBW4CFxZ0PBeNu4+UEx9cmU8S
        uvuyHQPN07pGOtlrblwHFIy/5GeRXz7m
X-Google-Smtp-Source: ABdhPJwcJbwcvkxkyoyFSZSbn82VKMzlrI84RDXWlN8XaC46q1B7drpSxXma/Hm3zmPp9rGVqI2twciQSTlq
X-Received: by 2002:a0c:a5c5:: with SMTP id z63mr9694727qvz.50.1590268381597;
 Sat, 23 May 2020 14:13:01 -0700 (PDT)
Date:   Sat, 23 May 2020 22:12:47 +0100
Message-Id: <20200523211247.23262-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] staging: rtl8712: Fix IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK
From:   Pascal Terjan <pterjan@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Taihsiang Ho (tai271828)" <tai271828@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value in shared headers was fixed 9 years ago in commit 8d661f1e462d
("ieee80211: correct IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK macro") and
while looking at using shared headers for other duplicated constants
I noticed this driver uses the old value.

The macros are also defined twice in this file so I am deleting the
second definition.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 drivers/staging/rtl8712/wifi.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index be731f1a2209..91b65731fcaa 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -440,7 +440,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 /* block-ack parameters */
 #define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
 #define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
-#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFA0
+#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
 #define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
 #define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
 
@@ -532,13 +532,6 @@ struct ieee80211_ht_addt_info {
 #define IEEE80211_HT_IE_NON_GF_STA_PRSNT	0x0004
 #define IEEE80211_HT_IE_NON_HT_STA_PRSNT	0x0010
 
-/* block-ack parameters */
-#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
-#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
-#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFA0
-#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
-#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
-
 /*
  * A-PMDU buffer sizes
  * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
-- 
2.27.0.rc0.183.gde8f92d652-goog

