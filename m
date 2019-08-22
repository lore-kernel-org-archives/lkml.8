Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D3C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0F4206DB
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgC1QqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:46:15 -0400
Received: from mx.sdf.org ([205.166.94.20]:50109 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbgC1QnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:25 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhNxj023546
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:23 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhNSB019516;
        Sat, 28 Mar 2020 16:43:23 GMT
Message-Id: <202003281643.02SGhNSB019516@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 21 Aug 2019 21:30:45 -0400
Subject: [RFC PATCH v1 41/50] drivers/block/drbd/drbd_nl.c: Use
 get_random_u64()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@tron.linbit.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to get_random_bytes() into a temporary buffer.

This is not a no-brainer change; get_random_u64() has slightly
weaker security guarantees, but they're fine for applications
like these where the random value is stored in the kernel for
as long as it's valuable.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: drbd-dev@lists.linbit.com
---
 drivers/block/drbd/drbd_nl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index de2f94d0103a6..ca8c706d47f3a 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3223,9 +3223,7 @@ int drbd_adm_resume_io(struct sk_buff *skb, struct genl_info *info)
 			 * the refuse to re-connect or re-attach (because no
 			 * matching real data uuid exists).
 			 */
-			u64 val;
-			get_random_bytes(&val, sizeof(u64));
-			drbd_set_ed_uuid(device, val);
+			drbd_set_ed_uuid(device, get_random_u64());
 			drbd_warn(device, "Resumed without access to data; please tear down before attempting to re-configure.\n");
 		}
 		clear_bit(NEW_CUR_UUID, &device->flags);
-- 
2.26.0

