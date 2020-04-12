Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37ACC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23CA206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXOyxuh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23CA206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgDLUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:25:47 -0400
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A9EC0A3BF0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586723146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=7C3D22+bfcyONw5l0dvYrkLR9HBNKhS92euE1BouTaU=;
        b=SXOyxuh8FGqBqCajQkol18njPYS86ZB0DKYk1cEjz0kICqQIEWZ1uWjvX6c570HrbIckOU
        O58LuAPqOCgLMiEeB/xkwNs92SpzfjWCPKkgxVJaaAI9GPVbE9Z2KiIdrq4FrwD//AZEDN
        ZbfqMXxSoS2SZi2ucCue/l2TjxTuSUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-U4fa6Hs1NyOaO2w4RMeAcQ-1; Sun, 12 Apr 2020 16:25:42 -0400
X-MC-Unique: U4fa6Hs1NyOaO2w4RMeAcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D7D01005509;
        Sun, 12 Apr 2020 20:25:40 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FC75D9C9;
        Sun, 12 Apr 2020 20:25:34 +0000 (UTC)
Date:   Sun, 12 Apr 2020 22:25:33 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] clone3: fix cgroup argument sanity check
Message-ID: <20200412202533.GA29554@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking that cgroup field value of struct clone_args is less than 0
is useless, as it is defined as unsigned 64-bit integer.  Moreover,
it doesn't catch the situations where its higher bits are lost during
the assignment to the cgroup field of the cgroup field of the internal
struct kernel_clone_args (where it is declared as signed 32-bit
integer), so it is still possible to pass garbage there.  A check
against INT_MAX solves both these issues.

Fixes: ef2c41cf38a7559b ("clone3: allow spawning processes into cgroups")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4385f3d..b4f7775 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2631,7 +2631,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
-	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup > INT_MAX)
 		return -EINVAL;
 
 	*kargs = (struct kernel_clone_args){
-- 
2.1.4

