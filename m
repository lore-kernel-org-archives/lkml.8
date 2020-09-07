Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB66C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE11A207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KuZEr/OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbgIGQ1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:27:35 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:63535 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbgIGQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599496025; x=1631032025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gaoG8GkE3nCA4mq3eby4DI5ttGvtMXjTHUELrf0upLM=;
  b=KuZEr/OKVBYabHBEOvW6/MhQso5OuIgrpTp6HwZbcku4/3dVaWhwwEqP
   9fPpRB7tsbrC5n+Y4ZNwT7km55Oc2yWqtoLxaF/jm2bVTXpmP60wgGRuL
   v/wnydL0nVocX+DNXs4h1D7ANWv9NXYUwHEqhKJTSFSlT1ZyNT8lFQaNn
   I=;
X-IronPort-AV: E=Sophos;i="5.76,402,1592870400"; 
   d="scan'208";a="73024410"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 07 Sep 2020 16:27:00 +0000
Received: from uc85b769cb7f9591afac0.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id BC317A2086;
        Mon,  7 Sep 2020 16:26:57 +0000 (UTC)
Received: from uc85b769cb7f9591afac0.ant.amazon.com (uc85b769cb7f9591afac0 [127.0.0.1])
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 087GQr5S011096;
        Mon, 7 Sep 2020 18:26:53 +0200
Received: (from markubo@localhost)
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Submit) id 087GQqSn011091;
        Mon, 7 Sep 2020 18:26:52 +0200
From:   Markus Boehme <markubo@amazon.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>,
        Markus Boehme <markubo@amazon.com>
Subject: [PATCH 3/3] ipmi: Add timeout waiting for channel information
Date:   Mon,  7 Sep 2020 18:25:37 +0200
Message-Id: <1599495937-10654-3-git-send-email-markubo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599495937-10654-1-git-send-email-markubo@amazon.com>
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed hosts with misbehaving BMCs that receive a Get Channel
Info command but don't respond. This leads to an indefinite wait in the
ipmi_msghandler's __scan_channels function, showing up as hung task
messages for modprobe.

Add a timeout waiting for the channel scan to complete. If the scan
fails to complete within that time, treat that like IPMI 1.0 and only
assume the presence of the primary IPMB channel at channel number 0.

Signed-off-by: Stefan Nuernberger <snu@amazon.com>
Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 72 ++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 2a2e8b2..9de9ba6 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3315,46 +3315,52 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
  */
 static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
 {
-	int rv;
+	long rv;
+	unsigned int set;
 
-	if (ipmi_version_major(id) > 1
-			|| (ipmi_version_major(id) == 1
-			    && ipmi_version_minor(id) >= 5)) {
-		unsigned int set;
+	if (ipmi_version_major(id) == 1 && ipmi_version_minor(id) < 5) {
+		set = intf->curr_working_cset;
+		goto single_ipmb_channel;
+	}
 
-		/*
-		 * Start scanning the channels to see what is
-		 * available.
-		 */
-		set = !intf->curr_working_cset;
-		intf->curr_working_cset = set;
-		memset(&intf->wchannels[set], 0,
-		       sizeof(struct ipmi_channel_set));
-
-		intf->null_user_handler = channel_handler;
-		intf->curr_channel = 0;
-		rv = send_channel_info_cmd(intf, 0);
-		if (rv) {
-			dev_warn(intf->si_dev,
-				 "Error sending channel information for channel 0, %d\n",
-				 rv);
-			intf->null_user_handler = NULL;
-			return -EIO;
-		}
+	/*
+	 * Start scanning the channels to see what is
+	 * available.
+	 */
+	set = !intf->curr_working_cset;
+	intf->curr_working_cset = set;
+	memset(&intf->wchannels[set], 0, sizeof(struct ipmi_channel_set));
 
-		/* Wait for the channel info to be read. */
-		wait_event(intf->waitq, intf->channels_ready);
+	intf->null_user_handler = channel_handler;
+	intf->curr_channel = 0;
+	rv = send_channel_info_cmd(intf, 0);
+	if (rv) {
+		dev_warn(intf->si_dev,
+			 "Error sending channel information for channel 0, %ld\n",
+			 rv);
 		intf->null_user_handler = NULL;
-	} else {
-		unsigned int set = intf->curr_working_cset;
+		return -EIO;
+	}
 
-		/* Assume a single IPMB channel at zero. */
-		intf->wchannels[set].c[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
-		intf->wchannels[set].c[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
-		intf->channel_list = intf->wchannels + set;
-		intf->channels_ready = true;
+	/* Wait for the channel info to be read. */
+	rv = wait_event_timeout(intf->waitq, intf->channels_ready, 5 * HZ);
+	if (rv == 0) {
+		dev_warn(intf->si_dev,
+			 "Timed out waiting for channel information. Assuming a single IPMB channel at 0.\n");
+		goto single_ipmb_channel;
 	}
 
+	goto out;
+
+single_ipmb_channel:
+	/* Assume a single IPMB channel at zero. */
+	intf->wchannels[set].c[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
+	intf->wchannels[set].c[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
+	intf->channel_list = intf->wchannels + set;
+	intf->channels_ready = true;
+
+out:
+	intf->null_user_handler = NULL;
 	return 0;
 }
 
-- 
2.7.4

