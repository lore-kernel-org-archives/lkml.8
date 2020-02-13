Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9A7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E16024676
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMkAGME7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgBMQkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39486 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgBMQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:19 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so7514071wme.4;
        Thu, 13 Feb 2020 08:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljIvDHLN6tog1gjQ51iNc2XMRU3cMi+uSkVVHu8cuT4=;
        b=OMkAGME7j7rQnbLnlKwKqvhjvo5FGigM7wlHU4CrcLnpiLC86ihdKcBsofYTSxPYRa
         KGW5vVaAF/GZ3G/ddvB9xGhznGLkrPRgmy1cagbrgJD4JfTiVEpTAZrru5VrHjeeaPWI
         kE4FOcM/lEx5lU7e3eD+mqvL3xOyFU1BQORJ26Q6jaH6IbjDtsO9XLK8oUVw478zdqa/
         peqvVcAUWFVhRbH9/zAv/g/e40YHVFdd6Zm8zBdbxlsYd8GAFHF+Va2g313xWjGqd/gX
         Ax+Hi+JHQVG0hbR23B73PHZWmAtYDIDUPCFX5cW8ktC2+XWiC1JDzhN4Ka03y8Fsh5cM
         /C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljIvDHLN6tog1gjQ51iNc2XMRU3cMi+uSkVVHu8cuT4=;
        b=brZMdueK+0D+dVEt0SSYwtrOQ2txdWQihFgONow/k5PV594m9AYEoyPyhSO6qAlh0b
         DsPwlY9E6JS0e62v0JvHabLDi9uZERZefupASyMvLDpfkKUJhYzBFslgEJyuP5hX/nNM
         zKSKa8omOOAevvAPksCA/SQS+7OpFPZ1ZnocP3DHAN/qtsaP77bPffwuelK2z733mAR7
         pAkiLuXsjLHqbJ7Ruv2+tV+y/ltMOVekNQMrdu12x0V5jLRZfvAbd4Qd8lsT7alY561P
         buK++8va0seUKmUFyaR/5gcNh7Lm5aqk+nsyqvLbIhnUz3zH+i8R7QqTWCH3lCVNyfkM
         gOwA==
X-Gm-Message-State: APjAAAW4Jcn350qukmjSStGfydoMvTqC8KwOp3TPBlhvrrR939+EuPnX
        PGdN5lZS15wy3VxU0rSM4+s=
X-Google-Smtp-Source: APXvYqw7sINzUbnoD5ydFKpKcLaCTZ30fHyF6HFAksiO/pDQK8NvJDQvWRxVCSqMtK3CJfsOF10GSg==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr6643132wmi.75.1581612017438;
        Thu, 13 Feb 2020 08:40:17 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y7sm3352850wrr.56.2020.02.13.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] iommu: arm-smmu: Get reference to memory controller
Date:   Thu, 13 Feb 2020 17:39:59 +0100
Message-Id: <20200213163959.819733-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213163959.819733-1-thierry.reding@gmail.com>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the memory controller framework to obtain a reference to the memory
controller to which the SMMU will make memory requests. This allows the
two drivers to properly order their probes so that the memory controller
can be programmed first.

An example where this is required is Tegra186 where the stream IDs need
to be associated with memory clients before memory requests are emitted
with the correct stream ID.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 drivers/iommu/arm-smmu.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 16c4b87af42b..862ea55018e8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2109,6 +2109,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	smmu->mc = devm_memory_controller_get_optional(dev, NULL);
+	if (IS_ERR(smmu->mc)) {
+		err = PTR_ERR(smmu->mc);
+
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "failed to get memory controller: %d\n",
+				err);
+
+		return err;
+	}
+
 	if (dev->of_node)
 		err = arm_smmu_device_dt_probe(pdev, smmu);
 	else
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 8d1cd54d82a6..d38bcd3ce447 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -18,6 +18,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/memory-controller.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -253,6 +254,7 @@ enum arm_smmu_implementation {
 
 struct arm_smmu_device {
 	struct device			*dev;
+	struct memory_controller	*mc;
 
 	void __iomem			*base;
 	unsigned int			numpage;
-- 
2.24.1

