Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E0C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D0B206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7AyPQ98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgBKSe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:34:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30668 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730450AbgBKSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581446065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSTAco2nQH8bLhCMiH/CLRNHDKaImhPirhNd4/I1epk=;
        b=X7AyPQ983siMostFAj9dagtUNL3UoedYs1VUNP28Ah54ehfCK05AWJXK5QWdOWgXZEmES8
        n/SwaqwQCncf5Havu9uHaWqaS340Z278GiGeESzVN3Ycz7YX2jV3Tu5rwKkuuClwiC96b0
        DoNo2po5kiCkquiZyLZeAjYc1BDfDjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-pcvFksYKPkyhM3E5kpkvpQ-1; Tue, 11 Feb 2020 13:34:24 -0500
X-MC-Unique: pcvFksYKPkyhM3E5kpkvpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA3D1137845;
        Tue, 11 Feb 2020 18:34:21 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC275C109;
        Tue, 11 Feb 2020 18:34:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/i915: Force DPCD backlight mode for some Dell CML 2020 panels
Date:   Tue, 11 Feb 2020 13:33:48 -0500
Message-Id: <20200211183358.157448-4-lyude@redhat.com>
In-Reply-To: <20200211183358.157448-1-lyude@redhat.com>
References: <20200211183358.157448-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Dell, trying to match their panels via OUI is not reliable
enough and we've been told that we should check against the EDID
instead. As well, Dell seems to have some panels that are actually
intended to switch between using PWM for backlight controls and DPCD for
backlight controls depending on whether or not the panel is in HDR or
SDR mode. Yikes.

Regardless, we need to add quirks for these so that DPCD backlight
controls get enabled by default, since without additional driver support
that's the only form of brightness control that will work. Hopefully in
the future we can remove these quirks once we have a better way of
probing for this.

Changes since v1:
* Add one more EDID per Dell's request
* Remove model number (which is possibly wrong) and replace with Dell
  CML 2020 systems

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_hel=
per.c
index a39c3cdacb20..620d78ff2706 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1240,6 +1240,20 @@ static const struct edid_quirk edid_quirk_list[] =3D=
 {
 	 * only supports DPCD backlight controls
 	 */
 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
+	/*
+	 * Some Dell CML 2020 systems have panels support both AUX and PWM
+	 * backlight control, and some only support AUX backlight control. All
+	 * said panels start up in AUX mode by default, and we don't have any
+	 * support for disabling HDR mode on these panels which would be
+	 * required to switch to PWM backlight control mode (plus, I'm not
+	 * even sure we want PWM backlight controls over DPCD backlight
+	 * controls anyway...). Until we have a better way of detecting these,
+	 * force DPCD backlight mode on all of them.
+	 */
+	{ MFG(0x06, 0xaf), PROD_ID(0x9b, 0x32), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
+	{ MFG(0x06, 0xaf), PROD_ID(0xeb, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
+	{ MFG(0x4d, 0x10), PROD_ID(0xc7, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
+	{ MFG(0x4d, 0x10), PROD_ID(0xe6, 0x14), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
 };
=20
 #undef MFG
--=20
2.24.1

