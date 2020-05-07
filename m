Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66252C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42782208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879065;
	bh=thByVMAAcBvR3AyjBBzl3EWLZRPLrKL2Gs1T44P2bM4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NCn3yDl94EUa75OVwoeMG10je5Aatz1BQV6mX0OxRRLOlwtqT181+yhLVMgVx7zZt
	 eSzbKXCDwXnk8eGvN46kfMWp3fVtzmndJnRGM+ZVuSeXa3uWIr65DDW0N6nmPA2zXY
	 z9a607KbxW1OethcyYecvY/UuhklBuua2IqPjap4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEGTRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:17:43 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A04208D6;
        Thu,  7 May 2020 19:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879063;
        bh=thByVMAAcBvR3AyjBBzl3EWLZRPLrKL2Gs1T44P2bM4=;
        h=Date:From:To:Cc:Subject:From;
        b=jpkxgGGqSk+xvBMgPdt4yAzdgPMsUFB+Z+HYSVVW0y1Y6WKUIWDbPjKJbr61zCz35
         CnvithaG8k5Tjp49vrUoa0VBeLgb51EH5I6Eteh1AZDClP35oT7+7HgeSVIeyUn/G+
         BfaBXJv5DEPXC/Y+bh07VXu6bo6l9bT6F4VFR34I=
Date:   Thu, 7 May 2020 14:22:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md/raid1: Replace zero-length array with flexible-array
Message-ID: <20200507192209.GA16290@embeddedor>
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
 drivers/md/md-linear.h |    2 +-
 drivers/md/raid1.h     |    2 +-
 drivers/md/raid10.h    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-linear.h b/drivers/md/md-linear.h
index 8381d651d4ed..24e97db50ebb 100644
--- a/drivers/md/md-linear.h
+++ b/drivers/md/md-linear.h
@@ -12,6 +12,6 @@ struct linear_conf
 	struct rcu_head		rcu;
 	sector_t		array_sectors;
 	int			raid_disks; /* a copy of mddev->raid_disks */
-	struct dev_info		disks[0];
+	struct dev_info		disks[];
 };
 #endif
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index e7ccad898736..b7eb09e8c025 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -180,7 +180,7 @@ struct r1bio {
 	 * if the IO is in WRITE direction, then multiple bios are used.
 	 * We choose the number when they are allocated.
 	 */
-	struct bio		*bios[0];
+	struct bio		*bios[];
 	/* DO NOT PUT ANY NEW FIELDS HERE - bios array is contiguously alloced*/
 };
 
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index d3eaaf3eb1bc..79cd2b7d3128 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -153,7 +153,7 @@ struct r10bio {
 		};
 		sector_t	addr;
 		int		devnum;
-	} devs[0];
+	} devs[];
 };
 
 /* bits for r10bio.state */

