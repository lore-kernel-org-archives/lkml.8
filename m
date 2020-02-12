Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC012C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBE920724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTd7o/yY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBLHDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:03:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgBLHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:03:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so580768pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0Uq9w8KRDPv2naiVGbzo1YruGuVK6eQQzWbOQYDeecw=;
        b=MTd7o/yYKoH1T6IbIIfsMprL4SAKxKNCgAZN5w35hXijDO9FHWh/oKlGsuq/htmkEF
         RLZzE8Djc6VkpDIMBJ+d7Uo3AGMWg10CotBhic4+GPYe+ULGt8msLWV8wbwdsFaXVvu9
         WHDMgF3h1aWYC/9eysN+J9tkQ6uOG72e0Woh3Gu6O5PF82+maktcY1QHKqsQ9n//+r8N
         VoZS4d3rPmKHaTUdUQW6Gxu2/DMfAGeRQtbEPpjaWdKJLgWaTUuMYdndvGNHh/fzU9/Q
         m0KyFcP28tAM5iG1BQqiEBuB3SNnMwU8kd6t7PcOhFunE2lOiFZt27xwK3rlkPJ1wUbM
         iuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0Uq9w8KRDPv2naiVGbzo1YruGuVK6eQQzWbOQYDeecw=;
        b=mawKP36HgIkQ10Rd4/Xm7D3AhpN1DvDCDbIYQHjAGNLv3XuxdmOhct2aQMauWDK1SB
         cIp/BGEvqTm2ghkb/Ctz08gVCiqBc1y4cDy4qZQKmQ4lgAcUrEdF2F3qobaL8RvtE3oP
         ntdGin8DdFCO5U0Ig7nc5UiejjwxrvvDDCFob6xIuC+hNA/wLXQkafZnLKwC6TEHv/DM
         yo5IwvTiVshTrJQlObi45Jb5szB4tYwg2yY+dWHE5kMvj37xOg/Lck3Lbaxid6YY8Zk3
         +nN80aP7Xqm7jsrNjbDn7w6DoPc2anu7UvZpVlfBBE08w0TiC1Cy7fKsLsMaje2mbz06
         M1kw==
X-Gm-Message-State: APjAAAXf6HzT3hHW6NnZl93VLe/jHiNHYAUYFGrEw4irEeoySyGpZnwG
        B+0k9nOjytTMFOCEefUOGEk=
X-Google-Smtp-Source: APXvYqxQkodvD6nB6JcwuOH1UJKapBinVfko7R6dPHJlDBd1FUj31O2XhtMRfbrarwSigqtb2G/bzg==
X-Received: by 2002:a17:90a:394d:: with SMTP id n13mr8404083pjf.1.1581491026134;
        Tue, 11 Feb 2020 23:03:46 -0800 (PST)
Received: from workstation-portable ([103.211.17.79])
        by smtp.gmail.com with ESMTPSA id y197sm6830998pfc.79.2020.02.11.23.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:03:45 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:33:37 +0530
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
Subject: [PATCH v3 RESEND] ipmi: msghandler: Pass lockdep expression to RCU
 lists
Message-ID: <20200212070337.GC14453@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1
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
v3:
- Remove rcu_read_lock_held() from lockdep expression since it is
  implicitly checked.
- Remove unintended macro usage.
 
v2:
- Fix sparse error
  CHECK: Alignment should match open parenthesis

 drivers/char/ipmi/ipmi_msghandler.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index cad9563f8f48..64ba16dcb681 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -618,6 +618,8 @@ static DEFINE_MUTEX(ipmidriver_mutex);
 
 static LIST_HEAD(ipmi_interfaces);
 static DEFINE_MUTEX(ipmi_interfaces_mutex);
+#define ipmi_interfaces_mutex_held() \
+	lockdep_is_held(&ipmi_interfaces_mutex)
 static struct srcu_struct ipmi_interfaces_srcu;
 
 /*
@@ -1321,7 +1323,8 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
 	 * synchronize_srcu()) then free everything in that list.
 	 */
 	mutex_lock(&intf->cmd_rcvrs_mutex);
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
 		if (rcvr->user == user) {
 			list_del_rcu(&rcvr->link);
 			rcvr->next = rcvrs;
@@ -1599,7 +1602,8 @@ static struct cmd_rcvr *find_cmd_rcvr(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & (1 << chan)))
 			return rcvr;
@@ -1614,7 +1618,8 @@ static int is_cmd_rcvr_exclusive(struct ipmi_smi *intf,
 {
 	struct cmd_rcvr *rcvr;
 
-	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link) {
+	list_for_each_entry_rcu(rcvr, &intf->cmd_rcvrs, link,
+				lockdep_is_held(&intf->cmd_rcvrs_mutex)) {
 		if ((rcvr->netfn == netfn) && (rcvr->cmd == cmd)
 					&& (rcvr->chans & chans))
 			return 0;
@@ -3450,7 +3455,8 @@ int ipmi_add_smi(struct module         *owner,
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

