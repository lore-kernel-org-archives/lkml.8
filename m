Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB62C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D368207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXhiLmSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgEKMZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729809AbgEKMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:25:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6DC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so7699704pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=haxNS0r+O/CZv15x/o++MDoCTq7xU6xDTOnaN5esXAw=;
        b=YXhiLmSx4goD8MUm/DW+rJ3zGpXWB6FJ31sgJ5LlIO1JYcdZkfCt5mSFZIuxiNtm5l
         UfHYxoICohviLDbSbjQmTo+sOI/dpnqt3cbXlcfW13WQsYTxb8gc/Ei0zObJ5Yh4p0Ba
         iF3fXBsX6jrgIDBJnZM4Wh/x3tNrHCcUf0MS3jsv6VVJmLC5qOzpwb4tGxZsrxkBbywa
         YxaL3gXVxEIlRpdW4oMDNSobiYem5inBDHkZxsUTxoA8QqbtdNHXhv5usHlkZeRqNhkO
         g/rXcAd6Vj+FDAc0jItxg+usDGmwxOWHSD++8EhIzWWfJUFNLJdxrvORZXMDBb5R+6zU
         8UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=haxNS0r+O/CZv15x/o++MDoCTq7xU6xDTOnaN5esXAw=;
        b=SMdfFvKVQjZExIlDsS+0BuALgL4tCQQiDbRY7nRZll7BEx0erOxZGkDVas1wcMRtKS
         CFdhu6TvYIYmypxb2BDkOCxauOL+LvfBC1uMZmz+2oo3jp3OYSavXtYclQ/eCe+jAhAo
         aNIGNedlSC7HGzKcVreo8gW53UjgjQ9dOQPR3C1YTc4+jvmYCddowY31NctGhHE3FZ/O
         fbwQdk/DvKQ7hWrmWThikbrp3aV8cmlEyFC4+LlifaQEP/7jsV++EfNPpLX6HPqWpq9j
         JYSUDy//CyFY2hZ8GVRd3R1l7KrUbAofKXcFYw7uegLQvME5da8eTgTGnpwPK83/qEdb
         kFVQ==
X-Gm-Message-State: AGi0Pub1owAn5DNdNKM0bf4RYT2Rtfp5DLQnD8YGcLOrLeyoI+mUCqQR
        4p64kovWbl7wZpJu+C4fRE2d11eQKXY=
X-Google-Smtp-Source: APiQypKuTjY9Gg8mysJb/lkYYkrUVhRtatcvHzJl+3wFXdbvG1f4JVxn/zvTUHIoQRLk+TPOTNmBjg==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr20147358pjy.16.1589199947854;
        Mon, 11 May 2020 05:25:47 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id x193sm9569958pfd.54.2020.05.11.05.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:25:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 04/14] thermal/drivers/thermal_helpers: Include export.h
Date:   Mon, 11 May 2020 17:54:52 +0530
Message-Id: <fd3443f00dbba6ca90f35726c7451ae52145d2d4.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferable to include export.h when you are using EXPORT_SYMBOL
family of macros.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8ea0a05404f7..e47da80daf3a 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -14,6 +14,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
-- 
2.20.1

