Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED2CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC0820801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDJTgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:36:16 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:37087 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJTgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:36:16 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:36:11 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 8A89D40BB1;
        Fri, 10 Apr 2020 12:36:15 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 01/36] objtool: Exit successfully when requesting help
Date:   Fri, 10 Apr 2020 12:35:24 -0700
Message-ID: <91239ed2f7b4d40fc4ffaff6457550ef49618830.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user requests help it's not an error so do not exit with
a non-zero exit code. This is not especially useful for a user but
any script that might wish to check that objtool --help is at least
available can't rely on the exit code to crudely check that, for
example building an objtool executable succeeds.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/objtool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 0b3528f05053..593ec85915a9 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -58,7 +58,10 @@ static void cmd_usage(void)
 
 	printf("\n");
 
-	exit(129);
+	if (!help)
+		exit(129);
+	else
+		exit(0);
 }
 
 static void handle_options(int *argc, const char ***argv)
-- 
2.20.1

