Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC88C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169D20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC+JynOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBWXSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44121 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgBWXSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so8206862wrx.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tqXBx3pW2XeZXOKkdshIeGK59QQ2bzYKaVDgcPRkVc=;
        b=LC+JynOMXP7MA84ZsHt9UdiFMqJsmNa3E/CM7pzdEnxQOO7BSJr9Y66WxMn4kVenGm
         wKrzp8mp1TZuE0nU4xai5gJ372ngfriF+gj/tRLcUROfsBGRvHck23lLsasm8Ug7ENh5
         W4JHollJ9JBHcES90yD8D106jxccdjjnRrAWzrF4z75Y6Nb8WMed+jKYlaYWCvihvuAV
         zmL68iiOji3Cczzb74zjWOEYbdtu4hTuAAw3RcdSjVfy4z7KCSshP5yUwaiUMuQRh6FX
         XE2rsMlvncajs3CjxHeVf38/yIOizsa7RlahyEzBO+17rV+P+BWL9MHdm9gDlZOH7+I6
         9WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tqXBx3pW2XeZXOKkdshIeGK59QQ2bzYKaVDgcPRkVc=;
        b=hexRP0GPf7RSoI84W0B72foLoWg+LzVbs1Lbq3XMwU0EdTLltef2EBSkyKgTs6qeLW
         /oPQ0M/lZ3ywX05Ys1NqSGZFKM/aAYg7r6UjyRwYRtZzeUkGGQOrl7pHsT1MNV7pHPRK
         o/tRH+BbBix1eMxx4MCA7nqiwrsZkhA0qJgd0mEAXywRHmDIX7Mw3LrSB0Lq4YqjcG3X
         Y8Bi/4lgH1MB1GdWV4Wpt+xVG1wqz4vhv5gcDkrt90inU+Ph6kvhQof9Lpq+T40gbw4F
         9uWc0n30F7YWlQ0gbSEJt5TARaFanmIZlPUeTZm0LtUA3of4SBSzjxzfHiFiTSYwv58d
         b3nA==
X-Gm-Message-State: APjAAAWuupv4cfSny13I8K4sYdHEc46LIJSEs2IVvVlG2yh5m4wvlvGz
        KdXYVpn6qj3tPduaoJGkzIs+2lkj+Fbr
X-Google-Smtp-Source: APXvYqz31sShpqsrfPCI5VrtqTypECSad9WivGnN/fCnolmHrDRh2aznSy0cdRBk0LGOojG44TYXjA==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr61892440wru.402.1582499911744;
        Sun, 23 Feb 2020 15:18:31 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:31 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 27/30] habanalabs: Add missing annotation for goya_hw_queues_lock()
Date:   Sun, 23 Feb 2020 23:17:08 +0000
Message-Id: <20200223231711.157699-28-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at goya_hw_queues_lock()
warning: context imbalance in goya_hw_queues_lock() - wrong count at exit
The root cause is a missing annotation at goya_hw_queues_lock()
Add the missing __acquires(&goya->hw_queues_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7344e8a222ae..8ca7ee57cbc1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5073,6 +5073,7 @@ static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
 }
 
 static void goya_hw_queues_lock(struct hl_device *hdev)
+	__acquires(&goya->hw_queues_lock)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
-- 
2.24.1

