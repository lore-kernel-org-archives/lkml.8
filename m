Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31952C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0237D2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXCpXtym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCIVBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:01:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726096AbgCIVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583787701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1RxqWrKO438vkGEbZpjxhyrkCxLkS0aydXYxGr+6zQ=;
        b=NXCpXtyml9uun1BUQrQIfZYKhfWfOXiHKdj0ChtOGcRqvVFHwOfszlCNPHPBldaRFKKa1P
        diKzr0B04b92t8rCHcjmLHFRuvNOkzTG22BoUSLCSXyP59u9cAOSJx1zRPzNJPAwa+P6X7
        mCI0QTtNYe99d8H6LGoq6EbbulynEHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-CLCY5D2iNIO5QGTkLhSluw-1; Mon, 09 Mar 2020 17:01:40 -0400
X-MC-Unique: CLCY5D2iNIO5QGTkLhSluw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3B713E2;
        Mon,  9 Mar 2020 21:01:37 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69AAF26370;
        Mon,  9 Mar 2020 21:01:34 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/dp_mst: Rewrite and fix bandwidth limit checks
Date:   Mon,  9 Mar 2020 17:01:31 -0400
Message-Id: <20200309210131.1497545-1-lyude@redhat.com>
In-Reply-To: <20200306234623.547525-5-lyude@redhat.com>
References: <20200306234623.547525-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh, this is mostly my fault for not giving commit cd82d82cbc04
("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
enough scrutiny during review. The way we're checking bandwidth
limitations here is mostly wrong:

For starters, drm_dp_mst_atomic_check_bw_limit() determines the
pbn_limit of a branch by simply scanning each port on the current branch
device, then uses the last non-zero full_pbn value that it finds. It
then counts the sum of the PBN used on each branch device for that
level, and compares against the full_pbn value it found before.

This is wrong because ports can and will have different PBN limitations
on many hubs, especially since a number of DisplayPort hubs out there
will be clever and only use the smallest link rate required for each
downstream sink - potentially giving every port a different full_pbn
value depending on what link rate it's trained at. This means with our
current code, which max PBN value we end up with is not well defined.

Additionally, we also need to remember when checking bandwidth
limitations that the top-most device in any MST topology is a branch
device, not a port. This means that the first level of a topology
doesn't technically have a full_pbn value that needs to be checked.
Instead, we should assume that so long as our VCPI allocations fit we're
within the bandwidth limitations of the primary MSTB.

We do however, want to check full_pbn on every port including those of
the primary MSTB. However, it's important to keep in mind that this
value represents the minimum link rate /between a port's sink or mstb,
and the mstb itself/. A quick diagram to explain:

                                MSTB #1
                               /       \
                              /         \
                           Port #1    Port #2
       full_pbn for Port #1 =E2=86=92 |          | =E2=86=90 full_pbn for=
 Port #2
                           Sink #1    MSTB #2
                                         |
                                       etc...

Note that in the above diagram, the combined PBN from all VCPI
allocations on said hub should not exceed the full_pbn value of port #2,
and the display configuration on sink #1 should not exceed the full_pbn
value of port #1. However, port #1 and port #2 can otherwise consume as
much bandwidth as they want so long as their VCPI allocations still fit.

And finally - our current bandwidth checking code also makes the mistake
of not checking whether something is an end device or not before trying
to traverse down it.

So, let's fix it by rewriting our bandwidth checking helpers. We split
the function into one part for handling branches which simply adds up
the total PBN on each branch and returns it, and one for checking each
port to ensure we're not going over its PBN limit. Phew.

This should fix regressions seen, where we erroneously reject display
configurations due to thinking they're going over our bandwidth limits
when they're not.

Changes since v1:
* Took an even closer look at how PBN limitations are supposed to be
  handled, and did some experimenting with Sean Paul. Ended up rewriting
  these helpers again, but this time they should actually be correct!
Changes since v2:
* Small indenting fix
* Fix pbn_used check in drm_dp_mst_atomic_check_port_bw_limit()

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST =
atomic check")
Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Sean Paul <seanpaul@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 119 ++++++++++++++++++++------
 1 file changed, 93 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index b81ad444c24f..d2f464bdcfff 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -4841,41 +4841,102 @@ static bool drm_dp_mst_port_downstream_of_branch=
(struct drm_dp_mst_port *port,
 	return false;
 }
=20
-static inline
-int drm_dp_mst_atomic_check_bw_limit(struct drm_dp_mst_branch *branch,
-				     struct drm_dp_mst_topology_state *mst_state)
+static int
+drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
+				      struct drm_dp_mst_topology_state *state);
+
+static int
+drm_dp_mst_atomic_check_mstb_bw_limit(struct drm_dp_mst_branch *mstb,
+				      struct drm_dp_mst_topology_state *state)
 {
-	struct drm_dp_mst_port *port;
 	struct drm_dp_vcpi_allocation *vcpi;
-	int pbn_limit =3D 0, pbn_used =3D 0;
+	struct drm_dp_mst_port *port;
+	int pbn_used =3D 0, ret;
+	bool found =3D false;
=20
-	list_for_each_entry(port, &branch->ports, next) {
-		if (port->mstb)
-			if (drm_dp_mst_atomic_check_bw_limit(port->mstb, mst_state))
-				return -ENOSPC;
+	/* Check that we have at least one port in our state that's downstream
+	 * of this branch, otherwise we can skip this branch
+	 */
+	list_for_each_entry(vcpi, &state->vcpis, next) {
+		if (!vcpi->pbn ||
+		    !drm_dp_mst_port_downstream_of_branch(vcpi->port, mstb))
+			continue;
=20
-		if (port->full_pbn > 0)
-			pbn_limit =3D port->full_pbn;
+		found =3D true;
+		break;
 	}
-	DRM_DEBUG_ATOMIC("[MST BRANCH:%p] branch has %d PBN available\n",
-			 branch, pbn_limit);
+	if (!found)
+		return 0;
=20
-	list_for_each_entry(vcpi, &mst_state->vcpis, next) {
-		if (!vcpi->pbn)
-			continue;
+	if (mstb->port_parent)
+		DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] Checking bandwidth limits on=
 [MSTB:%p]\n",
+				 mstb->port_parent->parent, mstb->port_parent,
+				 mstb);
+	else
+		DRM_DEBUG_ATOMIC("[MSTB:%p] Checking bandwidth limits\n",
+				 mstb);
=20
-		if (drm_dp_mst_port_downstream_of_branch(vcpi->port, branch))
-			pbn_used +=3D vcpi->pbn;
+	list_for_each_entry(port, &mstb->ports, next) {
+		ret =3D drm_dp_mst_atomic_check_port_bw_limit(port, state);
+		if (ret < 0)
+			return ret;
+
+		pbn_used +=3D ret;
 	}
-	DRM_DEBUG_ATOMIC("[MST BRANCH:%p] branch used %d PBN\n",
-			 branch, pbn_used);
=20
-	if (pbn_used > pbn_limit) {
-		DRM_DEBUG_ATOMIC("[MST BRANCH:%p] No available bandwidth\n",
-				 branch);
+	return pbn_used;
+}
+
+static int
+drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
+				      struct drm_dp_mst_topology_state *state)
+{
+	struct drm_dp_vcpi_allocation *vcpi;
+	int pbn_used =3D 0;
+
+	if (port->pdt =3D=3D DP_PEER_DEVICE_NONE)
+		return 0;
+
+	if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
+		bool found =3D false;
+
+		list_for_each_entry(vcpi, &state->vcpis, next) {
+			if (vcpi->port !=3D port)
+				continue;
+			if (!vcpi->pbn)
+				return 0;
+
+			found =3D true;
+			break;
+		}
+		if (!found)
+			return 0;
+
+		/* This should never happen, as it means we tried to
+		 * set a mode before querying the full_pbn
+		 */
+		if (WARN_ON(!port->full_pbn))
+			return -EINVAL;
+
+		pbn_used =3D vcpi->pbn;
+	} else {
+		pbn_used =3D drm_dp_mst_atomic_check_mstb_bw_limit(port->mstb,
+								 state);
+		if (pbn_used <=3D 0)
+			return pbn_used;
+	}
+
+	if (pbn_used > port->full_pbn) {
+		DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] required PBN of %d exceeds p=
ort limit of %d\n",
+				 port->parent, port, pbn_used,
+				 port->full_pbn);
 		return -ENOSPC;
 	}
-	return 0;
+
+	DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] uses %d out of %d PBN\n",
+			 port->parent, port, pbn_used, port->full_pbn);
+
+	return pbn_used;
 }
=20
 static inline int
@@ -5073,9 +5134,15 @@ int drm_dp_mst_atomic_check(struct drm_atomic_stat=
e *state)
 		ret =3D drm_dp_mst_atomic_check_vcpi_alloc_limit(mgr, mst_state);
 		if (ret)
 			break;
-		ret =3D drm_dp_mst_atomic_check_bw_limit(mgr->mst_primary, mst_state);
-		if (ret)
+
+		mutex_lock(&mgr->lock);
+		ret =3D drm_dp_mst_atomic_check_mstb_bw_limit(mgr->mst_primary,
+							    mst_state);
+		mutex_unlock(&mgr->lock);
+		if (ret < 0)
 			break;
+		else
+			ret =3D 0;
 	}
=20
 	return ret;
--=20
2.24.1

