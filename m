Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F4C38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC78121D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWi1xbRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDSBjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgDSBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:39:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D4C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so4514974edy.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BQFU3HkYECZtzmLCZGRzFVrW3CLq1ebiJ2ruTF8YJ+o=;
        b=JWi1xbRpg1gcYErF+rSn53PAiJKAfS7QbtMyFZ4RgGkL7u1vUcNQgkZ378kFXNRilg
         SdrSiY3vuCQiU+gV7fMtrgOxrT/saiVyvk46pIvPLSRfbC2ERmaiYh7Zj/im+axtnW2g
         vRPhUjuTseEEKI0RGvYSidchsVXWMNQO4fVBPLkjN3Tps4VrSqeG49kZ8DKWCZcjuk6U
         jKbOrKephz+itE7eW5fNOtSgP/QzkagitR0YlUaeM3GR+r8mLxN9xydsVvWuphKQXNsI
         yyWzjhoP/QmXOW05LRIGrM5blgbq0qVqjUk1KAdl4i3TpcKNfPao9KDuRyUSkgAzd938
         QbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BQFU3HkYECZtzmLCZGRzFVrW3CLq1ebiJ2ruTF8YJ+o=;
        b=RZJ2TL2unK25Oqy6ULzYV/m9hfev0ow3mJ6MDfIx8m/RS+dwMFx8bal2N5mpJqqnxt
         cepP18TbU7QEdM7zgZN65b3l4vsPAS0Sd/cIM2sNlDlhBJ5FEUf3W94lwAKQj2MYIInH
         ytm5SkcKddsuAVfzM7XL1nYEUHM98nxpgcNkr0ptYPNeUiG6dQwIHn+chIg4rP7mCr/g
         Q2NzYCW+yJr9OTZHRWhQ21eTwCvdf3mxB9Jy8YMhigBPGU/KvuZ7ZL+n2Dyz3/0Qdx+D
         e6/pFQLleZcprX0bbLItzs9BG7WeESYwsRLYXOLQL8ykREuioMgDv/eL3+5k8XkiqhxI
         AQkQ==
X-Gm-Message-State: AGi0PuYwSRnB0Dm8Q4tCB4ZvLFr7kOxAAdc0G6eJONSSbdJcqcWAbrT8
        OrUOUPa7Gzc+FCeMougiFD5VkoNK
X-Google-Smtp-Source: APiQypJJFRIBBVlp00jXau9ACyNbh3FER9denpX7MQqcJOLHpwlzdltDRqQr0Xkszo+o6+DdWKhGnQ==
X-Received: by 2002:aa7:d14e:: with SMTP id r14mr9159841edo.200.1587260372227;
        Sat, 18 Apr 2020 18:39:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r10sm396631edm.55.2020.04.18.18.39.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 18:39:31 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 4/4] mm/swapfile.c: move new_cluster to check free_clusters directly
Date:   Sun, 19 Apr 2020 01:39:21 +0000
Message-Id: <20200419013921.14390-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200419013921.14390-1-richard.weiyang@gmail.com>
References: <20200419013921.14390-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each time it needs jump to new_cluster, it is sure current
percpu_cluster is null.

Move the new_cluster to check free_clusters directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 07b0bc095411..78e92ff14c79 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -603,9 +603,9 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	struct swap_cluster_info *ci;
 	unsigned long tmp, max;
 
-new_cluster:
 	cluster = this_cpu_ptr(si->percpu_cluster);
 	if (cluster_is_null(&cluster->index)) {
+new_cluster:
 		if (!cluster_list_empty(&si->free_clusters)) {
 			cluster->index = si->free_clusters.head;
 			cluster->next = cluster_next(&cluster->index) *
-- 
2.23.0

