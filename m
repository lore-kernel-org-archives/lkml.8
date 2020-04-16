Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01046C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF1FD2222C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044390;
	bh=q6vOwUl1sXL/FGDjN4Jr98kzcb7jhnz4R1KTPTxdtq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IMh9zLsVkIo1wbiIFoNKCCLUMNeHvG82aedhht7PJ/zkxfqsVlL2P5l3rPtHCYeMh
	 IlueScNOFtvL6/keJdcB93+yFwru5XyIo/IQvHn3KOLuorLAd2F2/lKtbt42LuSOWk
	 7eu5t40XdWFp55n0kNQ7tt0uldg/sV4BzL0EJKoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898001AbgDPNjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896350AbgDPNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:31:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED32E217D8;
        Thu, 16 Apr 2020 13:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043866;
        bh=q6vOwUl1sXL/FGDjN4Jr98kzcb7jhnz4R1KTPTxdtq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTkJ3wyOqScN96hRpiuzOevR3W4lv2IKWHOFxLRLV+jyXRw1r1VacyCaD9K1R7Jdt
         wixG4JZ3YQl8dKocgm6ooZc8LpmreZnGEqK6VVXpA2kSD6zvqEFQ3WiOrsKXxdd8pI
         dDa1+3XXFiZm/dtF2l8y3fZLRaEXUDUMJFbLo3+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Liu <bob.liu@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 133/146] dm zoned: remove duplicate nr_rnd_zones increase in dmz_init_zone()
Date:   Thu, 16 Apr 2020 15:24:34 +0200
Message-Id: <20200416131300.638366312@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Liu <bob.liu@oracle.com>

[ Upstream commit b8fdd090376a7a46d17db316638fe54b965c2fb0 ]

zmd->nr_rnd_zones was increased twice by mistake. The other place it
is increased in dmz_init_zone() is the only one needed:

1131                 zmd->nr_useable_zones++;
1132                 if (dmz_is_rnd(zone)) {
1133                         zmd->nr_rnd_zones++;
					^^^
Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target")
Cc: stable@vger.kernel.org
Signed-off-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-zoned-metadata.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 086a870087cff..53eb21343b11f 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1105,7 +1105,6 @@ static int dmz_init_zone(struct dmz_metadata *zmd, struct dm_zone *zone,
 
 	if (blkz->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		set_bit(DMZ_RND, &zone->flags);
-		zmd->nr_rnd_zones++;
 	} else if (blkz->type == BLK_ZONE_TYPE_SEQWRITE_REQ ||
 		   blkz->type == BLK_ZONE_TYPE_SEQWRITE_PREF) {
 		set_bit(DMZ_SEQ, &zone->flags);
-- 
2.20.1



