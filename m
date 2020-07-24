Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713F4206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+rUbDNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGXJPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgGXJPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:15:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8241C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:15:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j187so9704671ybj.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=igO9PGS75sNuJ8Wtx045r3V9fh7O7ARU1wRPKhhhbQE=;
        b=R+rUbDNs7Bx8jqcdI/0YnjROZGc4JO11o3nTpLn5lsj9M24wu/7TLUpdRlFQsdGfCa
         6h8fwusAeBgzGxpmkfcbnTF8ArO9m1/wwq8SJ52rtE4kbBKp0UB0GhxYoINnPgvXBPio
         Xbl6/B7Roex2OG0din1MoSF8GcXY2ufWoCWrOJy8Ilhr9xM+ymkn4Qe8CoqsnZ2Q6LCb
         0uLmPj0Hkq0xoCiU9GSmZoP+E8EizD92Yu7oYgDE+VbNfMObA6Jz2pF10TBEJ8iLaW0Y
         Pfcx8bnuvf0qigg9i+8Rm39+1xqJRhKfD0LVwRMWZRXtYLzd+TVKnPKrG/TVJmoZzZL/
         tSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=igO9PGS75sNuJ8Wtx045r3V9fh7O7ARU1wRPKhhhbQE=;
        b=tAABIj5VYcbjIB880nKUsOjofWLXCbe+weEf3SGAUgKybfWpkIii/d1kjXkIojeqoe
         WgKbOzMqiMZ7UcvnA1xpVNvyKu25FARSqAuaWk8/bDyLvPAH1QU5aJw/PyiBbDh8K89d
         jbfi93yblXZlOkJs77DAvahlGBFUVTRbAC/KxDfYrWnL9RrBbicn2aYD53GS4ufXk++P
         7RvIKdSnxR6G5XJBeazTghbWlFqPznWNFI6C3XLoMWiW0TrfNuLCmMSEQKBN9fSsNR+x
         crNQ9ItEj36H8ThzAPXC+quZt5mdYNg/pF7HyRLgQ7xW7238kaHX48YbNq4s0kXdoAJ1
         1LOg==
X-Gm-Message-State: AOAM531ktmxeO5mL/El83F0cEgdxkpcpNhhK/vUNKG3FDyRCxx83PqLh
        t7iHIb4npAPkk6j7D8qnKiKWlUPNYA==
X-Google-Smtp-Source: ABdhPJxBSbg2aspYRo4mU3t74skGgXHjg4D4uwizYyZEnFxQ3NDgIaIEeQc0fTaUkekLPb35WUE5II5lwg==
X-Received: by 2002:a5b:449:: with SMTP id s9mr2280682ybp.465.1595582143955;
 Fri, 24 Jul 2020 02:15:43 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:15:03 +0200
Message-Id: <20200724091520.880211-1-tweek@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH] selinux: add tracepoint on denials
From:   "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audit data currently captures which process and which target
is responsible for a denial. There is no data on where exactly in the
process that call occurred. Debugging can be made easier by being able to
reconstruct the unified kernel and userland stack traces [1]. Add a
tracepoint on the SELinux denials which can then be used by userland
(i.e. perf).

Although this patch could manually be added by each OS developer to
trouble shoot a denial, adding it to the kernel streamlines the
developers workflow.

[1] https://source.android.com/devices/tech/debug/native_stack_dump

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Signed-off-by: Joel Fernandes <joelaf@google.com>
---
 MAINTAINERS                    |  1 +
 include/trace/events/selinux.h | 35 ++++++++++++++++++++++++++++++++++
 security/selinux/avc.c         |  6 ++++++
 3 files changed, 42 insertions(+)
 create mode 100644 include/trace/events/selinux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e64cdde81851..6b6cd5e13537 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,6 +15358,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/gi=
t/pcmoore/selinux.git
 F:	Documentation/ABI/obsolete/sysfs-selinux-checkreqprot
 F:	Documentation/ABI/obsolete/sysfs-selinux-disable
 F:	Documentation/admin-guide/LSM/SELinux.rst
+F:	include/trace/events/selinux.h
 F:	include/uapi/linux/selinux_netlink.h
 F:	scripts/selinux/
 F:	security/selinux/
diff --git a/include/trace/events/selinux.h b/include/trace/events/selinux.=
h
new file mode 100644
index 000000000000..e247187a8135
--- /dev/null
+++ b/include/trace/events/selinux.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM selinux
+
+#if !defined(_TRACE_SELINUX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SELINUX_H
+
+#include <linux/ktime.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(selinux_denied,
+
+	TP_PROTO(int cls, int av),
+
+	TP_ARGS(cls, av),
+
+	TP_STRUCT__entry(
+		__field(int, cls)
+		__field(int, av)
+	),
+
+	TP_fast_assign(
+		__entry->cls =3D cls;
+		__entry->av =3D av;
+	),
+
+	TP_printk("denied %d %d",
+		__entry->cls,
+		__entry->av)
+);
+
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..85d2e22ab656 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -31,6 +31,9 @@
 #include "avc_ss.h"
 #include "classmap.h"
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/selinux.h>
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
@@ -672,6 +675,9 @@ static void avc_audit_pre_callback(struct audit_buffer =
*ab, void *a)
 		return;
 	}
=20
+	if (sad->denied)
+		trace_selinux_denied(sad->tclass, av);
+
 	perms =3D secclass_map[sad->tclass-1].perms;
=20
 	audit_log_format(ab, " {");
--=20
2.28.0.rc0.142.g3c755180ce-goog

