Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434120716
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hackerdom.ru header.i=@hackerdom.ru header.b="JcbQbuyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCODrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:47:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44088 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCODrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:47:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id g19so17452017eds.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 20:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackerdom.ru; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0669bumRlP4HQpMkG80Cw5DJ/SJGZFv7rqtcnz7TDA0=;
        b=JcbQbuyXi81cm5wHDyJ7cqBJfT7UTa+AY43Mzi6y2wE2wjk6LKHVBy0RgQei1zf2un
         wLIrWKoqrryjFO6uU219/K6MMJbPbII+gfFayCOvs6RsTx3Z6q0GP37+BvMIaG9oT1qD
         tyQjRWQvVHiEo6pi3ETy9OAi5vSaCkQK8PEAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0669bumRlP4HQpMkG80Cw5DJ/SJGZFv7rqtcnz7TDA0=;
        b=qm332VFP/j+O6JvO/Pc7OiwpkEAQF1+3LnPEushWNLGCOlPlfOi5ZRWl8q4hSsQdwT
         IUz0VgB5H6LxGcZQVI38vkEAil+61vbMkTO3VKNSaag4qFMtNNfdNy2hVSs8vOzblozk
         OAwbccOKlBA7SoxUistSS2v5/P9PYkn66qXRiDEuCpcFhq4goEC0d3ZB0QWqW7ZyjEN0
         UVjuYLiRp44vy5w9b023prQWajwvU2aw2Ml9G6Dz8ogc4cLMySIDaUqw90NKpyxYGV3w
         TymQ6PuSyY3RW2EyfKaiiKRTuE4mkFkv+fHraQEse6Vdiri9rZ9klRyj+gf0Xb8f6cWl
         Lc6w==
X-Gm-Message-State: ANhLgQ2x56gm5vE7A6vFV8jHUNyfcZhMqSfe1jqXD4cgI3Gptmb9bx6A
        oxncbGwztziwksxHLeG/GM/n70OK74k=
X-Google-Smtp-Source: ADFU+vuPm0TydM8WrmSVNKxt+bqJFE69RN++6libq4nsRTD0a1n2sKLRxBjTwQ+GeYWJEMdpu9/ZOw==
X-Received: by 2002:a2e:8095:: with SMTP id i21mr10602389ljg.193.1584164053136;
        Fri, 13 Mar 2020 22:34:13 -0700 (PDT)
Received: from localhost.localdomain ([83.169.216.4])
        by smtp.googlemail.com with ESMTPSA id v200sm1232577lfa.48.2020.03.13.22.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 22:34:11 -0700 (PDT)
From:   Alexander Bersenev <bay@hackerdom.ru>
To:     bay@hackerdom.ru
Cc:     Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cdc_ncm: Fix the build warning
Date:   Sat, 14 Mar 2020 10:33:24 +0500
Message-Id: <20200314053324.197745-1-bay@hackerdom.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndp32->wLength is two bytes long, so replace cpu_to_le32 with cpu_to_le16.

Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5569077bd5b8..8929669b5e6d 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1172,7 +1172,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 		ndp32 = ctx->delayed_ndp32;
 
 	ndp32->dwSignature = sign;
-	ndp32->wLength = cpu_to_le32(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	ndp32->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
 	return ndp32;
 }
 
-- 
2.25.1

