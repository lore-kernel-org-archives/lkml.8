Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C105C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B524649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WvolgZSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCIUrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:47:49 -0400
Received: from gateway36.websitewelcome.com ([192.185.186.5]:32179 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgCIUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:47:49 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 4F5164021A4AA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Mar 2020 14:39:41 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BOwcjU3OJRP4zBOwcjqWht; Mon, 09 Mar 2020 15:24:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YCXQ7OaaKLESdOaDDCU6a1klTVbkOknb68ZAoamQmf0=; b=WvolgZSKdUZWjFcwdheL1u1uWA
        RwAiT+PW2jhOuQp5b3cgLPqq0sP5yoRtRwoZwerHE5Dx+cRzpXcvttMgbnqlg+6LMGi+J8jSrxnGk
        CQb9vrA44jwZlB11OFXYCUevHnKesl6XNkIesU/vkxkPLxLJzUyuSZnsd4vF/hZHKZAxwtVy1moVE
        z4I7bD/eaEDcFLf2ciTvvyzIvj+w22QfQMEDFqUDSDKPPZvv8aHvRyJFPvpdWnowXuyWzfCP+MHO7
        hIcvQiRk0lwmNtD0TnYoTr16t2Qx3+0roent0V2kLTlJG1FSKEdE4SPKcMGlh554yMmChAemWIZ67
        X3h99PRg==;
Received: from [201.162.168.201] (port=17137 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jBOwW-0010y3-R5; Mon, 09 Mar 2020 15:24:05 -0500
Date:   Mon, 9 Mar 2020 15:27:15 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] udf: udf_sb.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200309202715.GA9428@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.168.201
X-Source-L: No
X-Exim-ID: 1jBOwW-0010y3-R5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.168.201]:17137
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/udf/udf_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 3d83be54c474..65280ae009e0 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -83,7 +83,7 @@ struct udf_virtual_data {
 struct udf_bitmap {
 	__u32			s_extPosition;
 	int			s_nr_groups;
-	struct buffer_head 	*s_block_bitmap[0];
+	struct buffer_head	*s_block_bitmap[];
 };
 
 struct udf_part_map {
-- 
2.25.0

