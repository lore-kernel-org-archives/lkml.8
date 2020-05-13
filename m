Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D3FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783EE20727
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rO3yc4WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgEMVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729930AbgEMVqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:47 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so28116613wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJi5eMHwAqzUe2i3jUFYaA8xST3/sOL5U08KB2I3T4g=;
        b=rO3yc4WHAm3l05vSdlARVUnLXK95J2qlUiA4WDLwPUJENF18/YcfSvDZUegRU04XRm
         vBtu9zIFe4bD2hgd9QTULm8biR5bgXnGTh9InWANNuITuru0/z5vJu1Uognp7JSMx3pr
         8P3IXd/HOiDgEW8utGnSsiNoY2aF6SyGHq2ZGfQO2C67+KS87LgeeU9aICdC9HtcGptb
         Sv319/TJ5Z/0KAPdstm/aIyZeWaZforbuTfNxI/fChFR/r08Ag//hS1NvRSPUtxQPcRl
         Z2/NqtUtNsI8TQZu6Fg++9ThhlEm3wDnMjGRp0BuHFoWmPb7Tey5IVSvxvdhosybx7an
         VX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJi5eMHwAqzUe2i3jUFYaA8xST3/sOL5U08KB2I3T4g=;
        b=nT13TVvsSuar3M01ZfwzJ60m//z3YrTjVew1ceHa9YnSUgzSI8X1bOzjcEC2tMUnjO
         ltFJnP93at9rMwSuUUYTgvhaPZ96EcpIMVifyBhbJNqGzyg0p8XHQ8G1Fjrp4ycUOx3f
         dRGFOHZjpgpLW2QSu0ovIGfFgJSMaIUWPhWiOWPqoQo+EBjZ2pouyYCP2N0VXNFytw6W
         w+S2l/P12wKsIyohaa+5DCJRVYZwI/TKWGCcsakX9VDM3WJNm9pozF5zUQOjTFfFCflf
         17vXLLkV10KGiVPr7m/isCpe5yXgofrR7uGBP9dx9itYGxD36pd3o5O8kiAhklYbC0RV
         O4SA==
X-Gm-Message-State: AOAM532ctyUoxX6dy/NV2rr+aB4zrO9mhbOnijNoPXxsiHL2cY91meOJ
        moaAyPW8FPd4LCFNJWO1tVo=
X-Google-Smtp-Source: ABdhPJzAK3hSFQX3+iM2UijCSN/gp9M2/ZbzDliAJRi1ONBhnKazyOD1fNH1Svsw+VYzYAvf1rabIg==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr11288465wmf.20.1589406405887;
        Wed, 13 May 2020 14:46:45 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:45 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/11] drm: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:48 +0100
Message-Id: <20200513214351.2138580-8-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 drivers/gpu/drm/drm_fb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index a9771de4d17e..533767100efe 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -307,13 +307,13 @@ static void drm_fb_helper_sysrq(int dummy1)
 	schedule_work(&drm_fb_helper_restore_work);
 }
 
-static struct sysrq_key_op sysrq_drm_fb_helper_restore_op = {
+static const struct sysrq_key_op sysrq_drm_fb_helper_restore_op = {
 	.handler = drm_fb_helper_sysrq,
 	.help_msg = "force-fb(V)",
 	.action_msg = "Restore framebuffer console",
 };
 #else
-static struct sysrq_key_op sysrq_drm_fb_helper_restore_op = { };
+static const struct sysrq_key_op sysrq_drm_fb_helper_restore_op = { };
 #endif
 
 static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
-- 
2.25.1

