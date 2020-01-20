Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155AC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071412077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="SGZ/rsEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgATI5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:57:33 -0500
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:37612
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbgATI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579510649; bh=zuUeC+q1lHGrclRsJn5X44Wy5fQ7zVbOLjUy1OQMpkE=; h=From:To:Cc:Subject:Date:References:From:Subject; b=SGZ/rsEMQGXmDTUASSxzKfrX8sJ8tnxyZoScQDBoCN5J77IEKwj/MLHkRbGykacDMw4pcG0CYvKxe+01meJzuZVvrs7+CtAVE317uVchTdhlEtLpQ2H8QyBiMfcNwmQv7lP7dPz2gAK2Fd8jeRK6AJlBUwgCXRF5reil3jNCWlmawYGItn6ao3eQqMV/e943Ft9ijjxg+y9nYcyGdzuEgzHJzsO40n9f9VU4J9RDYx7qHC41ho+Rl8GvQLTa2hyNx0gPqSVH+bP6NsCsBq1sIffC8AN5Vpt3Ixi3gGQNLxR0jkAjzDkRoAvBLIu5ZR77uJcRVSYldcnSaSfcEtRxbg==
X-YMail-OSG: UYRY3WkVM1k2NrL2u1xuPI5eI1iQ3NMoxPiM1CsVwoFyPPxW479fmMGaXdQ3.uq
 qc9DJj86ytjn44cq7CbtfrnsKCRtzKQgD24kKDKEKmGFgPdat81r.1uyUjsKbeTwysr55Q9LeTuB
 zdkW.Mpn_HjDkeHfXuD6vFl2TMjfd_hbRQiAinrk3CvWCTicBaoiAAw338BZhNJLIE0UhOwYPjkw
 FY42jOh1D7YI7ne3u7bCeY1gdNKe6skHlnKnVGwQxdgJmfF3R1m_zw9AdiaRYlm9WeDraBg5OJd6
 8UDHVSUNaiue9xCYAzgGH3LGtIBHY2ZwVIgXEb_1hVio8FuFcn7Op5zPH5oKimmCclKNidTtw082
 w6n3_vBllI1oGjRAd9CR0pHbNC_iyd3t.kQ6pmYdFCEaEIDe7aXFuSKSE8Rh7TgtAjjfcSnI.wPI
 Jt4S9zew1WPBnH07oGbTguCnX7IjXoP3T_HAFLi_Yr3.zhf9hmqMJAZC.plijHe5AuoVpG10995n
 MUrYOgvU3noPe.ZcnGFIjW.emzIUDVXVFf11qBYW.MsEA7EOC2iIbaVg7oPNZ46.9pQ4_avNGrYG
 r9LujY0D.jR.VkY7Ac_KOzGxu0mz_DRt_QDknYtCGoaUcxnBmLeqo_MqGr5XRuYetuECijf55Av6
 wqFr4ZcoohRICGDHgE6RUvxXiqyYCFV7tF7DdBcWBtViZyLEG9gnkrhFk6m8vjIg2nbVESBJtm7g
 2WzkriJlUhxXHURPckoW0uyosAMrEtEiyCua9BIHRNdazZbWQQLzXcYzcIpPucZWjt7gIPIxDIDU
 7aWGu7buhGz6VC1ehX.UGH.x5zaLSrtpyaxB8OKnzAX1Y_h3wPTkFgoL5h.jB.J00498m6jQAUrb
 zwQfudcQQ3bFGRY3EqZ7UN1TiOi.8CGqLYnaB6pbLR2U9CqCRsLvQSitJVWUM3yEE4ibDsNNkzl4
 fAAvVEYhVrK1KeZz7ECZs5buZIZd6Q10wwEeuiOo6sgcQIldyrgGFX1VoE4LMw1XqwutpshdnfoB
 9CjC9vj7oc10mydOhKOIj_nB00ZWHK2ZZjlOSRloQ2Wm8GdROYCqmbPQuVwM0EL5RioodkuqMvC1
 0aRTkWjfB0nWJGEXVI2E9PVUd33s9bGtZQKN4vBO5KjwXJyPDur_TDpy.8vTrVK48qg_pu.Fu_HM
 neVWcyRVb_mfYdqy22k5mPh3Yn.hH909yuqZjFQrRRBYSAhN6SPSit0KAgMYfhOwWt4YYdA08tp9
 DoSNM3SNE..p7vTKQGEf0a95J44GdBD3ou22738oa2AyEODVg07mJaYlsjt9LI7.X.aqr9LfXZg4
 h2do_EUrLZl0QN8e_7bVSO4VlC8rvArdp2KeGutIdn0spdq4i9Teqa6LlxKUzYGsDlNY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 20 Jan 2020 08:57:29 +0000
Received: by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 108e935cc9711f548eb3f10aaf32bbda;
          Mon, 20 Jan 2020 08:57:24 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 1/2] erofs: fold in postsubmit_is_all_bypassed()
Date:   Mon, 20 Jan 2020 16:57:08 +0800
Message-Id: <20200120085709.10320-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200120085709.10320-1-hsiangkao.ref@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

No need to introduce such separated helper since
cache strategy compile configs was changed into
runtime options instead in v5.4. No logic changes.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fedeb4496e4..6ee5153801b2 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1148,20 +1148,6 @@ static void move_to_bypass_jobqueue(struct z_erofs_pcluster *pcl,
 	qtail[JQ_BYPASS] = &pcl->next;
 }
 
-static bool postsubmit_is_all_bypassed(struct z_erofs_decompressqueue *q[],
-				       unsigned int nr_bios, bool force_fg)
-{
-	/*
-	 * although background is preferred, no one is pending for submission.
-	 * don't issue workqueue for decompression but drop it directly instead.
-	 */
-	if (force_fg || nr_bios)
-		return false;
-
-	kvfree(q[JQ_SUBMIT]);
-	return true;
-}
-
 static bool z_erofs_submit_queue(struct super_block *sb,
 				 z_erofs_next_pcluster_t owned_head,
 				 struct list_head *pagepool,
@@ -1262,9 +1248,14 @@ static bool z_erofs_submit_queue(struct super_block *sb,
 	if (bio)
 		submit_bio(bio);
 
-	if (postsubmit_is_all_bypassed(q, nr_bios, *force_fg))
+	/*
+	 * although background is preferred, no one is pending for submission.
+	 * don't issue workqueue for decompression but drop it directly instead.
+	 */
+	if (!force_fg && !nr_bios) {
+		kvfree(q[JQ_SUBMIT]);
 		return true;
-
+	}
 	z_erofs_decompress_kickoff(q[JQ_SUBMIT], *force_fg, nr_bios);
 	return true;
 }
-- 
2.20.1

