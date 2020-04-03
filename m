Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9B5207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsbqPZWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgDCS5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:57:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34816 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgDCS44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:56:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id i19so8875529wmb.0;
        Fri, 03 Apr 2020 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5IL8lJ44sLe63OqUkMG0FhluuzRjw9oYGvmFBSOKwc=;
        b=KsbqPZWt4iG8tl6/L8/xJaRgrb6adiEVUu2L8vrCblQ8fd9bys7mAmKFOvr+bxRoMr
         +bDH2zrvm7Z2S/gX4YYLjke+OsongeJwD86C5kwgwp2Agr4A9xO+p+pnCfa3Qz+ag4EM
         p/vTcaCkN9B7XuD3IjFojy/ChethSaBLv/jmE2/vEuDNwOpXeDT5dFLvt3scVSItAbMZ
         BJTrL2++yFlE/XMAYGMgroG6ADcp9uxXQ7tPxuwh+BPNaNDyJ1gmOP6lLV32sK2BKIHa
         VvOfWNIs8GXKvNOzth/W+tbinQTOCL79b7WCZxgtwOfO1fzbY3Sn0FfgBPjEy0iIPFCE
         SmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5IL8lJ44sLe63OqUkMG0FhluuzRjw9oYGvmFBSOKwc=;
        b=okrtxupXRz4dpCU1kQBes2kh1hk9eGvB8vBM8VZQviECIcdlOiyKAkbcYMd8UzMLrf
         rwcKgplhZgK4dK+5mn5kYgxT4zv3Sd8GsRV6y008BbYQ5m8nUHNZhfc9XNd378cI9OlG
         wIaiyCQF4uWSLQPFDy3j0t2etGZAyqLMECdRMeXHyDRk3M65rgxpAB03csy7bpgNrlH6
         RleyBzvLIwmHHkcRUiMKsFUylNNc3FYC/I48EB7Xb7+6YgjcUOG4LQ5yK+H5P3hPkUBQ
         HcaYPYc8CMRydf4AOelIOed6xJNgfq4D2c19vSPrLBPHpD9hFB3BCjP7ugIn8JdPfTDe
         57fg==
X-Gm-Message-State: AGi0PuYlBGdT+1kJxIzdFKVjvkdqcIY3Mfteomb+01YAjO/kwJ0qhZp+
        /bbG//WHb0Dl91a9dxA+Bhs=
X-Google-Smtp-Source: APiQypISdK/p0hNwYPL/cpMcWbAc5HTuGMWpnIvfl8NPGhTj5NckXqVCmuYf7O/Myd6yrS8kfdvHfA==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr10587211wmd.159.1585940214263;
        Fri, 03 Apr 2020 11:56:54 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id t8sm11904135wmi.43.2020.04.03.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:56:53 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] of: reserved-memory: Support multiple regions per device
Date:   Fri,  3 Apr 2020 20:56:40 +0200
Message-Id: <20200403185640.118569-5-thierry.reding@gmail.com>
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

While the lookup/initialization code already supports multiple memory
regions per device, the release code will only ever release the first
matching memory region.

Enhance the code to release all matching regions. Each attachment of
a region to a device is uniquely identifiable using a struct device
pointer and a pointer to the memory region's struct reserved_mem.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/of_reserved_mem.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index dae70b147552..3ad24df0f673 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -388,24 +388,22 @@ EXPORT_SYMBOL_GPL(of_reserved_mem_device_init_by_name);
  */
 void of_reserved_mem_device_release(struct device *dev)
 {
-	struct rmem_assigned_device *rd;
-	struct reserved_mem *rmem = NULL;
+	struct rmem_assigned_device *rd, *tmp;
+	LIST_HEAD(release_list);
 
 	mutex_lock(&of_rmem_assigned_device_mutex);
-	list_for_each_entry(rd, &of_rmem_assigned_device_list, list) {
-		if (rd->dev == dev) {
-			rmem = rd->rmem;
-			list_del(&rd->list);
-			kfree(rd);
-			break;
-		}
+	list_for_each_entry_safe(rd, tmp, &of_rmem_assigned_device_list, list) {
+		if (rd->dev == dev)
+			list_move_tail(&rd->list, &release_list);
 	}
 	mutex_unlock(&of_rmem_assigned_device_mutex);
 
-	if (!rmem || !rmem->ops || !rmem->ops->device_release)
-		return;
+	list_for_each_entry_safe(rd, tmp, &release_list, list) {
+		if (rd->rmem && rd->rmem->ops && rd->rmem->ops->device_release)
+			rd->rmem->ops->device_release(rd->rmem, dev);
 
-	rmem->ops->device_release(rmem, dev);
+		kfree(rd);
+	}
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_device_release);
 
-- 
2.24.1

