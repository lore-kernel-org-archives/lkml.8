Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B7C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60858208E0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265123;
	bh=Vc/OQUeYv0IxdESW2NYabTodzPhNmsw/B3S4BdSrLPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sJqvH+7YPEulcUzmCAJb9fyD1FZMVkAsUw2aiUiGxvLgQ3aXIybSGC7GOpRxBniyu
	 fAsOch1OMYO3wI0B48zgt6AY2awgoCz+ZHRO4cwWvuSuId9ZY3KkjbMJsmeiYlqQJY
	 qgfUFw1ZASprh9SLQO801RG+acvfB+Ei7WL0Tzl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCZXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgCZXZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D7E4208E0;
        Thu, 26 Mar 2020 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265119;
        bh=Vc/OQUeYv0IxdESW2NYabTodzPhNmsw/B3S4BdSrLPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1VDoNyPrUjdahrWFLRwfpEJ4KWJeEZnC1ojpVioikJGO+/xl9sZkpoZdu4K/bTSWN
         xnGpKu8XEsJD5jibF+MZbIfl3TDM89GPQcopBRU2PFCyRoeRhpMWTp7NgtzqeFT5mI
         tp8iVlyMtiTEMs+P4JpRdpjpz24McucBn9Wcv5GQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 05/10] staging: greybus: loopback_test: fix potential path truncation
Date:   Thu, 26 Mar 2020 19:25:08 -0400
Message-Id: <20200326232513.8212-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232513.8212-1-sashal@kernel.org>
References: <20200326232513.8212-1-sashal@kernel.org>
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
index fbe589fca8408..ddea50523d562 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -644,7 +644,7 @@ int find_loopback_devices(struct loopback_test *t)
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

