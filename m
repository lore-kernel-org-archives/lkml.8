Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F2D2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589389882;
	bh=uSkg61BwOrNifZEHey9E2g+dgeUJ0K29iZPqEkw2C1A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CsIRE2MyuqNi2WFjMGy3L9SShdGFfqTlgF5CgQqqRP6Z83TehW24ljDNQ8Ibp5k+r
	 +t+fAyF//1cB1ogIPpNwZCWDqIjSRwAA9L8e0BXBLfwp/IxLlgd2qa4R3Ys6gvxAek
	 SBwuuxaoQ5qn+Tw8bim0qUscJvSLjQOmqywypW38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbgEMRLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgEMRLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:11:21 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C079205CB;
        Wed, 13 May 2020 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589389881;
        bh=uSkg61BwOrNifZEHey9E2g+dgeUJ0K29iZPqEkw2C1A=;
        h=Date:From:To:Cc:Subject:From;
        b=aEYGgg5i5me2qCi9VKCiX7P+P+teDthb9rpi5NS3rMap0eiPRldxu052rINx6puRk
         cUMxqvOGrSAgd1zvEq8OOca0UPW8wIXQLPLKJ8bD1F6q1K72+2MHVhWetq1h+pbeTh
         DqcRaC2GpB1t0kG9ksJDBkNz0PXOyfM/9GMdUCdI=
Date:   Wed, 13 May 2020 12:15:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Bluetooth: L2CAP: Replace zero-length array with
 flexible-array
Message-ID: <20200513171556.GA21969@embeddedor>
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
 include/net/bluetooth/l2cap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dada14d0622c..8f1e6a7a2df8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -499,7 +499,7 @@ struct l2cap_ecred_conn_req {
 	__le16 mtu;
 	__le16 mps;
 	__le16 credits;
-	__le16 scid[0];
+	__le16 scid[];
 } __packed;
 
 struct l2cap_ecred_conn_rsp {
@@ -507,13 +507,13 @@ struct l2cap_ecred_conn_rsp {
 	__le16 mps;
 	__le16 credits;
 	__le16 result;
-	__le16 dcid[0];
+	__le16 dcid[];
 };
 
 struct l2cap_ecred_reconf_req {
 	__le16 mtu;
 	__le16 mps;
-	__le16 scid[0];
+	__le16 scid[];
 } __packed;
 
 #define L2CAP_RECONF_SUCCESS		0x0000
-- 
2.26.2

