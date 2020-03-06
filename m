Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3822BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B07206D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWVCdFyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:46:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42910 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgCFXqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583538392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Po/iBBoWJfPjGLJrHZfnvvlLhPKKA60+1bls5u7diKE=;
        b=TWVCdFygv0ZZQbnUtnOHKU4DodSuQFBJc+NTEnfLQL48Cam4F3sS0ngYhmO5mPQfcdzYXR
        gjwgc+X3atKpn0q97ln2gvRvRJMmSdQF1gWorgSKKhqXupeizgf5ncKfXpRq1kK+Z8yQG9
        bnFPtZK0eQYRYte7PCfFSMHMG1V4W0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-qzJu6ej_P8uoHKNYBQA6nQ-1; Fri, 06 Mar 2020 18:46:31 -0500
X-MC-Unique: qzJu6ej_P8uoHKNYBQA6nQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC59800D4E;
        Fri,  6 Mar 2020 23:46:29 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 851397389A;
        Fri,  6 Mar 2020 23:46:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
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
Subject: [PATCH v2 0/4] drm/dp_mst: Fix bandwidth checking regressions from DSC patches
Date:   Fri,  6 Mar 2020 18:46:18 -0500
Message-Id: <20200306234623.547525-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Anyway, this should fix everything bandwidth-check related as far as I
can tell (I found some other regressions unrelated to AMD's DSC patches
which I'll be sending out patches for shortly). Note that I don't have
any DSC displays locally yet, so if someone from AMD could sanity check
this I would appreciate it =E2=99=A5.

Cc: Mikita Lipski <mikita.lipski@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sean Paul <seanpaul@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>

Lyude Paul (4):
  drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device() to be less
    redundant
  drm/dp_mst: Use full_pbn instead of available_pbn for bandwidth checks
  drm/dp_mst: Reprobe path resources in CSN handler
  drm/dp_mst: Rewrite and fix bandwidth limit checks

 drivers/gpu/drm/drm_dp_mst_topology.c | 185 ++++++++++++++++++--------
 include/drm/drm_dp_mst_helper.h       |   4 +-
 2 files changed, 129 insertions(+), 60 deletions(-)

--=20
2.24.1

