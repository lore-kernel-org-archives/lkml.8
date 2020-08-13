Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F32C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C7E20885
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1HwcSp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHMGV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMGVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:21:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F2C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so4908869ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV6j1YOlt73/vZbx39+AFv7LWnETp8Vud91G3AB3D38=;
        b=X1HwcSp96q0CP6XQhQs1GPo4nvPWoE+L2nDF9ZIDpZERw+rLiB/bEU8Te/A/TZJwkY
         mzhpjqBC43Z7FmQs5BkoYUSqU00bNuiM9TP22ps5RBUCgoV4ZKi60dhMorf9RPuguvA6
         4fJcM/d1wkeekHTE4FSDqDmLHrjLrQIS3JmTLdjKyngRnCxATKCAbkC3rOV0A8YSslEe
         TwMAWkKQvK3XwuP5Np6ZFuqdw+2z2u6WSfh88ZM2rvbGA9OIbIlxxnOWSJYEK8z1AU4o
         xnKrJYGQ/x7V3n1WM+bFyErLhocUGoQ8HA9vmdK2oTnr1U1XZiQuXYUXxCIbxRnGYR7N
         tvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV6j1YOlt73/vZbx39+AFv7LWnETp8Vud91G3AB3D38=;
        b=VnZwkQkPuwrrQp0FtrBqAk2OS8EyjcRge2Wp72c5GOgdAPFYd9DEyTKlBzjIA+ek2Y
         lfI7/4JM9g7Cyk8JoLsKGQ8EsMWvTCRq7gG4NyAIxrw4lUVtRSJknENSaoozZNmwhBgV
         JESRJYKCv/Bcb1nSp0mQ2qNmQRZg9H+U7B6z/PIqigdUIhbbTFCxpcEBuctudDFxPrRA
         n0dECxjTARAUdpRJJMyGsma1nhBLT6B84Jes7WFWqc6rQswpCoYDheBZrl6XReV2Pw5e
         gcfHr/miaW0fcmRVmmkFznb7xLIvDKprHozRqQPyFlXN9OqIG88JiyoEoB5mTqHoTe9H
         l+BQ==
X-Gm-Message-State: AOAM530yrPjbzIfjS8vn/Q4tAuMmYz5XvxJN1z9wuGl1AXx8ZzOxUwbT
        wJi4eGhYohKTYddKfomaXsA=
X-Google-Smtp-Source: ABdhPJyccRfWxWmuepWebwNoe1LCZJoc+bCL+PgtqKkfshXws5t6wobDOmvACsoPZG83M+Ft4/SImQ==
X-Received: by 2002:a2e:3c03:: with SMTP id j3mr1259425lja.397.1597299679335;
        Wed, 12 Aug 2020 23:21:19 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id f14sm964060lfd.2.2020.08.12.23.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:21:18 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 3/5] drm/xen-front: Add YUYV to supported formats
Date:   Thu, 13 Aug 2020 09:21:11 +0300
Message-Id: <20200813062113.11030-4-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813062113.11030-1-andr2000@gmail.com>
References: <20200813062113.11030-1-andr2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Add YUYV to supported formats, so the frontend can work with the
formats used by cameras and other HW.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index 459702fa990e..44f1f70c0aed 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -33,6 +33,7 @@ static const u32 plane_formats[] = {
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_YUYV,
 };
 
 const u32 *xen_drm_front_conn_get_formats(int *format_count)
-- 
2.17.1

