Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC844C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AA72067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584010958;
	bh=wh3flAKU3hCv7GRRbGVzhVIEk8a48kvifamNIQEdZDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ptmrocuI/XL2/gwRkvgpfHlwVR3Jll/Brq/pkGoue0iJ3MPEeMyJxaTVmMPvuohlV
	 tnbgrq+BrpU2ZLLrHdjlghpzkCT1XjAdwySoGIXAAaFK6k8jPLnwgyDNwweAUDvlrv
	 6+5xLXIJc2UtFHNlz1XhykG0k+wMfaeYFyx/LwMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCLLCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:02:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42441 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:02:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so4417237lfe.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 04:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Mj3MJcwV2Ob5PmZcW233AWny7Gxsi3b1PdwO4Wtlog=;
        b=QXc6aW5hOgaTMMasA6Lm+N8eIPWlqSayO/WjiblEhksuWHiuJNUjW8vxUndyt03W6Y
         q91zyOM3Rz6I9Rjs4S/Nkp6xPIE5TCSXb6+egRa41VUq42IQ945aXmDygRtnqCSWUi2f
         dSBJ5Wx869e8O99W6twdAxRRcFnMOCz8E88iDpwaye433UkaZa+W4AdpOhqWabGlWcK6
         MLL1r9wd6WauivMsVa+RkHACJP+q6kclrzjrWQ37FVe+HTE0jFMSZQdXXaNHM0P4ieks
         xmUuLKt7s+iiR1+hJD/7j/Ue4Woyam5klPYXXBSgr8JY9yoXpAnkNkdn5Co/nnNrz1gb
         ggCw==
X-Gm-Message-State: ANhLgQ170tfO1ExBZYk71GDbjxWEkYkIN5r2qAfR3QhrP/ptC+CNBtkh
        bVJFcO8OERbbU9vyDUhSboo=
X-Google-Smtp-Source: ADFU+vur2Hbz9dWEyrJsg/slUxBKugdWUurH4O/r2TmqsuxboHAg+aABhoo4sGy+ldWfEnNpdgPsyg==
X-Received: by 2002:ac2:5e31:: with SMTP id o17mr4661566lfg.123.1584010949191;
        Thu, 12 Mar 2020 04:02:29 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id s21sm2096862lfc.28.2020.03.12.04.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 04:02:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1jCLbS-0005kR-M1; Thu, 12 Mar 2020 12:02:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Axel Haslam <ahaslam@baylibre.com>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: greybus: loopback_test: fix potential path truncations
Date:   Thu, 12 Mar 2020 12:01:51 +0100
Message-Id: <20200312110151.22028-4-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312110151.22028-1-johan@kernel.org>
References: <20200312110151.22028-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/staging/greybus/tools/loopback_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index d38bb4fbd6b9..69c6dce9be31 100644
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
2.24.1

