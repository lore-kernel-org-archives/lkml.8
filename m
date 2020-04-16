Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D7C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27571206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048472;
	bh=LAIjssrxcqhHTuaqxyWX25CGsFD7yghpLh18RT6Ivr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y3z8/R1/29pZSw/1ZkV2Z+Sx95xo2/bD4vrPCt8fU22Smvv+39qYddhAXVsQ0lHnn
	 Kku5y6AoHA+Ri3r4leNJwE4Lv2SkVr0srC2NEYv/kJhnMItmSatlQX/vz/oRRh63Pk
	 YhFryO37sznRTKBAwrFvDnXxAQ4VE/Gi/wdiSdWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394697AbgDPOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgDPN7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:59:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D6721744;
        Thu, 16 Apr 2020 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045542;
        bh=LAIjssrxcqhHTuaqxyWX25CGsFD7yghpLh18RT6Ivr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JakRnOuGYu9+oi15R36wVpixEneaBWE1dktxllpHlOmY5obJygDKHR8O3HO4EfuyQ
         S0sWzeh5UnWUzXkiC5Aw67OtLvs4JBpNCZIz4MMSNlh+B1qV0aXBibMh18fTmPqM2K
         2FjIAQGIdwjwxn5H5kPIMo6cbQwKlG/myGVg42xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Liu <bob.liu@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.6 176/254] dm zoned: remove duplicate nr_rnd_zones increase in dmz_init_zone()
Date:   Thu, 16 Apr 2020 15:24:25 +0200
Message-Id: <20200416131348.412005581@linuxfoundation.org>
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

From: Bob Liu <bob.liu@oracle.com>

commit b8fdd090376a7a46d17db316638fe54b965c2fb0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-zoned-metadata.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1109,7 +1109,6 @@ static int dmz_init_zone(struct blk_zone
 	switch (blkz->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
 		set_bit(DMZ_RND, &zone->flags);
-		zmd->nr_rnd_zones++;
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
 	case BLK_ZONE_TYPE_SEQWRITE_PREF:


