Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F3DC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC08C2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584010955;
	bh=O5D6n72Hm+OTFu1Q1+S1oI0b9rbxNRbmX/WF52EB4Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RKFEmRHGkypbJq45nZSJiM91Pxf6fa+R3oUHgSWybCuIX7rLee72yXF3EZmXgSApI
	 CJoZQi2tA8xszHC2b/qKp4TWScI1qELymbbV7gqv4p0T5oFVWG2E6iEbR5bJkCepzO
	 4jSw98LWElIx/RKt0160jMMt+bQvN+BjFOg0OULE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgCLLCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:02:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42438 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLLC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:02:29 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so4417141lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 04:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKBLUr88wbraOZEGa0RYFtyftngjWe+Uqnh/hMum3do=;
        b=M9w3ZbYwQT5ElHCQuNaY3FkuLg2/laNE0SCHZQKS49oMQb7GLGrpW1GLvXg15YHYJ1
         ukJM38Vk4pPerSb5czgNY5WwMSWvda+aG/h3z4l4PKFJP2gk0Dhnhp/91YIKCCoJkeP4
         Z+sZ3CKAo6zWBh3wcv+yZpCZavr+ijBBI+P+YNe/Vo4lwOXikgOn+Wg8dYt8WBpmWe2t
         MzwVLDR95KL5/kyyMThgm2Hyc2oNwXsluloTNzzgvPdI1RXxyzCB5ymHWpL9hRxvphOn
         MnGbePayin0hwio506qMTW+FcoLLeytkBditOLPeSZreuu3lj/4FmokxfRhBIRdRuAbF
         gXcw==
X-Gm-Message-State: ANhLgQ10UWkNkZcCuL020AP3ekEhLzUCJjhCnY4miMoYOlnSFnDPZAVz
        2F5AcF4i0JSx6RyKLakLEVE=
X-Google-Smtp-Source: ADFU+vtHQqIHRNS01AKN1SrdHijm/KUgsYTIXJncnVu1hPocEsSAZTp8kIzRZAEWQIU2bwBzgPerlA==
X-Received: by 2002:ac2:538e:: with SMTP id g14mr5041703lfh.208.1584010946939;
        Thu, 12 Mar 2020 04:02:26 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id a17sm19109789ljk.42.2020.03.12.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:02:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jCLbS-0005kL-JP; Thu, 12 Mar 2020 12:02:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Axel Haslam <ahaslam@baylibre.com>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: greybus: loopback_test: fix potential path truncation
Date:   Thu, 12 Mar 2020 12:01:50 +0100
Message-Id: <20200312110151.22028-3-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312110151.22028-1-johan@kernel.org>
References: <20200312110151.22028-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/staging/greybus/tools/loopback_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 41e1820d9ac9..d38bb4fbd6b9 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -637,7 +637,7 @@ int find_loopback_devices(struct loopback_test *t)
 static int open_poll_files(struct loopback_test *t)
 {
 	struct loopback_device *dev;
-	char buf[MAX_STR_LEN];
+	char buf[MAX_SYSFS_PATH + MAX_STR_LEN];
 	char dummy;
 	int fds_idx = 0;
 	int i;
-- 
2.24.1

