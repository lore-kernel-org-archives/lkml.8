Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16AEC3F353
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4921D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812039;
	bh=8FIpGAv38N3JOcE3mn8yy2om0YdEiQlkwbQpw79bDhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4PQDm8LEjhfotwxW14d8L1H2A7HlVn/L1AwqeVyWlvqQcTAeDOrIUlHZ9qejD+hZ
	 yQDDId8LzJOqH7nuWBfphlYUJ7eZ0M41orJqYPAITwtwiPsoKWC95FmCqQoagrc2zY
	 eYTcpY9zVjk8qYwGOmkEoMN1Hc1oOA8oC3MFzsyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgB0OAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732597AbgB0OAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:00:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6AD2084E;
        Thu, 27 Feb 2020 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812033;
        bh=8FIpGAv38N3JOcE3mn8yy2om0YdEiQlkwbQpw79bDhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ED9/qWF6i6kq5JdWIxRUhtenCgiwa2SMHlefBf6rdt8NxFi4MOwc5b2Fjd2f6cnG4
         la35A2fFylehPqajGsYet0td+U79OyZ0D2+gPACciM2Vd6qdthzpeVdISrfN1vgDDY
         Wjg8OSdQoQhlso8uHIRS4R0LUZOo+5oK46h2j0rk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 158/237] bcache: explicity type cast in bset_bkey_last()
Date:   Thu, 27 Feb 2020 14:36:12 +0100
Message-Id: <20200227132308.154857170@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 8d1964b472e7e..0bfde500af196 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -381,7 +381,8 @@ void bch_btree_keys_stats(struct btree_keys *, struct bset_stats *);
 
 /* Bkey utility code */
 
-#define bset_bkey_last(i)	bkey_idx((struct bkey *) (i)->d, (i)->keys)
+#define bset_bkey_last(i)	bkey_idx((struct bkey *) (i)->d, \
+					 (unsigned int)(i)->keys)
 
 static inline struct bkey *bset_bkey_idx(struct bset *i, unsigned idx)
 {
-- 
2.20.1



