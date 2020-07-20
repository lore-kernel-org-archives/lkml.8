Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59246C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B2A20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NikpLS+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGTJ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGTJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:29:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9385C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:29:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so8436826plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2DSO/aWAoJzWSJL4puh7QjtP9M2G0vX5SgGCTFfnts=;
        b=NikpLS+N3qR2sHdhR++q/DgmRGoIAbwJDPZKGfWUAcTIcUw9TlzB5FnpPDt1sPSC8M
         Mk1NNk5XGn7yY2BPr8ug25MWnXMYXXuIY6FffQ9Cuct0k6OhyykTdx6MnypRI9vKclRx
         P8GI+xWh/nlO6Y8TpDcDUh1fqoYJqxCoGaVCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B2DSO/aWAoJzWSJL4puh7QjtP9M2G0vX5SgGCTFfnts=;
        b=ladolUT9O9x7pj706DmBkSzDTXJpwz7snxThJwCwzZ3wWdf0f88AVdoQusgtGuFkAm
         2y5SZcI7w5R+9af80EL4CAPFxNUSJfq6ybGZf9GygF2dVep5TUim3G76CMVGJtAV7IQP
         aq1H8avVu5BXjqvVZQejrfFFRha34f/wGhcGi4xspcI3bwRF8wy16plmdjDAQllpT2rd
         tGu4I8RTBZmgCZjw9vcWf3+z8Ldq7CN2wHbm/+lBnqU/FU0r3MeZX999xyYlcvY7DP2o
         wx1oqml6cUY6awU3izMi7U/PITYjwO6LohlO4g+1rTa5zBI0LVgwHWJDJlyKx9gI4drH
         oFkg==
X-Gm-Message-State: AOAM530WqCdTnW3aUTXUspnBrY/IXHUAg3W/GSWtho8+S2YdjlkPyPIW
        yvw52QvYfCwwbQp6LYvaTg8pEg==
X-Google-Smtp-Source: ABdhPJyUJqTu1oMIZdT1XQQeuBWfeUW3vYNGSn8M+KxvAA1dCrmEuEg2ct9wwK30sAebekF1pTzQeA==
X-Received: by 2002:a17:90a:66c7:: with SMTP id z7mr23079390pjl.172.1595237383150;
        Mon, 20 Jul 2020 02:29:43 -0700 (PDT)
Received: from jjsu-p920.tpe.corp.google.com ([2401:fa00:1:10:a6ae:11ff:fe11:67])
        by smtp.gmail.com with ESMTPSA id v2sm11197363pje.19.2020.07.20.02.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 02:29:42 -0700 (PDT)
From:   Jian-Jia Su <jjsu@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jian-Jia Su <jjsu@chromium.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2-dev/ioctl: Fix document for VIDIOC_QUERYCAP
Date:   Mon, 20 Jul 2020 17:29:33 +0800
Message-Id: <20200720092933.2089288-1-jjsu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4L2_CAP_VIDEO_M2M is documented as 0x00004000
V4L2_CAP_VIDEO_M2M_MPLANE is documented as 0x00008000
This is different from the definition in include/uapi/linux/videodev2.h

Signed-off-by: Jian-Jia Su <jjsu@chromium.org>
---
 Documentation/userspace-api/media/v4l/vidioc-querycap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
index 666ac4d420519..90347367ef06a 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
@@ -168,11 +168,11 @@ specification the ioctl returns an ``EINVAL`` error code.
       - The device supports the :ref:`multi-planar API <planar-apis>`
 	through the :ref:`Video Output <output>` interface.
     * - ``V4L2_CAP_VIDEO_M2M``
-      - 0x00004000
+      - 0x00008000
       - The device supports the single-planar API through the Video
 	Memory-To-Memory interface.
     * - ``V4L2_CAP_VIDEO_M2M_MPLANE``
-      - 0x00008000
+      - 0x00004000
       - The device supports the :ref:`multi-planar API <planar-apis>`
 	through the Video Memory-To-Memory interface.
     * - ``V4L2_CAP_VIDEO_OVERLAY``
-- 
2.28.0.rc0.105.gf9edc3c819-goog

