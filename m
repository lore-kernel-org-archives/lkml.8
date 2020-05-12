Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240E8C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDCC4206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tFn1g6Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgELN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgELN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:26:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63108C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so1820438wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OOA2tjrCMzpEGVQ4wsZGsx+qQve4HNZ307qi+80/974=;
        b=tFn1g6VnvjqXPa5wWer0AZBSgCntLE7a3TDJber7TVz1ksZz0vw9pfhNaKabsusts3
         Q4u3+Y5oY5lvmSGLH9CJQ6iSHnMcGwSbDi5N3mV6iaXU3iwtcRge+GOCgHJTPwx0Dunt
         2WFUIUd54IjSQ9oSGEb5gWVJfC/jZJ4qc9HgNV0GYgD+1BXgina5rNgxqjWB/aEYVW5+
         7le4q61yeaatKEThlrAGb+ERtdyhtKTxWq8CMOPXoSKqAyWd9kFZ6ufh5iuxUIRomUzA
         PmDi5o+TmXmttNyl87E1DKIAW4CJtNXTrTnaFSIGPzR94ZZjgoBRGo+8WdBKfJvQHsR5
         byRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OOA2tjrCMzpEGVQ4wsZGsx+qQve4HNZ307qi+80/974=;
        b=Fsrov2pGTC/m9Uo/vFlPmf33pxb1XhLa6AhFK6HwtKj1Ny1e2mGLTNKodPy0TZ/4gP
         aLu4JoJOnD7epUyY5y/+9tI0ew4W5AqUnyCLUI9rNww1mDCoScSmQHG5xe54TjjPY05Q
         T3P+G282sFw9gtxuwarJ0PUQ/V4zxtxsSa3iN2UAEfHmaS6xCbqfVVHatHtdtHNwhPvT
         aGiXWdJCOlPNHuMIZzTcPA1SO5KNHbRYiMtsVG1jbjSANCftB4cwY2Bh34dK4effd+J/
         yq6hyDH7TYEY9pkO7mhBOqd+aRJwZnLlUymxAMSaRBsvbF0m9fVRlJUxeJ47xFPdJW+s
         Isfw==
X-Gm-Message-State: AGi0PuYHL0Mf/YJzxZtiYeSzAbxYZIbznVD1Gh7YgS3tqtT12cs03Ykd
        eYoUNiqm6rSzh1Qmi0IChhP5kA==
X-Google-Smtp-Source: APiQypLPHEVWduy/3LzWWOhygupngnUuDQ/k1GFsn734lHfe0CkKPw+iJ6B+0gL3o0nrI8H96uujxg==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr13811365wrp.419.1589289984995;
        Tue, 12 May 2020 06:26:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id g15sm14441844wro.71.2020.05.12.06.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:26:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, srinivas.kandagatla@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] MAINTAINERS: add myself as maintainer for Khadas MCU drivers
Date:   Tue, 12 May 2020 15:26:12 +0200
Message-Id: <20200512132613.31507-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200512132613.31507-1-narmstrong@baylibre.com>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the HWMON and NVMEM drivers along the MFD drivers and header
as Maintained by myself.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..609baa78d810 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9431,6 +9431,16 @@ F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
 
+KHADAS MCU MFD DRIVER
+M:	Neil Armstrong <narmstrong@baylibre.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+F:	drivers/mfd/khadas-mcu.c
+F:	include/linux/mfd/khadas-mcu.h
+F:	drivers/hwmon/khadas-mcu-fan.c
+F:	drivers/nvmem/khadas-mcu-user-mem.c
+
 KMEMLEAK
 M:	Catalin Marinas <catalin.marinas@arm.com>
 S:	Maintained
-- 
2.22.0

