Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91345C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CAD206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0jzEtSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgAJQtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:49:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34896 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgAJQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:49:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so1262578pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brXuec6fVOc4dwf+FV3n+KOcRsO8MbgAaQ9yCNJ4rtQ=;
        b=n0jzEtSPIAyJr1b96PF8pKh1BWTiiObRYsejvJ/bLaoeNTrNPvcx8ERAFofXmXOLbx
         8j7k0EYBOesfQ/yyyg6PmulFcLdldU307A6tY9c6Z2QQIoIOenJnBmwc3CCEbSZHdA8v
         Nmmw3IsTeBCM7943yJN7PQOMKhPy1NmgsO2eKBuVFfxK90Je52sHonk9D0Qm1s6AuFHU
         n2gRNf06PQXXMIqnpSgTfdI15yr/MQZMC/wBcPpJz4JuMT2vCi5r/3weVEmx3VtQZmxS
         mhPXfKLEjQLZLi3zQWOKlcFmghSSUlqsviW4j/LaPdY/cRdmUMYUNc2izqC8gYjxfJKG
         cMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=brXuec6fVOc4dwf+FV3n+KOcRsO8MbgAaQ9yCNJ4rtQ=;
        b=NEBFUVGcpcDS0XrUYIhGy6gSLOTkP4O5gjivnSnM5F541T9giA+iXxSz6o6e25Slm7
         Nh77RtJvKm15gC+Ym01Bt0uk/6Vne1n/8Lr1JhEHvYpOJ3qF4PlBLA6p58YE966WF0y8
         dAdjciWxNpjtaWCvurDipv2vRYh8TBh4/e5WSSSNBXNBFsvBGtxfRP4QqczLMyCe9WeO
         gHCxVAee41JL7Vh5uLERAfypUgWwlCquPtE5xFkagLx2Vr+RrhBDvyY/UBDVb/VjC8mu
         L801q7DUVMWIfdfWGfrE2eRmH/jZzZ/e5X4OIfp1fH2zPyZB+jyHRSCENwIDS5uddfc+
         kZcA==
X-Gm-Message-State: APjAAAWlO/QwCWw8Ohfdkn9A8tqAxAUk+QQicVkrVua5h82FaM6cB12W
        /sQ61L7xoa4pFAZndo9p+bE=
X-Google-Smtp-Source: APXvYqwg1KhDgRTKcRKE4yl6HbIV3yB4bwewoheoY502mloPzg1d/sVq71GxLax/oMU9ZDd6AJNTwA==
X-Received: by 2002:a62:c541:: with SMTP id j62mr5172910pfg.237.1578674960543;
        Fri, 10 Jan 2020 08:49:20 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id h7sm3947538pfq.36.2020.01.10.08.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:49:20 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] drivers: char: ipmi: ipmi_msghandler: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 22:17:10 +0530
Message-Id: <20200110164709.26741-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

intf->cmd_rcvrs is traversed with list_for_each_entry_rcu
outside an RCU read-side critical section but under the
protection of intf->cmd_rcvrs_mutex.

ipmi_interfaces is traversed using list_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of ipmi_interfaces_mutex.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Fix sparse error
  CHECK: Alignment should match open parenthesis

 drivers/char/ipmi/ipmi_msghandler.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index cad9563f8f48..1cbeacb1e8b9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -35,6 +35,8 @@
 #include <linux/nospec.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
+#define cmd_rcvrs_mutex_held() \
+	lockdep_is_held(&intf->cmd_rcvrs_mutex)
 
 static struct ipmi_recv_msg *ipmi_alloc_recv_msg(void);
 static int ipmi_init_msghandler(void);
@@ -618,6 +620,8 @@ static DEFINE_MUTEX(ipmidriver_mutex);
 
 static LIST_HEAD(ipmi_interfaces);
 static DEFINE_MUTEX(ipmi_interfaces_mutex);
+#define ipmi_interfaces_mutex_held() \
+	lockdep_is_held(&ipmi_interfaces_mutex)
 static struct srcu_struct ipmi_interfaces_srcu;
 
 /*
@@ -1321,7 +1325,8 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 	 * synchronize_srcu()) then free everything in that list.
 	 */
 	mutex_lock(&intf->cmd_rcvrs_mutex);
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				cmd_rcvrs_mutex_held()) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
 			rcvr->next = rcvrs;
@@ -1599,7 +1604,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				rcu_read_lock_held() || cmd_rcvrs_mutex_held()) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & (1 << chan)))
 			return rcvr;
@@ -1614,7 +1620,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				cmd_rcvrs_mutex_held()) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & chans))
 			return 0;
@@ -3450,7 +3457,8 @@ int ipmi_add_smi(struct module         *owner,
 	/* Look for a hole in the numbers. */
 	i = 0;
 	link = &ipmi_interfaces;
-	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link,
+				ipmi_interfaces_mutex_held()) {
 		if (tintf->intf_num != i) {
 			link = &tintf->link;
 			break;
-- 
2.24.1

