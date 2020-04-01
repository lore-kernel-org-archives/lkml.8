Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612AC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A16420857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759360;
	bh=wijYzzdE7EI1N6OmJCxKV8tQ8Q+z4PXSfn6Chw4uxL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOzoBRM9pyg1j9EAYipYnsW7XxTDWAHsMNLre0scMbypojo8y6Ahwmt2wQm77LeTO
	 IN+8Z0+NwHKnpj3FvJdP/VOyllUffzWoD1j2KUynrEHXCk+e33u7cvpeSmN1VUbe05
	 K4es+BL+QKE9MyVlXLUg4uam7p8jAQiETuaKL2j0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbgDAQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389363AbgDAQmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22E4206F8;
        Wed,  1 Apr 2020 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759355;
        bh=wijYzzdE7EI1N6OmJCxKV8tQ8Q+z4PXSfn6Chw4uxL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijMBtLv8prpuxy3VtNvJoKCjLyR1M2u0mb5T4dww4+ZjyH5kHYKMPST7gH/r3gUFG
         xoah1Xonb3rsuV5eXE51ne9QuIBerrlNlWJptxGMFRMOe1FSZw+ihv7atEmR8sqaaT
         yu5hp6EpIoXyc4vFsbkgnvsoCJjT3TbRD4yvFS2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 054/148] staging: greybus: loopback_test: fix potential path truncations
Date:   Wed,  1 Apr 2020 18:17:26 +0200
Message-Id: <20200401161558.190241297@linuxfoundation.org>
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

commit ae62cf5eb2792d9a818c2d93728ed92119357017 upstream.

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

---
 drivers/staging/greybus/tools/loopback_test.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -20,6 +20,7 @@
 #include <signal.h>
 
 #define MAX_NUM_DEVICES 10
+#define MAX_SYSFS_PREFIX 0x80
 #define MAX_SYSFS_PATH	0x200
 #define CSV_MAX_LINE	0x1000
 #define SYSFS_MAX_INT	0x20
@@ -68,7 +69,7 @@ struct loopback_results {
 };
 
 struct loopback_device {
-	char name[MAX_SYSFS_PATH];
+	char name[MAX_STR_LEN];
 	char sysfs_entry[MAX_SYSFS_PATH];
 	char debugfs_entry[MAX_SYSFS_PATH];
 	struct loopback_results results;
@@ -94,8 +95,8 @@ struct loopback_test {
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
@@ -914,10 +915,10 @@ int main(int argc, char *argv[])
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
@@ -968,10 +969,10 @@ int main(int argc, char *argv[])
 	}
 
 	if (!strcmp(t.sysfs_prefix, ""))
-		snprintf(t.sysfs_prefix, MAX_SYSFS_PATH, "%s", sysfs_prefix);
+		snprintf(t.sysfs_prefix, MAX_SYSFS_PREFIX, "%s", sysfs_prefix);
 
 	if (!strcmp(t.debugfs_prefix, ""))
-		snprintf(t.debugfs_prefix, MAX_SYSFS_PATH, "%s", debugfs_prefix);
+		snprintf(t.debugfs_prefix, MAX_SYSFS_PREFIX, "%s", debugfs_prefix);
 
 	ret = find_loopback_devices(&t);
 	if (ret)


