Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8982B2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Df8GllVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbgEZWZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:25:17 -0400
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:32748 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389889AbgEZWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=from:subject:to:cc:content-type:content-transfer-encoding;
        s=001; bh=gYebp9rzYUVBATcyaT/NfFRbcFQwq1Ai5f6uhR6SvfA=;
        b=Df8GllViA4xdGWlSI7AzAilMI50SV8LNsHjpdMBiDjx076/Wb5G8nZ2SjYfPKuQgXPij
        0TX+paptKResOztyP7Bb/hnwYBl/7l/Uy4/IsXWWy8wZ6GsyvG2b9rL5FUuyxviLE7kUyS
        loxU517BiJ/EoXHTQIKqTqmpcBo+SgOxk=
Received: by filterdrecv-p3iad2-8ddf98858-4fqk8 with SMTP id filterdrecv-p3iad2-8ddf98858-4fqk8-19-5ECD974A-54
        2020-05-26 22:25:15.015279878 +0000 UTC m=+5347060.449712244
Received: from bionic.localdomain (unknown)
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP
        id pOuU-hH5TrqIU--iWX2dZg
        Tue, 26 May 2020 22:25:14.675 +0000 (UTC)
From:   Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] media: v4l2-ctrls: Unset correct HEVC loop filter flag
Date:   Tue, 26 May 2020 22:25:15 +0000 (UTC)
Message-Id: <20200526222511.19250-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.17.1
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h4NucujZqb2jdTqOb?=
 =?us-ascii?Q?eyTrc=2F1=2Fgi0sEhPbGFU5ou9bsWpLl0pN10UM=2FX8?=
 =?us-ascii?Q?siVB8aR03r7zPmISozzjuB+5kGzEgftPnZjkDfq?=
 =?us-ascii?Q?6rApNnujN4=2FA8rbQSOQz2QxMDPTPZAos9HqYGzJ?=
 =?us-ascii?Q?3G8uxVGdS9hBgK6=2Fmd1uk2M0gyUguSKNa4yF6Ab?=
 =?us-ascii?Q?bI5WwW1OPmFDmyJwIRipA=3D=3D?=
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong loop filter flag is unset when tiles enabled flag is not set,
this cause HEVC decoding issues with Rockchip Video Decoder.

Fix this by unsetting the loop filter across tiles enabled flag instead of
the pps loop filter across slices enabled flag when tiles are disabled.

Fixes: 256fa3920874 ("media: v4l: Add definitions for HEVC stateless decoding")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index b2e5804f1aa9..ebd7054d18ac 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2081,7 +2081,7 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 			       sizeof(p_hevc_pps->row_height_minus1));
 
 			p_hevc_pps->flags &=
-				~V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED;
+				~V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED;
 		}
 
 		if (p_hevc_pps->flags &
-- 
2.17.1

