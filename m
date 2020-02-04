Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3662C47409
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB12087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE7DeZHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBDT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:28:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727331AbgBDT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7Rzb3arItmNyBkuRXn0dlnmkb6n1rmp5wrZ7PgDBo4=;
        b=ZE7DeZHTr/q34XW3728UUOyw/ErBSpRxueC5qL4fiMCr+AtZ+x/tzT0VtX7kFynodgSIkt
        8H40AjY9vTzsI90CqKOE2J6cBQuDN/5f/Phe453oehFBolnFHL50h5mALYiLBDPn2INmUn
        E+rRO002quIplMvitxqnS6Fcktu5cWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-X32TnFnfPjykn0MXoxg-5A-1; Tue, 04 Feb 2020 14:28:52 -0500
X-MC-Unique: X32TnFnfPjykn0MXoxg-5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4881005F7A;
        Tue,  4 Feb 2020 19:28:51 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4322081213;
        Tue,  4 Feb 2020 19:28:50 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/i915: Force DPCD backlight mode for some Precision 7750 panels
Date:   Tue,  4 Feb 2020 14:28:12 -0500
Message-Id: <20200204192823.111404-5-lyude@redhat.com>
In-Reply-To: <20200204192823.111404-1-lyude@redhat.com>
References: <20200204192823.111404-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_hel=
per.c
index a39c3cdacb20..c24bbea3e2a2 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1240,6 +1240,19 @@ static const struct edid_quirk edid_quirk_list[] =3D=
 {
 	 * only supports DPCD backlight controls
 	 */
 	{ MFG(0x4c, 0x83), PROD_ID(0x41, 0x41), BIT(DP_QUIRK_FORCE_DPCD_BACKLIG=
HT) },
+	/*
+	 * Some Dell Precision 7750 systems have panels support both AUX and
+	 * PWM backlight control, and some only support AUX backlight control.
+	 * All said panels start up in AUX mode by default, and we don't have
+	 * any support for disabling HDR mode on these panels which would be
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
 };
=20
 #undef MFG
--=20
2.24.1

