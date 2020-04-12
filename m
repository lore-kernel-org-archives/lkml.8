Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A322C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:27:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB7C206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtpttlp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB7C206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgDLU1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLU1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6F0C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586723225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Xdl3tT1fMpAZO0aU+AOtp0+0VwcjFO1gqcFUmUcmpeQ=;
        b=dtpttlp55kNAZQG4UhE+joVp9SFo+7c9yIWuE+db0w7qrMhbf9StkG6y6lmbHLDh+QmD2F
        y3hwI9897H3Nnkwn6lj5kjeos30fOb4o7BdHkh7hGhCDWRdYlyYP+6tM0nvo+2J0qw6T5z
        mqisnQWxdQFkREw8+pFNhl+qRK2f5Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-dUlhAKhQM9a2gh1WLyDnoQ-1; Sun, 12 Apr 2020 16:27:03 -0400
X-MC-Unique: dUlhAKhQM9a2gh1WLyDnoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0BB5800D53;
        Sun, 12 Apr 2020 20:27:01 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13C3F38E;
        Sun, 12 Apr 2020 20:26:59 +0000 (UTC)
Date:   Sun, 12 Apr 2020 22:26:58 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] clone3: add build-time CLONE_ARGS_SIZE_VER* validity checks
Message-ID: <20200412202658.GA31499@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLONE_ARGS_SIZE_VER* macros are defined explicitly and not via
the offsets of the relevant struct clone_args fields, which makes
it rather error-prone, so it probably makes sense to add some
compile-time checks for them (including the one that breaks
on struct clone_args extension as a reminder to add a relevant
size macro and a similar check).  Function copy_clone_args_from_user
seems to be a good place for such checks.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index b4f7775..11bcc7e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2605,6 +2605,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	struct clone_args args;
 	pid_t *kset_tid = kargs->set_tid;
 
+	BUILD_BUG_ON(offsetofend(struct clone_args, tls) !=
+		     CLONE_ARGS_SIZE_VER0);
+	BUILD_BUG_ON(offsetofend(struct clone_args, set_tid_size) !=
+		     CLONE_ARGS_SIZE_VER1);
+	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
+		     CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
 	if (unlikely(usize < CLONE_ARGS_SIZE_VER0))
-- 
2.1.4

