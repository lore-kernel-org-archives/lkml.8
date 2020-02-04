Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569EC2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtsMuv73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBDT2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:28:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727331AbgBDT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xK7o2h0uCPzTn+BZp466NtcC29JdyGYqqZEyBuivOnc=;
        b=TtsMuv73+QiunvUHI+KsMxOZEiDxJpRebeAdupxR+PubLC0V4zUYgd1ZuTFBy8FU70IRHk
        A9P5yKZd1a42EXK/QFxqgAzC41Hi6ZMivtY7wb40srzX2UaVpXgPsDWyJ086QueSaCZIEX
        Kj1FkBVRhDWfX2Qalfl0jX107+TfDhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-gEqV_sM4PEmr472pFVoaeg-1; Tue, 04 Feb 2020 14:28:36 -0500
X-MC-Unique: gEqV_sM4PEmr472pFVoaeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99ABA1005F73;
        Tue,  4 Feb 2020 19:28:33 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40CF68068E;
        Tue,  4 Feb 2020 19:28:31 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Juha-Pekka Heikkila" <juhapekka.heikkila@gmail.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Lee Shawn C" <shawn.c.lee@intel.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>,
        "Manasi Navare" <manasi.d.navare@intel.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Imre Deak" <imre.deak@intel.com>,
        "Ramalingam C" <ramalingam.c@intel.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH 0/4] drm/dp,i915: eDP DPCD backlight control detection fixes
Date:   Tue,  4 Feb 2020 14:28:08 -0500
Message-Id: <20200204192823.111404-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, it turned out that the DPCD is also not a reliable way of
probing for DPCD backlight support as some panels will lie and say they
have DPCD backlight controls when they don't actually.

So, revert back to the old behavior and add a bunch of EDID-based DP
quirks for the panels that we know need this. As you might have already
guessed, OUI quirks didn't seem to be a very safe bet for these panels
due to them not having their device IDs filled out.

Lyude Paul (4):
  Revert "drm/i915: Don't use VBT for detecting DPCD backlight controls"
  drm/dp: Introduce EDID-based quirks
  drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED
    panel
  drm/i915: Force DPCD backlight mode for some Precision 7750 panels

 drivers/gpu/drm/drm_dp_helper.c               | 78 +++++++++++++++++++
 drivers/gpu/drm/drm_dp_mst_topology.c         |  3 +-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 11 ++-
 .../drm/i915/display/intel_dp_aux_backlight.c | 28 +++++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  2 +-
 include/drm/drm_dp_helper.h                   | 21 ++++-
 8 files changed, 130 insertions(+), 16 deletions(-)

--=20
2.24.1

