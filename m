Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92ADC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58A02064A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l8mddYZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgDQMkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:40:52 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19510 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgDQMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:40:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99a3630001>; Fri, 17 Apr 2020 05:38:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 05:40:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 05:40:51 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 12:40:50 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 12:40:51 +0000
Received: from moonraker.nvidia.com (Not Verified[10.26.73.163]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e99a3d10003>; Fri, 17 Apr 2020 05:40:50 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] soc/tegra: fuse: Update the SoC revision attribute to display a name
Date:   Fri, 17 Apr 2020 13:40:46 +0100
Message-ID: <20200417124046.26400-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587127139; bh=J65c/MvkuaR8eKoN8yHmhT2faFLCAxi0NFqBMduNorA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=l8mddYZixe3VXl3ZUEHPqOeON88seL17bjq9mzY4KKSixB2p+mEZDsGr8EmKrHNhT
         xcKdi5Ddhstp2a7p9Ze38tMDtI4VZzdgZzxhUlPR8z/GG8SZW1xhfFIxXtV4hvdVa4
         csrmDRZLV3bRUBynsgPs/ySzbZUS/plL+xAqKJKo2qTnY+NlHV2h/DxUq9SCREYWjP
         Z7hcyHSrYtnLiPL3qW8zII976N3c1to2Ju7H5GyhleqYI3mdoc0EPaZhVUEMxJKoUr
         JfvUgsC61LFmQXnWlmcfDLjCQgisE5qw9hFdFG3eqcClvAQX6SDJLcb7Qy3iyCPZxy
         +3n1epR+K65IA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SoC revision attribute for Tegra devices displays the
value of the enum associated with a particular revision. This is not
very useful because to obtain the actual revision you need to
use the tegra_revision enumeration to translate the value.

It is more meaningful to display a name for the revision, such as
'A01', than the enumarated value and therefore, update the revision
attribute to display a name. This change does alter the ABI, which
is unfortunate, but this is more meaningful and maintable.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index db65ddb6a5d2..d1f8dd0289e6 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -363,7 +363,8 @@ struct device * __init tegra_soc_device_register(void)
 		return NULL;
 
 	attr->family = kasprintf(GFP_KERNEL, "Tegra");
-	attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_sku_info.revision);
+	attr->revision = kasprintf(GFP_KERNEL, "%s",
+		tegra_revision_name[tegra_sku_info.revision]);
 	attr->soc_id = kasprintf(GFP_KERNEL, "%u", tegra_get_chip_id());
 	attr->custom_attr_group = fuse->soc->soc_attr_group;
 
-- 
2.17.1

