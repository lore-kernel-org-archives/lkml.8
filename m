Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4638520757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cYbN15Mw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgIGQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:27:44 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9329 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgIGQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599496029; x=1631032029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4O0QSxUDD3xeMWzO7pM0jb9DlbqpoAGCZgcqvEe0STI=;
  b=cYbN15MwAPJKke5qCKcZoSdF8G88iNwIhxPzDYPKa+1wWJSmJTDsX953
   8FQb/rCFGryaukvyp7YLHgtESPBtGD1vqo+wMFMC5Ljo9d4hsQOANg1yf
   TOwHH2KeZMV+GVCVeIRcAaPAOYIq/CHYz3UsEJIJP1OzawjIBnVlMjt3m
   c=;
X-IronPort-AV: E=Sophos;i="5.76,402,1592870400"; 
   d="scan'208";a="74236825"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Sep 2020 16:26:46 +0000
Received: from uc85b769cb7f9591afac0.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id E3162A045E;
        Mon,  7 Sep 2020 16:26:44 +0000 (UTC)
Received: from uc85b769cb7f9591afac0.ant.amazon.com (uc85b769cb7f9591afac0 [127.0.0.1])
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 087GQfm3011020;
        Mon, 7 Sep 2020 18:26:41 +0200
Received: (from markubo@localhost)
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Submit) id 087GQeTL011013;
        Mon, 7 Sep 2020 18:26:40 +0200
From:   Markus Boehme <markubo@amazon.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>,
        Markus Boehme <markubo@amazon.com>
Subject: [PATCH 2/3] ipmi: Add timeout waiting for device GUID
Date:   Mon,  7 Sep 2020 18:25:36 +0200
Message-Id: <1599495937-10654-2-git-send-email-markubo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599495937-10654-1-git-send-email-markubo@amazon.com>
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed hosts with misbehaving BMCs that receive a Get Device
GUID command but don't respond. This leads to an indefinite wait in the
ipmi_msghandler's __get_guid function, showing up as hung task messages
for modprobe.

According to IPMI 2.0 specification chapter 20, the implementation of
the Get Device GUID command is optional. Therefore, add a timeout to
waiting for its response and treat the lack of one the same as missing a
device GUID.

Signed-off-by: Stefan Nuernberger <snu@amazon.com>
Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2b213c9..2a2e8b2 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3184,18 +3184,26 @@ static void guid_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
 
 static void __get_guid(struct ipmi_smi *intf)
 {
-	int rv;
+	long rv;
 	struct bmc_device *bmc = intf->bmc;
 
 	bmc->dyn_guid_set = 2;
 	intf->null_user_handler = guid_handler;
 	rv = send_guid_cmd(intf, 0);
-	if (rv)
+	if (rv) {
 		/* Send failed, no GUID available. */
 		bmc->dyn_guid_set = 0;
-	else
-		wait_event(intf->waitq, bmc->dyn_guid_set != 2);
+		goto out;
+	}
 
+	rv = wait_event_timeout(intf->waitq, bmc->dyn_guid_set != 2, 5 * HZ);
+	if (rv == 0) {
+		dev_warn_once(intf->si_dev,
+			      "Timed out waiting for GUID. Assuming GUID is not available.\n");
+		bmc->dyn_guid_set = 0;
+	}
+
+out:
 	/* dyn_guid_set makes the guid data available. */
 	smp_rmb();
 
-- 
2.7.4

