Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70838C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2F320692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zUF41G4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgDMKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbgDMKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:49:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24CC008769
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:42:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so8947378wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxLLEtf7L3c0hGSdxGKFQpoT2uSSCcGo15k+Gpv2wKY=;
        b=zUF41G4Bw1k5BI7yxQOyGjqBkuZxS+Ym+5PwQuckymqcszDP0yg01AMt969Epq5Vrw
         o+XLhiUcYrW5uFacawoOf7cgJkpmIzXrXPIFXGnylG+wHD/1P702tGWcoejMGPB+Be+m
         czt7Y/HD+OS4aFtdINPw4bHxAQVgLXqQDmRQ+rULttDNeouAWOJ64xAZTf7cbdJB+jp4
         WFCfMKBLl80lanTUqj/AYjQwhdht/VMS4O9RQmd1nHsNhVpAICF7Lq7NjtNJrqeKoPUS
         F7Lg+nIbrwVjSkItk6XSqmy34wiDkPYx61bEuU7Q6JdSi7wu91rQDtvvCVOGsfY8ziKq
         9gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxLLEtf7L3c0hGSdxGKFQpoT2uSSCcGo15k+Gpv2wKY=;
        b=gwPS960i97M0Uub7CFMSTQF2yvlaihuTRiWWilA37j/NBm0jeoM49bZY4dfUctdwH1
         HsCS0ri/v190yiK8AB1LknQSbbQoTfshVK2K/tW+vlYc+9NyK1O4Zwb9xCY2yM4hMAU+
         1JMg5qdqUmiwjZajGn0dbm+LW3YddZjlOewOUmTar8gzYaN3n8Hai9k8CbymfBFrVHau
         Dm57/cEUVcBF4F6u7A/zyjt58irOCbZQWufMC+Fme5/YZDVaZ4CeL5IVJ6DBY54217fh
         G6Ep+DDeea8jxU06U2/lVyNaP0hP2jrDeuV01uNcbRW8rLeoNwO3CWpGIaQBFeptvUp3
         GoDA==
X-Gm-Message-State: AGi0PuYmc1kGlV01OEcSJ6yhOlXfLQdOhgjy3PiHI6PzBEC/NObdaljd
        rOPXipPU5vJy41AsbGjhMtvr8RayDbg=
X-Google-Smtp-Source: APiQypLAlI/vijmodM4EggLCa7l/yBBo2uK2IiTLS6PklWMZRCHtdF6ZbMuDZ33wavGWnr0g/uWHVQ==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr19632154wmf.168.1586774576391;
        Mon, 13 Apr 2020 03:42:56 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id k8sm12530599wrm.52.2020.04.13.03.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 03:42:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefani Seibold <stefani@seibold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH] MAINTAINERS: add an entry for kfifo
Date:   Mon, 13 Apr 2020 12:42:50 +0200
Message-Id: <20200413104250.26683-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kfifo has been written by Stefani Seibold and she's implicitly expected to
Ack any changes to it.  She's not however officially listed as kfifo
maintainer which leads to delays in patch review.  This patch proposes to
add an explicit entry for kfifo to MAINTAINERS file.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
I'm not sure why this patch hasn't made it into v5.7 - it's been in next
for weeks now. :(

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..f0f30b2cafa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9412,6 +9412,13 @@ F:	include/linux/keyctl.h
 F:	include/uapi/linux/keyctl.h
 F:	security/keys/
 
+KFIFO
+M:	Stefani Seibold <stefani@seibold.net>
+S:	Maintained
+F:	lib/kfifo.c
+F:	include/linux/kfifo.h
+F:	samples/kfifo/
+
 KGDB / KDB /debug_core
 M:	Jason Wessel <jason.wessel@windriver.com>
 M:	Daniel Thompson <daniel.thompson@linaro.org>
-- 
2.25.0

