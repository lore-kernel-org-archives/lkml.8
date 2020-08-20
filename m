Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD56C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E03207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928795;
	bh=qyt87pzmTp24Sz1p8Tt2FxVV5c23LEOA5GmK4+jMLYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lc61rTz9uwZS0CgQk0M+Dkgo/VZigmFJU/Czid4W/REaJnkZs8lvUIJT/uayjUyPm
	 ojX8S3qxYRi46P5abP5FWJ9nSv5DyHWyPBsgAiqC7LxdAuvfRyjDyj/9CjfxL1GSqW
	 oph6HokXQQ37w5XtX4zinCQ/qpi0dbtOTcbGLDc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgHTNGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgHTJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:38:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E99320724;
        Thu, 20 Aug 2020 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916325;
        bh=qyt87pzmTp24Sz1p8Tt2FxVV5c23LEOA5GmK4+jMLYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/qmcqris9Zu/pMXutsJx/qJc6hG9DMnGPvvGEqjErM1jFqRt6Cjn7Il7wYUxv06/
         ZIgTv5dNs+qCuk62EXE6qhX9KB62gAPFPCC7tcPkZHv0ASW7ExdfB59iD95wiIcEPE
         5wKzZSeKxE/dL3Ik06sxTV/xyTL0A3/lmox09ZiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.7 088/204] bootconfig: Fix to find the initargs correctly
Date:   Thu, 20 Aug 2020 11:19:45 +0200
Message-Id: <20200820091610.732050537@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 477d08478170469d10b533624342d13701e24b34 upstream.

Since the parse_args() stops parsing at '--', bootconfig_params()
will never get the '--' as param and initargs_found never be true.
In the result, if we pass some init arguments via the bootconfig,
those are always appended to the kernel command line with '--'
even if the kernel command line already has '--'.

To fix this correctly, check the return value of parse_args()
and set initargs_found true if the return value is not an error
but a valid address.

Link: https://lkml.kernel.org/r/159650953285.270383.14822353843556363851.stgit@devnote2

Fixes: f61872bb58a1 ("bootconfig: Use parse_args() to find bootconfig and '--'")
Cc: stable@vger.kernel.org
Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 init/main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/init/main.c
+++ b/init/main.c
@@ -385,8 +385,6 @@ static int __init bootconfig_params(char
 {
 	if (strcmp(param, "bootconfig") == 0) {
 		bootconfig_found = true;
-	} else if (strcmp(param, "--") == 0) {
-		initargs_found = true;
 	}
 	return 0;
 }
@@ -397,19 +395,23 @@ static void __init setup_boot_config(con
 	const char *msg;
 	int pos;
 	u32 size, csum;
-	char *data, *copy;
+	char *data, *copy, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size, &csum);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
-		   bootconfig_params);
+	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+			 bootconfig_params);
 
-	if (!bootconfig_found)
+	if (IS_ERR(err) || !bootconfig_found)
 		return;
 
+	/* parse_args() stops at '--' and returns an address */
+	if (err)
+		initargs_found = true;
+
 	if (!data) {
 		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 		return;


