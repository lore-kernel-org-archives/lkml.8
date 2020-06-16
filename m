Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA3E20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592302454;
	bh=yZgg/X3OtqsCUMSqbPqhvaERebP2JWDOcMpre3GtJuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1GOXWbQz316YwSRHAoVupjOXQYJ34r3FgBLPmxCpk8rQegDYDAQ8FLNiW3wT9k756
	 B/80CSpjomdgG/ebXJ3FIj8avfBW9kbPRVSMNtQA2xFpxdpbnqIIFg/1D+0CMZfsTb
	 2KB/cXKZhAtpl6IP+6Q9qDW2CLBcLMyshOXJtqos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgFPKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgFPKOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:14:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DDE920767;
        Tue, 16 Jun 2020 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592302451;
        bh=yZgg/X3OtqsCUMSqbPqhvaERebP2JWDOcMpre3GtJuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeeIZO/Fvb74m3oLaMMUZ0SWj3SoBaps66trqTRJx7OWzcaLD4so3qttEFXJ2ZSOG
         kQzkyO9JqvODQbStbVk3o4C/pj8aSEPU2wiAcjjVSH3iZ2lEQ0cnrRybGDoOi6U1Yd
         4j4BhVsPNIlqa/wVKO1OtLWlLM47n33gy5+KjQjg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] proc/bootconfig: Fix to use correct quotes for value
Date:   Tue, 16 Jun 2020 19:14:08 +0900
Message-Id: <159230244786.65555.3763894451251622488.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159230243779.65555.11413773790099102781.stgit@devnote2>
References: <159230243779.65555.11413773790099102781.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix /proc/bootconfig to select double or single quotes
corrctly according to the value.

If a bootconfig value includes a double quote character,
we must use single-quotes to quote that value.

This modifies if() condition and blocks for avoiding
double-quote in value check in 2 places. Anyway, since
xbc_array_for_each_value() can handle the array which
has a single node correctly.
Thus,

if (vnode && xbc_node_is_array(vnode)) {
	xbc_array_for_each_value(vnode)	/* vnode->next != NULL */
		...
} else {
	snprintf(val); /* val is an empty string if !vnode */
}

is equivalent to

if (vnode) {
	xbc_array_for_each_value(vnode)	/* vnode->next can be NULL */
		...
} else {
	snprintf("");	/* value is always empty */
}

Fixes: c1a3c36017d4 ("proc: bootconfig: Add /proc/bootconfig to show boot config list")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Sort local vars definition as upside-down xmas tree format.
  - Fix patch description (typo and add comments)
---
 fs/proc/bootconfig.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 9955d75c0585..ad31ec4ad627 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -26,8 +26,9 @@ static int boot_config_proc_show(struct seq_file *m, void *v)
 static int __init copy_xbc_key_value_list(char *dst, size_t size)
 {
 	struct xbc_node *leaf, *vnode;
-	const char *val;
 	char *key, *end = dst + size;
+	const char *val;
+	char q;
 	int ret = 0;
 
 	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
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

