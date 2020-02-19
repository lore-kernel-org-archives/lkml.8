Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DADC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42944207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IzvE2I3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSUAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:00:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37875 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:00:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so522018pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fmDci05JHgVKjcgLPSVfqdV3CiFfxgAZngf1Re3DIhY=;
        b=IzvE2I3IpnWm6NE2Ng5/GGEuVLFwyvJlma/2j4jiSayqmL7fZvL7kfydyrijoVplQ+
         ASCRNMkgO7D68tZ50d9B/8VrV/u68HMSx2UPoXoiG9ChvNQXMeQDTfwSp0NWGMLbHq1l
         FAYYZTNOq2x/zjyfRkrlAMNF3Jjrmq2VDjY6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fmDci05JHgVKjcgLPSVfqdV3CiFfxgAZngf1Re3DIhY=;
        b=ZZiKdV2+cMEVsxxvdJoi76w7KYmBZOQCWox236oSxp6EJX8lEMAQthWl32a6Flvsx3
         O4B7z35Of27SEKY0PY/h3GKRilQDfMuf2rLf2wZmYHBhutIfzPX4PvSpH9IVCxBEBqOc
         3+Z3jANqwZqQDXRQNfakIQ9QW9tInACekU2wjFSUIOyOhTvDtF55ABwSEJOmGkspVQ19
         O6Ei3AQfsaKUppIax+Dixt9MYvoUvydC/HXSQ+cmOwE1QueB/L2zCSfNyXTE6HWqEh9Q
         eQFjVTNa2THA6CEk0DpNHhn2VjMyKjfzcwl6es9lX41ahxA3ZhB4MPnINgpPZ6ydHL0G
         TXsg==
X-Gm-Message-State: APjAAAVvaV36Jqa3XnS/DqGM2tBYtsIBQJnRO/CKCLyIou+EJ5dg/7c2
        Fjb6aYtIwqBlW0hYzGEJAEb5kA==
X-Google-Smtp-Source: APXvYqzpcl13F5RQ5GygW2x7suYzcJF08duSYixNAJ2FvzcdSkb52Y+MCajGLFfYVA8rX3sUwWjzwQ==
X-Received: by 2002:a17:90a:f012:: with SMTP id bt18mr10864393pjb.8.1582142442905;
        Wed, 19 Feb 2020 12:00:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm498600pgj.79.2020.02.19.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:00:42 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:00:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Benoit Parrot <bparrot@ti.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Fix typo in "TI VPE/CAL DRIVERS"
Message-ID: <202002191158.2BB5431@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent MAINTAINERS entry change for "TI VPE/CAL DRIVERS" broke the
file format as it skipped having a line prefix character. Add missing
"F:".

Fixes: 2099ef02c6c0 ("media: dt-bindings: media: cal: convert binding to yaml")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a0d86490c2c6..8f95de7f5eee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16752,7 +16752,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/platform/ti-vpe/
 F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
-	Documentation/devicetree/bindings/media/ti,cal.yaml
+F:	Documentation/devicetree/bindings/media/ti,cal.yaml
 
 TI WILINK WIRELESS DRIVERS
 L:	linux-wireless@vger.kernel.org
-- 
2.20.1


-- 
Kees Cook
