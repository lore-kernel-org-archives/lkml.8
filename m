Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB80C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF59206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgAPNQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:16:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:42538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgAPNQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:16:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97B86B1D2;
        Thu, 16 Jan 2020 13:16:56 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Wagner <dwagner@suse.de>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH] tools/vm/slabinfo: Fix sanity checks enabling
Date:   Thu, 16 Jan 2020 14:16:42 +0100
Message-Id: <20200116131642.642-1-dwagner@suse.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs file name for enabling sanity checking is called
'sanity_checks' and not 'sanity'.

The name of the file has never changed since the introduction of the
slub allocator. Obviously, most people turn the checks on via the
command line option and not during runtime using slabinfo.

Cc: "Tobin C. Harding" <tobin@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tools/vm/slabinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 68092d15e12b..9b68658b6bb8 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -720,11 +720,11 @@ static void slab_debug(struct slabinfo *s)
 		return;
 
 	if (sanity && !s->sanity_checks) {
-		set_obj(s, "sanity", 1);
+		set_obj(s, "sanity_checks", 1);
 	}
 	if (!sanity && s->sanity_checks) {
 		if (slab_empty(s))
-			set_obj(s, "sanity", 0);
+			set_obj(s, "sanity_checks", 0);
 		else
 			fprintf(stderr, "%s not empty cannot disable sanity checks\n", s->name);
 	}
-- 
2.24.1

