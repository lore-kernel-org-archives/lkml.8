Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5EAC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02E92073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGwKWFKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgAQN2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:28:20 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42967 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:28:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so11969385pfz.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Uq9w8KRDPv2naiVGbzo1YruGuVK6eQQzWbOQYDeecw=;
        b=KGwKWFKU8LpyyRPZZIjn241CT5YAMcsFkRMS+vcUU6Je9CLIHqi9KEsRG4O9zYbk/K
         CTzDWNvPcyEppR+1PrMUEclVDew8SRrSgPmu2kKu8VJRoZ9zPOWucfSNBDxyEL3QvIAn
         nOkR5Hwn6wa/UYgS+dyHidzR8Y5c9EQf7wORozmG5TEGsoSZCWZWX37qeWxU0tCx+OnT
         nv0wcfy3+xUicbIu1uTVyRU/jyZ2sIGQTZxnZhJMjwmUXAj+s3dR3lgUkcdNnRCPxLYL
         bLjfBjTD9xJl45zF+TnjXx/v73Vnh/tgZbjdVJD8JBisXrb2v/P2AsVANsj6YkWyrvJN
         YhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Uq9w8KRDPv2naiVGbzo1YruGuVK6eQQzWbOQYDeecw=;
        b=A3uWlbN/XNkvb3xKdBRS1S0EdPeEZrCGAsUW0LItjOERsrJ0okMxw2i8NqvDxf4MWB
         qxCqFq6BV5MIJHFOSmMrduJebed0YzblPGjHFe2/1l6dkcmcGdRvDcC20vflWVGNDFeS
         QQT2in5UhCz3wB4781szCsSZHfbbD/7uUDFBanenBl5CsRSlaS5p1IO4PRX+9f51sPtr
         ukuz2+R/Sm6SwLhEjzM23xH4XVheuLwJ7KOndID0F1AaQeyRv5O94PI6Ob7u3/t3mQkf
         Fp/lxvy1t32BljgieGjMXLbrFzByBZ/k39JvgjuYKGYkKLt1iV35WK/cRUWmtklMplAI
         BRVA==
X-Gm-Message-State: APjAAAWQ4xjJNhlr56d9HUPOR8X0NBSsRAJcgq9EI+mKwI8GlphV7ipS
        i21L+g2PAIEKMnD9Uk/iouM=
X-Google-Smtp-Source: APXvYqyRa5bPkS0cG3zloOH2k5dMVEL4C0YaP/hjBpfFF4s/zTbF/WZZ2pyaRtjPo4Vg3Yz+SB8szw==
X-Received: by 2002:a63:28c7:: with SMTP id o190mr44013043pgo.394.1579267699670;
        Fri, 17 Jan 2020 05:28:19 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.168])
        by smtp.googlemail.com with ESMTPSA id i3sm30798353pfo.72.2020.01.17.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:28:18 -0800 (PST)
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
Subject: [PATCH v3] drivers: char: ipmi: ipmi_msghandler: Pass lockdep expression to RCU lists
Date:   Fri, 17 Jan 2020 18:55:22 +0530
Message-Id: <20200117132521.31020-1-frextrite@gmail.com>
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

