Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19872076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047216;
	bh=cOdDWYDw+GJ+hRmAPg16sAWISZrCcsqiTeYFKrelNr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffuUvd4yfOWe5L904yu9EpaciKG4mJIFi48G3e8XJZ17S1IJTSNdfwJiLzetIW3Rs
	 Tv0WcJsIqjZCROFJDcmAiUGwZ9ZoouBWG12nDT7GVrnZix1GELx5tKMejujypD9BPd
	 c7qn3QGu/LNPwm0MQXjp+mokFo6QdZueqg26nxaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgDPO0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894549AbgDPN66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE3A20732;
        Thu, 16 Apr 2020 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045537;
        bh=cOdDWYDw+GJ+hRmAPg16sAWISZrCcsqiTeYFKrelNr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMahRcEstcT3xEaELcRoeo9UmNq927aZW8msgLNaXnuks4xyeZV7xi3e2q93qzkzo
         oprO77WGW3M0tnYEadovtiRZabj4Wa1NxwsPnpffrJ+vV9CWi+c+qA9uCZGuP2z8JI
         obxCOEzhJsiVWQGBXmRKNom5preLKCivRknH328c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.6 174/254] dm integrity: fix a crash with unusually large tag size
Date:   Thu, 16 Apr 2020 15:24:23 +0200
Message-Id: <20200416131348.189769005@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit b93b6643e9b5a7f260b931e97f56ffa3fa65e26d upstream.

If the user specifies tag size larger than HASH_MAX_DIGESTSIZE,
there's a crash in integrity_metadata().

Cc: stable@vger.kernel.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-integrity.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1519,7 +1519,7 @@ static void integrity_metadata(struct wo
 		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		char *checksums;
 		unsigned extra_space = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
-		char checksums_onstack[HASH_MAX_DIGESTSIZE];
+		char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		unsigned sectors_to_process = dio->range.n_sectors;
 		sector_t sector = dio->range.logical_sector;
 
@@ -1748,7 +1748,7 @@ retry_kmap:
 				} while (++s < ic->sectors_per_block);
 #ifdef INTERNAL_VERIFY
 				if (ic->internal_hash) {
-					char checksums_onstack[max(HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
+					char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
 					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {


