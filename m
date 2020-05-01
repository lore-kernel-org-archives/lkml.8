Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F97C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7A1E216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQEbCFSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEAVq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgEAVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:46:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C10C09B040
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:46:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h26so9062745qtu.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8gxTSUogDwuGLJulsmZ9RxF75CEfaqEdykWJgqsyHRs=;
        b=mQEbCFSG03FogeRAqzrIa13/XN1kbi5D36jDNukOmTu+o7J6EmE3NP2IKE+WPGx+0g
         bTQmHp2wZhUHtfw2mINbOZ1dZYOCazzFF1BI1FmmISZnM1ZJVMGCr0YXGbxU+nbjrVcE
         Qc5JwRo+yzKNBcg3vXMQEDn43yD0Z8OmqhX+t9E+VnurbZkiQdUGEZlgiKufJdQ/lxYb
         pKOvZ2bRvzzpHN1THbRMkZT3Wjfl59tHqNdw1mzlge1OzLMLkNmNJXMnt1xXSXAJ4DLy
         WYVofSHGHa1VvXWqdZAsGvPMP+fF1nKqH/QdoGNbdQr7BzPjnf4cRtZ1OlClxyootJEf
         rpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8gxTSUogDwuGLJulsmZ9RxF75CEfaqEdykWJgqsyHRs=;
        b=n8YKq7wNOBhJlOHEVgQOZpr8ukzbAWj8tcKNUivgRzusTeAZLZaBfugfMvNKHj1eWM
         wQniuu14+UpeomOooZ5BNPGBzEhkPZgm+OIybvs6U9lRoE1FANcoZ5O4s4DWzskC0Wpa
         CcwPvvhQUOEn9Ghohyv0GEuf3YVp4ClyvxgJuR+4lhyvNiH9c+D8AgtEJAp3NJqzVU0Z
         9GzMQT+r5yTTxdWVmn3+fuPrGbHWAQbDhqRA7sr2pi/WBh1C3A15FWBp3EhMzsDfenih
         O304OyO+DctyjrMgHJA5nLegErAodDtyUwTvQUBwivqW4UHHVwSVG4RwAyIVqgQ5nDyN
         k0gQ==
X-Gm-Message-State: AGi0PubHGfSpwkupxnz8MkDCma+2UkV+YUUJzGBkafrSjGf5iQxLp42Q
        yUlJrIsXkJP38ZfHJ/1hc2Mqdg==
X-Google-Smtp-Source: APiQypIIqwtR3OM/3zGi5DIPfwsyDFHMqqlj+kjboPAogLyhmOkseCui/dghUIqb4bkEfE9iB3tLOg==
X-Received: by 2002:ac8:46d0:: with SMTP id h16mr6146683qto.242.1588369593085;
        Fri, 01 May 2020 14:46:33 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm3470982qti.47.2020.05.01.14.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 14:46:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 2/4] net: ipa: redefine struct ipa_mem_data
Date:   Fri,  1 May 2020 16:46:23 -0500
Message-Id: <20200501214625.31539-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501214625.31539-1-elder@linaro.org>
References: <20200501214625.31539-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipa_mem_data structure type was never actually used.  Instead,
the IPA memory regions were defined using the ipa_mem structure.

Redefine struct ipa_mem_data so it encapsulates the array of IPA-local
memory region descriptors along with the count of entries in that
array.  Pass just an ipa_mem structure pointer to ipa_mem_init().

Rename the ipa_mem_data[] array ipa_mem_local_data[] to emphasize
that the memory regions it defines are IPA-local memory.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sc7180.c | 10 +++++++---
 drivers/net/ipa/ipa_data-sdm845.c | 10 +++++++---
 drivers/net/ipa/ipa_data.h        | 13 +++++--------
 drivers/net/ipa/ipa_main.c        |  2 +-
 drivers/net/ipa/ipa_mem.c         |  9 +++++----
 drivers/net/ipa/ipa_mem.h         |  3 ++-
 6 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index 042b5fc3c135..f97e7e4e61c1 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -193,7 +193,7 @@ static const struct ipa_resource_data ipa_resource_data = {
 };
 
 /* IPA-resident memory region configuration for the SC7180 SoC. */
-static const struct ipa_mem ipa_mem_data[] = {
+static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
 		.offset		= 0x0000,
 		.size		= 0x0080,
@@ -296,12 +296,16 @@ static const struct ipa_mem ipa_mem_data[] = {
 	},
 };
 
+static struct ipa_mem_data ipa_mem_data = {
+	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
+	.local		= ipa_mem_local_data,
+};
+
 /* Configuration data for the SC7180 SoC. */
 const struct ipa_data ipa_data_sc7180 = {
 	.version	= IPA_VERSION_4_2,
 	.endpoint_count	= ARRAY_SIZE(ipa_gsi_endpoint_data),
 	.endpoint_data	= ipa_gsi_endpoint_data,
 	.resource_data	= &ipa_resource_data,
-	.mem_count	= ARRAY_SIZE(ipa_mem_data),
-	.mem_data	= ipa_mem_data,
+	.mem_data	= &ipa_mem_data,
 };
diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index 0d9c36e1e806..c55507e94559 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -235,7 +235,7 @@ static const struct ipa_resource_data ipa_resource_data = {
 };
 
 /* IPA-resident memory region configuration for the SDM845 SoC. */
-static const struct ipa_mem ipa_mem_data[] = {
+static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
 		.offset		= 0x0000,
 		.size		= 0x0080,
@@ -318,12 +318,16 @@ static const struct ipa_mem ipa_mem_data[] = {
 	},
 };
 
+static struct ipa_mem_data ipa_mem_data = {
+	.local_count	= ARRAY_SIZE(ipa_mem_local_data),
+	.local		= ipa_mem_local_data,
+};
+
 /* Configuration data for the SDM845 SoC. */
 const struct ipa_data ipa_data_sdm845 = {
 	.version	= IPA_VERSION_3_5_1,
 	.endpoint_count	= ARRAY_SIZE(ipa_gsi_endpoint_data),
 	.endpoint_data	= ipa_gsi_endpoint_data,
 	.resource_data	= &ipa_resource_data,
-	.mem_count	= ARRAY_SIZE(ipa_mem_data),
-	.mem_data	= ipa_mem_data,
+	.mem_data	= &ipa_mem_data,
 };
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index 7110de2de817..51d8e5a6f23a 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -246,14 +246,12 @@ struct ipa_resource_data {
 
 /**
  * struct ipa_mem - IPA-local memory region description
- * @offset:		offset in IPA memory space to base of the region
- * @size:		size in bytes base of the region
- * @canary_count:	number of 32-bit "canary" values that precede region
+ * @local_count:	number of regions defined in the local[] array
+ * @local:		array of IPA-local memory region descriptors
  */
 struct ipa_mem_data {
-	u32 offset;
-	u16 size;
-	u16 canary_count;
+	u32 local_count;
+	const struct ipa_mem *local;
 };
 
 /**
@@ -270,8 +268,7 @@ struct ipa_data {
 	u32 endpoint_count;	/* # entries in endpoint_data[] */
 	const struct ipa_gsi_endpoint_data *endpoint_data;
 	const struct ipa_resource_data *resource_data;
-	u32 mem_count;		/* # entries in mem_data[] */
-	const struct ipa_mem *mem_data;
+	const struct ipa_mem_data *mem_data;
 };
 
 extern const struct ipa_data ipa_data_sdm845;
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 28998dcce3d2..9295a9122e8e 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -778,7 +778,7 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_kfree_ipa;
 
-	ret = ipa_mem_init(ipa, data->mem_count, data->mem_data);
+	ret = ipa_mem_init(ipa, data->mem_data);
 	if (ret)
 		goto err_reg_exit;
 
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 42d2c29d9f0c..fb4de2a12796 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -12,6 +12,7 @@
 
 #include "ipa.h"
 #include "ipa_reg.h"
+#include "ipa_data.h"
 #include "ipa_cmd.h"
 #include "ipa_mem.h"
 #include "ipa_data.h"
@@ -266,15 +267,15 @@ int ipa_mem_zero_modem(struct ipa *ipa)
 }
 
 /* Perform memory region-related initialization */
-int ipa_mem_init(struct ipa *ipa, u32 count, const struct ipa_mem *mem)
+int ipa_mem_init(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 {
 	struct device *dev = &ipa->pdev->dev;
 	struct resource *res;
 	int ret;
 
-	if (count > IPA_MEM_COUNT) {
+	if (mem_data->local_count > IPA_MEM_COUNT) {
 		dev_err(dev, "to many memory regions (%u > %u)\n",
-			count, IPA_MEM_COUNT);
+			mem_data->local_count, IPA_MEM_COUNT);
 		return -EINVAL;
 	}
 
@@ -302,7 +303,7 @@ int ipa_mem_init(struct ipa *ipa, u32 count, const struct ipa_mem *mem)
 	ipa->mem_size = resource_size(res);
 
 	/* The ipa->mem[] array is indexed by enum ipa_mem_id values */
-	ipa->mem = mem;
+	ipa->mem = mem_data->local;
 
 	return 0;
 }
diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
index 065cb499ebe5..f99180f84f0d 100644
--- a/drivers/net/ipa/ipa_mem.h
+++ b/drivers/net/ipa/ipa_mem.h
@@ -7,6 +7,7 @@
 #define _IPA_MEM_H_
 
 struct ipa;
+struct ipa_mem_data;
 
 /**
  * DOC: IPA Local Memory
@@ -84,7 +85,7 @@ void ipa_mem_teardown(struct ipa *ipa);
 
 int ipa_mem_zero_modem(struct ipa *ipa);
 
-int ipa_mem_init(struct ipa *ipa, u32 count, const struct ipa_mem *mem);
+int ipa_mem_init(struct ipa *ipa, const struct ipa_mem_data *mem_data);
 void ipa_mem_exit(struct ipa *ipa);
 
 #endif /* _IPA_MEM_H_ */
-- 
2.20.1

