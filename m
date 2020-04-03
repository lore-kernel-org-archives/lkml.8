Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13038206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccqKboDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgDCUII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:08:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbgDCUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585944487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TkamcyvUPqN5kcSYh+i5OtzU6Ni2nQG6cLAfWaqbe6M=;
        b=ccqKboDP+TZLRxRZOgYyjkMt4+diYX6GWxrDWrJY/OWAL5QI0FaNAPi7H6GW7NI+JCGZ2E
        7PiqVew0+oPU5RESmq3FQ8wAx/8XzGRnGxaYpjqIcyUXloTz5PXq2zTmbXr/bizziDq63X
        gRWdxxhBpCsfQvuT20MV46v/YFSjuYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-zi1qdTwpPL-Atu5STQHOvA-1; Fri, 03 Apr 2020 16:08:06 -0400
X-MC-Unique: zi1qdTwpPL-Atu5STQHOvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 786B6107ACC4;
        Fri,  3 Apr 2020 20:08:04 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-203.rdu2.redhat.com [10.10.117.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3B235C541;
        Fri,  3 Apr 2020 20:08:02 +0000 (UTC)
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
Subject: [PATCH 0/4] drm/dp_mst: drm_dp_check_act_status() fixes
Date:   Fri,  3 Apr 2020 16:07:52 -0400
Message-Id: <20200403200757.886443-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

 drivers/gpu/drm/drm_dp_mst_topology.c | 50 ++++++++++++++++++---------
 1 file changed, 34 insertions(+), 16 deletions(-)

--=20
2.25.1

