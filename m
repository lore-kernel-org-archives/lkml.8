Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B1E2080D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135342;
	bh=yDWefRkMe9qUEJoLyvTql1Q8OuXw7bj+6Z9/PVE7/3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPVceDlgq7X/S3KYoCfrf4NgDJdLryggjOq/cnOqcEAA2jz35K3u8iLFIx0cqaiZC
	 FzIH3vazyCn73PBuD4D7AnVRS+QqNdcx3Pk2Z8lnybiLo1L4STwpOhLkHaOuphv1t6
	 nBfFaJo4o4W63CLmX7hxEDYaFL7vdZ4nHkdjoQJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgGGPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729819AbgGGPWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:22:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E7320663;
        Tue,  7 Jul 2020 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135334;
        bh=yDWefRkMe9qUEJoLyvTql1Q8OuXw7bj+6Z9/PVE7/3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyhJLFzak/btwN+pMRO5GrS3Lhe7PRHkkoFFC3ucqgJcRjjtaPuJobmsRwkIFTcP+
         mZU92nNd1sOUNi9/OqX9lE89pPKsDSVHv7pjpv1ZPelOsdTVFyE8KVbQzniEIHYcB0
         5T7P2wq988B54FOWPIKdu2g6EAEXWtfz9ZPCAkxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 64/65] dm zoned: assign max_io_len correctly
Date:   Tue,  7 Jul 2020 17:17:43 +0200
Message-Id: <20200707145755.565283438@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

commit 7b2377486767503d47265e4d487a63c651f6b55d upstream.

The unit of max_io_len is sector instead of byte (spotted through
code review), so fix it.

Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target")
Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/md/dm-zoned-target.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -790,7 +790,7 @@ static int dmz_ctr(struct dm_target *ti,
 	}
 
 	/* Set target (no write same support) */
-	ti->max_io_len = dev->zone_nr_sectors << 9;
+	ti->max_io_len = dev->zone_nr_sectors;
 	ti->num_flush_bios = 1;
 	ti->num_discard_bios = 1;
 	ti->num_write_zeroes_bios = 1;


