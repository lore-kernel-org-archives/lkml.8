Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E8C55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D68520738
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+kyl4n3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDUViu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:38:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7FC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so6107wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QgHQYt+tSYmVX1FszAKxvpLA+NP+fPMv9Zm76RuSMDY=;
        b=G+kyl4n334TCZJ0kpD3OlF7g3uExQx5sGvCxzuEreMno1d9LZsTxQQGpRaQfmmcTr2
         +tNWGLmqgt6B9XK230gc9C0rx5dMZ6PYeF+uAQ+EMgrGmIS9E1F2f67NpK3jw0QSSEXj
         D+dum1sm57swdZ8Y65LkRCXCRRddFOcIurynbAnJyN3Ei1Xt6zN5CSQmvV4HFQKkQ8ny
         dk+hES3vuLPeXma1MCbv6ZJpXdf/HDk0crpKTwQlOhfFHnuzYtL/gIrvWVNCNLgUDrCr
         1GilaKl13y4DhBRJ2IlMM48Je6JjPuYSAgQ4S9ZTr7Umpfo8HbXFTUS5xdqAge8Ycugy
         EUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QgHQYt+tSYmVX1FszAKxvpLA+NP+fPMv9Zm76RuSMDY=;
        b=plhYI1wBE3IKd6GzgxmVtbWvJBdAeeerNtQYSkCo7+ootdlkViwBhR7jhT69Ycfrxe
         xcjlqrb7Bx+P+kNt94kUvo/kJJpRlpumA2yMnCDkT/mxo4cHzgsDI3DwNGKRf9NUg4p4
         qpeJFTyImFBBKpPf6QgLvMx1FeiodH7QTsLTsF6p2DR7Ijs5ZTZGkyoE1mh9FpbhNuX+
         xppsHzpGeffEda3ISA0R6u2lmp9Y04akUs/zBJaJHWIf5A3Xk5Gsws6YfTX79kQX7QqL
         KdvM6Dm7YGLozxq5TWzNNhhDS1k3cq0Ewb1EBSF63mG3+OpgMy2E19gQz+92w8zQanTB
         VO5A==
X-Gm-Message-State: AGi0PuZetmUbaNM4AYxurGfWkFAGFI8zZCVHlAu30mVR8x2Ik78wRo4N
        wc1UsSE0Ut/vGNPs/MIGvW4=
X-Google-Smtp-Source: APiQypLq6kd84+XIo3taeW1VrsqbybXePe+7oakneNj52RAHgTQ9SX7DCMV5m5610uW5+gYBcRYJ+Q==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr15160051wrp.193.1587505128647;
        Tue, 21 Apr 2020 14:38:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m188sm4989305wme.47.2020.04.21.14.38.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 14:38:47 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 1/3] mm/swapfile.c: found_free could be represented by (tmp < max)
Date:   Tue, 21 Apr 2020 21:38:22 +0000
Message-Id: <20200421213824.8099-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not necessary to use the variable found_free to record the
status. Just check tmp and max is enough.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 469ab417ed43..d203cdc6750a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -601,7 +601,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 {
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
-	bool found_free;
 	unsigned long tmp, max;
 
 new_cluster:
@@ -623,8 +622,6 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 			return false;
 	}
 
-	found_free = false;
-
 	/*
 	 * Other CPUs can use our cluster if they can't find a free cluster,
 	 * check if there is still free entry in the cluster
@@ -638,21 +635,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	}
 	ci = lock_cluster(si, tmp);
 	while (tmp < max) {
-		if (!si->swap_map[tmp]) {
-			found_free = true;
+		if (!si->swap_map[tmp])
 			break;
-		}
 		tmp++;
 	}
 	unlock_cluster(ci);
-	if (!found_free) {
+	if (tmp >= max) {
 		cluster_set_null(&cluster->index);
 		goto new_cluster;
 	}
 	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
-	return found_free;
+	return tmp < max;
 }
 
 static void __del_from_avail_list(struct swap_info_struct *p)
-- 
2.23.0

