Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA90C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895BD206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYa0DR4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895BD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgDLUbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:31:34 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DE2C0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586723492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=pdGxSItAg1hNt0eqCWfo1nI029akRqxf1Spx/SODDE0=;
        b=IYa0DR4vZExMDqHF38+mPoE5RZAWX2nZsH80KY0CJcLmOnBTGa0sxl0eEHKihUwENb2fdZ
        WVaNJS8ZN6sjbLJJGLeLKpXpjDX/3pWyUqj0aOXyR5+y5+YG49ivcZh2on0dEV89a4zgqI
        90laz446+EYhP4glxT563+1S8qALPHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-yQDXnCojP_CJE4SAeSV1FA-1; Sun, 12 Apr 2020 16:31:28 -0400
X-MC-Unique: yQDXnCojP_CJE4SAeSV1FA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF766801E53;
        Sun, 12 Apr 2020 20:31:26 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B006610013D9;
        Sun, 12 Apr 2020 20:31:24 +0000 (UTC)
Date:   Sun, 12 Apr 2020 22:31:23 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] clone3: add a check for the user struct size if
 CLONE_INTO_CGROUP is set
Message-ID: <20200412203123.GA5869@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing CLONE_INTO_CGROUP with an under-sized structure (that doesn't
properly contain cgroup field) seems like garbage input, especially
considering the fact that fd 0 is a valid descriptor.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 11bcc7e..8c700f8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2639,7 +2639,8 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
-	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup > INT_MAX)
+	if ((args.flags & CLONE_INTO_CGROUP) &&
+	    (args.cgroup > INT_MAX || usize < CLONE_ARGS_SIZE_VER2))
 		return -EINVAL;
 
 	*kargs = (struct kernel_clone_args){
-- 
2.1.4

