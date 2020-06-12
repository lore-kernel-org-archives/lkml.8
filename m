Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10A9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF79220838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975403;
	bh=TSu33CSsTcCx8Wa5ui/4Ko3g3fmL370oljk9gPZh5KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2wZOtKrJJmhvqp2vHnX9C7/JWmuMLQ+i5/ebFnKekueid4qcre/8yMS0enFpypqC
	 jugmtyEN1oDrPmsxF6cCh3tv9gnbaEK2q7sQwWKQBllmDmeI2gIll3P23jpKKNQyMC
	 KITy8GxMsLvcEKRrzlu3VZsN5SpEzGL3WIgfoflk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFLPXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFLPXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:23:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4041520878;
        Fri, 12 Jun 2020 15:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975401;
        bh=TSu33CSsTcCx8Wa5ui/4Ko3g3fmL370oljk9gPZh5KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kw28jipWRHsrK8JiMPbUQ4YTdii8VdHmWWcIC2jwAFjNwwqmBsWk7RDBamTCC7tXH
         ryiOagzdf14zZMKQ2Dpuv1ScdtCZyvDfxSawqWFY8jREWrCSCHn2QHoRN4Dt9LWgO1
         0J28rVO+E56oHMlvY1u8qmh2Uyo+meHU3lFCxJbE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for value
Date:   Sat, 13 Jun 2020 00:23:18 +0900
Message-Id: <159197539793.80267.10836787284189465765.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159197538852.80267.10091816844311950396.stgit@devnote2>
References: <159197538852.80267.10091816844311950396.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix /proc/bootconfig to show the correctly choose the
double or single quotes according to the value.

If a bootconfig value includes a double quote character,
we must use single-quotes to quote that value.

Fixes: c1a3c36017d4 ("proc: bootconfig: Add /proc/bootconfig to show boot config list")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 fs/proc/bootconfig.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 9955d75c0585..930d1dae33eb 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -27,6 +27,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 {
 	struct xbc_node *leaf, *vnode;
 	const char *val;
+	char q;
 	char *key, *end = dst + size;
 	int ret = 0;
 
@@ -41,16 +42,20 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 			break;
 		dst += ret;
 		vnode = xbc_node_get_child(leaf);
-		if (vnode && xbc_node_is_array(vnode)) {
+		if (vnode) {
 			xbc_array_for_each_value(vnode, val) {
-				ret = snprintf(dst, rest(dst, end), "\"%s\"%s",
-					val, vnode->next ? ", " : "\n");
+				if (strchr(val, '"'))
+					q = '\'';
+				else
+					q = '"';
+				ret = snprintf(dst, rest(dst, end), "%c%s%c%s",
+					q, val, q, vnode->next ? ", " : "\n");
 				if (ret < 0)
 					goto out;
 				dst += ret;
 			}
 		} else {
-			ret = snprintf(dst, rest(dst, end), "\"%s\"\n", val);
+			ret = snprintf(dst, rest(dst, end), "\"\"\n");
 			if (ret < 0)
 				break;
 			dst += ret;

