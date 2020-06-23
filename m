Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F047CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9C02072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944391;
	bh=R8g0zEbyqFw6D+ciYXIPii4CJ0lk9q9fkxWVCc92rdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cnidNF6qhsgHsgF9tP4zhiXtqbrnfnIXSnLAhNy6s5LyWq/pfA0k1Jx556ujBX3Ns
	 ajVXNjyrHEYkscr33BWtso4QFkJgqEBSIz5F7PNEEPbmNhU5XnnYhl1fwahZMZfO5U
	 fWHcss3KI0siiGRJvYODz6J0LWFeXRjboNah0O28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391158AbgFWUdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391380AbgFWUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D5820702;
        Tue, 23 Jun 2020 20:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944384;
        bh=R8g0zEbyqFw6D+ciYXIPii4CJ0lk9q9fkxWVCc92rdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPJ/NOMI9gd5XNcDhPtyZPCjBQhW8+AvCow8W1rKxHuM4wXGuYwC5CuY/NlK0ftRI
         DtL1IUWKDQzwIq94tcqiP6MGNi9v0ScSJTC3GZfdhmETbVD1KwyKVTugjhOud4TuSN
         wEyD9eJKOTHIbGU7btXh9ilS/3nJb72uZxN5zaYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Sean Paul <sean@poorly.run>
Subject: [PATCH 5.4 283/314] drm/dp_mst: Reformat drm_dp_check_act_status() a bit
Date:   Tue, 23 Jun 2020 21:57:58 +0200
Message-Id: <20200623195352.480467724@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

commit a5cb5fa6c3a5c2cf492db667b8670ee7b044b79f upstream.

Just add a bit more line wrapping, get rid of some extraneous
whitespace, remove an unneeded goto label, and move around some variable
declarations. No functional changes here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
[this isn't a fix, but it's needed for the fix that comes after this]
Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: Sean Paul <sean@poorly.run>
Cc: <stable@vger.kernel.org> # v3.17+
Reviewed-by: Sean Paul <sean@poorly.run>
Link: https://patchwork.freedesktop.org/patch/msgid/20200406221253.1307209-3-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_dp_mst_topology.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3507,33 +3507,31 @@ fail:
  */
 int drm_dp_check_act_status(struct drm_dp_mst_topology_mgr *mgr)
 {
+	int count = 0, ret;
 	u8 status;
-	int ret;
-	int count = 0;
 
 	do {
-		ret = drm_dp_dpcd_readb(mgr->aux, DP_PAYLOAD_TABLE_UPDATE_STATUS, &status);
-
+		ret = drm_dp_dpcd_readb(mgr->aux,
+					DP_PAYLOAD_TABLE_UPDATE_STATUS,
+					&status);
 		if (ret < 0) {
-			DRM_DEBUG_KMS("failed to read payload table status %d\n", ret);
-			goto fail;
+			DRM_DEBUG_KMS("failed to read payload table status %d\n",
+				      ret);
+			return ret;
 		}
 
 		if (status & DP_PAYLOAD_ACT_HANDLED)
 			break;
 		count++;
 		udelay(100);
-
 	} while (count < 30);
 
 	if (!(status & DP_PAYLOAD_ACT_HANDLED)) {
-		DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n", status, count);
-		ret = -EINVAL;
-		goto fail;
+		DRM_DEBUG_KMS("failed to get ACT bit %d after %d retries\n",
+			      status, count);
+		return -EINVAL;
 	}
 	return 0;
-fail:
-	return ret;
 }
 EXPORT_SYMBOL(drm_dp_check_act_status);
 


