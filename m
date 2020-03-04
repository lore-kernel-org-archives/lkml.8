Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B5C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D260E20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRuVOjXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgCDWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:36:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388410AbgCDWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583361387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bGzow7OU6gaIH5sJh0BKwjJSVmZdQNGpCvs2KXsONBE=;
        b=TRuVOjXRaPIL14oFg3Co6ALKgWLKY2yU1DaDULn39XZwF90BEBMmACEo2yLIaTzolCo64g
        aWuVyghZJ9losjrbNV3wC7nIhaoWVIOAPznYmc6tQWN8GtDeo5mi/iALkQW1kSkDlrXogB
        4uwe9N99UXH5n7At19E+rawZveLLVXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-3VoyKBf-Nk-icFBQSHFWrw-1; Wed, 04 Mar 2020 17:36:25 -0500
X-MC-Unique: 3VoyKBf-Nk-icFBQSHFWrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7374B8017DF;
        Wed,  4 Mar 2020 22:36:23 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB5DE60BE0;
        Wed,  4 Mar 2020 22:36:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/3] drm/dp_mst: Fix bandwidth checking regressions from DSC patches
Date:   Wed,  4 Mar 2020 17:36:10 -0500
Message-Id: <20200304223614.312023-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD's patch series for adding DSC support to the MST helpers
unfortunately introduced a few regressions into the kernel that I didn't
get around to fixing until just now. I would have reverted the changes
earlier, but seeing as that would have reverted all of amd's DSC support
+ everything that was done on top of that I realllllly wanted to avoid
doing that.

Anyway, this should fix everything as far as I can tell. Note that I
don't have any DSC displays locally yet, so if someone from AMD could
sanity check this I would appreciate it =E2=99=A5.

Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sean Paul <seanpaul@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>

Lyude Paul (3):
  drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less
    redundant
  drm/dp_mst: Don't show connectors as connected before probing
    available PBN
  drm/dp_mst: Rewrite and fix bandwidth limit checks

 drivers/gpu/drm/drm_dp_mst_topology.c | 124 ++++++++++++++++++++------
 1 file changed, 96 insertions(+), 28 deletions(-)

--=20
2.24.1

