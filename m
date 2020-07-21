Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C151C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9359208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaaqOgLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgGUHwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgGUHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:52:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487DEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:52:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so23049061ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Wsh5lsQJS5Oj2N0tWY17u1sLYFEy9iokkNEGsNaFVc=;
        b=OaaqOgLWbDq6dMMW9Qd714qnIPqwNeJycdVqOHjHvtSPWLsGIigkGw3oYMdwp9gy4J
         88BotViSV5y55ZHLLXr8sWbl+PPKCk9tXV+bTSFWoP3wNxz7xA30hFbaLABgg0NpGMod
         uDE0TkuRkq58eaFQFqS+oH2AtsKYdu8HhKnLuZbl20b4DKXdf7SXkHyZiw4H5Rj19ktz
         u9JPRKOqXwdSgzsBEgXe474H+oLNjrbIfD0CTbStqhC18SSsUtnX1Kih5O9eSmUm9G3q
         LeZQzR6KTwjZYtd+Mz5s6/lnFAn7MHBqU8dsogvhX9kxc+XXAVSRxGaCMyP7kH6prdMJ
         7uhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Wsh5lsQJS5Oj2N0tWY17u1sLYFEy9iokkNEGsNaFVc=;
        b=TV94UJhllz0ibrBoAbxlKsFmCA+Yl8qZdpuvJ0U5JCFGueChqRMf/Ob3sZbKN+FtSF
         8A7e6OYAQLkkgYLWpXCfFIHlwZe9HE0ywewo/LFx37jVYe4rVsdNvotvS5OiA4LBNHTy
         M/7t3rriiFoiXJJ2U2c5iumLnTTIK0bel+8R9Yz+PKFtrFH+WiRsQCWGXz4iKAGISOha
         CnRd5QVaAFimVksoeC+uE/4rpgzfRxqDMKbcZouwkPhI0AlhWI8hbZOyys8+YK7xGU6k
         cg/xQxKzIGteVVkp6Kh9FPCSPdCFAHZL0sCZ7A+qg/Ct3NIapKX4Xe3rwbq8ybrOtlv2
         JjfA==
X-Gm-Message-State: AOAM530ZnFiT9uTmcPJL8wb9DOc2AOcqAY3GTzHaS5sE11mWslt20Se+
        3RJbuAl7BYRkVaKmSichF9Ytbg==
X-Google-Smtp-Source: ABdhPJyZFPSvzK9fQpzmF3fsaGlhPY4lxN74NDqrPwju5khjBtSE4wGLSPuWeHdry7K/2o8YPgJUUg==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr12887062ljo.62.1595317927776;
        Tue, 21 Jul 2020 00:52:07 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id d2sm4045334ljg.6.2020.07.21.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:52:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 6/6] media: docs: Deprecate mfc frame skip control
Date:   Tue, 21 Jul 2020 10:45:38 +0300
Message-Id: <20200721074538.505-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721074538.505-1-stanimir.varbanov@linaro.org>
References: <20200721074538.505-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate mfc private frame skip mode control for new
clients and use the standard one instead.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 985e4c2d29bf..31d77d1cdcc9 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2821,6 +2821,11 @@ MFC 5.1 Control IDs
 ``V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE``
     (enum)
 
+    .. note::
+
+       This control is deprecated. Use the standard
+       ``V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE`` control instead.
+
 enum v4l2_mpeg_mfc51_video_frame_skip_mode -
     Indicates in what conditions the encoder should skip frames. If
     encoding a frame would cause the encoded stream to be larger then a
-- 
2.17.1

