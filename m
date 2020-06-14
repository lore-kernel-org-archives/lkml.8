Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F16EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B17020747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng0Hs7X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFNHMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:12:39 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790DBC03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:12:39 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c75so12470010ila.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J0HX3Qy+oA7OgSkbAwCFUgm7xc4/mQq2g3sSxGqtxts=;
        b=ng0Hs7X76WMv2RgLHK06guvTkOhbuJO1TZxkIDGvxw8Y8cfXgIV/12HWs0gFqNgvOe
         UM/bVQxlvagvWjXIbdCgd0k8y/XX6chWyaZW1KeVUtw5AjHuhIWQ4KHUw3jXaX4omsA7
         9HzANrDVVvngT3aa19831CroM1Oqm5DAjVrmsQUuCefQz5mv7gnPKn7ZKQW+NjsL2lQl
         n69rfkYHJB+wiUECAcoooaS7GBQV/CImXYpLQKQ7uYEOxKRfFCoPCpaZ4pnQkZwBuR04
         xbinJ2+pytEaA+KPFsIRiRHp+tyJYzZTedi4Kngguff8RDa/SnPIRw/e9/jM7E4RE0IY
         uCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J0HX3Qy+oA7OgSkbAwCFUgm7xc4/mQq2g3sSxGqtxts=;
        b=NpFzfFRl9xkZjBIJpgLHYixYssk3qRk+pYct/8y9ROohn/WBJ43+mB8N7w0JnxMjx/
         xaqABLfb8O0fNztnNJ/fbo1yDOeJzrX4vo8rhXedCYbyA76gL0HbwwHa5h+4qv50ptaL
         /PA6B8sXcnyixQdPMIShytLPKf54FxFeJsJlJHc84iZCtZefFOsjslxuWs/uvJ1PsGMP
         RXkENnrdga8RqVWLx5nqvCK7whRfEKZ/qU5Tx/6jw2mFXitfKdBxsYmZxwbl2hYNGR1V
         zH2RRyyT9xMo4BsZPNVV6nrtwjoCyf97x1FpXSWjBDEDXioQkl+cjpFctEq9oeMRwemu
         r4fw==
X-Gm-Message-State: AOAM532E6icu2UYVPDyFBzRiw4PoD691setPmiwkkf1XSwsvQyNf3Ts5
        EmGwg+GR8Kj2c5rsvaig2/A=
X-Google-Smtp-Source: ABdhPJyimyxSAUwofweWNgN5hEFbQ/O7Qx3jeTQjffr0wRqkezjV+1DdWhLCq+42269oMOzx82Uv1A==
X-Received: by 2002:a92:4885:: with SMTP id j5mr19444436ilg.35.1592118758649;
        Sun, 14 Jun 2020 00:12:38 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id t63sm6158788ill.54.2020.06.14.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:12:38 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amdgpu: fix ref count leak in amdgpu_driver_open_kms
Date:   Sun, 14 Jun 2020 02:12:29 -0500
Message-Id: <20200614071231.87723-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in amdgpu_driver_open_kms the call to pm_runtime_get_sync increments the
counter even in case of failure, leading to incorrect
ref count. In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7e17e34fee1..bd40aa307462 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -991,7 +991,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0)
-		return r;
+		goto pm_put;
 
 	fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 	if (unlikely(!fpriv)) {
@@ -1042,6 +1042,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
+pm_put:
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.17.1

