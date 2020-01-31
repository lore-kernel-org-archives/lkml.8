Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E466206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="smD1iayx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAaOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:50:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45239 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgAaOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:50:45 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so3338343qvu.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEWwUoDvKgE0JkyZkNP6WsuVDogS4Rbn/RaYXt1EZVU=;
        b=smD1iayxRy+9VqIiytwLA1+Wp2M1FCHdFZi40FV96wO7/21DXgURoKiUJBzxmSsuA0
         J/TKJHGfbp9fBWd1vKjx3GVOA4for31G8X26WcCN6PKFIYXFwBNcp7tGpgIz84SronKf
         ypV8j7J+KPqxJWgu0+7oEP6oobK5hR7mrO5F8u0GEjPaJMvmSbrSjMfKKLBRlSe4SCbs
         KDZpIEdyQNsdjI+qIy/naZCjY/0o6hpi2NOklMh/flVLpc4J77SojDLyE3lwwoSy9sdY
         Ij/geOdOjzzwvE1REKBvl78x5SHEWtOIIoWaduT9Hjgb9xaTV3hxRkZkiHKo4kthDtwL
         C7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GEWwUoDvKgE0JkyZkNP6WsuVDogS4Rbn/RaYXt1EZVU=;
        b=Wtvw4YWMiCzOYEHVl8Iyn5FseG8oiL1yDdiIv8BPBEutYX+UgAl5HmN7Z9gTjmZSHx
         zwAstQ0gflDvbAyGuPtNgewbZJz9uP78k77lQibioEy10cXMmGG6842HD0chg9f/gh8j
         J9iLDtsvMyloBZxDFbn6/6KLyY0gU4EWfCROoeyhiW6QZQG0l48HsnMy/f8c+n8STRhV
         +nl5MWPgKls+gqHxlQr7H4cn0FEW8GDVRSvhdPbU5siymYdVp2kwd+epat7RAhIZuWVa
         lIfXEfMkjLNVFqG9JuuMSyc6OJMqTP7ZwwYi9hjQHfcRmqRWn3Sniu0+FA/4NXXhMzhm
         tdwA==
X-Gm-Message-State: APjAAAXgwvQzLDP3aGkCPK3Qm7hcZqVJWfyOqWqbU2iMoLm/Wt6MLIyU
        gtxfzbH/fVNyayXzgdNq5F6paw==
X-Google-Smtp-Source: APXvYqzNZ+HTWVJTOb5Rc/PuAM989QFNOEJ3sPLZQ5T7V9ikr27h+yVuXXNJuObqj8RMaKNHskKzLg==
X-Received: by 2002:a05:6214:1103:: with SMTP id e3mr10620973qvs.159.1580482243440;
        Fri, 31 Jan 2020 06:50:43 -0800 (PST)
Received: from ovpn-120-129.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h13sm4921208qtu.23.2020.01.31.06.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 06:50:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will@kernel.org, elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] locking/osq_lock: mark an intentional data race
Date:   Fri, 31 Jan 2020 09:50:38 -0500
Message-Id: <20200131145038.2386-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node->next could be accessed concurrently as reported by KCSAN,

 BUG: KCSAN: data-race in osq_lock / osq_unlock

 write (marked) to 0xffff8bb2f1abbe40 of 8 bytes by task 1138 on cpu 44:
  osq_lock+0x149/0x340 kernel/locking/osq_lock.c:143
  __mutex_lock+0x277/0xd20 kernel/locking/mutex.c:657
  mutex_lock_nested+0x31/0x40
  kernfs_iop_getattr+0x58/0x90
  vfs_getattr_nosec+0x11a/0x170
  vfs_statx_fd+0x54/0x90
  __do_sys_newfstat+0x40/0x90
  __x64_sys_newfstat+0x3a/0x50
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff8bb2f1abbe40 of 8 bytes by task 1150 on cpu 29:
  osq_unlock+0xee/0x170 kernel/locking/osq_lock.c:78
  __mutex_lock+0xb68/0xd20 kernel/locking/mutex.c:686
  mutex_lock_nested+0x31/0x40
  kernfs_iop_getattr+0x58/0x90
  vfs_getattr_nosec+0x11a/0x170
  vfs_statx_fd+0x54/0x90
  __do_sys_newfstat+0x40/0x90
  __x64_sys_newfstat+0x3a/0x50
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is a false positive. Since even if that load is shattered the code
will function correctly -- it checks for any !0 value, any byte
composite that is !0 is sufficient. Hence, mark it as an intentional
data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/osq_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f7734949ac8..009bf18c2226 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 		 * wait for either @lock to point to us, through its Step-B, or
 		 * wait for a new @node->next from its Step-C.
 		 */
-		if (node->next) {
+		if (data_race(node->next)) {
 			next = xchg(&node->next, NULL);
 			if (next)
 				break;
-- 
2.21.0 (Apple Git-122.2)

