Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA74C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03302082F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460146;
	bh=Ko1ZhXCx4mPUi3PFsF4m7owQC8fH7OXNJhwIkoqVYA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1bH3G7RqesPDsbtflb0chM+IS3F64S37wXxT27BkxGN5nrUkUC18oc6lmjQvfb9+
	 cjCmdAyswORNfuYzI2drCJK5eqBocJN14ddA+s4yh8oUHQQpteqV/02duB55tYTPtn
	 5hiWLnb1B98xxeI5Fxxo5hAEtW+UzMKlVYeRN1pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgF2Ts6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbgF2Tkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9B6248F1;
        Mon, 29 Jun 2020 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444444;
        bh=Ko1ZhXCx4mPUi3PFsF4m7owQC8fH7OXNJhwIkoqVYA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyVXANs6yDNJEHOXXfwfe7ptAQmU82yO+tKpxRBKqtTQEzHaSWbmamnd60Cfzm3Iw
         LjiWNK+t6Vrb5xXjAN4BDYKgqWnAjtpBkIFNFdpMAq3/hXPny8Mh64mL2zhSDY9yVp
         aRl6UeIOA9Q0aEzeNBcuX6tx0/uJ2VWDjeGYZnts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 123/178] ibmvnic: Harden device login requests
Date:   Mon, 29 Jun 2020 11:24:28 -0400
Message-Id: <20200629152523.2494198-124-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
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
index 5a42ddeecfe50..4f503b9a674c4 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -779,12 +779,13 @@ static int ibmvnic_login(struct net_device *netdev)
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
@@ -799,11 +800,23 @@ static int ibmvnic_login(struct net_device *netdev)
 
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

