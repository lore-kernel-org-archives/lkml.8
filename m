Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15643C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C492082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Afi57NmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgAQS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:56:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34012 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:56:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so12355704pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 10:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkoQ4nyifh7YprS+4/LmLf8NkjkvRebOrTXBRE37Y34=;
        b=Afi57NmSu6mVLyLVY2bm5P9bxE6WIrfLdGkFkU+xutZbEiG2AmufMLW0vvw+smTrNd
         eK+90elSwPoIWkEHzAtqtnVSSk9EJdEtweqBTtHVr3+T3atlRnopLa5JFI4E0xBaVDxF
         qzM0KHQlnQ47aAv7WOpKffUWZj51sFf6ayBB82Ydt9W7BC+bxte4jrlpQlF3Xs163gBf
         Pt3ZUyWoGdPA0av2tfL9qgoFGkFrQ8GY4VdlgTxy7W/N6j56vO+MMxvMo2v2jeL3CbNd
         CtPfaWIUgMzVmDiTx/Z175FBnpNL8ztWjNA1VP2jQ67nsogSH7A6Zz5QtEOo5/RAsFLe
         jNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkoQ4nyifh7YprS+4/LmLf8NkjkvRebOrTXBRE37Y34=;
        b=UG2M+O2eawXFWmOcsp/3oGglLAyVfbJrcGno0sqaA8Ea0wFCx5WBU3GxRxCSCyuoaW
         ldBPYfk134jGEIHU794XhlykPfBfDY9IsY16QxOsjzHHnSY+HQf9WwIIeLixZG47B7Fs
         P6RO9O2NAfERWqsx4DyGk9XGMZVmy8QFgwsKfMdTfQLwU98oKQG20rpY2wzHQFSwSbaX
         breMpZUAvDSsb6aerFNFrH8RKA0eSEK6eSjNBSnMucvmFy1C1KcaCD3XBQuWLubO7WU7
         B+hhGpoGBhzBiSsQufcggwqTcQrjLlFJRm1cta1mNWE1JLmeJH8cqYMnUEovcPNhiiqv
         aSIg==
X-Gm-Message-State: APjAAAWhJPo7nL9RDoLT0WGddM5MnuoPO8H1du7hMfnh7fYI6sPG+9L/
        ibpmfv6CAz2ZgLXWmV/kXYIHzg==
X-Google-Smtp-Source: APXvYqwuqnHTthBlGcBYhcMhhAoDEc/iVnS8+lDVO/wVH/677XnbZTEn0iNg7nF/LNPKmKcdlfnyoA==
X-Received: by 2002:a65:621a:: with SMTP id d26mr45686355pgv.151.1579287370272;
        Fri, 17 Jan 2020 10:56:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r8sm5899181pjo.22.2020.01.17.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 10:56:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: etm4x: Fix unused function warning
Date:   Fri, 17 Jan 2020 11:56:07 -0700
Message-Id: <20200117185607.24244-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117185607.24244-1-mathieu.poirier@linaro.org>
References: <20200117185607.24244-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some of the newly added code in the etm4x driver is inside of an #ifdef,
and some other code is outside of it, leading to a harmless warning when
CONFIG_CPU_PM is disabled:

drivers/hwtracing/coresight/coresight-etm4x.c:68:13: error: 'etm4_os_lock' defined but not used [-Werror=unused-function]
 static void etm4_os_lock(struct etmv4_drvdata *drvdata)
             ^~~~~~~~~~~~

To avoid the warning and simplify the the #ifdef checks, use
IS_ENABLED() instead, so the compiler can drop the unused functions
without complaining.

Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Fixed capital 'f' in title]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index dc3f507e7562..a90d757f7043 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1132,7 +1132,6 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
-#ifdef CONFIG_CPU_PM
 static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1402,17 +1401,17 @@ static struct notifier_block etm4_cpu_pm_nb = {
 
 static int etm4_cpu_pm_register(void)
 {
-	return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+
+	return 0;
 }
 
 static void etm4_cpu_pm_unregister(void)
 {
-	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 }
-#else
-static int etm4_cpu_pm_register(void) { return 0; }
-static void etm4_cpu_pm_unregister(void) { }
-#endif
 
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
-- 
2.20.1

