Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F6C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1095F20786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045464;
	bh=9dyaT9wnAWhQSKmAiJwAuMsv2hIYneiLsOUo5frnMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RASxD4uqIox3lswC86Vyhgjgu/FCuyXJ93IJ1Qnt7zCZT0JR/Kuo+Q6YgwxcGREHj
	 M8bgwmsGborx7lqu0yfgLg2qBsTwykts74hKhiU4/mLkbyAr70kO1OD2grwvO4UXeW
	 T1LULoSVwl/4OqyvduWeQyXfLwwU2hhWrywcoVHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506758AbgDPN5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897943AbgDPNjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:39:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355272063A;
        Thu, 16 Apr 2020 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044360;
        bh=9dyaT9wnAWhQSKmAiJwAuMsv2hIYneiLsOUo5frnMTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3AtTKOOcI0g0c6D/On/Sj2muOcAVdg0kFfap/rtkIp5D3Of9WbNpq0eWjmiFWbAW
         oslhASLUXUqPGBwiH0Xr5+wdADpndPzOQ7RmE7nctnv0ODEEpH3zaEJ784iwceh1cE
         C7P1Itv3W81dKOB+iWS6rPKLts3y5kawjtklakv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikos Tsironis <ntsironis@arrikto.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.5 186/257] dm clone: Add missing casts to prevent overflows and data corruption
Date:   Thu, 16 Apr 2020 15:23:57 +0200
Message-Id: <20200416131349.554357030@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikos Tsironis <ntsironis@arrikto.com>

commit 9fc06ff56845cc5ccafec52f545fc2e08d22f849 upstream.

Add missing casts when converting from regions to sectors.

In case BITS_PER_LONG == 32, the lack of the appropriate casts can lead
to overflows and miscalculation of the device sector.

As a result, we could end up discarding and/or copying the wrong parts
of the device, thus corrupting the device's data.

Fixes: 7431b7835f55 ("dm: add clone target")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-clone-target.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -282,7 +282,7 @@ static bool bio_triggers_commit(struct c
 /* Get the address of the region in sectors */
 static inline sector_t region_to_sector(struct clone *clone, unsigned long region_nr)
 {
-	return (region_nr << clone->region_shift);
+	return ((sector_t)region_nr << clone->region_shift);
 }
 
 /* Get the region number of the bio */
@@ -471,7 +471,7 @@ static void complete_discard_bio(struct
 	if (test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags) && success) {
 		remap_to_dest(clone, bio);
 		bio_region_range(clone, bio, &rs, &nr_regions);
-		trim_bio(bio, rs << clone->region_shift,
+		trim_bio(bio, region_to_sector(clone, rs),
 			 nr_regions << clone->region_shift);
 		generic_make_request(bio);
 	} else
@@ -804,11 +804,14 @@ static void hydration_copy(struct dm_clo
 	struct dm_io_region from, to;
 	struct clone *clone = hd->clone;
 
+	if (WARN_ON(!nr_regions))
+		return;
+
 	region_size = clone->region_size;
 	region_start = hd->region_nr;
 	region_end = region_start + nr_regions - 1;
 
-	total_size = (nr_regions - 1) << clone->region_shift;
+	total_size = region_to_sector(clone, nr_regions - 1);
 
 	if (region_end == clone->nr_regions - 1) {
 		/*


