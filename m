Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3EC3524E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D549720721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UOVYXCRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBCJKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:10:38 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50785 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBCJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:10:37 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so6050608pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdnNdnWJaDcUVCq0geRe2WaQj8c2WK+3ArcS2rroge4=;
        b=UOVYXCRF/dwVfkMz296E3J0RLNs+wrhtscM2WLQx4lk6yMElzwISgevk4+XQKZ+y6V
         qQ8jwMV/J9mo7H+NecThRw9nqL6wv1hnjBNkQfhHYEiNxIUSZ5yoDFoBryoz5XFsdOhp
         HMbIqXCzYjtJcfTQbl0LjPXzigxCuwm21l5fcM5hLp/SbPgWTvxOOEVB9QTaFcrp/xkQ
         u7n9rcJ4WwXaVTVV0hwbnl98dUm74f5xpMd/wRZ5xxdbtpOQd2gA2olp5x13GO70OtvK
         0LBOuia+qGKcu7BbsFIZnOHjxzZC4uCqprY7HEZUi0Uh49tmuKy1irn0U9luirZIW59x
         IPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdnNdnWJaDcUVCq0geRe2WaQj8c2WK+3ArcS2rroge4=;
        b=Wd3/O4z/mNaEuoHOsdpwLXVpnFkNmhRTvnPya/Q2vmm9vbSJUL/ECkmXSucEhhXVLz
         TJf8ZSuhwKpv2D+eeft2Wp19HIRIlKFald6PYLlUz8YKRuT+uqSKO/oA4mKP3Jvx84Jd
         BINsVOugC9Re+q5ABtF0+HRAiENykB0Z1qqndzXbr1XJyGwnLnf3PVozGWUPiOgORKdb
         bwDXAUW3+TpEYvYsdfVbrOq3WP08b2ROMC6xc7cphRb9Apsof69h94C7mRRwT/er/2Hi
         Q5JN4qMWyBMmWyAjFjFnppAZvy74dOUJMWMJWHWCnWGsVqDbCbB1L8GahZQ9DRl+Q3hw
         1bkQ==
X-Gm-Message-State: APjAAAVkxEPFWyxvAAEBmsW53ixZ0Ykf7mQjGufPmLl6vJvcNMv/wJeY
        12FacoaXW/y43mt3vwNAhh8baA==
X-Google-Smtp-Source: APXvYqwvYee9a5uw5VUUf+RdsWW8I+Awo/lkJG9Is5/tHstxlBEp+lghT9F7sKZzDVA6ixGfnzHjJw==
X-Received: by 2002:a17:90a:8a8f:: with SMTP id x15mr28788646pjn.87.1580721036957;
        Mon, 03 Feb 2020 01:10:36 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.googlemail.com with ESMTPSA id y64sm14300390pgb.25.2020.02.03.01.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:10:36 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
Date:   Mon,  3 Feb 2020 17:10:10 +0800
Message-Id: <20200203091009.196658-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device has no IOMMU, it still invokes iommu_need_mapping during
intel_alloc_coherent. However, iommu_need_mapping can only check the
device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iommu/intel-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 35a4a3abedc6..878bc986a015 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
 	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
+	if (!iommu) {
+		dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
 		return -ENODEV;
+	}
 
 	iommu_device_link(&iommu->iommu, dev);
 
-- 
2.25.0

