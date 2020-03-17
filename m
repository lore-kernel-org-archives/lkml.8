Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2207C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822BC205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zzu34Nxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgCQIc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 04:32:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39778 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgCQIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584433975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OoRzPfuCM7vs2QtUS+yVnYK5sqva1RZlWPK2nX2Hv+0=;
        b=Zzu34Nxxzgp9S7Nzs0hJI6dJ0RsQVGYx8oKDZhwHjfTvwLin+SAMISy6492R2qafKAEXUR
        GzYzTXGv6Xe2/wWEyVEwnU43FX82lGWl7psn6ZCQFGubg+9yXhU20vQrWr1LlufmqM8lhi
        Vq7JZUBIGle2eAcxebHSonNOYCrJLEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5Xc1f0L3PV-XRhNNjcmdMQ-1; Tue, 17 Mar 2020 04:32:51 -0400
X-MC-Unique: 5Xc1f0L3PV-XRhNNjcmdMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 597271B2C991;
        Tue, 17 Mar 2020 08:32:49 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-179.ams2.redhat.com [10.36.112.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C92A260BF3;
        Tue, 17 Mar 2020 08:32:46 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/4] clone3: align structs and comments
Date:   Tue, 17 Mar 2020 09:30:43 +0100
Message-Id: <20200317083043.226593-4-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
References: <20200317083043.226593-1-areber@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To follow the existing style this commit aligns the comments and
structure settings to have the same look as before. Just with more
spaces.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 include/uapi/linux/sched.h | 72 +++++++++++++++++++-------------------
 kernel/fork.c              | 18 +++++-----
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index c9b36ef647cc..86387052de19 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -45,42 +45,42 @@
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
- * @flags:        Flags for the new process as listed above.
- *                All flags are valid except for CSIGNAL and
- *                CLONE_DETACHED.
- * @pidfd:        If CLONE_PIDFD is set, a pidfd will be
- *                returned in this argument.
- * @child_tid:    If CLONE_CHILD_SETTID is set, the TID of the
- *                child process will be returned in the child's
- *                memory.
- * @parent_tid:   If CLONE_PARENT_SETTID is set, the TID of
- *                the child process will be returned in the
- *                parent's memory.
- * @exit_signal:  The exit_signal the parent process will be
- *                sent when the child exits.
- * @stack:        Specify the location of the stack for the
- *                child process.
- *                Note, @stack is expected to point to the
- *                lowest address. The stack direction will be
- *                determined by the kernel and set up
- *                appropriately based on @stack_size.
- * @stack_size:   The size of the stack for the child process.
- * @tls:          If CLONE_SETTLS is set, the tls descriptor
- *                is set to tls.
- * @set_tid:      Pointer to an array of type *pid_t. The size
- *                of the array is defined using @set_tid_size.
- *                This array is used to select PIDs/TIDs for
- *                newly created processes. The first element in
- *                this defines the PID in the most nested PID
- *                namespace. Each additional element in the array
- *                defines the PID in the parent PID namespace of
- *                the original PID namespace. If the array has
- *                less entries than the number of currently
- *                nested PID namespaces only the PIDs in the
- *                corresponding namespaces are set.
- * @set_tid_size: This defines the size of the array referenced
- *                in @set_tid. This cannot be larger than the
- *                kernel's limit of nested PID namespaces.
+ * @flags:              Flags for the new process as listed above.
+ *                      All flags are valid except for CSIGNAL and
+ *                      CLONE_DETACHED.
+ * @pidfd:              If CLONE_PIDFD is set, a pidfd will be
+ *                      returned in this argument.
+ * @child_tid:          If CLONE_CHILD_SETTID is set, the TID of the
+ *                      child process will be returned in the child's
+ *                      memory.
+ * @parent_tid:         If CLONE_PARENT_SETTID is set, the TID of
+ *                      the child process will be returned in the
+ *                      parent's memory.
+ * @exit_signal:        The exit_signal the parent process will be
+ *                      sent when the child exits.
+ * @stack:              Specify the location of the stack for the
+ *                      child process.
+ *                      Note, @stack is expected to point to the
+ *                      lowest address. The stack direction will be
+ *                      determined by the kernel and set up
+ *                      appropriately based on @stack_size.
+ * @stack_size:         The size of the stack for the child process.
+ * @tls:                If CLONE_SETTLS is set, the tls descriptor
+ *                      is set to tls.
+ * @set_tid:            Pointer to an array of type *pid_t. The size
+ *                      of the array is defined using @set_tid_size.
+ *                      This array is used to select PIDs/TIDs for
+ *                      newly created processes. The first element in
+ *                      this defines the PID in the most nested PID
+ *                      namespace. Each additional element in the array
+ *                      defines the PID in the parent PID namespace of
+ *                      the original PID namespace. If the array has
+ *                      less entries than the number of currently
+ *                      nested PID namespaces only the PIDs in the
+ *                      corresponding namespaces are set.
+ * @set_tid_size:       This defines the size of the array referenced
+ *                      in @set_tid. This cannot be larger than the
+ *                      kernel's limit of nested PID namespaces.
  * @timens_offset:      Pointer to an array of clock offsets for the
  *                      newly created process in a time namespaces.
  *                      This requires that a new time namespace has been
diff --git a/kernel/fork.c b/kernel/fork.c
index f80aca79d263..6e9acac1d347 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2652,15 +2652,15 @@ noinline static int copy_clone_args_from_user(str=
uct kernel_clone_args *kargs,
 		return -EINVAL;
=20
 	*kargs =3D (struct kernel_clone_args){
-		.flags		=3D args.flags,
-		.pidfd		=3D u64_to_user_ptr(args.pidfd),
-		.child_tid	=3D u64_to_user_ptr(args.child_tid),
-		.parent_tid	=3D u64_to_user_ptr(args.parent_tid),
-		.exit_signal	=3D args.exit_signal,
-		.stack		=3D args.stack,
-		.stack_size	=3D args.stack_size,
-		.tls		=3D args.tls,
-		.set_tid_size	=3D args.set_tid_size,
+		.flags		    =3D args.flags,
+		.pidfd		    =3D u64_to_user_ptr(args.pidfd),
+		.child_tid	    =3D u64_to_user_ptr(args.child_tid),
+		.parent_tid	    =3D u64_to_user_ptr(args.parent_tid),
+		.exit_signal	    =3D args.exit_signal,
+		.stack		    =3D args.stack,
+		.stack_size	    =3D args.stack_size,
+		.tls		    =3D args.tls,
+		.set_tid_size	    =3D args.set_tid_size,
 		.timens_offset_size =3D args.timens_offset_size,
 	};
=20
--=20
2.24.1

