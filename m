Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77457C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585632070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 22:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9zhqa5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEKWmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 18:42:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgEKWmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 18:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589236941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5AW1tPrIf1NH23mBvqTHaK47Gct2K80GUJUWM/a2mOg=;
        b=d9zhqa5CM9mYwpZb3WK9JxT58CX8qMTaNKbAlN0YENVVpbJ/HRGw3ySuqT2CSwWQz3UivF
        QBSlMy2n1p5aHIZfDHvKdJ1XoYucRzkKc+6Y08WD++h+6SqNg706EdmWIWA7aMfW8DX7x1
        EfK8Ec+OHaRBL17MvjCSeji7cqMr4as=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-72MkkdwwNAqOVOmAuvb87w-1; Mon, 11 May 2020 18:42:18 -0400
X-MC-Unique: 72MkkdwwNAqOVOmAuvb87w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02E5A0BD7;
        Mon, 11 May 2020 22:42:15 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-117-238.rdu2.redhat.com [10.10.117.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C29DE77F2E;
        Mon, 11 May 2020 22:42:13 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Alex Deucher" <alexander.deucher@amd.com>,
        "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>, "Takashi Iwai" <tiwai@suse.de>,
        "Sean Paul" <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>
Subject: [PATCH v3 0/5] drm/nouveau: DP interlace fixes
Date:   Mon, 11 May 2020 18:41:22 -0400
Message-Id: <20200511224148.598468-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nouveau doesn't actually bother to try probing whether or not
it can actually handle interlaced modes over DisplayPort. As a result,
on volta and later we'll end up trying to set an interlaced mode even
when it's not supported and cause the front end for the display engine
to hang.

So, let's teach nouveau to reject interlaced modes on hardware that
can't actually handle it. Additionally for MST, since we accomplish this
by simply reusing more of the SST mode validation we also get (some)
basic bw validation for modes we detect on MST connectors completely for
free.

Lyude Paul (5):
  drm/nouveau/kms/nv50-: Initialize core channel in
    nouveau_display_create()
  drm/nouveau/kms/nv50-: Probe SOR and PIOR caps for DP interlacing
    support
  drm/nouveau/kms/gv100-: Add support for interlaced modes
  drm/nouveau/kms/nv50-: Move 8BPC limit for MST into
    nv50_mstc_get_modes()
  drm/nouveau/kms/nv50-: Share DP SST mode_valid() handling with MST

 drivers/gpu/drm/nouveau/dispnv50/core.h     |  7 +++
 drivers/gpu/drm/nouveau/dispnv50/core507d.c | 15 ++++++
 drivers/gpu/drm/nouveau/dispnv50/core827d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/core907d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/core917d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c | 26 +++++++++
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 58 +++++++++++++++------
 drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  5 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  5 +-
 drivers/gpu/drm/nouveau/dispnv50/pior507d.c |  8 +++
 drivers/gpu/drm/nouveau/dispnv50/sor507d.c  |  7 +++
 drivers/gpu/drm/nouveau/dispnv50/sor907d.c  | 11 ++++
 drivers/gpu/drm/nouveau/dispnv50/sorc37d.c  |  9 ++++
 drivers/gpu/drm/nouveau/nouveau_connector.c | 48 +++++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  5 ++
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 31 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |  8 +++
 19 files changed, 213 insertions(+), 35 deletions(-)

-- 
2.26.2

