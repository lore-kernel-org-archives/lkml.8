Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9707EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714A02076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047239;
	bh=1m5wxyivcW2j67TdFd8cmYte2yfupQ9BTC223xGt5FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFqf1rc19UMTZRTSw948rdlrBEoimXfAZpSFpfgqLhWJihfPfaBLAY1ut5l+FkS0X
	 yPyMkzd3g9Sn0h7Ds+2D+pdjHRHFXp/aYO2+W7iO9ADa8Pl3QMImaE+1XTQM0cMbeB
	 z28Q59FZHJfMhmIUKsS8wyqJr56FwHPg7fx7h148=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgDPO1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898849AbgDPN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED5720786;
        Thu, 16 Apr 2020 13:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045554;
        bh=1m5wxyivcW2j67TdFd8cmYte2yfupQ9BTC223xGt5FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2F2xgcvaDoF6YQZAGJn3ffBBSfuYeek0FSXyxTP3mpmvOgh8I9nD7Ztx9rB/nCVe
         o5U6rhzdZcSZLBD7g6mMW6lglZcA54E7RyyA++TpuJMtMwg17ASuLlyZLrMbfSnfhB
         1VEjqPcaPEdYJLPac5EtbCaNkfbFfTIE3M7hG1Zw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.6 180/254] dm clone metadata: Fix return type of dm_clone_nr_of_hydrated_regions()
Date:   Thu, 16 Apr 2020 15:24:29 +0200
Message-Id: <20200416131348.897131217@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit 81d5553d1288c2ec0390f02f84d71ca0f0f9f137 upstream.

dm_clone_nr_of_hydrated_regions() returns the number of regions that
have been hydrated so far. In order to do so it employs bitmap_weight().

Until now, the return type of dm_clone_nr_of_hydrated_regions() was
unsigned long.

Because bitmap_weight() returns an int, in case BITS_PER_LONG == 64 and
the return value of bitmap_weight() is 2^31 (the maximum allowed number
of regions for a device), the result is sign extended from 32 bits to 64
bits and an incorrect value is displayed, in the status output of
dm-clone, as the number of hydrated regions.

Fix this by having dm_clone_nr_of_hydrated_regions() return an unsigned
int.

Fixes: 7431b7835f55 ("dm: add clone target")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-clone-metadata.c |    2 +-
 drivers/md/dm-clone-metadata.h |    2 +-
 drivers/md/dm-clone-target.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-clone-metadata.c
+++ b/drivers/md/dm-clone-metadata.c
@@ -656,7 +656,7 @@ bool dm_clone_is_range_hydrated(struct d
 	return (bit >= (start + nr_regions));
 }
 
-unsigned long dm_clone_nr_of_hydrated_regions(struct dm_clone_metadata *cmd)
+unsigned int dm_clone_nr_of_hydrated_regions(struct dm_clone_metadata *cmd)
 {
 	return bitmap_weight(cmd->region_map, cmd->nr_regions);
 }
--- a/drivers/md/dm-clone-metadata.h
+++ b/drivers/md/dm-clone-metadata.h
@@ -156,7 +156,7 @@ bool dm_clone_is_range_hydrated(struct d
 /*
  * Returns the number of hydrated regions.
  */
-unsigned long dm_clone_nr_of_hydrated_regions(struct dm_clone_metadata *cmd);
+unsigned int dm_clone_nr_of_hydrated_regions(struct dm_clone_metadata *cmd);
 
 /*
  * Returns the first unhydrated region with region_nr >= @start
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -1473,7 +1473,7 @@ static void clone_status(struct dm_targe
 			goto error;
 		}
 
-		DMEMIT("%u %llu/%llu %llu %lu/%lu %u ",
+		DMEMIT("%u %llu/%llu %llu %u/%lu %u ",
 		       DM_CLONE_METADATA_BLOCK_SIZE,
 		       (unsigned long long)(nr_metadata_blocks - nr_free_metadata_blocks),
 		       (unsigned long long)nr_metadata_blocks,


