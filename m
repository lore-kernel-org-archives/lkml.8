Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB72C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FED02192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgCKFH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:07:28 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:51826 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728258AbgCKFHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:07:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 103FF10185974;
        Wed, 11 Mar 2020 05:07:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dolls43_23050b1e12945
X-Filterd-Recvd-Size: 3010
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:20 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH -next 019/491] Hyper-V CORE AND DRIVERS: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:33 -0700
Message-Id: <84677022b8ec4ad14bddab57d871dcbfc0b4a1bf.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hv/hv_kvp.c             | 4 +---
 drivers/hv/vmbus_drv.c          | 2 +-
 drivers/video/fbdev/hyperv_fb.c | 4 ++--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index e74b144..da4686 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -353,9 +353,7 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
 				MAX_IP_ADDR_SIZE);
 
 		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
-
-		/* fallthrough */
-
+		fallthrough;
 	case KVP_OP_GET_IP_INFO:
 		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
 				MAX_ADAPTER_ID_SIZE,
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 029378..0befc0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1188,7 +1188,7 @@ static void vmbus_chan_sched(struct hv_per_cpu_context *hv_cpu)
 
 			case HV_CALL_BATCHED:
 				hv_begin_read(&channel->inbound);
-				/* fallthrough */
+				fallthrough;
 			case HV_CALL_DIRECT:
 				tasklet_schedule(&channel->callback_event);
 			}
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index e4c3c8b..02411d 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -648,13 +648,13 @@ static int synthvid_connect_vsp(struct hv_device *hdev)
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN10);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN8);
 		if (!ret)
 			break;
-		/* Fallthrough */
+		fallthrough;
 	case VERSION_WS2008:
 	case VERSION_WIN7:
 		ret = synthvid_negotiate_ver(hdev, SYNTHVID_VERSION_WIN7);
-- 
2.24.0

