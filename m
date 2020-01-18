Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32713C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059C824695
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvbU/Xnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgARTzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:55:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgARTzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 14:55:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so10842948wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 11:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTmBENH79h2ojt7Bwsg0kO8vkaLLGDO2AWjzRPO7/iM=;
        b=SvbU/XnjCS2L/MMPXI2k41s/8qR7aSEaMvacV7TJmjxkMvtvbYRMeM0i4vhF4Xh9VQ
         CzAsNZt8U4IZ5KTUYXDfrirRkQBN4rljET9wSyRAMyhSqbses5hSOCz9Sci0ry8jngMS
         voN1+pkI4ImLI0jpGeYkdYi5/dGIRgtvPiPOWbh9R5EPndAdPa3sTQewSh97OzZPQE4g
         9vQjAh//7I/zVbO9YMjHqzdpEbTn+JfpSJKHr9sT/Umv1bwIFhJZz25HVlKTulL1NsEZ
         uUuZDEJralThfOiPlOTsa3U6A4EfrZNDpX54+M/f9LdYoXFA3lS0vyRXM4qBrdTEKQCc
         d/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTmBENH79h2ojt7Bwsg0kO8vkaLLGDO2AWjzRPO7/iM=;
        b=ZHVSAr/bvsCKUtAWoro4gSklVpezyR2olTKuXCDUzyMGo9KZ+gIcJwA4fdiOk46I9m
         Jg+bo4vyMHYbFMOcUibDafu1zw4Ll3pjtyg2IIkc4KlkwIYbr/PIOzctHlv9nFaRUsaX
         BIzM4WURu1zzlVLOGfkJeBNEoXT3VIvGmU3m68saad+hdbRmEBg4+2VGYq2jZSVRdTtx
         3TqU3iE9+7yI1fr6B/YCT4RPKbTmimHuReDnsZEmIuXiZO3p/sW7jX04VSpUiFfQCe6L
         sNVH9os+vDbmWxJHOWSo2vcfY/3LI/r1LS5IzSfCio/BXhUCQ8Vd4cAUBsMbbfyk/A6D
         Xyhw==
X-Gm-Message-State: APjAAAWvEueVFADO5DnLHYTs6QymczJonq6NgCz0qPBFRocOLA5Uvu6b
        7sjhNtPnCCLoXh5lsJfBKII=
X-Google-Smtp-Source: APXvYqw2wdUEcCd+jtgG9ImExu8CGRP3EFET8QPQSsCJX5Ax5/nPr+1Ft+NBguxNfrtVF/YYgaNd3A==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr11108286wmg.139.1579377313803;
        Sat, 18 Jan 2020 11:55:13 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-199.002.204.pools.vodafone-ip.de. [2.204.143.199])
        by smtp.gmail.com with ESMTPSA id z3sm39877523wrs.94.2020.01.18.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 11:55:13 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8712: simplify evm_db2percentage()
Date:   Sat, 18 Jan 2020 20:53:05 +0100
Message-Id: <20200118195305.16685-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118195305.16685-1-straube.linux@gmail.com>
References: <20200118195305.16685-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify function evm_db2percentage() and reduce object
file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 00ea0beb12c9..116773943a2e 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -663,17 +663,11 @@ static u8 evm_db2percentage(s8 value)
 	/*
 	 * -33dB~0dB to 0%~99%
 	 */
-	s8 ret_val;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
-	ret_val = value;
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-	ret_val = -ret_val;
-	ret_val *= 3;
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.24.1

