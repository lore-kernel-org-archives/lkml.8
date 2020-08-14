Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98443C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506EB2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGgqXBAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgHNW5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:57:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA0C061385;
        Fri, 14 Aug 2020 15:57:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so5255818pfd.2;
        Fri, 14 Aug 2020 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIWJj9zW4KG8oMM7dhJRCde1cAcexSQbE9o5aOfo5vA=;
        b=dGgqXBAbhFwTauGBYV/gCxewQKhaBNsC0nOWPlYbBDxPHN2hCbWMJkHQ2xJrCbK9Ia
         LdIIX9Z+9vctGiw7fQLl+MCr+4YyjSFqpxTfcWGedQ+oOfxkCjq6iz43OOriPGuFsK+E
         MRk+TFW7XM6Yi59luiDbrbuZFN79x5o2dDNCXs3mhAcP/3sn9pG45eGkzeIEPSKb2ZYv
         Y704TRUOJA3CMzgzkIcBkJeWVu6EdT+lQOilTWYFacWyGqqxiKxwVsmAsx1MQtIvb+ie
         Ai1ZwLV/ymuGm13J3sBYQq7TI6QFSzqZX4w1EUM+4Yf4wM6NBHmWwXoRbgnbt6+CvfEr
         DWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIWJj9zW4KG8oMM7dhJRCde1cAcexSQbE9o5aOfo5vA=;
        b=hCOUfAeI/snOIHgk/pOG8Pp2is+nvDmkY1gynqec3T45iPC3zc0BsGcn+723LcL3oX
         Cf4lgOKf13mDIBT3HawNf5IkRLwASuVqZSHfT096IYfJbykcx0LJ64NwDXKfU7gxDASx
         h4T9CY7y0W158BYZ85KT9XAMIq1bOcbuJpeyE82TYHVO2DO6AtYXUkP88tzKU/AsML2I
         8v/TWtnGe+86blPLRc0uxcsg2wwjWB+RJqCUe5UTj4Mam/yCmbslR7UGgTD12bfBZg3O
         KvoGKD0AFH821yonduM5khUDGZDyKPuDvQrgbwyJYLwD3+yuLjsxTv5/OgyyTxpQpkYU
         pm8w==
X-Gm-Message-State: AOAM5337J4WX6V9AcpfU0eljQNvyDzyvbM/s8yULEgeFAZ2JS6tkRWx6
        gDtGW+Cu8nmYVdcEPvHef3g=
X-Google-Smtp-Source: ABdhPJyyUomKHl7OaS+/Kq2abnv3emMTEKzTtaGOrEFfHJCFWkEwyRGk9MqSlpboMZU4uybJx3AHvA==
X-Received: by 2002:a65:6287:: with SMTP id f7mr3180416pgv.307.1597445838256;
        Fri, 14 Aug 2020 15:57:18 -0700 (PDT)
Received: from localhost.localdomain ([167.179.71.198])
        by smtp.gmail.com with ESMTPSA id s185sm9633347pgc.18.2020.08.14.15.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:57:17 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com, robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] of/fdt: Remove duplicate check in early_init_dt_scan_memory()
Date:   Sat, 15 Aug 2020 06:56:37 +0800
Message-Id: <20200814225637.702584-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the value of the first reg is not NULL, there will be
two repeated checks. So modify it.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 drivers/of/fdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4602e467ca8b..f54412c00642 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1002,10 +1002,11 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 		return 0;
 
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
-	if (reg == NULL)
+	if (reg == NULL) {
 		reg = of_get_flat_dt_prop(node, "reg", &l);
-	if (reg == NULL)
-		return 0;
+		if (reg == NULL)
+			return 0;
+	}
 
 	endp = reg + (l / sizeof(__be32));
 	hotpluggable = of_get_flat_dt_prop(node, "hotpluggable", NULL);
-- 
2.25.1

