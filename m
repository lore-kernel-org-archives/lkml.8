Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CDC206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+oDyl2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCFXtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:49:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20086 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726237AbgCFXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v+JBQbCOXTS0FlnC1/Gxr+beCyEpCMXP0Ynor51xOGs=;
        b=F+oDyl2VNARhRAKr0rp3K869R++AjnQfk2pUA/LpETAxQG+Eudlt8nj8OBd9Y+NV8Ht/Sq
        VI16eGfY84YwbLkQ7Q0vkaib729YArmuh4jITTIDZZ0WKQ8orYF8UmNi4XTWZijCjRJ+OD
        54quhj3iKdxALZANs/0GUGJaVTvLKFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-LrfGex8wPz2qwyStpsC_6g-1; Fri, 06 Mar 2020 18:49:28 -0500
X-MC-Unique: LrfGex8wPz2qwyStpsC_6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5918A800D4E;
        Fri,  6 Mar 2020 23:49:26 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDD4791D7A;
        Fri,  6 Mar 2020 23:49:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     "Alex Deucher" <alexander.deucher@amd.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        "David Airlie" <airlied@linux.ie>,
        "David Francis" <david.francis@amd.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Lyude Paul" <lyude@redhat.com>,
        "Benjamin Gaignard" <benjamin.gaignard@st.com>
Subject: [PATCH 0/2] drm/dp_mst: Fix link address probing regressions
Date:   Fri,  6 Mar 2020 18:49:20 -0500
Message-Id: <20200306234923.547873-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While fixing some regressions caused by introducing bandwidth checking
into the DP MST atomic helpers, I realized there was another much more
subtle regression that got introduced by a seemingly harmless patch to
fix unused variable errors while compiling with W=3D1 (mentioned in patch
2). Basically, this regression makes it so sometimes link address
appears to "hang". This patch series fixes it.

Lyude Paul (2):
  drm/dp_mst: Make drm_dp_mst_dpcd_write() consistent with
    drm_dp_dpcd_write()
  drm/dp_mst: Fix drm_dp_check_mstb_guid() return code

 drivers/gpu/drm/drm_dp_mst_topology.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--=20
2.24.1

