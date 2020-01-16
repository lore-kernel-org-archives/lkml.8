Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE84C33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB02075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zhwv/exD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbgAPVRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:17:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388584AbgAPVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579209419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nFJ6uwOoJtC0MqewmZr1cCXqAoblceejQfDtB1E24lk=;
        b=Zhwv/exDphH3pmR7FO/yGrR3CZ1W636shsJBD/2Dyi/4wTK7tERe8/VtNbsfFqwR5I1xag
        b8OSr48oMt5oEqEpd9sY4iHpAEGTYiXOsklTHcZ+lDcQKUf2Y+GgiL8Xbg9YHA2sq+3IFv
        yj0UA+OzxXsmgEqeJfK5gTLvLOFFnfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-LFIEQ6_pPeefBuYFJirb_g-1; Thu, 16 Jan 2020 16:16:58 -0500
X-MC-Unique: LFIEQ6_pPeefBuYFJirb_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E3510054E3;
        Thu, 16 Jan 2020 21:16:55 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-90.bss.redhat.com [10.20.1.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA5F960C84;
        Thu, 16 Jan 2020 21:16:53 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        AceLan Kao <acelan.kao@canonical.com>,
        Perry Yuan <pyuan@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] drm/i915: Auto detect DPCD backlight support by default
Date:   Thu, 16 Jan 2020 16:16:12 -0500
Message-Id: <20200116211623.53799-6-lyude@redhat.com>
In-Reply-To: <20200116211623.53799-1-lyude@redhat.com>
References: <20200116211623.53799-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out we actually already have some companies, such as Lenovo,
shipping machines with AMOLED screens that don't allow controlling the
backlight through the usual PWM interface and only allow controlling it
through the standard EDP DPCD interface. One example of one of these
laptops is the X1 Extreme 2nd Generation.

Since we've got systems that need this turned on by default now to have
backlight controls working out of the box, let's start auto-detecting it
for systems by default based on what the VBT tells us. We do this by
changing the default value for the enable_dpcd_backlight module param
from 0 to -1.

Tested-by: AceLan Kao <acelan.kao@canonical.com>
Tested-by: Perry Yuan <pyuan@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/i915_params.c | 2 +-
 drivers/gpu/drm/i915/i915_params.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i9=
15_params.c
index 64009e99073d..905decc36e53 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -172,7 +172,7 @@ i915_param_named_unsafe(inject_probe_failure, uint, 0=
400,
=20
 i915_param_named(enable_dpcd_backlight, int, 0600,
 	"Enable support for DPCD backlight control"
-	"(-1=3Duse per-VBT LFP backlight type setting, 0=3Ddisabled [default], =
1=3Denabled)");
+	"(-1=3Duse per-VBT LFP backlight type setting [default], 0=3Ddisabled, =
1=3Denabled)");
=20
 #if IS_ENABLED(CONFIG_DRM_I915_GVT)
 i915_param_named(enable_gvt, bool, 0400,
diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i9=
15_params.h
index be6089e4f9e6..947d0a38fa3c 100644
--- a/drivers/gpu/drm/i915/i915_params.h
+++ b/drivers/gpu/drm/i915/i915_params.h
@@ -66,7 +66,7 @@ struct drm_printer;
 	param(int, reset, 3, 0600) \
 	param(unsigned int, inject_probe_failure, 0, 0600) \
 	param(int, fastboot, -1, 0600) \
-	param(int, enable_dpcd_backlight, 0, 0600) \
+	param(int, enable_dpcd_backlight, -1, 0600) \
 	param(char *, force_probe, CONFIG_DRM_I915_FORCE_PROBE, 0400) \
 	param(unsigned long, fake_lmem_start, 0, 0400) \
 	/* leave bools at the end to not create holes */ \
--=20
2.24.1

