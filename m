Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE2206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944180;
	bh=/+iVkgbg7YnWofcIMORaVGvFwvXOMaHzu/f7qNOKlqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VShguRDLmI8GiSD+SJ7hNPvMFlxClo9YsKaY95xZYfeJYoF1b0GRjsY9+Kv+P0cmE
	 vEtKq7qHO4/rOi+k2E4G7KN0hLdOadpFjVh0umAAO9r/TPHE+OgUr5dm1UJJ/SQ5+5
	 6A3heGXPph1jLSaVDxkbcnZM7pJPweXLw34dcG8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391007AbgFWU3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390979AbgFWU32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 396D2206EB;
        Tue, 23 Jun 2020 20:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944168;
        bh=/+iVkgbg7YnWofcIMORaVGvFwvXOMaHzu/f7qNOKlqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wp4TdiSP0dCeDdltEIjE17ys+U/ZnSp3s4pono3R52JStTrVi+3Y15+r+97q4cC6u
         K6OZlJ4EP0RnJwagDoNhCEBrVkqR/yebX6tZA4rF0j/LJFlEd6pgKQAr2SbqDuqnAi
         JnKTuzRRcbJiSlUsIXSWvSRyEODE8iUDfyoNHsGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 169/314] dm zoned: return NULL if dmz_get_zone_for_reclaim() fails to find a zone
Date:   Tue, 23 Jun 2020 21:56:04 +0200
Message-Id: <20200623195346.943605131@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 489dc0f06a5837f87482c0ce61d830d24e17082e ]

The only case where dmz_get_zone_for_reclaim() cannot return a zone is
if the respective lists are empty. So we should just return a simple
NULL value here as we really don't have an error code which would make
sense.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-zoned-metadata.c | 4 ++--
 drivers/md/dm-zoned-reclaim.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index e0a6cf9239f1c..e6b0039d07aa8 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1589,7 +1589,7 @@ static struct dm_zone *dmz_get_rnd_zone_for_reclaim(struct dmz_metadata *zmd)
 			return dzone;
 	}
 
-	return ERR_PTR(-EBUSY);
+	return NULL;
 }
 
 /*
@@ -1609,7 +1609,7 @@ static struct dm_zone *dmz_get_seq_zone_for_reclaim(struct dmz_metadata *zmd)
 			return zone;
 	}
 
-	return ERR_PTR(-EBUSY);
+	return NULL;
 }
 
 /*
diff --git a/drivers/md/dm-zoned-reclaim.c b/drivers/md/dm-zoned-reclaim.c
index e7ace908a9b7d..d50817320e8e3 100644
--- a/drivers/md/dm-zoned-reclaim.c
+++ b/drivers/md/dm-zoned-reclaim.c
@@ -349,8 +349,8 @@ static int dmz_do_reclaim(struct dmz_reclaim *zrc)
 
 	/* Get a data zone */
 	dzone = dmz_get_zone_for_reclaim(zmd);
-	if (IS_ERR(dzone))
-		return PTR_ERR(dzone);
+	if (!dzone)
+		return -EBUSY;
 
 	start = jiffies;
 
-- 
2.25.1



