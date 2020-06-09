Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1E52074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgFISMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:12:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41206 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732839AbgFISF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:56 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidE-0001oU-Vv; Tue, 09 Jun 2020 19:05:53 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidE-006Vv1-E9; Tue, 09 Jun 2020 19:05:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paul Moore" <pmoore@redhat.com>,
        "Richard Guy Briggs" <rgb@redhat.com>
Date:   Tue, 09 Jun 2020 19:04:03 +0100
Message-ID: <lsq.1591725832.608123328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 12/61] selinux: convert WARN_ONCE() to printk() in
 selinux_nlmsg_perm()
In-Reply-To: <lsq.1591725831.850867383@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.85-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Guy Briggs <rgb@redhat.com>

commit d950f84c1c6658faec2ecbf5b09f7e7191953394 upstream.

Convert WARN_ONCE() to printk() in selinux_nlmsg_perm().

After conversion from audit_log() in commit e173fb26, WARN_ONCE() was
deemed too alarmist, so switch it to printk().

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
[PM: Changed to printk(WARNING) so we catch all of the different
 invalid netlink messages.  In Richard's defense, he brought this
 point up earlier, but I didn't understand his point at the time.]
Signed-off-by: Paul Moore <pmoore@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/selinux/hooks.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4683,9 +4683,10 @@ static int selinux_nlmsg_perm(struct soc
 	err = selinux_nlmsg_lookup(sksec->sclass, nlh->nlmsg_type, &perm);
 	if (err) {
 		if (err == -EINVAL) {
-			WARN_ONCE(1, "selinux_nlmsg_perm: unrecognized netlink message:"
-				  " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
-				  sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
+			printk(KERN_WARNING
+			       "SELinux: unrecognized netlink message:"
+			       " protocol=%hu nlmsg_type=%hu sclass=%hu\n",
+			       sk->sk_protocol, nlh->nlmsg_type, sksec->sclass);
 			if (!selinux_enforcing || security_get_allow_unknown())
 				err = 0;
 		}

