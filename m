Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676352051A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eJ5c87zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCFRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:32:17 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33678 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:32:16 -0500
Received: by mail-pj1-f65.google.com with SMTP id o21so3671566pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=G1RDgxBiyV6Kk2G6RLMWzGPree6/YVdm0hvb7UeIEqk=;
        b=eJ5c87ziTXTK+rhDA6QRlgfcRU/IdlKxZshAQM2TCEltwHmpXlDjzbuPMRXbX/7SGS
         X6IcuBDDareaY/S6mEVT0sTK3myUJL+cptTI+1dD6SVbdEuCtEJVaWp1SEPjhfBDYtPO
         VnfXAUQrEMFY0Nar8GnvXCEnkpF1wckCT89A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=G1RDgxBiyV6Kk2G6RLMWzGPree6/YVdm0hvb7UeIEqk=;
        b=VFazNQynUmNfIqvn5DiYhHl9f1s6sz7jCtwnhRYcHA6AXq3F5rzlxRXAG9A0dgQJaH
         QP+fMfc2MOzyfLFN4f0Z94gb2s4yP+vS6TjrXEH0HETOhWdl8tDgnM3hiiaGKr2Zjrrh
         4zE8ehBo+YDfgmuKa9sQ7jmoO+DV1y6MCFL3ekn5pNV0iH5MMs1/qQwKFLGVG7/sefGb
         jCXjNiVWLWd7yJn8bsHs3bKRyA3oJ4EZKlbAJ+XYpSBFNN4xHiPMvnkkY6vm608BVA2f
         sV75oHQRgRtGRvyoBoAHXZ2e6WEe9N8Wwewcb50iuvJW7pFvD9GnSMKw628Z3wSoy/zO
         cO9Q==
X-Gm-Message-State: ANhLgQ39FEQb2vUgCs/XCm/WqaC1CzwsOeVF9JO+4Riy3f5zrZQ3w7H8
        cJYCj06w5xOYDX4tJx+6VHWPuQ==
X-Google-Smtp-Source: ADFU+vu76IOA+FPbi+9Jw1089IGoAuLPRcbDWWPgxaDXV5HF6U2+lYzFPU/z9i6aSOe5cIMfsSEKHg==
X-Received: by 2002:a17:902:342:: with SMTP id 60mr3878637pld.206.1583515935302;
        Fri, 06 Mar 2020 09:32:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x190sm37154310pfb.96.2020.03.06.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 09:32:14 -0800 (PST)
Date:   Fri, 6 Mar 2020 09:32:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/edid: Distribute switch variables for initialization
Message-ID: <202003060930.DDCCB6659@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, lift such variables up into the next code
block.

drivers/gpu/drm/drm_edid.c: In function ‘drm_edid_to_eld’:
drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be
executed [-Wswitch-unreachable]
 4395 |     int sad_count;
      |         ^~~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: move into function block instead being switch-local (Ville Syrjälä)
---
 drivers/gpu/drm/drm_edid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 805fb004c8eb..46cee78bc175 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4381,6 +4381,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 
 	if (cea_revision(cea) >= 3) {
 		int i, start, end;
+		int sad_count;
 
 		if (cea_db_offsets(cea, &start, &end)) {
 			start = 0;
@@ -4392,8 +4393,6 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 			dbl = cea_db_payload_len(db);
 
 			switch (cea_db_tag(db)) {
-				int sad_count;
-
 			case AUDIO_BLOCK:
 				/* Audio Data Block, contains SADs */
 				sad_count = min(dbl / 3, 15 - total_sad_count);
-- 
2.20.1


-- 
Kees Cook
