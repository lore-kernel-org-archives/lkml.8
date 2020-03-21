Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E5BC43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1FE2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 20:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIyxJthK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCUUht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 16:37:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39264 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgCUUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:37:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so11573774edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MAv9nYA+EA8sQl+oTebsnJpHm15vlJ946YYDhPPH8Ag=;
        b=PIyxJthK+hKVhHkV7DNb9tnBekj1Mm8kPvfdZQZygyJR7pBcGLrIK6iN18cvt7CQYv
         TJIpET5h3dTZSjkraa5sQpn2lt0qus/fFspnU3UEim8fc9/mChTzZ8pt0VyhGBUn4lv9
         Sy3DZOEIRmaa/3Wbh3eTm8arhmxhrqyHDx2svwv/kXFQwJnKwm4IOzVJBRaySFaBKny3
         SeuVUnAaYC0KPsVBsVMkfexM9/qoM1N728SI6sfwgr6K0O4bIsa/twWw0swZSo15d3g6
         4Uyn7Gdzx3JPNFzS2n6c7ohoJ90tXiE38yonPC/Q1QdiDWNnPyUiWecJmg+Vtu9CsXOP
         7y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MAv9nYA+EA8sQl+oTebsnJpHm15vlJ946YYDhPPH8Ag=;
        b=fp5CL4X7v7c3KT1rlAPNnhzP8yMRKXYiNSMZ36yXc8b7B3CnI/L2HCvzI8ExbsIncA
         BlpFg2oAISd+Ht+eR1fEDmtXXH3OE/wFBRHxvlvnwCqOYdoSD6uUwKWGAg/tKRwm9HxP
         frPHtxkfEe+/4E7ckwGiMa2bHOfBRQiPDADqQZXSXhtXkb7BTk9XUsAgxdCD/Ebhj4p3
         yDLIXhBwm2wUy7tyKgGcPtoec1oYlusy4W+zcbi0MJIPp9qQLLF8jrypvzeuiEMa2eiz
         BI8qtYCazcBZMh4Xzmhul8gFwhMIT50Iqx+uczT55uNn1WixrDRgpQRnXYMNfnlAZIMJ
         qlPw==
X-Gm-Message-State: ANhLgQ0NhgZ9b/3suXGwsmidXPMev4TeL38rr4UNn8m6nfvzzsQ2/R5o
        B6Rcr/znApG1P4WRtTD8kLQ=
X-Google-Smtp-Source: ADFU+vuYvDjWH4U0N7xvR70zyMG7JDP3kL/4N/gFVXeM6Sx2ajf8vISRp+9ESGYjiQs41fFi3HFCeA==
X-Received: by 2002:a17:906:a28d:: with SMTP id i13mr1872058ejz.166.1584823067347;
        Sat, 21 Mar 2020 13:37:47 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id t19sm634333ejc.55.2020.03.21.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 13:37:46 -0700 (PDT)
Date:   Sat, 21 Mar 2020 17:37:40 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rodrigo.Siqueira@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: enable cursor by default
Message-ID: <20200321203740.pg3r7f4vybruowox@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch proposes a change in the behavior of the cursor to enable it as
soon as the vkms module is added. Enabling the cursor by default appears
to be an expected and more friendly behavior, especially when running IGT
tests.

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 860de052e820..6e6feecf7f20 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -34,7 +34,7 @@
 
 static struct vkms_device *vkms_device;
 
-bool enable_cursor;
+bool enable_cursor = true;
 module_param_named(enable_cursor, enable_cursor, bool, 0444);
 MODULE_PARM_DESC(enable_cursor, "Enable/Disable cursor support");
 
-- 
2.25.1

