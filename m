Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C65C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9AB21BE5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879353;
	bh=rAAcA/uyPsMlDFHBL/ARQqIM+l0b7F6eryRo6frkMmU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=c3d4OklCAZAGIj7f4cEfg57Bb6EkLxXR+JNSUQxDh6/RLq0WsyRUu5XSfq7SyaXUF
	 Bu67ko6gJHwMGICssnsBfbHCmNS+kJCIgo8p1foZaX2XPjyXa9bi92drAeijKQr/l9
	 UsSYaz17t8OdKxIoxS82s7Uy8MhcT7Uo8AA38XqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEGTWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEGTWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:22:31 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF99208D6;
        Thu,  7 May 2020 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879351;
        bh=rAAcA/uyPsMlDFHBL/ARQqIM+l0b7F6eryRo6frkMmU=;
        h=Date:From:To:Cc:Subject:From;
        b=XcdZ8qDDtujWEK2Zpc/nnDUR3pOSai0W7TrM5tPd5hmF2mivtKeGojuQDh39kWFMN
         yn72OoRheRjEZiZK3MemAVu0l7RsopKhxUWRdAPbVtXBKxKwUHnOFGmKxt1UlLH9Q4
         Q5VueboSpEyNlqGy/Fq9Mxy13YAYpvAmr+J6Mtds=
Date:   Thu, 7 May 2020 14:26:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] w1: Replace zero-length array with flexible-array
Message-ID: <20200507192657.GA16764@embeddedor>
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
 drivers/w1/w1_netlink.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index 3041092e84b3..449680a61569 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -73,7 +73,7 @@ struct w1_netlink_msg
 			__u32		res;
 		} mst;
 	} id;
-	__u8				data[0];
+	__u8				data[];
 };
 
 /**
@@ -122,7 +122,7 @@ struct w1_netlink_cmd
 	__u8				cmd;
 	__u8				res;
 	__u16				len;
-	__u8				data[0];
+	__u8				data[];
 };
 
 #ifdef __KERNEL__

