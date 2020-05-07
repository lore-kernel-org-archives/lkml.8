Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356C8C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B36324956
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877268;
	bh=L19SLkkQXKcOuzW3RL8LtzKlqMiQPoyoesq3zLXKhnA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=x81Ojog/ydAdiswDrUPwq/D0kAMadE+MqAx2fthOtifddX8+Rfs1BrSxQblvswsuq
	 Baws4ilxQimnQKs+hKGMMKN+ljcugeuUyVc5CkMPepmU3v7dZ0RYWUgmlRYjg6cdPL
	 1VX3VOijQ+Bq/LNPODfAJuDQjwISNfs8yQAnT+Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgEGSrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:47:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGSrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:47:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908C124954;
        Thu,  7 May 2020 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877266;
        bh=L19SLkkQXKcOuzW3RL8LtzKlqMiQPoyoesq3zLXKhnA=;
        h=Date:From:To:Cc:Subject:From;
        b=Z65uFmK9tBSaSMi50NVL8iZ9JUxFnlgm4iHolyTl8/eZ9jcErJOhoUHk31un83xOW
         7K9w4V79TCedl3epr+ZSOZqyenRt7cNlIiDY4i2KjckpxL7tKYNAcWYSJBQfulHb5j
         rs0z8eA/uaI7I0yqfUppDH/u4ElRzXnctijFPdmU=
Date:   Thu, 7 May 2020 13:52:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drbd: Replace zero-length array with flexible-array
Message-ID: <20200507185212.GA14165@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/drbd/drbd_int.h      |    2 +-
 drivers/block/drbd/drbd_protocol.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index aae99a2d7bd4..a3314dd781a7 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -620,7 +620,7 @@ struct fifo_buffer {
 	unsigned int head_index;
 	unsigned int size;
 	int total; /* sum of all values */
-	int values[0];
+	int values[];
 };
 extern struct fifo_buffer *fifo_alloc(unsigned int fifo_size);
 
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index e6fc5ad72501..dea59c92ecc1 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -271,7 +271,7 @@ struct p_rs_param {
 	u32 resync_rate;
 
 	      /* Since protocol version 88 and higher. */
-	char verify_alg[0];
+	char verify_alg[];
 } __packed;
 
 struct p_rs_param_89 {
@@ -305,7 +305,7 @@ struct p_protocol {
 	u32 two_primaries;
 
 	/* Since protocol version 87 and higher. */
-	char integrity_alg[0];
+	char integrity_alg[];
 
 } __packed;
 
@@ -360,7 +360,7 @@ struct p_sizes {
 	u16	    dds_flags; /* use enum dds_flags here. */
 
 	/* optional queue_limits if (agreed_features & DRBD_FF_WSAME) */
-	struct o_qlim qlim[0];
+	struct o_qlim qlim[];
 } __packed;
 
 struct p_state {
@@ -409,7 +409,7 @@ struct p_compressed_bm {
 	 */
 	u8 encoding;
 
-	u8 code[0];
+	u8 code[];
 } __packed;
 
 struct p_delay_probe93 {

