Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8305DC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5641A24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="I8z6hFJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgANMeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:34:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgANMeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:34:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so11983932wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EqOL31gUqSpkjJR99Wdt9hlwWgIJHXjyD65jCY2UG6I=;
        b=I8z6hFJX4LIjq3Kd/pcQ91dfqmtM9Q+wHLsRuR+Kxs3Rslsphk4lW1UCDWBkBH+Cwq
         vcWp3vY5Ias3siQLz7FaqdYLCcXAh7xdzRGBKYPWubjUn8sMiW6j30cvX3/h9SVks243
         fQs66w++BdbMhKe2xb9Xnq74SWdjbMmZ2/FucTMMwFxLpBIRp4VaqItGpZ2PSbslVnc1
         NU207MB7LPiEM+JchPnp+lhntRbtUAt7KPoI5MQj6Tjr0f2Lea7LJ4OW/tK0t+jGIiFc
         K1pEkiqs6VPYzXWgRSa2YFmYAJSWG9DtdcnXUlaz4VTRGLw0meFOz0rGwI7pR8frEG9g
         CiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=EqOL31gUqSpkjJR99Wdt9hlwWgIJHXjyD65jCY2UG6I=;
        b=aOBs+QYQLNioTL7X78gP/O6nyfzzMIhZa6Qy1Zoz6ljYAB5CTUNt4yqNiBtnQJ8HXW
         4Fiuk4FEBoatCFbdhLe6knXPlYCT7zotZ0ED0PrStOLg8D1clZg0zpRCqQtY/PLyCJ+4
         jcQOXfP8oklkw9/1jxahShe/i4P+WspJIiuCRatFKa7bjwkSbxFqm9uBBcDy0+GeWbo2
         5s6dXGoy8jJ0+TlidNb/gKlBTkiRBjExLO/ILBbo5B0ofahkzzXqcjU7syaLf39TLlDV
         WHG7BO6l43Y7XjIc9wCnJJt8Yiy51pQUDA+FaPqU1YMRDpw8ZPRbnY30UnCWxG2AyPtT
         Q9fg==
X-Gm-Message-State: APjAAAX24CVXVKIUetL1r/wGfd1izxnlIn4octg2zJkhDC8TnQPiYWBk
        grX5oRxy1uSB8IrIwhJDySTuLplUvlICqg==
X-Google-Smtp-Source: APXvYqwhAE59j9QvH8R9v0nc/8jwO50OuDlzH2yuKTj7GEVBCsvOUF3b6p8cW69xerKoHYVDk/XUHQ==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr25467331wru.150.1579005259226;
        Tue, 14 Jan 2020 04:34:19 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x11sm18604583wmg.46.2020.01.14.04.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 04:34:18 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] microblaze: Prevent the overflow of the start
Date:   Tue, 14 Jan 2020 13:34:17 +0100
Message-Id: <e24752dd9ea739c86bca9cfe79f7f29b0afa0182.1579005255.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In case the start + cache size is more than the max int the
start overflows.
Prevent the same.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/kernel/cpu/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/cpu/cache.c b/arch/microblaze/kernel/cpu/cache.c
index 0bde47e4fa69..dcba53803fa5 100644
--- a/arch/microblaze/kernel/cpu/cache.c
+++ b/arch/microblaze/kernel/cpu/cache.c
@@ -92,7 +92,8 @@ static inline void __disable_dcache_nomsr(void)
 #define CACHE_LOOP_LIMITS(start, end, cache_line_length, cache_size)	\
 do {									\
 	int align = ~(cache_line_length - 1);				\
-	end = min(start + cache_size, end);				\
+	if (start <  UINT_MAX - cache_size)				\
+		end = min(start + cache_size, end);			\
 	start &= align;							\
 } while (0)
 
-- 
2.24.0

