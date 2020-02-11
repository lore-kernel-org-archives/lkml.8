Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A2C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1913220714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcDpEH7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBKW42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:56:28 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:52506 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgBKW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:56:27 -0500
Received: by mail-yw1-f73.google.com with SMTP id r75so263932ywg.19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 14:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=aOL9U/iY2dMKzhjMVeVV6Ai5vMkOfKpOd0BcDILMuYA=;
        b=dcDpEH7ZN45igP4l8mc9PLVcF4M9BgFDWIlzqYNPFVHD6Z9a751NvNdASr+aSkxqGo
         hQ1XpwVZvmIanE1Ex5O04cjcsPkuZVxJAfOCqRqyiPxgoy1ysb6uxY3UGdHfafMSX1MU
         fTeN9/ZqOmoZXeHp5x+PY060mJJ/fE8HJF+tBMze97Qu/dFQrzoasWRUYb2tXGqKUKYo
         bChRMEJPWxfwTZKUbB2x5blZWDc93pOqsuHp/kZZCSWvmA/er+k58DSej0RKcNcSDyRM
         DcPDwp14VI4GIRj2OGVYPhefz4RsPm7OZMkVfFDpukpkiDh+ff0A61+ElYpQWuqcMJRW
         mJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=aOL9U/iY2dMKzhjMVeVV6Ai5vMkOfKpOd0BcDILMuYA=;
        b=g4aR0MKsaAtqGytaJrqvAdWEx+KEDlPgCHQL7DTFz3nx8Ue/107oNsz2o0x5DykWK0
         XKMROuAlo5E7PtQwV+e5lz6pMw0q0QycKCldLrylnjoWVMPb6PLQZtocHP3dv51PMM8u
         gIwnnv5GgNtQ1YLsX+5pn4H7T3b3gb42wy3Z1RusaqUvTzN05iOZ124VtFjqS06B/1x5
         iCf7Tro3XkXaHwKxR5HOKwTCDBDS9m67GDHe7aGhLuci+0E7RQNP7CwJbLug+/i55dNc
         40y0vpwKMCOtix2ZsCaMZvhss+jhSBfazTUmUm1/Z+ILfisqT6b9ZLIiO5mW4UcbzT2Q
         CWWQ==
X-Gm-Message-State: APjAAAXopGtoG/r/N4znVi4TU+FyWkEeTUmCXyuBNlOzVj9o6/2nCZ0a
        dp6s737HLJuHKIYK3vwBFiVBxorc3wY=
X-Google-Smtp-Source: APXvYqzllhiKHdQpM4uPNwyqX+Good3/YFtj2svIu2Spz84zHU9aLEFd2AKu32ak6wuV1+Ian4qkJ4nZyhg=
X-Received: by 2002:a0d:e2d1:: with SMTP id l200mr7607645ywe.122.1581461784825;
 Tue, 11 Feb 2020 14:56:24 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:47 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-7-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 6/6] Add a new sysctl for limiting userfaultfd to user mode faults
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new sysctl knob unprivileged_userfaultfd_user_mode_only.
This sysctl can be set to either zero or one. When zero (the default)
the system lets all users call userfaultfd with or without
UFFD_USER_MODE_ONLY, modulo other access controls. When
unprivileged_userfaultfd_user_mode_only is set to one, users without
CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
will fail with EPERM. This facility allows administrators to reduce
the likelihood that an attacker with access to userfaultfd can delay
faulting kernel code to widen timing windows for other exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 fs/userfaultfd.c                        | 11 ++++++++++-
 include/linux/userfaultfd_k.h           |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 64aeee1009ca..1f416aff68b9 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -847,6 +847,19 @@ privileged users (with SYS_CAP_PTRACE capability).
 
 The default value is 1.
 
+unprivileged_userfaultfd_user_mode_only
+========================================
+
+This flag controls whether unprivileged users can use the userfaultfd
+system calls to handle page faults in kernel mode.  If set to zero,
+userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
+unprivileged_userfaultfd above.  If set to one, users without
+SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
+to succeed.  Prohibiting use of userfaultfd for handling faults from
+kernel mode may make certain vulnerabilities more difficult
+to exploit.
+
+The default value is 0.
 
 user_reserve_kbytes
 ===================
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 47825a804d63..d39bdf177f8c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -29,6 +29,7 @@
 #include <linux/hugetlb.h>
 
 int sysctl_unprivileged_userfaultfd __read_mostly = 1;
+int sysctl_unprivileged_userfaultfd_user_mode_only __read_mostly = 0;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
@@ -1951,8 +1952,16 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
+	bool need_cap_check = false;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
+	if (!sysctl_unprivileged_userfaultfd)
+		need_cap_check = true;
+
+	if (sysctl_unprivileged_userfaultfd_user_mode_only &&
+	    (flags & UFFD_USER_MODE_ONLY) == 0)
+		need_cap_check = true;
+
+	if (need_cap_check && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
 
 	BUG_ON(!current->mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 549c8b0cca52..efe14abb2dc8 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -29,6 +29,7 @@
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
 extern int sysctl_unprivileged_userfaultfd;
+extern int sysctl_unprivileged_userfaultfd_user_mode_only;
 
 extern const struct file_operations userfaultfd_fops;
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..0650063c3741 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1740,6 +1740,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "unprivileged_userfaultfd_user_mode_only",
+		.data		= &sysctl_unprivileged_userfaultfd_user_mode_only,
+		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd_user_mode_only),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 	{ }
 };
-- 
2.25.0.225.g125e21ebc7-goog

