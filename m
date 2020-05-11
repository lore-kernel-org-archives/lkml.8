Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCAC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2E620801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoTOvG7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgEKM0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730006AbgEKM0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D64C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so7706766pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hF8S2ow201STm9wEzkJ199uzwJVbP1aLvlH6u2KlxKw=;
        b=ZoTOvG7sdBo8g0iLE80nyWqdc/DOAUWNi627jdhPSIh4oMCTzEkY39BHGhuS9Q6Smg
         vIj+Ye4GVk6LoJF8h2ZgA4Qfe1scI/dnskcEnzYzelau/d2cV6YEvdvvxeKD1KeCnlCq
         DwWC6vV5J5N9ADddZxK/p6cEtZHf0P4gO5QgVYhFkgzG0BH40A4+xeP4BcqFL38mVukf
         2MDwSYX/Td2bIGmIfEjXlWPKS29gtrkYLwvMFJ+DCjBikf8N4MaBoTYKZBxTYsSUpkB/
         fmN+cOhIklGuufiuQ2vFSeZfYSjPm+R+GQyyjTxEPW/sOQW4qz/+JNrvnP6//6D71lKx
         oTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hF8S2ow201STm9wEzkJ199uzwJVbP1aLvlH6u2KlxKw=;
        b=WDweXX9QYHL4dD1fbvPDf8cx2+dHwxtpWlxdP2h075kZq9Gu0C+ptjex18GRgK4bOj
         W/2HqE7oCg5krx56RIycQzm9e+6IhhUXjSd5kUVetBpLoBk1X2idsSlVRUWGO7Bt+uOG
         AZIWqYxAZC43YpfBrMR6iy6WSjYDk50lrrAiOb97Yke05eNIMakfCNNFChQ5vjO2kTGp
         o9QWVe9tX8sBojUpENj5GHqWXVvX+ZgMvuGfm9wuOqiOSh6NLQs5tmbRJoettXoFE+lj
         QKoDYMe/D7Z4GQ5e4XH0rXWMuHFBf9ZEy6g+kA7A11OfMxEOR8WKaZwMU8fLL5bYmwGv
         yG0w==
X-Gm-Message-State: AGi0PuZ5UpfW4E4OlqQfyAOgZ9+i0TEAnvOOpNtHYazNyEV91BARsGuL
        DA8xOcqP/fWN4D26xY0P5F8znxHnEqQ=
X-Google-Smtp-Source: APiQypJatB+Ym6YLZS8IFfrGHFQFr///5CfFtcokbVGanuM03QlrrHzyaaQkUDCy0ui2HFE8tM7u9g==
X-Received: by 2002:a17:902:8697:: with SMTP id g23mr14694952plo.306.1589199977199;
        Mon, 11 May 2020 05:26:17 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id gz19sm9928726pjb.7.2020.05.11.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 11/14] thermal/drivers/of-thermal: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:54:59 +0530
Message-Id: <f9f9d8117f1659872114ba65bbfa9ed4b813128f.1589199124.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers to make it easier to read and find duplicate headers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 874a47d6923f..ddf88dbe7ba2 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -8,13 +8,13 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/thermal.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
 #include <linux/string.h>
 
 #include "thermal_core.h"
-- 
2.20.1

