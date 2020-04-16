Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD738C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CA4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052427;
	bh=LoemScDtwq3mKzvNIvuf4pkxIjr/iGO4pf7UOgojR8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8yL/h340/LawVItfFhRApjN0t6sHJQ4J0wOEBYP0j8/SinEJfYM2JDOPJAeZQaHR
	 no7AXMFqLgOC7Kewdind+2Q+iTQ71EapHoBHwFKtLodIP1ljrA0ras46Rkhll8M8zX
	 BPHryAW7Q+oRB82xq/Vv2mKwPZ14cwhwN6pkk6gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896794AbgDPPxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896402AbgDPNcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:32:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09001221EB;
        Thu, 16 Apr 2020 13:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043888;
        bh=LoemScDtwq3mKzvNIvuf4pkxIjr/iGO4pf7UOgojR8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U06ecuROZpseln+qta9b2DmSBw9LZKEgN+hpLhJN8ezlQCiwZnjijj7Oepipkuipp
         XDVmsnkWWJNd/8VVEytoOE+LfE4ZPLFJNmOLmcle1SCuCki23VsETHMhZ6Bzqvq01r
         LC8dTUdOQxREGg7rgWkDOwrPxO70aipmwd2nfkIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Wayne Lin <Wayne.Lin@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Lyude Paul <lyude@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 141/146] drm/dp_mst: Fix clearing payload state on topology disable
Date:   Thu, 16 Apr 2020 15:24:42 +0200
Message-Id: <20200416131301.651728040@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 8732fe46b20c951493bfc4dba0ad08efdf41de81 ]

The issues caused by:

commit 64e62bdf04ab ("drm/dp_mst: Remove VCPI while disabling topology
mgr")

Prompted me to take a closer look at how we clear the payload state in
general when disabling the topology, and it turns out there's actually
two subtle issues here.

The first is that we're not grabbing &mgr.payload_lock when clearing the
payloads in drm_dp_mst_topology_mgr_set_mst(). Seeing as the canonical
lock order is &mgr.payload_lock -> &mgr.lock (because we always want
&mgr.lock to be the inner-most lock so topology validation always
works), this makes perfect sense. It also means that -technically- there
could be racing between someone calling
drm_dp_mst_topology_mgr_set_mst() to disable the topology, along with a
modeset occurring that's modifying the payload state at the same time.

The second is the more obvious issue that Wayne Lin discovered, that
we're not clearing proposed_payloads when disabling the topology.

I actually can't see any obvious places where the racing caused by the
first issue would break something, and it could be that some of our
higher-level locks already prevent this by happenstance, but better safe
then sorry. So, let's make it so that drm_dp_mst_topology_mgr_set_mst()
first grabs &mgr.payload_lock followed by &mgr.lock so that we never
race when modifying the payload state. Then, we also clear
proposed_payloads to fix the original issue of enabling a new topology
with a dirty payload state. This doesn't clear any of the drm_dp_vcpi
structures, but those are getting destroyed along with the ports anyway.

Changes since v1:
* Use sizeof(mgr->payloads[0])/sizeof(mgr->proposed_vcpis[0]) instead -
  vsyrjala

Cc: Sean Paul <sean@poorly.run>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200122194321.14953-1-lyude@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index b4fd20062bb80..5f508ec321fef 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2117,6 +2117,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 	int ret = 0;
 	struct drm_dp_mst_branch *mstb = NULL;
 
+	mutex_lock(&mgr->payload_lock);
 	mutex_lock(&mgr->lock);
 	if (mst_state == mgr->mst_state)
 		goto out_unlock;
@@ -2175,7 +2176,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 		/* this can fail if the device is gone */
 		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
 		ret = 0;
-		memset(mgr->payloads, 0, mgr->max_payloads * sizeof(struct drm_dp_payload));
+		memset(mgr->payloads, 0,
+		       mgr->max_payloads * sizeof(mgr->payloads[0]));
+		memset(mgr->proposed_vcpis, 0,
+		       mgr->max_payloads * sizeof(mgr->proposed_vcpis[0]));
 		mgr->payload_mask = 0;
 		set_bit(0, &mgr->payload_mask);
 		mgr->vcpi_mask = 0;
@@ -2183,6 +2187,7 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
 
 out_unlock:
 	mutex_unlock(&mgr->lock);
+	mutex_unlock(&mgr->payload_lock);
 	if (mstb)
 		drm_dp_put_mst_branch_device(mstb);
 	return ret;
-- 
2.20.1



