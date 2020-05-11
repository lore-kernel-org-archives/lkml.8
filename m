Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B77C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA2420801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+M5qnS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgEKM00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729022AbgEKM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:26:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so4678642pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6qQPRYkkqKyAG6TLaEJB/cXToLWZ6lQEL1jR4ff/IE=;
        b=X+M5qnS54NsxisnIx7GWnpMoWDWn3S2xQWIGyp3UWhsDJYDkZoiNsvjCajD6xx8AuQ
         6mOWP09lgMi99nLfIw805FbWRAgJv6s45+jM0CbnOCyl3V/xqGnqi27nzDsb2mwlXfAA
         XJ47NejW5B4bMduwJJwqauCx9wS0XpxT+By53oU2vUu872hKmotTLcAS8RKKKdqlxE+q
         R5k259oNqmf7ex6OJunBi2f/dH6P7waZekWGNgAJptbSmOEUuS7eikiChC7J4X3aH0g/
         nE2Ha6gc9xTR6Nerie4w88IVyFzTw5E+MtNxlclal4M/RklF4pXg2jJItR7e9POgsDuu
         hBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6qQPRYkkqKyAG6TLaEJB/cXToLWZ6lQEL1jR4ff/IE=;
        b=d2BtryfSp+VFOyD2zTrNjJ2ZREiIAKHwZJpeJwTpXTfUvEHQb96VIAPh6Hz4Z3r7nt
         1G2nxktIh5tOg1ByHMZNLnwfmRAFkWLSJhtSb3kHHr4luOpVi87450IOaBicIQsSBL4p
         pNfoWjcbHj+4A+YOw4vBwZEl0AZMhmQJzlh3SBXE5oqxEgd6lX9e4VdpVm54nX6VOKxA
         6vwBbf8YBQkvsQHZeQFXOEAQ24G1iMoEwAKt8eborbgehPkHxVciMR9Ic3zhmViYa21O
         h5+593cnUqyHqD1eYBBsBn5/NymR6xfbTOzMOapg3eq7ZYLGLO7X1DMzvBLXISLd3f4L
         bNFg==
X-Gm-Message-State: AGi0PubaLzfxQ+p8x10lzoqpvcVc8iwH7VB+wDasSrs9E+DM+FE2HWAm
        wNNBKoCm4KjrXFuGGne7ab5Cwdfp0U0=
X-Google-Smtp-Source: APiQypLL4nvhq334zGg7iTbU1aDby51pF04VFXV0ASs9Ytw4L7wGG6wQYPS0Ri4lhijGPjC5YU88PA==
X-Received: by 2002:a63:9558:: with SMTP id t24mr8618037pgn.48.1589199981320;
        Mon, 11 May 2020 05:26:21 -0700 (PDT)
Received: from localhost ([45.127.45.102])
        by smtp.gmail.com with ESMTPSA id y7sm9229481pfq.21.2020.05.11.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 05:26:20 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 12/14] thermal/drivers/user_space: Sort headers alphabetically
Date:   Mon, 11 May 2020 17:55:00 +0530
Message-Id: <406d0c7c961e997b42e25adf4e432fe4f57b315a.1589199124.git.amit.kucheria@linaro.org>
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
 drivers/thermal/user_space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/user_space.c b/drivers/thermal/user_space.c
index 293cffd9c8ad..82a7198bbe71 100644
--- a/drivers/thermal/user_space.c
+++ b/drivers/thermal/user_space.c
@@ -10,8 +10,8 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#include <linux/thermal.h>
 #include <linux/slab.h>
+#include <linux/thermal.h>
 
 #include "thermal_core.h"
 
-- 
2.20.1

