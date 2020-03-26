Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B89C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3120409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265167;
	bh=ILKBso8F8J3sD1EDPzbQdGO+8uM+4gF2bQRRPJShJQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XpJdkTxM1IioRJxMsUBekgIutGdSJ/NWgkSh9y6LQUJFZ8yaTkt3bsi9fwvA5QXWt
	 Z/kUXydiEorNpZdOvnicymZXs1vCAGnwpduZFb5SIg88RBbIAuMvBE5acWeqiDEo57
	 ngcfySaXO9I3qNL2g3P6aElFO9fb+344qw1L+ZFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgCZX0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgCZXZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A591E208E0;
        Thu, 26 Mar 2020 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265130;
        bh=ILKBso8F8J3sD1EDPzbQdGO+8uM+4gF2bQRRPJShJQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKgO5GCf4865GQ25a8HBOkaJRrw15lKeNCX627tcg+otY8m5DguABdhmz5nJ4Uuoq
         3futzYyLTkEeAsijRFPdAm7O7RPXPoOFYZMdg6En2U1xTH68Gjypwyrv/vVwmIaAON
         M0EMykWLccHkrr+DodUiOXO7H+qcsC9jpI93hY44=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.9 3/7] staging: greybus: loopback_test: fix potential path truncation
Date:   Thu, 26 Mar 2020 19:25:22 -0400
Message-Id: <20200326232526.8349-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232526.8349-1-sashal@kernel.org>
References: <20200326232526.8349-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit f16023834863932f95dfad13fac3fc47f77d2f29 ]

Newer GCC warns about a possible truncation of a generated sysfs path
name as we're concatenating a directory path with a file name and
placing the result in a buffer that is half the size of the maximum
length of the directory path (which is user controlled).

loopback_test.c: In function 'open_poll_files':
loopback_test.c:651:31: warning: '%s' directive output may be truncated writing up to 511 bytes into a region of size 255 [-Wformat-truncation=]
  651 |   snprintf(buf, sizeof(buf), "%s%s", dev->sysfs_entry, "iteration_count");
      |                               ^~
loopback_test.c:651:3: note: 'snprintf' output between 16 and 527 bytes into a destination of size 255
  651 |   snprintf(buf, sizeof(buf), "%s%s", dev->sysfs_entry, "iteration_count");
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by making sure the buffer is large enough the concatenated
strings.

Fixes: 6b0658f68786 ("greybus: tools: Add tools directory to greybus repo and add loopback")
Fixes: 9250c0ee2626 ("greybus: Loopback_test: use poll instead of inotify")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20200312110151.22028-3-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/tools/loopback_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index f7f4cd6fb55b3..9430f3e0162b5 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -646,7 +646,7 @@ int find_loopback_devices(struct loopback_test *t)
 static int open_poll_files(struct loopback_test *t)
 {
 	struct loopback_device *dev;
-	char buf[MAX_STR_LEN];
+	char buf[MAX_SYSFS_PATH + MAX_STR_LEN];
 	char dummy;
 	int fds_idx = 0;
 	int i;
-- 
2.20.1

