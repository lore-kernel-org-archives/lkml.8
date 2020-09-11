Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FDF20731
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inevjptb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKHTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgIKHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:19:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373FC0613ED;
        Fri, 11 Sep 2020 00:19:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so3978642pgd.3;
        Fri, 11 Sep 2020 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SS7jLbqMqo7oAIExIEmTdCQZIIujYEeMEKPzckwgOOc=;
        b=InevjptbbgvQ9h7Iyupif311WbVVYkJoovS5NtNBAZUpv+hJ+zfqvCsdzptDDDruor
         6IDBuQHCA7/TgfTD5CDBKJ3O0kqDVHJb9tApHoScRDHil3iMCL/Hns2vP1HOZk3mf45A
         hcx3d7tI3fITed6XgZdYLMuMj/An3/OK2jriLAqsYq8/zdun2109NEluu0z0wB2gPC3k
         lV8g/q9/jn3dRqkNk5DA8lnEVnqzqDJBoX6psH8H3nOMYmhcSa3/spdhunDwws5NYG19
         XuDDrRtvNnnXpKSW4p/9B+x8+/Eo7M2R+f8Wqwtar5JQGNh7q3Mcs1xpDHF8A0kMDyc3
         oBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SS7jLbqMqo7oAIExIEmTdCQZIIujYEeMEKPzckwgOOc=;
        b=BvwI9xxg4lnmIKvR38MLo4ujbTWy9Gehmz8KvWX+az1NsYVya1oFPZCbmm6MXE2JYN
         HPUK0eG8x6xzV/20MQ9vK18YeiF3CT1h2e/cD10KD5DZTxW5tZKQrd5nFYT1vbSNBb35
         LQXZqXHb5+zRoTxdEvbJs5phzmCC7FLnC3uDZNrsUy97PQ7zjB46Zu0lS2FHFrb+HMBo
         UydaqHZJ7qyz7crF/DwEeoE0WHhB8hudbzMXSEOrOTncpT8ZWfNB32eTbEn0nzN4i3L5
         H/UDaKxm5IqXbH0WrJ1VU8P+NMtJvGwZh2w/hJTCjGrztNVjJirsyggOyzSEjKns9bMY
         NicQ==
X-Gm-Message-State: AOAM532do0Ax6oGRWY+Lq/8Tt5GK2LAopaRd98pqoh2RjJIu18dSVM4U
        lnPz/k0T8IxBGYvsNTpg9HqbqGC5u+Q=
X-Google-Smtp-Source: ABdhPJxDnur/DWFdvxSNIUQJ+nJ1mk1yUkPO5xqZL5sS/HV+nD5vZh/pEnxJKHg5E+09d+0dPkUbxQ==
X-Received: by 2002:a17:902:bccb:b029:d1:9bf7:22f4 with SMTP id o11-20020a170902bccbb02900d19bf722f4mr1066840pls.27.1599808741034;
        Fri, 11 Sep 2020 00:19:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     joro@8bytes.org, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-tegra@vger.kernel.org, jonathanh@nvidia.com,
        vdumpa@nvidia.com
Subject: [PATCH 3/3] iommu/tegra-smmu: Allow to group clients in same swgroup
Date:   Fri, 11 Sep 2020 00:16:43 -0700
Message-Id: <20200911071643.17212-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be clients using the same swgroup in DT, for example i2c0
and i2c1. The current driver will add them to separate IOMMU groups,
though it has implemented device_group() callback which is to group
devices using different swgroups like DC and DCB.

All clients having the same swgroup should be also added to the same
IOMMU group so as to share an asid. Otherwise, the asid register may
get overwritten every time a new device is attached.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 50b962b0647e..84fdee473873 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -23,6 +23,7 @@ struct tegra_smmu_group {
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
 	struct iommu_group *group;
+	unsigned int swgroup;
 };
 
 struct tegra_smmu {
@@ -909,14 +910,14 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	/* Find group_soc associating with swgroup */
 	soc = tegra_smmu_find_group(smmu, swgroup);
-	if (!soc)
-		return NULL;
 
 	mutex_lock(&smmu->lock);
 
+	/* Find existing iommu_group associating with swgroup or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if (group->soc == soc) {
+		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
 			grp = iommu_group_ref_get(group->group);
 			mutex_unlock(&smmu->lock);
 			return grp;
@@ -929,6 +930,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	}
 
 	INIT_LIST_HEAD(&group->list);
+	group->swgroup = swgroup;
 	group->smmu = smmu;
 	group->soc = soc;
 
@@ -940,7 +942,8 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 	}
 
 	iommu_group_set_iommudata(group->group, group, tegra_smmu_group_release);
-	iommu_group_set_name(group->group, soc->name);
+	if (soc)
+		iommu_group_set_name(group->group, soc->name);
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
-- 
2.17.1

