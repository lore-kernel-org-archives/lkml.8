Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08567C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60A924954
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878935;
	bh=ZPm1lXreSdVxT/TB7RrJsuJK7F5PayuZXbIMXSCMsAY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xeL1nAI+Lo4eswjQt5ieG6emukNhDJP7AWB+dLwdtDl8EuaTHwt4Z16rgKDBT9Qdr
	 Z4V6hl8yi/E//mqcc9qG0OOn5OqKawSNI+bmWa10pfLuddyQcfCjjRDEPMsvhJ96So
	 Pl8tfH92qPje7x1KqOwDDNfPViAAFGT22OzttMV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgEGTPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:15:34 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF12208E4;
        Thu,  7 May 2020 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878933;
        bh=ZPm1lXreSdVxT/TB7RrJsuJK7F5PayuZXbIMXSCMsAY=;
        h=Date:From:To:Cc:Subject:From;
        b=vlko1ZXU6sxyMwVHztzLWGJbGIgUyvcKyr7zJGP09DVL7Q53ijWDz62osbXgQtpqB
         m6+ktOxPTd8FWxurabY8spnYoPSq/8r1QDAPrYCIUwuHt+V27sKyMHKbZeYonoHLn9
         +LBX/te2mO9bBc6Gi15U13IQoxBlukDWYHM+Zr+k=
Date:   Thu, 7 May 2020 14:20:00 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: s5k5baf: Replace zero-length array with flexible-array
Message-ID: <20200507192000.GA16098@embeddedor>
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
 drivers/media/i2c/s5k5baf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5k5baf.c b/drivers/media/i2c/s5k5baf.c
index cdfe008ba39f..42584a088273 100644
--- a/drivers/media/i2c/s5k5baf.c
+++ b/drivers/media/i2c/s5k5baf.c
@@ -281,7 +281,7 @@ struct s5k5baf_fw {
 		u16 id;
 		u16 offset;
 	} seq[0];
-	u16 data[0];
+	u16 data[];
 };
 
 struct s5k5baf {

