Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B6CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FA62080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iq7W+AY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgIGQ0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:26:31 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:13398 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbgIGQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599495986; x=1631031986;
  h=from:to:cc:subject:date:message-id;
  bh=VnpGX/rq2G60jYuw3svogFQniQh9VvXUtLdT7zfMxQA=;
  b=iq7W+AY3BPXmL7CprOnyVEJY2YBektUVHQuZV4KtoUds56RGblhkjQcO
   y/vOnavYBrOsA2ny3kokR9XDojIHK5UNc2cCYw5+aEz2+t56zF0Xe3Qcw
   yROPydvd4xSZtdnLByk4n0CHHMVTfE65NmBlzLyNIDlzKHQYnb5C+Y4Mk
   s=;
X-IronPort-AV: E=Sophos;i="5.76,402,1592870400"; 
   d="scan'208";a="52586337"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Sep 2020 16:26:24 +0000
Received: from uc85b769cb7f9591afac0.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 06CFDA252B;
        Mon,  7 Sep 2020 16:26:22 +0000 (UTC)
Received: from uc85b769cb7f9591afac0.ant.amazon.com (uc85b769cb7f9591afac0 [127.0.0.1])
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 087GQIbD010913;
        Mon, 7 Sep 2020 18:26:18 +0200
Received: (from markubo@localhost)
        by uc85b769cb7f9591afac0.ant.amazon.com (8.15.2/8.15.2/Submit) id 087GQHcc010906;
        Mon, 7 Sep 2020 18:26:17 +0200
From:   Markus Boehme <markubo@amazon.com>
To:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>,
        Markus Boehme <markubo@amazon.com>
Subject: [PATCH 1/3] ipmi: Reset response handler when failing to send the command
Date:   Mon,  7 Sep 2020 18:25:35 +0200
Message-Id: <1599495937-10654-1-git-send-email-markubo@amazon.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When failing to send a command we don't expect a response. Clear the
`null_user_handler` like is done in the success path.

Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 737c0b6..2b213c9 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2433,7 +2433,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
 
 	rv = send_get_device_id_cmd(intf);
 	if (rv)
-		return rv;
+		goto out_reset_handler;
 
 	wait_event(intf->waitq, bmc->dyn_id_set != 2);
 
@@ -2443,6 +2443,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
 	/* dyn_id_set makes the id data available. */
 	smp_rmb();
 
+out_reset_handler:
 	intf->null_user_handler = NULL;
 
 	return rv;
@@ -3329,6 +3330,7 @@ static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
 			dev_warn(intf->si_dev,
 				 "Error sending channel information for channel 0, %d\n",
 				 rv);
+			intf->null_user_handler = NULL;
 			return -EIO;
 		}
 
-- 
2.7.4

