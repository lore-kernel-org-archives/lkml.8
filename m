Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8037C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B2620748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaocN2Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgAQUVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:21:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43755 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579292513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZvKx1Czra6EoUEQ9CtfFs9u9YO5nby30A33ADtqe8Fw=;
        b=RaocN2Vwf/tImWXVR8+fSdPluuI5ifkiM+SCllo7Dz+zE5ohbUec1Ea1Sb6R51Ljl3DkB/
        1qbEts1t2u44M0LLgIECEiUQCIuizEN7+L1duIqQS+TbUtuVEGQeWtA+BiMdnq1DkLC4v9
        F39pK2N2hg4YehIJR9LRkj2myrw3j5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-YS719jqoNNCqNbAlhgJREA-1; Fri, 17 Jan 2020 15:21:50 -0500
X-MC-Unique: YS719jqoNNCqNbAlhgJREA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 859018017CC;
        Fri, 17 Jan 2020 20:21:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3706460BE1;
        Fri, 17 Jan 2020 20:21:42 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, nhorman@redhat.com, eparis@parisplace.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak28 V4] audit: log audit netlink multicast bind and unbind events
Date:   Fri, 17 Jan 2020 15:21:02 -0500
Message-Id: <ca70ee17d85860aa599e0001a75d639d819de7ae.1579292286.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log information about programs connecting to and disconnecting from the
audit netlink multicast socket. This is needed so that during
investigations a security officer can tell who or what had access to the
audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
Criteria.  Here is the systemd startup event:

type=UNKNOWN[1335] msg=audit(2020-01-17 10:30:33.731:6) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes

And the events from the test suite:

type=PROCTITLE msg=audit(2020-01-17 10:36:24.050:294) : proctitle=/usr/bin/perl -w amcast_joinpart/test
type=SOCKADDR msg=audit(2020-01-17 10:36:24.050:294) : saddr={ saddr_fam=netlink nlnk-fam=16 nlnk-pid=0 }
type=SYSCALL msg=audit(2020-01-17 10:36:24.050:294) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x55d65cb79090 a2=0xc a3=0x0 items=0 ppid=671 pid=674 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=3 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.050:294) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes

type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes

Please see the upstream issue tracker:
  https://github.com/linux-audit/audit-kernel/issues/28
  https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
  https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

---
Note: msg type 1334 was skipped due to BPF accepted in another tree.
Note: v5 due to previous 2014-10-07, 2015-07-23, 2016-11-30, 2017-10-13
Note: subj attrs included due to missing syscall record for systemd (audit=1)
Note: tried refactor of subj attrs, but this is yet another new order.
---
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 3ad935527177..67fb24472dc2 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -116,6 +116,7 @@
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
 #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
 #define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
+#define AUDIT_EVENT_LISTENER	1335	/* Task joined multicast read socket */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/audit.c b/kernel/audit.c
index 17b0d523afb3..478259f3fa53 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1520,20 +1520,60 @@ static void audit_receive(struct sk_buff  *skb)
 	audit_ctl_unlock();
 }
 
+/* Log information about who is connecting to the audit multicast socket */
+static void audit_log_multicast_bind(int group, const char *op, int err)
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
+	audit_log_multicast_bind(group, "connect", err);
+	return err;
+}
 
-	return 0;
+static void audit_multicast_unbind(struct net *net, int group)
+{
+	audit_log_multicast_bind(group, "disconnect", 0);
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

