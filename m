Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83EC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF24206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkdZPW+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFUHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:07:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgDFUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586203621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rXIYebum9QchqOrGhXWLQLLK7a5E49kIN0en0Oaf2sg=;
        b=XkdZPW+cOYVR/p/jcsaObVQnUWcCpht90Uq+FhrlHYaQVWn+K/v4brznu4rpEJy6SB/Byt
        1aZQMY5uQGn+qhfsPucsKiF/nzouvSP077xD5Zmkbi/C7o11Jv8PH7V6FZD1/oNz0CVTIT
        GI+zmvluXWRIn57RdAwkbhMrZTMCdAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-KCzBsCLTMzuH58e91jJXyQ-1; Mon, 06 Apr 2020 16:06:59 -0400
X-MC-Unique: KCzBsCLTMzuH58e91jJXyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80ED88018A6;
        Mon,  6 Apr 2020 20:06:57 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-117-12.rdu2.redhat.com [10.10.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1572B6EF97;
        Mon,  6 Apr 2020 20:06:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Imre Deak <imre.deak@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/i915/dp_mst: Cast intel_connector->port as drm_dp_mst_port
Date:   Mon,  6 Apr 2020 16:06:41 -0400
Message-Id: <20200406200646.1263435-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only reason for having this cast as void * before was because we
originally needed to use drm_dp_mst_get_port_validated() and friends in
order to (attempt to) safely access MST ports. However, we've since
improved how reference counting works with ports and mstbs such that we
can now rely on drm_dp_mst_port structs remaining in memory for as long
as the driver needs. This means we don't really need to cast this as
void* anymore, and can just access the struct directly.

We'll also need this for the next commit, so that we can remove
drm_dp_mst_port_has_audio().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers=
/gpu/drm/i915/display/intel_display_types.h
index 5a0adf14ebef..0ddc98afe252 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -438,7 +438,7 @@ struct intel_connector {
 	   state of connector->polled in case hotplug storm detection changes i=
t */
 	u8 polled;
=20
-	void *port; /* store this opaque as its illegal to dereference it */
+	struct drm_dp_mst_port *port;
=20
 	struct intel_dp *mst_port;
=20
--=20
2.25.1

