Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B500BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DBF20787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNWPy1Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDFWNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:13:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38466 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgDFWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/HSM7a17NXiCfmU3HyJmqf3yicBWvNyRVvlLx1TwWsY=;
        b=XNWPy1Uld+uI/l2bcBsiZnor6EXu0TKtSqerI8KgHVwgAQlM1wrXgZghu7P0x4ByIsxaAc
        ihqxsKbjDPQhjGH8v9NdKxyoLEmcTOkTt7lS/Yg96xXGkULTKOTL+Vav0Cx2WfWYyMm1kA
        LO9cIw/C4uW+2YdspB1hwyja5jbC19Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-_kdFTnKNMnCSBorMBVkrDg-1; Mon, 06 Apr 2020 18:13:05 -0400
X-MC-Unique: _kdFTnKNMnCSBorMBVkrDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FBC4801A07;
        Mon,  6 Apr 2020 22:13:03 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-12.rdu2.redhat.com [10.10.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7ACC89D359;
        Mon,  6 Apr 2020 22:13:01 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Dave Airlie" <airlied@redhat.com>,
        "Todd Previte" <tprevite@gmail.com>
Subject: [PATCH v2 0/4] drm/dp_mst: drm_dp_check_act_status() fixes
Date:   Mon,  6 Apr 2020 18:12:49 -0400
Message-Id: <20200406221253.1307209-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while fixing some unrelated issues with NAKs being dropped
- we don't wait nearly long enough to receive ACTs from MST hubs in some
situations. Also, we take the time to refactor this function a bit.

This fixes some ACT timeouts I observed on an EVGA MST hub with i915.

Lyude Paul (4):
  drm/dp_mst: Improve kdocs for drm_dp_check_act_status()
  drm/dp_mst: Reformat drm_dp_check_act_status() a bit
  drm/dp_mst: Increase ACT retry timeout to 3s
  drm/dp_mst: Print errors on ACT timeouts

 drivers/gpu/drm/drm_dp_mst_topology.c | 71 +++++++++++++++++----------
 1 file changed, 44 insertions(+), 27 deletions(-)

--=20
2.25.1

