Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B720674
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CFjJyI82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGFVzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:55:18 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:59991 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGFVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:in-reply-to:references:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=TGA8bCtzG3W48MXoVBxFSHeewOIBjbl37ylvpTpVch8=;
        b=CFjJyI82kqHAAybk35Iw5Oxm6ciN3WXKnqdGBPs6ot03enrioSCkp+e7N7T6q7aas32L
        Hr264zsRRdggLlNKE+Xlb8Ji2bhg87huQr7K/Y3Fgy+H61iSc9DLbgPOZCt5uN+JkZ1/2F
        yiAEFNJ4JNO25EH2SUKRFh6Nit9l2iHHA=
Received: by filterdrecv-p3iad2-5b55dcd864-d2lx7 with SMTP id filterdrecv-p3iad2-5b55dcd864-d2lx7-18-5F039D9A-4
        2020-07-06 21:54:34.170135634 +0000 UTC m=+881111.822229131
Received: from bionic.localdomain (unknown)
        by ismtpd0008p1lon1.sendgrid.net (SG) with ESMTP
        id lAitVEpTTyqzql48WShlmQ
        Mon, 06 Jul 2020 21:54:33.919 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/12] media: rkvdec: Ensure decoded resolution fit coded
 resolution
Date:   Mon, 06 Jul 2020 21:54:34 +0000 (UTC)
Message-Id: <20200706215430.22859-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706215430.22859-1-jonas@kwiboo.se>
References: <20200701215616.30874-1-jonas@kwiboo.se>
 <20200706215430.22859-1-jonas@kwiboo.se>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hxOVj4gd+wIhsMeaZ?=
 =?us-ascii?Q?4=2Fuq2uZ67RzqPtTDrFqEKz5LOLXtj=2FFf4sWlE2+?=
 =?us-ascii?Q?+AwGx5hzQFsz0qLPWfM26W5k7Zgkfyi8I35U0Qd?=
 =?us-ascii?Q?EkYNXz1z=2Fj7V=2F0hqsGQbPToqE6wTTEmVOiPXwT+?=
 =?us-ascii?Q?wZOkxO3lm5FJ7NtjSKbIg76JAuAcR6DmoOzbHix?=
 =?us-ascii?Q?JGQ1hDdcnTACfX1Gmd95Q=3D=3D?=
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure decoded CAPTURE buffer resolution is larger or equal to the coded
OPTUPT buffer resolution.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch
---
 drivers/staging/media/rkvdec/rkvdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 55dc27171ce4..4ab8f7e0566b 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -235,6 +235,8 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
 
 	/* Always apply the frmsize constraint of the coded end. */
+	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
+	pix_mp->height = max(pix_mp->height, ctx->coded_fmt.fmt.pix_mp.height);
 	v4l2_apply_frmsize_constraints(&pix_mp->width,
 				       &pix_mp->height,
 				       &coded_desc->frmsize);
-- 
2.17.1

