Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FD6204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHMWax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHMWax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:30:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9833C204EC;
        Thu, 13 Aug 2020 22:30:52 +0000 (UTC)
Date:   Thu, 13 Aug 2020 18:30:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] bootconfig: Fix off-by-one in xbc_node_compose_key_after()
Message-ID: <20200813183050.029a6003@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

While reviewing some patches for bootconfig, I noticed the following
code in xbc_node_compose_key_after():

	ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
		       depth ? "." : "");
	if (ret < 0)
		return ret;
	if (ret > size) {
		size = 0;
	} else {
		size -= ret;
		buf += ret;
	}

But snprintf() returns the number of bytes that would be written, not
the number of bytes that are written (ignoring the nul terminator).
This means that if the number of non null bytes written were to equal
size, then the nul byte, which snprintf() always adds, will overwrite
that last byte.

	ret = snprintf(buf, 5, "hello");
	printf("buf = '%s'\n", buf);
	printf("ret = %d\n", ret);

produces:

	buf = 'hell'
	ret = 5

The string was truncated without ret being greater than 5.
Test (ret >= size) for overwrite.

Cc: stable@vger.kernel.org
Fixes: 76db5a27a827c ("bootconfig: Add Extra Boot Config support")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a5f701161f6b..42735f2b8860 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -248,7 +248,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret > size) {
+		if (ret >= size) {
 			size = 0;
 		} else {
 			size -= ret;
