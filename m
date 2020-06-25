Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72386C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5358B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406534AbgFYRDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:03:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406501AbgFYRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:03:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6BDD52A5736
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_rpmsg: Document missing struct parameters
Date:   Thu, 25 Jun 2020 19:03:00 +0200
Message-Id: <20200625170300.224906-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects all kernel structure member to be documented.

Fixes the following W=1 level warnings:

  cros_ec_rpmsg.c:49: warning: Function parameter or member 'ept' not described in 'cros_ec_rpmsg'
  cros_ec_rpmsg.c:49: warning: Function parameter or member 'has_pending_host_event' not described in 'cros_ec_rpmsg'
  cros_ec_rpmsg.c:49: warning: Function parameter or member 'probe_done' not described in 'cros_ec_rpmsg'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_rpmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index ff08c3d12873a..ad0a30afd7423 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -38,6 +38,9 @@ struct cros_ec_rpmsg_response {
  * @rpdev:	rpmsg device we are connected to
  * @xfer_ack:	completion for host command transfer.
  * @host_event_work:	Work struct for pending host event.
+ * @ept: The rpmsg endpoint of this channel.
+ * @has_pending_host_event: Boolean used to check if there is a pending event.
+ * @probe_done: Flag to indicate that probe is done.
  */
 struct cros_ec_rpmsg {
 	struct rpmsg_device *rpdev;
-- 
2.27.0

