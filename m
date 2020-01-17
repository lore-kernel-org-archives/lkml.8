Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFAFC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9050D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 20:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6kyeRW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgAQUwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:52:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727519AbgAQUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579294319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zOh5BTGUh3xerGe5YmzlD/g3NoOq6842Kunrgz3bRG8=;
        b=Q6kyeRW2iLusPmi57LjktV69QzQznqJtmqB/cIwIwkDhtoZN66xDSz06ikZCwNja4fZ7mD
        njwKToe+Q2OM5OWeCcE4lOIJ2QRk0g9nBR0XCYMjOOBfJQmD51e/w8iqNr7qgPpVCE8Bad
        5bK7TA6v4xIEiTGuzAWi5Kq8Gw7x0xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-6wyV6EoSNnqPDlIYOLIWfQ-1; Fri, 17 Jan 2020 15:51:57 -0500
X-MC-Unique: 6wyV6EoSNnqPDlIYOLIWfQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C98800D5A;
        Fri, 17 Jan 2020 20:51:55 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 944A619C7F;
        Fri, 17 Jan 2020 20:51:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>, Wayne Lin <Wayne.Lin@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/dp_mst: Remove VCPI while disabling topology mgr"
Date:   Fri, 17 Jan 2020 15:51:49 -0500
Message-Id: <20200117205149.97262-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 64e62bdf04ab8529f45ed0a85122c703035dec3a.

This commit ends up causing some lockdep splats due to trying to grab the
payload lock while holding the mgr's lock:

[   54.010099]
[   54.011765] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   54.018670] WARNING: possible circular locking dependency detected
[   54.025577] 5.5.0-rc6-02274-g77381c23ee63 #47 Not tainted
[   54.031610] ------------------------------------------------------
[   54.038516] kworker/1:6/1040 is trying to acquire lock:
[   54.044354] ffff888272af3228 (&mgr->payload_lock){+.+.}, at:
drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.054957]
[   54.054957] but task is already holding lock:
[   54.061473] ffff888272af3060 (&mgr->lock){+.+.}, at:
drm_dp_mst_topology_mgr_set_mst+0x3c/0x2e4
[   54.071193]
[   54.071193] which lock already depends on the new lock.
[   54.071193]
[   54.080334]
[   54.080334] the existing dependency chain (in reverse order) is:
[   54.088697]
[   54.088697] -> #1 (&mgr->lock){+.+.}:
[   54.094440]        __mutex_lock+0xc3/0x498
[   54.099015]        drm_dp_mst_topology_get_port_validated+0x25/0x80
[   54.106018]        drm_dp_update_payload_part1+0xa2/0x2e2
[   54.112051]        intel_mst_pre_enable_dp+0x144/0x18f
[   54.117791]        intel_encoders_pre_enable+0x63/0x70
[   54.123532]        hsw_crtc_enable+0xa1/0x722
[   54.128396]        intel_update_crtc+0x50/0x194
[   54.133455]        skl_commit_modeset_enables+0x40c/0x540
[   54.139485]        intel_atomic_commit_tail+0x5f7/0x130d
[   54.145418]        intel_atomic_commit+0x2c8/0x2d8
[   54.150770]        drm_atomic_helper_set_config+0x5a/0x70
[   54.156801]        drm_mode_setcrtc+0x2ab/0x833
[   54.161862]        drm_ioctl+0x2e5/0x424
[   54.166242]        vfs_ioctl+0x21/0x2f
[   54.170426]        do_vfs_ioctl+0x5fb/0x61e
[   54.175096]        ksys_ioctl+0x55/0x75
[   54.179377]        __x64_sys_ioctl+0x1a/0x1e
[   54.184146]        do_syscall_64+0x5c/0x6d
[   54.188721]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   54.194946]
[   54.194946] -> #0 (&mgr->payload_lock){+.+.}:
[   54.201463]
[   54.201463] other info that might help us debug this:
[   54.201463]
[   54.210410]  Possible unsafe locking scenario:
[   54.210410]
[   54.217025]        CPU0                    CPU1
[   54.222082]        ----                    ----
[   54.227138]   lock(&mgr->lock);
[   54.230643]                                lock(&mgr->payload_lock);
[   54.237742]                                lock(&mgr->lock);
[   54.244062]   lock(&mgr->payload_lock);
[   54.248346]
[   54.248346]  *** DEADLOCK ***
[   54.248346]
[   54.254959] 7 locks held by kworker/1:6/1040:
[   54.259822]  #0: ffff888275c4f528 ((wq_completion)events){+.+.},
at: worker_thread+0x455/0x6e2
[   54.269451]  #1: ffffc9000119beb0
((work_completion)(&(&dev_priv->hotplug.hotplug_work)->work)){+.+.},
at: worker_thread+0x455/0x6e2
[   54.282768]  #2: ffff888272a403f0 (&dev->mode_config.mutex){+.+.},
at: i915_hotplug_work_func+0x4b/0x2be
[   54.293368]  #3: ffffffff824fc6c0 (drm_connector_list_iter){.+.+},
at: i915_hotplug_work_func+0x17e/0x2be
[   54.304061]  #4: ffffc9000119bc58 (crtc_ww_class_acquire){+.+.},
at: drm_helper_probe_detect_ctx+0x40/0xfd
[   54.314855]  #5: ffff888272a40470 (crtc_ww_class_mutex){+.+.}, at:
drm_modeset_lock+0x74/0xe2
[   54.324385]  #6: ffff888272af3060 (&mgr->lock){+.+.}, at:
drm_dp_mst_topology_mgr_set_mst+0x3c/0x2e4
[   54.334597]
[   54.334597] stack backtrace:
[   54.339464] CPU: 1 PID: 1040 Comm: kworker/1:6 Not tainted
5.5.0-rc6-02274-g77381c23ee63 #47
[   54.348893] Hardware name: Google Fizz/Fizz, BIOS
Google_Fizz.10139.39.0 01/04/2018
[   54.357451] Workqueue: events i915_hotplug_work_func
[   54.362995] Call Trace:
[   54.365724]  dump_stack+0x71/0x9c
[   54.369427]  check_noncircular+0x91/0xbc
[   54.373809]  ? __lock_acquire+0xc9e/0xf66
[   54.378286]  ? __lock_acquire+0xc9e/0xf66
[   54.382763]  ? lock_acquire+0x175/0x1ac
[   54.387048]  ? drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.393177]  ? __mutex_lock+0xc3/0x498
[   54.397362]  ? drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.403492]  ? drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.409620]  ? drm_dp_dpcd_access+0xd9/0x101
[   54.414390]  ? drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.420517]  ? drm_dp_mst_topology_mgr_set_mst+0x218/0x2e4
[   54.426645]  ? intel_digital_port_connected+0x34d/0x35c
[   54.432482]  ? intel_dp_detect+0x227/0x44e
[   54.437056]  ? ww_mutex_lock+0x49/0x9a
[   54.441242]  ? drm_helper_probe_detect_ctx+0x75/0xfd
[   54.446789]  ? intel_encoder_hotplug+0x4b/0x97
[   54.451752]  ? intel_ddi_hotplug+0x61/0x2e0
[   54.456423]  ? mark_held_locks+0x53/0x68
[   54.460803]  ? _raw_spin_unlock_irqrestore+0x3a/0x51
[   54.466347]  ? lockdep_hardirqs_on+0x187/0x1a4
[   54.471310]  ? drm_connector_list_iter_next+0x89/0x9a
[   54.476953]  ? i915_hotplug_work_func+0x206/0x2be
[   54.482208]  ? worker_thread+0x4d5/0x6e2
[   54.486587]  ? worker_thread+0x455/0x6e2
[   54.490966]  ? queue_work_on+0x64/0x64
[   54.495151]  ? kthread+0x1e9/0x1f1
[   54.498946]  ? queue_work_on+0x64/0x64
[   54.503130]  ? kthread_unpark+0x5e/0x5e
[   54.507413]  ? ret_from_fork+0x3a/0x50

The proper fix for this is probably cleanup the VCPI allocations when we'=
re
enabling the topology, or on the first payload allocation. For now though=
,
let's just revert.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 64e62bdf04ab ("drm/dp_mst: Remove VCPI while disabling topology mg=
r")
Cc: Sean Paul <sean@poorly.run>
Cc: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
index 4b74193b89ce..0c585f2bbb69 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3481,7 +3481,6 @@ static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, =
u8  dp_link_count)
 int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr,=
 bool mst_state)
 {
 	int ret =3D 0;
-	int i =3D 0;
 	struct drm_dp_mst_branch *mstb =3D NULL;
=20
 	mutex_lock(&mgr->lock);
@@ -3542,22 +3541,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp=
_mst_topology_mgr *mgr, bool ms
 		/* this can fail if the device is gone */
 		drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL, 0);
 		ret =3D 0;
-		mutex_lock(&mgr->payload_lock);
 		memset(mgr->payloads, 0, mgr->max_payloads * sizeof(struct drm_dp_payl=
oad));
 		mgr->payload_mask =3D 0;
 		set_bit(0, &mgr->payload_mask);
-		for (i =3D 0; i < mgr->max_payloads; i++) {
-			struct drm_dp_vcpi *vcpi =3D mgr->proposed_vcpis[i];
-
-			if (vcpi) {
-				vcpi->vcpi =3D 0;
-				vcpi->num_slots =3D 0;
-			}
-			mgr->proposed_vcpis[i] =3D NULL;
-		}
 		mgr->vcpi_mask =3D 0;
-		mutex_unlock(&mgr->payload_lock);
-
 		mgr->payload_id_table_cleared =3D false;
 	}
=20
--=20
2.24.1

