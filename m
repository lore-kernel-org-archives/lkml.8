Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D85C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A4820739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ei3a4oCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgFNBdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:33:47 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54378 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgFNBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:33:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kxnP0y58z9vYRk
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s2bQBb1WHftM for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:33:45 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kxnN6Qbnz9vYRS
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:33:44 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kxnN6Qbnz9vYRS
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kxnN6Qbnz9vYRS
Received: by mail-io1-f69.google.com with SMTP id p8so8877990ios.19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUlMgTFm6fgfWMMV+9s/cidt0Ya0VFDxiosQzLpc40s=;
        b=Ei3a4oCienBBw6iPl3GFWh9tQY0JjX8uZSP4hyeKGf0Iq4siwktVhkBFJeMu9dwJMn
         Chw34JghNFTOkIHxYWPcX2+UpEehlBp8JIeBr0oRj/bA5uN3Q7o4yyyAqT7GAZMF0Q+d
         S0i844L14NaGAbApvuzW7pnHYPEBsCSj1kfzImBZGrw3dgSdnbPSvg+2v8ZsH3aJpFMY
         7hZb1cX44hmnYFYpTJLycCmLzr7inAoKdNdrIlie5gMSZ7zwczaPrNIgiThSEtf/+m05
         7mfJOB3cvuM5dhSwAiobY8dTIC69JCgS6oQRCW+KQ51cbA9nwl4O81GOweBb3rvAWj2S
         7C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUlMgTFm6fgfWMMV+9s/cidt0Ya0VFDxiosQzLpc40s=;
        b=d1J01ZCoN2wZ9xd5AQ8DJ0Po0hWbRr8zlN0jXxKiWBwKCWhzSRmqJq+p5ceEibLLnV
         7UaMtVez1EyPHSHq+/xhxKkVkfYgTzqd9dTIz6govFXTv7JPXXA1TwB4kA1O5Jbf3nO2
         bCnQlMkiYBCWKCjI73XEn4D3Skm4Brudf/FNo/5xHo2iviV3X+b3WTJIdB5mF450mqmS
         oz1shLSP1tb41bCO/bzd9/wPX8ZgheqKD4ckbTvH7yN+SbTBn1dw/k31NGKpGiYddYCG
         f9rh5RNTPcNnt4hpSvgS7Tup1LxrDKHI10GFLf7NVbZ3iG6TrrowZMTE3yIoyy5LlvQI
         Kx3Q==
X-Gm-Message-State: AOAM530sJCviOavxkHZTHAF1kriWPK7vjGzY7Lme+356lnrKNVt5FfS9
        I/D4ACo2OZF/y2GemIfByBFLRMGrg8kPys7WQNXmGJa2Lo4Tg+pO7RYfFIESBwGm/Kse3SmUriz
        cyNoYSHDrpi+YD3hzkjTvel6ka/Yh
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr21169392iow.75.1592098424491;
        Sat, 13 Jun 2020 18:33:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8lq+ZJcFfEGG8Lqn6FC+nNd+cCmmNo/tt7bKBSBKebyGZR+rrsj/xfGHJjBtj4WzgMDZCYw==
X-Received: by 2002:a05:6602:1647:: with SMTP id y7mr21169380iow.75.1592098424337;
        Sat, 13 Jun 2020 18:33:44 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:d65:8ac4:1b02:86ac])
        by smtp.gmail.com with ESMTPSA id w18sm5705722ili.19.2020.06.13.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:33:43 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/noveau: fix reference count leak in nouveau_fbcon_open
Date:   Sat, 13 Jun 2020 20:33:42 -0500
Message-Id: <20200614013342.122079-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_fbcon_open() calls calls pm_runtime_get_sync() that
increments the reference count. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 3d11b84d4cf9..f10d28f8f132 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -189,8 +189,10 @@ nouveau_fbcon_open(struct fb_info *info, int user)
 	struct nouveau_fbdev *fbcon = info->par;
 	struct nouveau_drm *drm = nouveau_drm(fbcon->helper.dev);
 	int ret = pm_runtime_get_sync(drm->dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put(drm->dev->dev);
 		return ret;
+	}
 	return 0;
 }
 
-- 
2.25.1

