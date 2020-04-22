Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36808C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7519B20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR2MPKUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgDVVhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:37:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgDVVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587591467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=F+pxzQP1T/d8OeigvUdVtvyNkolkdrIs1yX5zMm8Uc4=;
        b=VR2MPKUKHqVDkRBm17bKc+uQRp9RzcJvyUmHLu3Z9krq0DreXujGLBvvoqf1Bb1e/+6+Eb
        YFKMYvdc6BwQdjIEaC3NtVIApFlZplA/jN84jvTanZKCBT9zcWHgqoiPwIRw1VZgAK+GDT
        7ROu5KhP/1pAYvsCGJlFUfsRv9EGSzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-z7wRFVzaPn6i8Y-MU5_Quw-1; Wed, 22 Apr 2020 17:37:44 -0400
X-MC-Unique: z7wRFVzaPn6i8Y-MU5_Quw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93881801E7A;
        Wed, 22 Apr 2020 21:37:42 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC77C5DA7B;
        Wed, 22 Apr 2020 21:37:31 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak28 V8] audit: log audit netlink multicast bind and unbind events
Date:   Wed, 22 Apr 2020 17:37:04 -0400
Message-Id: <3623b9dba8068d1488681f62683bb42ad3f4debb.1587571187.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log information about programs connecting to and disconnecting from the
audit netlink multicast socket. This is needed so that during
investigations a security officer can tell who or what had access to the
audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
Criteria.

Here is the systemd startup event:
type=PROCTITLE msg=audit(2020-04-22 10:10:21.787:10) : proctitle=/init
type=SYSCALL msg=audit(2020-04-22 10:10:21.787:10) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x19 a1=0x555f4aac7e90 a2=0xc a3=0x7ffcb792ff44 items=0 ppid=0 pid=1 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=systemd exe=/usr/lib/systemd/systemd subj=kernel key=(null)
type=UNKNOWN[1335] msg=audit(2020-04-22 10:10:21.787:10) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes

And events from the test suite that just uses close():
type=PROCTITLE msg=audit(2020-04-22 11:47:08.501:442) : proctitle=/usr/bin/perl -w amcast_joinpart/test
type=SYSCALL msg=audit(2020-04-22 11:47:08.501:442) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x563004378760 a2=0xc a3=0x0 items=0 ppid=815 pid=818 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=UNKNOWN[1335] msg=audit(2020-04-22 11:47:08.501:442) : pid=818 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes

type=UNKNOWN[1335] msg=audit(2020-04-22 11:47:08.501:443) : pid=818 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes

And the events from the test suite using setsockopt with NETLINK_DROP_MEMBERSHIP:
type=PROCTITLE msg=audit(2020-04-22 11:39:53.291:439) : proctitle=/usr/bin/perl -w amcast_joinpart/test
type=SYSCALL msg=audit(2020-04-22 11:39:53.291:439) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x5560877c2d20 a2=0xc a3=0x0 items=0 ppid=772 pid=775 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=UNKNOWN[1335] msg=audit(2020-04-22 11:39:53.291:439) : pid=775 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes

type=PROCTITLE msg=audit(2020-04-22 11:39:53.292:440) : proctitle=/usr/bin/perl -w amcast_joinpart/test
type=SYSCALL msg=audit(2020-04-22 11:39:53.292:440) : arch=x86_64 syscall=setsockopt success=yes exit=0 a0=0x7 a1=SOL_NETLINK a2=0x2 a3=0x7ffc8366f000 items=0 ppid=772 pid=775 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=UNKNOWN[1335] msg=audit(2020-04-22 11:39:53.292:440) : pid=775 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes

Please see the upstream issue tracker at
  https://github.com/linux-audit/audit-kernel/issues/28
With the feature description at
  https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
The testsuite support is at
  https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join
  https://github.com/linux-audit/audit-testsuite/pull/93
And the userspace support patch is at
  https://github.com/linux-audit/audit-userspace/pull/114

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

---
Note: subj attrs included due to missing syscall record for disconnect on close
Note: tried refactor of subj attrs, but this is yet another new order.

Changelog:
v8:
- rebase on audit/next v5.7-rc1
- clean up patch description sample records

v7:
- rename audit_log_multicast_bind to audit_log_multicast

v6:
- rebased on 5.6-rc1 audit/next and audit log BPF
- updated patch description sample records

v5:
- rebased on 5.5-rc1 audit/next
- group bind/unbind ops
- add audit context
- justify message number skip
- check audit_enabled
- change field name from nlnk-grp to nl-mcgrp
- fix whitespace issues

v4:
- 2017-10-13 sgrubb
- squash to 1 patch
- rebase on KERN_MODULE event
- open code subj attrs

v3:
- 2016-11-30 sgrubb
- rebase on REPLACE event
- minimize audit_log_format calls
- rename audit_log_bind to audit_log_multicast_bind

v2:
- 2015-07-23 sgrubb
- spin off audit_log_task_simple in seperate patch

v1:
- 2014-10-07 rgb
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index a534d71e689a..9b6a973f4cc3 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -117,6 +117,7 @@
 #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
 #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 #define AUDIT_BPF		1334	/* BPF subsystem */
+#define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.c b/kernel/audit.c
index b69c8b460341..5c738cfb4a7e 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1522,20 +1522,60 @@ static void audit_receive(struct sk_buff  *skb)
 	audit_ctl_unlock();
 }
 
+/* Log information about who is connecting to the audit multicast socket */
+static void audit_log_multicast(int group, const char *op, int err)
+{
+	const struct cred *cred;
+	struct tty_struct *tty;
+	char comm[sizeof(current->comm)];
+	struct audit_buffer *ab;
+
+	if (!audit_enabled)
+		return;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_EVENT_LISTENER);
+	if (!ab)
+		return;
+
+	cred = current_cred();
+	tty = audit_get_tty();
+	audit_log_format(ab, "pid=%u uid=%u auid=%u tty=%s ses=%u",
+			 task_pid_nr(current),
+			 from_kuid(&init_user_ns, cred->uid),
+			 from_kuid(&init_user_ns, audit_get_loginuid(current)),
+			 tty ? tty_name(tty) : "(none)",
+			 audit_get_sessionid(current));
+	audit_put_tty(tty);
+	audit_log_task_context(ab); /* subj= */
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, get_task_comm(comm, current));
+	audit_log_d_path_exe(ab, current->mm); /* exe= */
+	audit_log_format(ab, " nl-mcgrp=%d op=%s res=%d", group, op, !err);
+	audit_log_end(ab);
+}
+
 /* Run custom bind function on netlink socket group connect or bind requests. */
-static int audit_bind(struct net *net, int group)
+static int audit_multicast_bind(struct net *net, int group)
 {
+	int err = 0;
+
 	if (!capable(CAP_AUDIT_READ))
-		return -EPERM;
+		err = -EPERM;
+	audit_log_multicast(group, "connect", err);
+	return err;
+}
 
-	return 0;
+static void audit_multicast_unbind(struct net *net, int group)
+{
+	audit_log_multicast(group, "disconnect", 0);
 }
 
 static int __net_init audit_net_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input	= audit_receive,
-		.bind	= audit_bind,
+		.bind	= audit_multicast_bind,
+		.unbind	= audit_multicast_unbind,
 		.flags	= NL_CFG_F_NONROOT_RECV,
 		.groups	= AUDIT_NLGRP_MAX,
 	};
-- 
1.8.3.1

