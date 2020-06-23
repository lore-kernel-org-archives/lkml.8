Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6568C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BDF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592934213;
	bh=vdb3TveFjyvQks47AHenerdqgenOBvw1z+LsNwim0kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RH9ElquQS12e0CEdhFxwi8j5KRgNO4fdGGroPEEYsHNA9M/dt7iKRa0ywPr1Rdz6O
	 BLKRR82B0uUevSGHe+ikhTS0rpsv2lS3QjmObkpr/l27mIAdIiM9E8kbx9TAXyXzq8
	 yvxoDgdDcccU5EpaJ03OPOf/w3t+7FODR2YfiJCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgFWRfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbgFWRfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AFD720781;
        Tue, 23 Jun 2020 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933733;
        bh=vdb3TveFjyvQks47AHenerdqgenOBvw1z+LsNwim0kQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLNkOuHbMVdK5S79oDNOl+JlhqPAB58SCoLvZuPGy6ypObM002S9nreR/lAuMZS62
         um3M+p0nFH8vHKlC+deWdg1MM/sN3/IbA8P9XSgn/JSKjrBjUCgbOrZ8BtfbL0U6Vp
         YUg6dtggA/4iM+gDnTLC7KAImq+AVbqpm/RO6VuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.7 08/28] ibmvnic: Harden device login requests
Date:   Tue, 23 Jun 2020 13:35:03 -0400
Message-Id: <20200623173523.1355411-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit dff515a3e71dc8ab3b9dcc2e23a9b5fca88b3c18 ]

The VNIC driver's "login" command sequence is the final step
in the driver's initialization process with device firmware,
confirming the available device queue resources to be utilized
by the driver. Under high system load, firmware may not respond
to the request in a timely manner or may abort the request. In
such cases, the driver should reattempt the login command
sequence. In case of a device error, the number of retries
is bounded.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 197dc5b2c0905..c265917487e84 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -842,12 +842,13 @@ static int ibmvnic_login(struct net_device *netdev)
 	struct ibmvnic_adapter *adapter = netdev_priv(netdev);
 	unsigned long timeout = msecs_to_jiffies(30000);
 	int retry_count = 0;
+	int retries = 10;
 	bool retry;
 	int rc;
 
 	do {
 		retry = false;
-		if (retry_count > IBMVNIC_MAX_QUEUES) {
+		if (retry_count > retries) {
 			netdev_warn(netdev, "Login attempts exceeded\n");
 			return -1;
 		}
@@ -862,11 +863,23 @@ static int ibmvnic_login(struct net_device *netdev)
 
 		if (!wait_for_completion_timeout(&adapter->init_done,
 						 timeout)) {
-			netdev_warn(netdev, "Login timed out\n");
-			return -1;
+			netdev_warn(netdev, "Login timed out, retrying...\n");
+			retry = true;
+			adapter->init_done_rc = 0;
+			retry_count++;
+			continue;
 		}
 
-		if (adapter->init_done_rc == PARTIALSUCCESS) {
+		if (adapter->init_done_rc == ABORTED) {
+			netdev_warn(netdev, "Login aborted, retrying...\n");
+			retry = true;
+			adapter->init_done_rc = 0;
+			retry_count++;
+			/* FW or device may be busy, so
+			 * wait a bit before retrying login
+			 */
+			msleep(500);
+		} else if (adapter->init_done_rc == PARTIALSUCCESS) {
 			retry_count++;
 			release_sub_crqs(adapter, 1);
 
-- 
2.25.1

