Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46E3C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5068206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUJlKgpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbgBKSeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:34:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730450AbgBKSeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581446051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L6sDU4tMPoI49wPdSUl0EfKYp+lvyu+SM87E9CYvdLk=;
        b=FUJlKgpdHUf5X6f4Pfxj/4o8syruJoxssbzwQxhlGxPOsIeQRcHlmLW0xGzrGLZImaIVkP
        XtilUFAloUb9deseG7tWAQ8Chn4mU8rbyk8LPD2DBeu/WKLEu/PcO1jRTA2lEaNm9nwk2p
        zQvXi8zQldYZGn3Z+YnW8qkIN46mRAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-S4JzFpgiPB2I_lM_BsLbXw-1; Tue, 11 Feb 2020 13:34:09 -0500
X-MC-Unique: S4JzFpgiPB2I_lM_BsLbXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CBCE1922962;
        Tue, 11 Feb 2020 18:34:06 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8D5E5C11E;
        Tue, 11 Feb 2020 18:34:03 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>,
        "Manasi Navare" <manasi.d.navare@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Imre Deak" <imre.deak@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Matt Roper" <matthew.d.roper@intel.com>,
        "Ramalingam C" <ramalingam.c@intel.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        "Juha-Pekka Heikkila" <juhapekka.heikkila@gmail.com>,
        "Lee Shawn C" <shawn.c.lee@intel.com>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/3] drm/dp,i915: eDP DPCD backlight control detection fixes
Date:   Tue, 11 Feb 2020 13:33:45 -0500
Message-Id: <20200211183358.157448-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Lyude Paul (3):
  drm/dp: Introduce EDID-based quirks
  drm/i915: Force DPCD backlight mode on X1 Extreme 2nd Gen 4K AMOLED
    panel
  drm/i915: Force DPCD backlight mode for some Dell CML 2020 panels

 drivers/gpu/drm/drm_dp_helper.c               | 79 +++++++++++++++++++
 drivers/gpu/drm/drm_dp_mst_topology.c         |  3 +-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 11 ++-
 .../drm/i915/display/intel_dp_aux_backlight.c | 25 +++++-
 drivers/gpu/drm/i915/display/intel_dp_mst.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  2 +-
 include/drm/drm_dp_helper.h                   | 21 ++++-
 8 files changed, 130 insertions(+), 14 deletions(-)

--=20
2.24.1

