Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD845C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A70A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnylnDhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIXcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:32:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C4C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 16:32:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n2so3164357edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eHdc0RwCyYc05fwyou4V97bhyi7abJndZKMy/fLO/JA=;
        b=OnylnDhIwv5IuKd7WhncjUcCmtg6GK79nI0OpL00wKLlnIQyQH8ddEvdL7RmSlDkmZ
         KGGcfE9GtLVyoWwBdEP3b2/Tb7sz+EvixPzk2CVLfNdquLSX+nRFHg9ssZT/3Uh6zZYv
         J3yJq0pAoTaGQv/n5NovxMWvfcrnqs2Ukajv0A33BixiJs9JeTtiFVVgrJj5exXhWHjW
         sRhxYA9caKiPVkUAP17LT7z7zr/HNXK24vT6+K3tqoFP8HCKqHL3ddubKpYQu5jSDZHk
         /YXv9hCsfassUkBGOkSqc7aC3SXCA5PtK9DWo1HW6dpR/iv5cWdPqqy2+nAlP6BRrkkj
         vxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eHdc0RwCyYc05fwyou4V97bhyi7abJndZKMy/fLO/JA=;
        b=e6F/qWREEJRuVT0UqaoDq6GvkLfe/LK/B7yfnyoyd6M3IgW2uTKLJLffyNgGH0M9dX
         w57SQEwB780ccq1ZNNeizXHsFSBbCsv7+ygz2JKkavh0MD/IF8ViAg7Gc5LxBtbUepNE
         0VY+jrxN2xabaJZp26xNm9rxMMAPpNTfJT3bZ2AX+fIZK/GW0S3KunF/qYe84Mvfxl/W
         1D0dQLrNwahfPbqdCqLn8I13I32bl7x4eQBFgvG2jr4TI1/20xTbDoyDasIknMokbQoL
         Ey3xxPDOzS3HwFwoME10o7KYogERA7TXrftTHQjWWojgDa7Wkd0Z1OD+Btv9En2OBJPF
         GL8Q==
X-Gm-Message-State: AOAM533seqJnwWTbc5pMT/RvaJrX5jw9pcQRDr9JECu6zPk1gIwU5bVn
        X0Sd6qI9hFB4keU8uT4vTqtkdjR5
X-Google-Smtp-Source: ABdhPJw3pSN2FEH4F4m6013+KarO9fvPGJXwwXf5VjjVj0238tMsBilLVLvvNgLpTj+b4Rimopo35w==
X-Received: by 2002:a05:6402:354:: with SMTP id r20mr76812229edw.32.1594337541255;
        Thu, 09 Jul 2020 16:32:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s21sm3007847edw.37.2020.07.09.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:32:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] bus: brcmstb_gisb: Shorten prints
Date:   Thu,  9 Jul 2020 16:27:46 -0700
Message-Id: <20200709232746.6141-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not print the full function name (brcmstb_gisb_arb_decode_addr) which
is quite long, and reduces our chances to printing a full line, instead
just use "GISB: " as a prefix for these prints.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index ec1004c858b8..7579439971e3 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -210,8 +210,8 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 		m_name = m_fmt;
 	}
 
-	pr_crit("%s: %s at 0x%llx [%c %s], core: %s\n",
-		__func__, reason, arb_addr,
+	pr_crit("GISB: %s at 0x%llx [%c %s], core: %s\n",
+		reason, arb_addr,
 		cap_status & ARB_ERR_CAP_STATUS_WRITE ? 'W' : 'R',
 		cap_status & ARB_ERR_CAP_STATUS_TIMEOUT ? "timeout" : "",
 		m_name);
-- 
2.17.1

