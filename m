Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAA5214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgD3VdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:33:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgD3Vc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:32:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4Qbu-1j4WWI3CFi-011OpV; Thu, 30 Apr 2020 23:32:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/15] hpfs: avoid gcc-10 zero-length-bounds warning
Date:   Thu, 30 Apr 2020 23:30:52 +0200
Message-Id: <20200430213101.135134-11-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200430213101.135134-1-arnd@arndb.de>
References: <20200430213101.135134-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TWAbVqd/FDjE8oAJK+F9iueSPdUXZs2izCsAi82xdsZEpMid81Z
 4o1bo/1WKSS/Qc8nbIrKiMjR8I1vIbcOx2Iv1XB718BxIq2NCRtcm9x+jbIUlNbPOmjjoLE
 djnCox6aEUHS4c6k+qdilFgUJXc3+oI0YtLoupsOkiV/n0xNlc1ITaxzG5CUmIfZ3sg2cly
 Rd7Qnq48cNnqUfp8PdtRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eIt6t0Sefk8=:tWznhMqdwignmUEUFcZ2eK
 kndC3BiLCSWAXDLQb7aJh94UIQwBK5wGMn0vZ2i+RJLUkrWSgZbBDmpoAhhuomJVubanxjvEL
 iqhSGmNsJd1jLD7kr/o9qjEEO4nAPvY5KxzKNe6tSUxgUa5rig/JLF9KSxQB8wt6jlses0eFb
 a1F0IG/ab3VUjGGzkReBRUQNxwuCaJDjFq/8TJ+38FlUb40mrWELUFe3q7He0EjZ+EwgTIiNc
 Pa68DrZwvzHwzLq2dFsQ3YnqzIjEs8bEp4H2WV7wTnkSFEsxHQB0VdEYpyvTWSezMTtHlgoQG
 3KLTYHaP5CfgpyNyeydy2QHK2L0D9ZaSkPvmKR1DHfH5BX8ak5WakgM65A0EWBavSmifIVTYD
 e6JTYHwpWjisZICH3qPwlECRJyIZyXLotfdT98k34oaMzJs5fFL87I9oA7dvx7IPkN6yqlqJ0
 g5VHo3xyWSZjIbnVuLb7QwGbp5l06PWwSlJqt3u+T+FZV2qNdyNPURrDDKAySiG+AZv6O6BDC
 aMPqgvPOqnreyCsGhK3DLCf7RGNqG8VEgqCgqS51Xy0nbWFbMa58cUKAxQVjL4EAKGSPtsQwl
 bbTFRQFYSR3qM7RKX3C7JoFxh1wIxBX8fZfRUFw9jBilgta3z9q8p//f68gB2D2N6w2XLvaq2
 snEYHbLyNwLKN31Wwt8OGIaGudyLAvhO6YKIGM6EX3pkagCDob/HOgJEb31EXruR0aH2au4V3
 3f9yNtmaj0Btoy8rluWG+Z0h23rNIB0j3l0GU+VrEQGEczgAvY32LQaEceUO4JLXvqkeUHK+7
 WXfkZrHUcs/toSho+vCgiM6cDMoa2Nkck7K3qKVZSA4goLCKsA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 now warns about accessing members of a zero-length array
field:

fs/hpfs/anode.c: In function 'hpfs_add_sector_to_btree':
fs/hpfs/anode.c:209:27: error: array subscript 0 is outside the bounds of an interior zero-length array 'struct bplus_internal_node[0]' [-Werror=zero-length-bounds]
  209 |    anode->btree.u.internal[0].down = cpu_to_le32(a);
      |    ~~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from fs/hpfs/hpfs_fn.h:26,
                 from fs/hpfs/anode.c:10:
fs/hpfs/hpfs.h:411:32: note: while referencing 'internal'
  411 |     struct bplus_internal_node internal[0]; /* (internal) 2-word entries giving
      |                                ^~~~~~~~

It would be nice to make it a flexible-array member, but that is not
possible inside of a union, so work around the warnings by adding
a temporary pointer that hides the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hpfs/anode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index c14c9a035ee0..55788ca7969f 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -200,14 +200,17 @@ secno hpfs_add_sector_to_btree(struct super_block *s, secno node, int fnod, unsi
 		brelse(bh);
 		a = na;
 		if ((new_anode = hpfs_alloc_anode(s, a, &na, &bh))) {
+			struct bplus_internal_node *internal;
+
 			anode = new_anode;
 			/*anode->up = cpu_to_le32(up != -1 ? up : ra);*/
 			anode->btree.flags |= BP_internal;
 			anode->btree.n_used_nodes = 1;
 			anode->btree.n_free_nodes = 59;
 			anode->btree.first_free = cpu_to_le16(16);
-			anode->btree.u.internal[0].down = cpu_to_le32(a);
-			anode->btree.u.internal[0].file_secno = cpu_to_le32(-1);
+			internal = anode->btree.u.internal;
+			internal->down = cpu_to_le32(a);
+			internal->file_secno = cpu_to_le32(-1);
 			mark_buffer_dirty(bh);
 			brelse(bh);
 			if ((anode = hpfs_map_anode(s, a, &bh))) {
-- 
2.26.0

