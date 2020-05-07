Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B0EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52C92063A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879117;
	bh=PmaRvWKL0WGLgfjQ1uvdyt1NSJQfqavoNxrgKWSaeQk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uT/dankAkvb+KP0JrRYOBcdy7hBaG4wxBxSZO49REEwJNaszJIsVj0jN/1QTt5B9e
	 +xzNRCf/OFwBssV+K62Up8ReSEZGMCWaWT9gAmX/LL6bFXsxgOYjHi0VZb82K/jbLv
	 sVT16S6Ve7YaqTnvVpXIgA6jOgHL+1yWoWlxPdD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgEGTSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgEGTSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:18:36 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409EA2063A;
        Thu,  7 May 2020 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879115;
        bh=PmaRvWKL0WGLgfjQ1uvdyt1NSJQfqavoNxrgKWSaeQk=;
        h=Date:From:To:Cc:Subject:From;
        b=C3Kelkzg4jGnKUJAti5PEFqSI042uFT80iLvvdSVCw3XhrJby/ZYUfBPVkFl5kZlj
         ynKQnuPOAzSq7MPWh8KjZ6E8mjgM5nmLYoaVewBuUbUNNggTlkSJgbVx4HLzEUowUk
         syh9hvRxFT7UkK8LnoTwCP6EFjf79wiDIAWi54Ao=
Date:   Thu, 7 May 2020 14:23:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64: Replace zero-length array with flexible-array
Message-ID: <20200507192302.GA16402@embeddedor>
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
 arch/sparc/kernel/cpumap.c |    2 +-
 arch/sparc/kernel/ds.c     |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index 1cb62bfeaa1f..f07ea88a83af 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -50,7 +50,7 @@ struct cpuinfo_tree {
 
 	/* Offsets into nodes[] for each level of the tree */
 	struct cpuinfo_level level[CPUINFO_LVL_MAX];
-	struct cpuinfo_node  nodes[0];
+	struct cpuinfo_node  nodes[];
 };
 
 
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 75232cbd58bf..522e5b51050c 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -87,7 +87,7 @@ struct ds_reg_req {
 	__u64			handle;
 	__u16			major;
 	__u16			minor;
-	char			svc_id[0];
+	char			svc_id[];
 };
 
 struct ds_reg_ack {
@@ -701,12 +701,12 @@ struct ds_var_hdr {
 
 struct ds_var_set_msg {
 	struct ds_var_hdr		hdr;
-	char				name_and_value[0];
+	char				name_and_value[];
 };
 
 struct ds_var_delete_msg {
 	struct ds_var_hdr		hdr;
-	char				name[0];
+	char				name[];
 };
 
 struct ds_var_resp {
@@ -989,7 +989,7 @@ struct ds_queue_entry {
 	struct ds_info			*dp;
 	int				req_len;
 	int				__pad;
-	u64				req[0];
+	u64				req[];
 };
 
 static void process_ds_work(void)

