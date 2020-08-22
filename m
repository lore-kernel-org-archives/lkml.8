Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7A5C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2844F20656
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Fjb47DU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHVBkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHVBkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:40:33 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F788C061575
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d19so2414813qvm.23
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MZt6zWa+RNv5nFf3tGacIvcIKi4HOMw7I8ZdHhGadw8=;
        b=Fjb47DU5UAmSrK+favah3JR3SaEeIHpvEskXHgYrtYJ3n/Bq3bJrOY1YznTe99CW9w
         DFFIxz48eB5rPJvbwZ2WmLcr2udtejpyE5PqXM8EcPnXgeTz0iF5sYdswDmwwMS9HZgw
         AekKXEkBi+3/lLdRxCUTx8u+CUn1noNVk8XXftvGOqPgK+jMFzLQgKigImeF0kzHlWqL
         Z1Rvj6co0gfQGg9GPvRp4AyBe9tkZ/yVC0BCmF6i0CwLfxSSQnm8UzGsE0uvZj9QkjSa
         cnB+JCWlCT8nJW88RKFw1sv86Du/hRSoJqDwnHSeAgdx3gajxoWK8DAZ67q75sM4G4mX
         Ujmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZt6zWa+RNv5nFf3tGacIvcIKi4HOMw7I8ZdHhGadw8=;
        b=hgtDUk3Xcy9fUrnHzZE5dDQqBMykEm1AN+Dif2Wh/Hto9rSer9joNVUj+OE3SP55+D
         jVlnl+hOMMeN7n2mlklKTsam/0L9PlZToO04owsWTqtS2y5wjh57C3tLTeYFgRxKpT1r
         JF1sqvMcxIHwxIZpeNaS3QqTHO3rdkVrb8UHwtcNrgi0EMxojEm9yLOXJN+27jWVmnCm
         R5NtwQTudQbH9yHOo6U3Y4QrmyZqTy0q4mXOPi5bnLk+v975I7iCbnugGFHCEImtq8dH
         1HPftqHJFVnFcXuBBWOn2vHXHyTjzjAshQ0kImcp5RVV3LmIqpRCVgbDHFjUSwxVcdIU
         OUug==
X-Gm-Message-State: AOAM533pFc11qUCPv/DvHBsFIfeBR2JSYNIfaWUHJQylIvZPG/pLHPld
        Q8P7RYw40RmiCZgowbQ/YRQ2CBcbxO7EE0D3dg==
X-Google-Smtp-Source: ABdhPJylWPWmpbtUgK/VlQmDrGjkTVQmIPagoBhVfweXeFSEuVo3aeNUXXPJ4rkw3klaFazqhLHnatwJe2pNyCOagQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:d44e:: with SMTP id
 r14mr5036474qvh.105.1598060430375; Fri, 21 Aug 2020 18:40:30 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:40:18 -0700
In-Reply-To: <20200822014018.913868-1-lokeshgidra@google.com>
Message-Id: <20200822014018.913868-3-lokeshgidra@google.com>
Mime-Version: 1.0
References: <20200822014018.913868-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 2/2] Add user-mode only option to unprivileged_userfaultfd
 sysctl knob
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A third option is added to 'unprivileged_userfaultfd' sysctl knob.
When the knob is set to 2, it allows unprivileged users to call
userfaultfd, like when it is set to 1, but with the restriction that
page faults from only user-mode can be handled. In this mode,
an unprivileged user (without SYS_CAP_PTRACE capability) must pass
UFFD_USER_MODE_ONLY to userfaultd or the API will fail with EPERM.

This facility allows administrators to reduce the likelihood that
an attacker with access to userfaultfd can delay faulting kernel
code to widen timing windows for other exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 10 +++++++---
 fs/userfaultfd.c                        | 10 ++++++++--
 kernel/sysctl.c                         |  2 +-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4b9d2e8e9142..23d6feb79f5c 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -872,9 +872,13 @@ unprivileged_userfaultfd
 ========================
 
 This flag controls whether unprivileged users can use the userfaultfd
-system calls.  Set this to 1 to allow unprivileged users to use the
-userfaultfd system calls, or set this to 0 to restrict userfaultfd to only
-privileged users (with SYS_CAP_PTRACE capability).
+system calls.  Set this to 0 to restrict userfaultfd to only privileged
+users (with SYS_CAP_PTRACE capability), set this to 1 to allow unprivileged
+users to use the userfaultfd system calls, or set this to 2 to restrict
+unprivileged users to handle page faults in user mode only. In the last case,
+users without SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for
+userfaultfd to succeed.  Prohibiting use of userfaultfd for handling faults
+from kernel mode may make certain vulnerabilities more difficult to exploit.
 
 The default value is 1.
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 3e4ae6145112..2fcdeb28c960 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1973,8 +1973,14 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
-	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
-		return -EPERM;
+	switch (sysctl_unprivileged_userfaultfd) {
+	case 2:
+		if (flags & UFFD_USER_MODE_ONLY)
+			break;
+	case 0:
+		if (!capable(CAP_SYS_PTRACE))
+			return -EPERM;
+	}
 
 	BUG_ON(!current->mm);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 287862f91717..7e94215dfff5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3119,7 +3119,7 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.extra2		= &two,
 	},
 #endif
 	{ }
-- 
2.28.0.297.g1956fa8f8d-goog

