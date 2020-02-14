Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C45C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C23206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702499;
	bh=zgVsgEnnXQ7LrYe7AE7KvemzilGGhK+OX2oKdOz0gEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5WI62crUwda1o2yH3PJPQZB4gC7A5DevApRtj+mojZDH4yu1blxYbN3yBPUbwfPQ
	 Di0IKTg+UQxTwjXP8QZPmEVy27tqIz2dZimIJYEOok8FbeDvx2Nd/rCmUcuavA1QNF
	 Ov3zX52kN0MF8yIM847prViMnNwLNvKeThHFD4s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgBNRsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbgBNP7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BAB2086A;
        Fri, 14 Feb 2020 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695989;
        bh=zgVsgEnnXQ7LrYe7AE7KvemzilGGhK+OX2oKdOz0gEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMI64wJv1M1IicyTFIEWFxv8grwZnPG1JnYBa6+GdhtD4adOzSciW83xBzpMDxgIx
         ZYn85opqg/RvqB4SbNIY2k+GphlK/+MYbKbsfXc23uau6Esuv72HDURgD3shkuH5FU
         kC0oKp8QBhNdGa14RcQ/D9oWskk1qlsW8X2iRT8o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, kbuild test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 510/542] bcache: explicity type cast in bset_bkey_last()
Date:   Fri, 14 Feb 2020 10:48:22 -0500
Message-Id: <20200214154854.6746-510-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 7c02b0055f774ed9afb6e1c7724f33bf148ffdc0 ]

In bset.h, macro bset_bkey_last() is defined as,
    bkey_idx((struct bkey *) (i)->d, (i)->keys)

Parameter i can be variable type of data structure, the macro always
works once the type of struct i has member 'd' and 'keys'.

bset_bkey_last() is also used in macro csum_set() to calculate the
checksum of a on-disk data structure. When csum_set() is used to
calculate checksum of on-disk bcache super block, the parameter 'i'
data type is struct cache_sb_disk. Inside struct cache_sb_disk (also in
struct cache_sb) the member keys is __u16 type. But bkey_idx() expects
unsigned int (a 32bit width), so there is problem when sending
parameters via stack to call bkey_idx().

Sparse tool from Intel 0day kbuild system reports this incompatible
problem. bkey_idx() is part of user space API, so the simplest fix is
to cast the (i)->keys to unsigned int type in macro bset_bkey_last().

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/bset.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index c71365e7c1fac..a50dcfda656f5 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -397,7 +397,8 @@ void bch_btree_keys_stats(struct btree_keys *b, struct bset_stats *state);
 
 /* Bkey utility code */
 
-#define bset_bkey_last(i)	bkey_idx((struct bkey *) (i)->d, (i)->keys)
+#define bset_bkey_last(i)	bkey_idx((struct bkey *) (i)->d, \
+					 (unsigned int)(i)->keys)
 
 static inline struct bkey *bset_bkey_idx(struct bset *i, unsigned int idx)
 {
-- 
2.20.1

