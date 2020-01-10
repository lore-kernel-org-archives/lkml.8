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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20264C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10732072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyJDmw1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgAJMSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:18:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35156 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgAJMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:18:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so809792plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 04:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34rCBCNBrLFlE6OZuubd6Z6OlOWhV0HGucVsYoePbqA=;
        b=AyJDmw1nfTmU38bLxh+Zgeu6ZVenlE9iZh5wgKN+xTCCcVbRXd9o/heLIU/pN6gucy
         +x5Tsci0dO8ZhS0dQsBFg5t6DZIgfpU5hJ3dQgkh4Hr0FvQ3c1MCVSdIux67XzFt1JAN
         swqPk6+jTakkB2XfeIbBenGxQxjLc+3Vu0tDUnHnT0MFTrjWU9bMvxEumVbT2V0IH2k3
         NKMn8E3yiX+w12LiWcL2SWzxnYU4T0LCidiwLYIKi9lxQzBvfqDxICtapnipP+9jxEuS
         TohB1N+FcisEX8rLBfH9FIqKIemfV8QvJoxW17SQIC8NKLfxpFYpoySyD9/uqs5nLHRv
         HPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34rCBCNBrLFlE6OZuubd6Z6OlOWhV0HGucVsYoePbqA=;
        b=BKxksYhafmuwAt+6GT/rmpEJx04lLTeC5faIBmblfZMX4RDbQwLJcs+4EtgnElSJ3Y
         4aX3y2nkj6rtkqaeVLHOnKn2Ouhq1/xLAqH2twIFfjBr48ZI6Wl30vNSTDdNshUVr2PY
         idFO6deBjUQNDJvEoIywwTAVOldtNykdBQl7raR28M9SNgAkUJZWThPcROJIzhp8fDnk
         lMsV8xttLTHCzZUpNo7U7GkHmt/4FyYgc6ZYB+aabm0L6uxSEZWjUqHKTtKwoMYwV73H
         2mkD2K8Mqw72fCt4fmaGsKl3jTLaithVN45esKjct3xLxYbRzurNXa1ri6amM12bJoC9
         VbDQ==
X-Gm-Message-State: APjAAAXKuXjE0t++QjOjjwIotzjK89t/mTqAcORRAI/FXEtt0LhH2+UH
        QFxRSulqsTPpg7QN7vQXGuc=
X-Google-Smtp-Source: APXvYqwC+PRY9JeuUX6ytka2wfVtRm/TMSWCLgftycjUZOj9TUHFQKY/Dli2kVHoe5tJT3gd4K9HVw==
X-Received: by 2002:a17:90a:10c8:: with SMTP id b8mr4336581pje.92.1578658722987;
        Fri, 10 Jan 2020 04:18:42 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id m128sm2774523pfm.183.2020.01.10.04.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 04:18:42 -0800 (PST)
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
Subject: [PATCH] drivers: char: ipmi: ipmi_msghandler: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 17:43:42 +0530
Message-Id: <20200110121341.31522-1-frextrite@gmail.com>
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
 drivers/char/ipmi/ipmi_msghandler.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index cad9563f8f48..7eff0335bc82 100644
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
+					cmd_rcvrs_mutex_held()) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
 			rcvr->next = rcvrs;
@@ -1599,7 +1604,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+			rcu_read_lock_held() || cmd_rcvrs_mutex_held()) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & (1 << chan)))
 			return rcvr;
@@ -1614,7 +1620,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+					cmd_rcvrs_mutex_held()) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & chans))
 			return 0;
@@ -3450,7 +3457,8 @@ int ipmi_add_smi(struct module         *owner,
 	/* Look for a hole in the numbers. */
 	i = 0;
 	link = &ipmi_interfaces;
-	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(tintf, &ipmi_interfaces, link,
+					ipmi_interfaces_mutex_held()) {
 		if (tintf->intf_num != i) {
 			link = &tintf->link;
 			break;
-- 
2.24.1

