Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5121DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B120658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759358;
	bh=0G8P3DF8fKF5Qx0/mGMaQWMIsrrbrBX05uMTHgQb3/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ZHeWVjKTvsdRwfdmEf91S6FVVIebWfBm/ZAT++0IqMN9Dwb46sWmb2U3M48ZgCtI
	 ZQm3GdM0W30s/d7WKR4zJ+FHBzTDiwlVd7vX5/BwpZDcW0M8QlTfNSk34GXGVhMZBu
	 5XrO0jEX1O0IqIYTpOSkqSWnzzXk5xoAD8pTQ1UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389532AbgDAQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388970AbgDAQmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:42:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF3320658;
        Wed,  1 Apr 2020 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759352;
        bh=0G8P3DF8fKF5Qx0/mGMaQWMIsrrbrBX05uMTHgQb3/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgC5V01o7dA5DSLKbnff9nJkQY7GZ8+n4cH5YPponGHDsARG1A4rsjhoyCD9D95mM
         O8052qvfCDL6dZQvZj3GgC3me83umfcy9/2Rp6kGdnf28DFHybHF8wmkZJhsqBCMlv
         zVmvTM2VWf9TGxhlhhTv8jBFc5gsWw7NVrZUBmF0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 053/148] staging: greybus: loopback_test: fix potential path truncation
Date:   Wed,  1 Apr 2020 18:17:25 +0200
Message-Id: <20200401161558.110327495@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit f16023834863932f95dfad13fac3fc47f77d2f29 upstream.

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

---
 drivers/staging/greybus/tools/loopback_test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -644,7 +644,7 @@ baddir:
 static int open_poll_files(struct loopback_test *t)
 {
 	struct loopback_device *dev;
-	char buf[MAX_STR_LEN];
+	char buf[MAX_SYSFS_PATH + MAX_STR_LEN];
 	char dummy;
 	int fds_idx = 0;
 	int i;


