Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E7DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D6C20736
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEHPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgEHPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:13:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F32206B8;
        Fri,  8 May 2020 15:13:50 +0000 (UTC)
Date:   Fri, 8 May 2020 11:13:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: [PATCH] tools/bootconfig: Fix apply_xbc() to return zero on success
Message-ID: <20200508111349.3b599bde@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The return of apply_xbc() returns the result of the last write() call, which
is not what is expected. It should only return zero on success.

Link: https://lore.kernel.org/r/20200508093059.GF9365@kadam

Fixes: 8842604446d1 ("tools/bootconfig: Fix resource leak in apply_xbc()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 001076c51712..0efaf45f7367 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -337,6 +337,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
 		goto out;
 	}
+	ret = 0;
 out:
 	close(fd);
 	free(data);
-- 
2.20.1

