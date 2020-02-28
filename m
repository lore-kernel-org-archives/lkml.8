Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A0FC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A27246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF8EzwU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgB1ITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:19:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34835 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgB1ITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:19:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so1344374pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 00:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82hR3jxtPv4UggNL0wzEkgrjlskYE39vomAxuJiCLBc=;
        b=lF8EzwU6FiMyfYM17VgdfJRlWA1Cngg7w662b4E4QrKszsubmtKTlYbyi5xobHoLQK
         3i6p/VlC6tP3jrlL++O+5zrHqkw+7BzZY5YEg9hT+d9iCru4cq++vUG6ZFd9758OuQMD
         a9X+2PvDkLyvjcKf6zLj6h/twbH9Wb8B+vH9dmkGPEQXqA53hWhTsPv25xz9sAKkSCT7
         TVN/jNsx5Q5wQb7mfmdqMiEtEjR6aTmAQDcq+a9WUjLqOmflo7sJbVnbx0yXZ81447nk
         /j1mmawMVmBu37FXmc0oIfCUnrDW8BmszNpbWdPIyfrTrYtfN5Kh5PvNHWuLrCMY9m+K
         21SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82hR3jxtPv4UggNL0wzEkgrjlskYE39vomAxuJiCLBc=;
        b=ud7mI9uRj/O1fF7r/WGVtnGvA1w87+EeJ5APiiLhuW6n4dimOkzbOYx6gAMOXr4RtC
         2XJutWXx7KXIncMKpDYfHE0WAun8e9d/K0c/D00A8Fq66F8YlvLp+7sdjJ/RAUIU5Gjf
         Sa0P2ojRXyhxn7mKc/RWPM6uK2pkx6tVgtlQCYQ2B39WYZ9B4PqpXjofA877IuutA4ys
         yz3Kd3DoanAodB6Z0bCZiVSkeqnD7kpFh/X2D54B67uwwugCj6M2v1jWOULR9xIDdika
         jTCS8JBGsnggSw3eLafl2jHnJ8T0mRYL5QRuNV19WgnraIat+KMvdljgy4zN459ulnhq
         Zl7Q==
X-Gm-Message-State: APjAAAVbvwatzjtF68L7yj7Yt9bBqyUGzn2Fk2NSg7Em/G1uGondUNtI
        7d+j9qP4HafeGN5nYeVh1cI=
X-Google-Smtp-Source: APXvYqziHDDhfs5tzanK2PouHCdpnTx5zN5eNwSrR+ezntHCZVaBiSIlLux4fDYTeNcdcrX8aNgYkQ==
X-Received: by 2002:a62:e708:: with SMTP id s8mr3377192pfh.122.1582877972863;
        Fri, 28 Feb 2020 00:19:32 -0800 (PST)
Received: from localhost.localdomain ([103.87.56.81])
        by smtp.gmail.com with ESMTPSA id w18sm10370516pfq.167.2020.02.28.00.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 00:19:31 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        John Garry <john.garry@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . Mckenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] ipmi: Fix RCU list lockdep debugging warnings
Date:   Fri, 28 Feb 2020 13:47:33 +0530
Message-Id: <20200228081731.18149-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is completely safe to traverse ipmi_interfaces and
intf->users under SRCU read lock using list_for_each_entry_rcu().
Tell lockdep about it as well else it will show false-positive
warnings as the one below.

Fixes the following false-positive warning and others that may follow.

[   29.772408] =============================
[   29.776863] WARNING: suspicious RCU usage
[   29.780915] 5.6.0-rc3-00001-g907305ae6618-dirty #1755 Not tainted
[   29.787046] -----------------------------
[   29.791100] drivers/char/ipmi/ipmi_msghandler.c:744 RCU-list traversed in
non-reader section!!

Reported-by: John Garry <john.garry@huawei.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index cad9563f8f48..d202022c69de 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -741,7 +741,8 @@ int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
 	list_add(&watcher->link, &smi_watchers);
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
+				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
 		int intf_num = READ_ONCE(intf->intf_num);
 
 		if (intf_num == -1)
@@ -1188,7 +1189,8 @@ int ipmi_create_user(unsigned int          if_num,
 		return -ENOMEM;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
+				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
 		if (intf->intf_num == if_num)
 			goto found;
 	}
@@ -1241,7 +1243,8 @@ int ipmi_get_smi_info(int if_num, struct ipmi_smi_info *data)
 	struct ipmi_smi *intf;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
+				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
 		if (intf->intf_num == if_num)
 			goto found;
 	}
@@ -4098,7 +4101,8 @@ static int handle_read_event_rsp(struct ipmi_smi *intf,
 	 * getting events.
 	 */
 	index = srcu_read_lock(&intf->users_srcu);
-	list_for_each_entry_rcu(user, &intf->users, link) {
+	list_for_each_entry_rcu(user, &intf->users, link,
+				srcu_read_lock_held(&intf->users_srcu)) {
 		if (!user->gets_events)
 			continue;
 
@@ -4453,7 +4457,8 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
 		int index;
 
 		index = srcu_read_lock(&intf->users_srcu);
-		list_for_each_entry_rcu(user, &intf->users, link) {
+		list_for_each_entry_rcu(user, &intf->users, link,
+					srcu_read_lock_held(&intf->users_srcu)) {
 			if (user->handler->ipmi_watchdog_pretimeout)
 				user->handler->ipmi_watchdog_pretimeout(
 					user->handler_data);
@@ -4746,7 +4751,8 @@ static void ipmi_timeout(struct timer_list *unused)
 		return;
 
 	index = srcu_read_lock(&ipmi_interfaces_srcu);
-	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
+	list_for_each_entry_rcu(intf, &ipmi_interfaces, link,
+				srcu_read_lock_held(&ipmi_interfaces_srcu)) {
 		if (atomic_read(&intf->event_waiters)) {
 			intf->ticks_to_req_ev--;
 			if (intf->ticks_to_req_ev == 0) {
-- 
2.25.0

