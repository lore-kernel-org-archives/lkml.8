Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB85C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217EC2076E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX/RxiCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgDCS4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:56:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52492 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgDCS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:56:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id t8so8199120wmi.2;
        Fri, 03 Apr 2020 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQFf5QOW9wV2omuXCF0wGUv7jQKvZzP6SHvYmGO8r/g=;
        b=aX/RxiCc5BGzHQdPC56O4Dc7CED3JAddta77ld8C08ESz3Lwzb3AMYc1K5MoRWFTKH
         5vriOAIg3eLq1vu8i2YNRtBoK5kgKqBnX+LKIJTbVYa8qY4pV0lIf62mWwLOIQMhIp0t
         yuAdXbVBcLyWItSZUlsP17s2a1owkuNphPQXbqEs3eEpmXLvF92Xy3krZnhtaXrKJbBv
         wipx859cNeBd/KNk08UuZTsWR5E35Wa8rSUg5ou8s87acOWCyGd9yGo5YZ0aJkhP/4T1
         l3r4e4Lw+zI5Q4pt6xIltxQ7Bn3h9Qg4bFbjinKrBolkF8eE8sGQbOPHTSUFlvXrwrev
         Cl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQFf5QOW9wV2omuXCF0wGUv7jQKvZzP6SHvYmGO8r/g=;
        b=REVV4h4ER1htpABZz4uh53mGM16vydSSmufZG3RVF1s4PPO3N+VQ2xLzpEn+1Wudr3
         qJN3Q5TWHLFAtcw3qutFmyy8wF56Der73x29L0QreFJ9DuxMSoSLfNLsdNRP+vBFySxS
         +38BM1NfxbUq/CakLeQzQa6gF03rc5KAGCaSxKoyoAXJO0u6rru+a1/cXXf/WdUH4Aei
         Gi8pPgdpY78ViLlZuLWg8QC8UKS49/26ZIcigN4YEm4G4L4kiPjkVq3YqlXaocHyDBPP
         u3JqGjLGPPm1b+GR02Yth1YLr+OVp6eYzisZmVqVuMHNFL0Cvuydh7NloYY0Gest1r+I
         ZQZw==
X-Gm-Message-State: AGi0PuY4XEzZxnTjIADSZkTlZ+yXzqu2IBu87SOzVP+lPBhwLQIKAhT0
        xppHuNfressVFjovLP8pHd8=
X-Google-Smtp-Source: APiQypIFyWKi3vLABZNQO7VIsJF4PNRyAB4S2ec1HO//6VTVln/vV8HWeormMn8HvmMOcY17h6xLOQ==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr10371768wmb.112.1585940210147;
        Fri, 03 Apr 2020 11:56:50 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id j68sm13377870wrj.32.2020.04.03.11.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:56:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] of: reserved-memory: Support memory-regions property
Date:   Fri,  3 Apr 2020 20:56:38 +0200
Message-Id: <20200403185640.118569-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403185640.118569-1-thierry.reding@gmail.com>
References: <20200403185640.118569-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Implement the memory-regions property as the preferred way to get at the
list of reserved memory regions referenced by a device. For backwards-
compatibility, fallback to the memory-region property.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/of_reserved_mem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1a84bc0d5fa8..62a35422c28d 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -302,9 +302,9 @@ static DEFINE_MUTEX(of_rmem_assigned_device_mutex);
  * @idx:	Index of selected region
  *
  * This function assigns respective DMA-mapping operations based on reserved
- * memory region specified by 'memory-region' property in @np node to the @dev
- * device. When driver needs to use more than one reserved memory region, it
- * should allocate child devices and initialize regions by name for each of
+ * memory region specified by 'memory-region(s)' property in @np node to the
+ * @dev device. When driver needs to use more than one reserved memory region,
+ * it should allocate child devices and initialize regions by name for each of
  * child device.
  *
  * Returns error code or zero on success.
@@ -320,7 +320,10 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 	if (!np || !dev)
 		return -EINVAL;
 
-	target = of_parse_phandle(np, "memory-region", idx);
+	target = of_parse_phandle(np, "memory-regions", idx);
+	if (!target)
+		target = of_parse_phandle(np, "memory-region", idx);
+
 	if (!target)
 		return -ENODEV;
 
-- 
2.24.1

