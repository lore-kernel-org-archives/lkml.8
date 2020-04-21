Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E024C55189
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB522068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 23:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="G74PTK6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgDUXlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 19:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUXlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:41:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC3AC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:41:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so238059qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LvYouvVpcqYLPafw/K5/u16SlbXdlEtkvI3+uiIfQUs=;
        b=G74PTK6TtB9NwQj+FSqGUh2FwwFtWKKCQ+mOSiH63EAaBhzW/vQhn1g45PghckrUdo
         S871ocFS0GrOqjr/r2si+SWzI5Ge85eGKFPXU2HNCU83mmZgo7S5lItiNiBMEs2mEOJg
         gsUKJXpwCQXygXlSgssdZ0GyQfnmHVdS0tikEB1I9MYpowwsLxR1F59/1M7fTzLMz7NO
         VRmXu7/AGWWKMeCNisN1iyQ785p7gL+LwjR2XT3cNhqcHpMbD1ljdRQZ9lVoN+B78zvl
         ZmqSVBL1DSDDXbhuHR3y0/eGmQdsT0MC8tEm7H+f2dswxFr8BmE8bkRXYMduNScQKsMC
         BcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LvYouvVpcqYLPafw/K5/u16SlbXdlEtkvI3+uiIfQUs=;
        b=f83xHsyCS6ZdRTVix5ZGSOGDERRDWhcSGdI4PDmWU5XVb+kaz+pTPezseP0qBZx78j
         ulw527fsBfjagCctMtharo1IXT5nFvFdPHaJraYtVoIyrboW75bFnVUo6ZqpEW1L0wM2
         KbUHIAZvfeyxquwbl7Urjtfh0C3y4N8IX769iMYleoHO3PIaF2kA+Iv/rJCl9quuHiyV
         zzqSnHbYZCNjs+VkVKWQPk648vF9kcwLKUkh0lM3V4g/6xIfk2YJm2LBaDSmo6EVR7MP
         vWEsN+oqq/4pFKqeaxiVS7Vr9NRrEsRT8QozxiJMLdsrZHGeM2vig6QRENIlAT2WLRGJ
         ABkA==
X-Gm-Message-State: AGi0PubCEqO1/LxbHowAiRXU8KYgmS4M6Pgqe7ALR4DePFcYHXWqxFVD
        pBbpn+AROVtcR967Jk5IkRDdbw==
X-Google-Smtp-Source: APiQypK1nmzvS2nmLwnRxDmP5lKch6j44kgbOozEUbrgbvCS5biDAMrxAAoKoc/vJFqcrC/GuSVPhQ==
X-Received: by 2002:ac8:4cd1:: with SMTP id l17mr23695608qtv.20.1587512508380;
        Tue, 21 Apr 2020 16:41:48 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y17sm2664010qky.33.2020.04.21.16.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 16:41:48 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/9] drm/msm: add internal MSM_BO_MAP_PRIV flag
Date:   Tue, 21 Apr 2020 19:41:20 -0400
Message-Id: <20200421234127.27965-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421234127.27965-1-jonathan@marek.ca>
References: <20200421234127.27965-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag sets IOMMU_PRIV, which is required for some a6xx GMU objects.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_gem.c | 3 +++
 drivers/gpu/drm/msm/msm_gem.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index d8f56a34c117..6277fde13df9 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -428,6 +428,9 @@ static int msm_gem_pin_iova(struct drm_gem_object *obj,
 	if (!(msm_obj->flags & MSM_BO_GPU_READONLY))
 		prot |= IOMMU_WRITE;
 
+	if (msm_obj->flags & MSM_BO_MAP_PRIV)
+		prot |= IOMMU_PRIV;
+
 	WARN_ON(!mutex_is_locked(&msm_obj->lock));
 
 	if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 30584eaf8cc8..972490b14ba5 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -13,6 +13,7 @@
 
 /* Additional internal-use only BO flags: */
 #define MSM_BO_STOLEN        0x10000000    /* try to use stolen/splash memory */
+#define MSM_BO_MAP_PRIV      0x20000000    /* use IOMMU_PRIV when mapping */
 
 struct msm_gem_address_space {
 	const char *name;
-- 
2.26.1

