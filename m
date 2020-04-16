Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B50C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9F020774
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049668;
	bh=Tl/oh1lZ+Gp9rx75HeDyxdbaLetuQooaBMQefpYAtJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IFIgY/g/KaGIl49BGGIPgoPB1XwyqNuDYaLkHJMwY+VBqzNHbbwuhLPCNh2AE5b5q
	 piaz/HPKZvSWYVvRrq2riF5zRDFaCzEcageCV2cxSNhTk4PXCqkLPvxwumgNvdQX41
	 3IqxLxmunx/JMW1ss9ttiGaUAD4s8i8uAnB93GdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbgDPPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392371AbgDPNva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:51:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5439220732;
        Thu, 16 Apr 2020 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045089;
        bh=Tl/oh1lZ+Gp9rx75HeDyxdbaLetuQooaBMQefpYAtJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn5pkcAAD0CAZJDHW2WvphGIFZbmoczGpUTdTAHKKbkS2MBK7hvE0x7a0a7e5HHtr
         C5gFdUXlOy7YUUJrI+bityxMR1b3Ayf/82hmuXc2OvDu3eGKRteQTIv3Ug1UnpJBsE
         yClV1R1WT74ELR7lf3n3gpQR2FcQU5kZoc2lTBz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Liu <bob.liu@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 218/232] dm zoned: remove duplicate nr_rnd_zones increase in dmz_init_zone()
Date:   Thu, 16 Apr 2020 15:25:12 +0200
Message-Id: <20200416131342.752816897@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
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
index 5205cf9bbfd92..e0a6cf9239f1c 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1107,7 +1107,6 @@ static int dmz_init_zone(struct dmz_metadata *zmd, struct dm_zone *zone,
 
 	if (blkz->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		set_bit(DMZ_RND, &zone->flags);
-		zmd->nr_rnd_zones++;
 	} else if (blkz->type == BLK_ZONE_TYPE_SEQWRITE_REQ ||
 		   blkz->type == BLK_ZONE_TYPE_SEQWRITE_PREF) {
 		set_bit(DMZ_SEQ, &zone->flags);
-- 
2.20.1



