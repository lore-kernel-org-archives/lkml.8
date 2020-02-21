Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58CBC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C57208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQK1eZ1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgBURWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:22:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgBURWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582305740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bcpyz6Uxa5gpVE2jBpBWG5lNqmVXOPAXzpEnMnIkWFk=;
        b=eQK1eZ1SeNLku1kngH9eibpkU4lDt5SsDK2eTBjAZwAxfkjqDH3QVOdM8fXKl4aBXZKGJp
        33DAW4ueIuYzx8IVu+svII4VZt6xfC9U8l2nV86izRYNCZEkegwgY56yVvc4N29F+6uWbh
        rz9TfYkrcXVN9OWasyI/oDpPwJlcV4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-gcmbGllcPYSksIPZNSkGUg-1; Fri, 21 Feb 2020 12:22:16 -0500
X-MC-Unique: gcmbGllcPYSksIPZNSkGUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DE4A18A5500;
        Fri, 21 Feb 2020 17:22:15 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-191.ams2.redhat.com [10.36.116.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4183F5D9E2;
        Fri, 21 Feb 2020 17:22:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend] drm: Add DRM_MODE_TYPE_USERDEF flag to probed modes matching a video= argument
Date:   Fri, 21 Feb 2020 18:22:09 +0100
Message-Id: <20200221172209.509686-2-hdegoede@redhat.com>
In-Reply-To: <20200221172209.509686-1-hdegoede@redhat.com>
References: <20200221172209.509686-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_helper_probe_add_cmdline_mode() prefers using a probed mode matching
a video=3D argument over calculating our own timings for the user specifi=
ed
mode using CVT or GTF.

But userspace code which is auto-configuring the mode may want to know th=
at
the user has specified that mode on the kernel commandline so that it can
pick that mode over the mode which is marked as DRM_MODE_TYPE_PREFERRED.

This commit sets the DRM_MODE_TYPE_USERDEF flag on the matching mode, jus=
t
as we would do on the user-specified mode when no matching probed mode is
found.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 2 ++
 include/drm/drm_modes.h            | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_pro=
be_helper.c
index 576b4b7dcd89..466dfbba8256 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -159,6 +159,8 @@ static int drm_helper_probe_add_cmdline_mode(struct d=
rm_connector *connector)
 				continue;
 		}
=20
+		/* Mark the matching mode as being preferred by the user */
+		mode->type |=3D DRM_MODE_TYPE_USERDEF;
 		return 0;
 	}
=20
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index e946e20c61d8..c7efb7487e9b 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -256,7 +256,8 @@ struct drm_display_mode {
 	 *  - DRM_MODE_TYPE_DRIVER: Mode created by the driver, which is all of
 	 *    them really. Drivers must set this bit for all modes they create
 	 *    and expose to userspace.
-	 *  - DRM_MODE_TYPE_USERDEF: Mode defined via kernel command line
+	 *  - DRM_MODE_TYPE_USERDEF: Mode defined or selected via the kernel
+	 *    command line.
 	 *
 	 * Plus a big list of flags which shouldn't be used at all, but are
 	 * still around since these flags are also used in the userspace ABI.
--=20
2.25.0

