Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C31C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1477C20409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265257;
	bh=8u+PO8O/rMMjysdIVDeLa8atUBZcBPK1uZYnnII1iNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WJrV3mH4fy7IBMra4jp9b9zVVlaQVnq4uzwNfnVIHpoazFSCG8catwlwVa4wqts5V
	 kQ/st7++8sd8j7yqdJSGuUyWgDeIDEYR2mdQkQAJwCg7E0mvB5rtimeFwFpXjS5h5R
	 ra+ydusRLMPS8P27b+yLnzyOjBhEW2pfsMAU0dd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgCZXYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgCZXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AF8208E4;
        Thu, 26 Mar 2020 23:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265082;
        bh=8u+PO8O/rMMjysdIVDeLa8atUBZcBPK1uZYnnII1iNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sivLjPAaOY7FKFO+qac28l2H0Ri6c2Xdl0OOG/HzArZdoKIqM63tklCa4sUMeXGFq
         Jk1gMa4QQhCB5ALpAuKta57iwjXn0lkgtYxAsxiJw6EvKAvydnTT2Oqhl6bF8gYwsD
         33b2KsyiSqgv4ApCvy0ykyRO5Pi1QwbBXWPK7QRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 09/19] staging: greybus: loopback_test: fix potential path truncations
Date:   Thu, 26 Mar 2020 19:24:21 -0400
Message-Id: <20200326232431.7816-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit ae62cf5eb2792d9a818c2d93728ed92119357017 ]

Newer GCC warns about possible truncations of two generated path names as
we're concatenating the configurable sysfs and debugfs path prefixes
with a filename and placing the results in buffers of the same size as
the maximum length of the prefixes.

	snprintf(d->name, MAX_STR_LEN, "gb_loopback%u", dev_id);

	snprintf(d->sysfs_entry, MAX_SYSFS_PATH, "%s%s/",
		 t->sysfs_prefix, d->name);

	snprintf(d->debugfs_entry, MAX_SYSFS_PATH, "%sraw_latency_%s",
		 t->debugfs_prefix, d->name);

Fix this by separating the maximum path length from the maximum prefix
length and reducing the latter enough to fit the generated strings.

Note that we also need to reduce the device-name buffer size as GCC
isn't smart enough to figure out that we ever only used MAX_STR_LEN
bytes of it.

Fixes: 6b0658f68786 ("greybus: tools: Add tools directory to greybus repo and add loopback")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20200312110151.22028-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/tools/loopback_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 5ce7d6fa086cc..3ee9109c38f60 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -19,6 +19,7 @@
 #include <signal.h>
 
 #define MAX_NUM_DEVICES 10
+#define MAX_SYSFS_PREFIX 0x80
 #define MAX_SYSFS_PATH	0x200
 #define CSV_MAX_LINE	0x1000
 #define SYSFS_MAX_INT	0x20
@@ -67,7 +68,7 @@ struct loopback_results {
 };
 
 struct loopback_device {
-	char name[MAX_SYSFS_PATH];
+	char name[MAX_STR_LEN];
 	char sysfs_entry[MAX_SYSFS_PATH];
 	char debugfs_entry[MAX_SYSFS_PATH];
 	struct loopback_results results;
@@ -93,8 +94,8 @@ struct loopback_test {
 	int stop_all;
 	int poll_count;
 	char test_name[MAX_STR_LEN];
-	char sysfs_prefix[MAX_SYSFS_PATH];
-	char debugfs_prefix[MAX_SYSFS_PATH];
+	char sysfs_prefix[MAX_SYSFS_PREFIX];
+	char debugfs_prefix[MAX_SYSFS_PREFIX];
 	struct timespec poll_timeout;
 	struct loopback_device devices[MAX_NUM_DEVICES];
 	struct loopback_results aggregate_results;
@@ -907,10 +908,10 @@ int main(int argc, char *argv[])
 			t.iteration_max = atoi(optarg);
 			break;
 		case 'S':
-			snprintf(t.sysfs_prefix, MAX_SYSFS_PATH, "%s", optarg);
+			snprintf(t.sysfs_prefix, MAX_SYSFS_PREFIX, "%s", optarg);
 			break;
 		case 'D':
-			snprintf(t.debugfs_prefix, MAX_SYSFS_PATH, "%s", optarg);
+			snprintf(t.debugfs_prefix, MAX_SYSFS_PREFIX, "%s", optarg);
 			break;
 		case 'm':
 			t.mask = atol(optarg);
@@ -961,10 +962,10 @@ int main(int argc, char *argv[])
 	}
 
 	if (!strcmp(t.sysfs_prefix, ""))
-		snprintf(t.sysfs_prefix, MAX_SYSFS_PATH, "%s", sysfs_prefix);
+		snprintf(t.sysfs_prefix, MAX_SYSFS_PREFIX, "%s", sysfs_prefix);
 
 	if (!strcmp(t.debugfs_prefix, ""))
-		snprintf(t.debugfs_prefix, MAX_SYSFS_PATH, "%s", debugfs_prefix);
+		snprintf(t.debugfs_prefix, MAX_SYSFS_PREFIX, "%s", debugfs_prefix);
 
 	ret = find_loopback_devices(&t);
 	if (ret)
-- 
2.20.1

