Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EF7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636C120888
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975420;
	bh=4NxsWbYy8tttI/qIvtMbNeqPjzpkgvMM0wqi9DcMHlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dc2ejHXwuxjV7Z/j1aTkE516ueCTnDlUE17P+uaoafDlJWlOte65FOo/iunBo80tx
	 TOfJRrbMAxeuyp7ICpImL+pGNZamEzHLX0rMgmlIZgtpP1EAdkOCvznhUjLV1M2BPF
	 fj57SBCB9WTHB/sXv9Bpm2KuiEY8akABpyqbihB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFLPXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFLPXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:23:38 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A44AE20890;
        Fri, 12 Jun 2020 15:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975418;
        bh=4NxsWbYy8tttI/qIvtMbNeqPjzpkgvMM0wqi9DcMHlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ieSCUjTWAMzSe2X5+Tb6xLYwVRYCFRF/cjNiRkv5kAh+Zeyn08XtNyGp5DLraWTI+
         NsU2fIvYEThmrGtk08xdz1rooXbXJeqUClrI1odkL4pHOJJtYBf+SKKOv7WeqJ5b8R
         Lc7USrQZZT5YPT/Cy3UQndshvTPfUi2D9KUIZdjY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
Date:   Sat, 13 Jun 2020 00:23:35 +0900
Message-Id: <159197541534.80267.9851345208191438725.stgit@devnote2>
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

Fix bootconfig to return 0 if succeeded to show the bootconfig
in initrd. Without this fix, "bootconfig INITRD" command
returns !0 even if the command succeeded to show the bootconfig.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 21896a6675fd..ff2cc9520e10 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -209,8 +209,10 @@ int show_xbc(const char *path)
 	ret = load_xbc_from_initrd(fd, &buf);
 	if (ret < 0)
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
-	else
+	else {
 		xbc_show_compact_tree();
+		ret = 0;
+	}
 
 	close(fd);
 	free(buf);

