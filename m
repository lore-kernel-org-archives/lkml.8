Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3BC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946BB20787
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Au21O8D/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgC0DMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:12:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42371 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgC0DMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:12:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so7488487qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIXComzXepyZpZfkSblI2SvNO6XmMKECWAWpAqRW/10=;
        b=Au21O8D/qy9u3Of+krvBKLHtOYxqMUd5Ec6R5lbQ/DBQTGXqjAho1ZDpFIMAkaOgm2
         ewXEfxltHGoRfNE3fC2zN0YtVceZeNo+CDY9k4iZ3Os3/gKTHxXuYEstaSys1lovmaxt
         QqN21E/z71rWIfKUNCA+qK9kmo0TB2o5nC2D+06D4p1ezFmxBgKvHhhkvE38RbsXK4Ab
         wRKl40UnPP2cJ0kmrfoIM7W9wUQBoOgJvFMZwjwAe3IObYQpWbVNDiA78+youcAZnRfg
         FvjAKcb7FwMCmxYf2FJto0/drulD7TOB3qvInk4sA6X09Kbu/0aFmH4QED0b1eSyUIxg
         jnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIXComzXepyZpZfkSblI2SvNO6XmMKECWAWpAqRW/10=;
        b=novItSVMTFM3pMj7PLWD7ndmG4sYMlhH6dz4vJjS8DanValuq9muasg89vT4VDWu4s
         SC24SWLfD55DqCZEQfobXCwomEmA0uToNqBlWVwkJw+OwJMNBS7M2VmQ/nzu5TGlncgw
         s0/dcXmyNErWnQw+BUx+nn1Wn8bCy8qcRY+yVGjfOI6ciqnglFa2IZ/7L/aew9BXupJz
         7hIk37oabhzMbxvwoOYpRtqwHH9+6DNxVZOuBkkZIALKWBlrag52Td1sS+ePdFyqr/5P
         Er9QSUsTvTaKGVpnPANfSDUJJhNYUMwdNYQdYW3Liea1KmigBHD8qmZCn/REfMvgX1wV
         cqlQ==
X-Gm-Message-State: ANhLgQ1yNx3NWJJNj44Y0/9Ec1cuobFFliX2v58cKaL3P1mR2cK2RQT0
        9vKCG6xTgPwC9iJ5VLHsyDs1dw==
X-Google-Smtp-Source: ADFU+vu9EU6kz3gxEg0tiOJnT7diZc04olU9w1A4COE5kYhYoV9Q753XHqozw9Vazmcbo2FKj6jY0A==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr12210719qtb.378.1585278731781;
        Thu, 26 Mar 2020 20:12:11 -0700 (PDT)
Received: from ovpn-66-69.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p38sm2994223qtf.50.2020.03.26.20.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 20:12:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will@kernel.org, dbueso@suse.de, juri.lelli@redhat.com,
        longman@redhat.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] locking/percpu-rwsem: fix a task_struct refcount
Date:   Thu, 26 Mar 2020 23:10:57 -0400
Message-Id: <20200327031057.10866-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some memory leaks due to a missing put_task_struct().

Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/percpu-rwsem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a008a1ba21a7..6f487e5d923f 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -123,8 +123,10 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 	struct percpu_rw_semaphore *sem = key;
 
 	/* concurrent against percpu_down_write(), can get stolen */
-	if (!__percpu_rwsem_trylock(sem, reader))
+	if (!__percpu_rwsem_trylock(sem, reader)) {
+		put_task_struct(p);
 		return 1;
+	}
 
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
-- 
2.21.0 (Apple Git-122.2)

