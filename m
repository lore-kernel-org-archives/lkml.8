Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B1BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9544C206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4hYkwVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHTSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgHTSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:38:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A6FC061385;
        Thu, 20 Aug 2020 11:38:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 83so264198wme.4;
        Thu, 20 Aug 2020 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgRf0Ar5MulFcCJvaCQyug2lmRa/ai0OZaAGSl3iEgY=;
        b=H4hYkwVVPQYi9sO0a0/uLgOj8mXjpo7sKsrsj0dTHZy/XBHYoiNaAXeTSx/OL5Wlx3
         dBrNi4aPjLVP+/AEvLkeoPT8OQJ8dZYUjPKUo0Y+ugsDL0vs1NBSj0gESCIgYO8hF/bC
         Hycyy9kkoy6tGRRv2l1Wutk7sQ0lxJfrUtY+bTvYyI35YZ75rT2nUbAUg5TMNQ/kjjlY
         4wa5aXdTpnQyL7DVapgmwaBwOdsTo7iI+DYqXBQr6ITMBpItHvHL5jf6QB8UgyQ1UwHU
         tMoLD6WXbHU/w5yoAwWnbNSnfrTg5jUpyAV69BPvyoZvjMNyIjghUisXzRNWxHPpNObD
         dXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PgRf0Ar5MulFcCJvaCQyug2lmRa/ai0OZaAGSl3iEgY=;
        b=oiIU52eQs5HV2nXWJfi0D9//59ktOYDDWyj0yeVJsD0Cu9z2SHh0kGOiHpZQ+yDSZ8
         jAz7gwZoPksyj6ADKLONovnltxZ9+sWTKHJsK62tEFRGxAGM45wzKNX2X2nAMFJtobvV
         lQ6BYRVMgCy9gP6rEBjkGG0ZnT4qfxUjySaclvRg2vVQ5aU7z0ABxlpJJs4UOe/U/Dkk
         TtaroDLTpvFrsb4cfnUdxDoaWh8N5UqEePwboZXSwUZF+JY9/L/fzJBQneoUhLAPWFPM
         VUOiiNhLEU4RztIbBQHVDe1XmJssJYrEUoFI0+4BmlT90iA5QjZbhq+J0K/z49Q/MyUK
         B0Ug==
X-Gm-Message-State: AOAM5334l8paN11cSMqL3EOdLC6tvoeSQoGmyFH5C6TfNU283OmRjlHx
        DEmlEMQgo1NBH6efB5LrAwGnzloTQEJZN8yr
X-Google-Smtp-Source: ABdhPJwNRbuc6tSHftgEA+hcCV17PDfcinJw4n/pz9l/504EM/GlQARZj9wibS2vkPEgwsV69p/2/g==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr52135wme.16.1597948735669;
        Thu, 20 Aug 2020 11:38:55 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id b139sm6147232wmd.19.2020.08.20.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:38:55 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Alex Dewar <alex.dewar90@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: st21nfca: Remove unnecessary cast
Date:   Thu, 20 Aug 2020 19:38:36 +0100
Message-Id: <20200820183840.912558-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In st21nfca_connectivity_event_received(), the return value of
devm_kzalloc() is unnecessarily cast from void*. Remove cast.

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/nfc/st21nfca/se.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/se.c b/drivers/nfc/st21nfca/se.c
index 6586378cacb0..c8bdf078d111 100644
--- a/drivers/nfc/st21nfca/se.c
+++ b/drivers/nfc/st21nfca/se.c
@@ -315,8 +315,7 @@ int st21nfca_connectivity_event_received(struct nfc_hci_dev *hdev, u8 host,
 		    skb->data[0] != NFC_EVT_TRANSACTION_AID_TAG)
 			return -EPROTO;
 
-		transaction = (struct nfc_evt_transaction *)devm_kzalloc(dev,
-						   skb->len - 2, GFP_KERNEL);
+		transaction = devm_kzalloc(dev, skb->len - 2, GFP_KERNEL);
 		if (!transaction)
 			return -ENOMEM;
 
-- 
2.28.0

