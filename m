Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53857C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21ED220776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gm0xuuSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgEZSXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:23:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54525 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbgEZSXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590517403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5+EU/K2kj/k8K0E7hESfXaQ4YimAcr8+UqvyVfx2X4A=;
        b=Gm0xuuSA95wVqbcTQF4LWnsS7RkwTyCvxNoLt9x62JPmRtW8Ck5/+bB+QsbndJurd3+S1+
        H5szroD0CHHuJp2veHw5kRG32XZMiAzBhfIKtO0WhaypvgviyiLVT3XDVknWiBoUmwL1/M
        n5jsOrdY+BpH4TcrtGeY5L5/BhXx/rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-g6Gi8_IIO7aRX8Un7vznuA-1; Tue, 26 May 2020 14:23:19 -0400
X-MC-Unique: g6Gi8_IIO7aRX8Un7vznuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C4C8018AD;
        Tue, 26 May 2020 18:23:17 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-120-19.rdu2.redhat.com [10.10.120.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAE0079C40;
        Tue, 26 May 2020 18:23:14 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Lee Shawn C <shawn.c.lee@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Lyude Paul" <lyude@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 0/2] drm/probe_helper, i915: Validate MST modes against PBN limits
Date:   Tue, 26 May 2020 14:23:08 -0400
Message-Id: <20200526182313.4005-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something we've been missing for a while with drivers that support MST
is being able to prune modes that can't be set due to bandwidth
limitations. So, let's go ahead and add that. This also adds a new hook
that was needed, mode_valid_ctx, so that we can grab additional locks as
needed when validating modes.

Lee Shawn C (1):
  drm/i915/mst: filter out the display mode exceed sink's capability

Lyude Paul (1):
  drm/probe_helper: Add drm_connector_helper_funcs.mode_valid_ctx

 drivers/gpu/drm/drm_crtc_helper_internal.h  |  6 +-
 drivers/gpu/drm/drm_probe_helper.c          | 65 ++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_dp_mst.c | 39 +++++++++++--
 include/drm/drm_modeset_helper_vtables.h    | 41 +++++++++++++
 4 files changed, 123 insertions(+), 28 deletions(-)

-- 
2.26.2

