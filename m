Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC94C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FECD2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shw0t8B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgA2RAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 12:00:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36721 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgA2Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so76880pgc.3;
        Wed, 29 Jan 2020 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHjjsiMv1wzBzYyD+HE2PIrBR1oeknOAP7k+Y37wTOU=;
        b=shw0t8B3zA6CFyI1x/5Y4QVs4mRC4KcQuPyKBA/kKA/pBp5R3adOcDf+e8sY/1XebQ
         nuR793bgVlDQfNjsSd8SYIrZziZmqY+enjkFZ/ndySx/mJ2S2BWlg7CTzhkAJltN4yW1
         YvIA4zjInhJewzLRZXwgyzGbUzhhWj4pS52a3hOgjW4beVUctm/BaxLXqWXmH592ycZ3
         iwLlUEFamzMt0nogbi7KDvOQI/6h3ACnDHhWZB7SDmj8p0IDvCyZRM0J0TXDFTIegn0d
         txtdOIrQdDxD01YEUM/4eBjlN8Cjf3zafwyWwZBDHWpH20NHXUZbcB2bPYE/LZg560FK
         TPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eHjjsiMv1wzBzYyD+HE2PIrBR1oeknOAP7k+Y37wTOU=;
        b=HCTKMPHlhZINj2CRXrx/GkEJKduDvSlX4OUUwmnO7wp+cSbDO/C0EntMFFo8nB1Bts
         qSw1qp3qY0wnpb9wWCtKG0WtIsSLMJslVcjWI56lhoZKeShJYzSVg+ykCJ6ZpAXWl0sM
         exDU+2USGhq10B9qnbKyLmZ5vAFVMB1D7d9L4YZQ3Lce/0JLr27VUcygquMljCME4upS
         QheIDh94KcvGh6F5bB3eJmCWDIErcGfhQjUyr4s6DxEc8bFS6cqH2YylspqHhQH95/w0
         5lKLmoIcGRiBd06YDB2hC2HhfYMhkqCn1r22NUgO0b0akvbVB6hu3ShpYktFhvHl1zEA
         /Mvg==
X-Gm-Message-State: APjAAAWLl4YTBpfD/FCL/slkPsA0Oxc/kOQTcH5OeZebuPQ9GRBKjyEb
        0AH9RAcZNoiRqjLnIRvsQzE=
X-Google-Smtp-Source: APXvYqxABWPyCjxgqwnirseesvhmXcgODMGoWG64H+djLbHYA5lVIEhFjUKzaCXD/ZciOPEJSZoA6A==
X-Received: by 2002:aa7:8bcd:: with SMTP id s13mr518903pfd.234.1580317197984;
        Wed, 29 Jan 2020 08:59:57 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:57 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 12/19] staging: exfat: Rename variable 'UsedClusters' to 'used_clusters'
Date:   Wed, 29 Jan 2020 22:28:25 +0530
Message-Id: <20200129165832.10574-13-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrecnes of identifier "UsedClusters" to "used_clusters"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2c42519d5eba..2242cf1fdb4a 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -246,7 +246,7 @@ struct vol_info_t {
 	u32      cluster_size;
 	u32      num_clusters;
 	u32      free_clusters;
-	u32      UsedClusters;
+	u32      used_clusters;
 };
 
 /* directory structure */
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 335bf39aa171..4b8ffb8ab557 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -497,8 +497,8 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	info->fat_type = p_fs->vol_type;
 	info->cluster_size = p_fs->cluster_size;
 	info->num_clusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
-	info->UsedClusters = p_fs->used_clusters;
-	info->free_clusters = info->num_clusters - info->UsedClusters;
+	info->used_clusters = p_fs->used_clusters;
+	info->free_clusters = info->num_clusters - info->used_clusters;
 
 	if (p_fs->dev_ejected)
 		err = -EIO;
@@ -3351,8 +3351,8 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 		info.fat_type = p_fs->vol_type;
 		info.cluster_size = p_fs->cluster_size;
 		info.num_clusters = p_fs->num_clusters - 2;
-		info.UsedClusters = p_fs->used_clusters;
-		info.free_clusters = info.num_clusters - info.UsedClusters;
+		info.used_clusters = p_fs->used_clusters;
+		info.free_clusters = info.num_clusters - info.used_clusters;
 
 		if (p_fs->dev_ejected)
 			pr_info("[EXFAT] statfs on device that is ejected\n");
-- 
2.17.1

