Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F49C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3072D206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046414;
	bh=Q6Ia7usDOLuZ4bedNUL50Ce4q2NYsM6H3bmyAwXYQEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wPgA0M4sJeSvPAY8pe3zBZ3Jr68SZSsFHIF3cCuGD+wmbRbYjB2XDbbKVrT1zgz2q
	 qO4gr/RKbdN5G/PP1LRoWc+rIN9ywlWswQmt9dNPkG8dm5thOwtrr3s4vhLhZV7NRc
	 UTIvPyX/cC7IN99g11/jMtYgOpcnv8jOtKCNncs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441950AbgDPONc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898782AbgDPNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF2E20732;
        Thu, 16 Apr 2020 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044936;
        bh=Q6Ia7usDOLuZ4bedNUL50Ce4q2NYsM6H3bmyAwXYQEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKd51s+cnU6BNNvHfSlszHsj9tS93HSLQ8hJG6La/AqG5cpyb9dhLen2iuB8+OjVv
         WwqUPwLZ+R8QLAaisUN9UfGhowWcJo189+p+0Jx8UDruzddbMBoIleUKpPUlW2agbW
         +ka005hhL1jJxFNStbpfFhjFgKakFZcOfVKkMD9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 161/232] dm writecache: add cond_resched to avoid CPU hangs
Date:   Thu, 16 Apr 2020 15:24:15 +0200
Message-Id: <20200416131335.128511666@linuxfoundation.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

commit 1edaa447d958bec24c6a79685a5790d98976fd16 upstream.

Initializing a dm-writecache device can take a long time when the
persistent memory device is large.  Add cond_resched() to a few loops
to avoid warnings that the CPU is stuck.

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-writecache.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -872,6 +872,7 @@ static int writecache_alloc_entries(stru
 		struct wc_entry *e = &wc->entries[b];
 		e->index = b;
 		e->write_in_progress = false;
+		cond_resched();
 	}
 
 	return 0;
@@ -926,6 +927,7 @@ static void writecache_resume(struct dm_
 			e->original_sector = le64_to_cpu(wme.original_sector);
 			e->seq_count = le64_to_cpu(wme.seq_count);
 		}
+		cond_resched();
 	}
 #endif
 	for (b = 0; b < wc->n_blocks; b++) {
@@ -1770,8 +1772,10 @@ static int init_memory(struct dm_writeca
 	pmem_assign(sb(wc)->n_blocks, cpu_to_le64(wc->n_blocks));
 	pmem_assign(sb(wc)->seq_count, cpu_to_le64(0));
 
-	for (b = 0; b < wc->n_blocks; b++)
+	for (b = 0; b < wc->n_blocks; b++) {
 		write_original_sector_seq_count(wc, &wc->entries[b], -1, -1);
+		cond_resched();
+	}
 
 	writecache_flush_all_metadata(wc);
 	writecache_commit_flushed(wc, false);


