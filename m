Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF33C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B8E20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 12:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FynBPSjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGEMMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 08:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgGEMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 08:12:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA14C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 05:12:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so39552207ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7mX8hu/WWjnwnEyPTlU3MGnHpJuzqdu2Apw48vMC6z4=;
        b=FynBPSjDhveS96iN5Y0RalC1idg3UpwKXyEYfOeZzLo2ogVhqEy87dxLuAgtsox3SM
         0whLGGo62pu83HJdLhY3CrWldzxYFN460mOqGomto6LXz36fymnmJfA5Mufh+qQx9M/W
         ao69skQFA9ywZgRdnrpEF6yM9wnsf97mBvIohYf4H8h/2UmxfVy6d2dv+9Zl4T/ysM8E
         S4LCilQdYEyxH4J8KMn/ILcOUrCmy9HSb+B6nLw+zXb8sywWxFkWREcJul+F5CNwIMmW
         B7xIeo2WhAv5C0/kge5WGslynFQ1q32Ve9xBUaGvTvhJTtG61gKKXs1wvOeX+de/Shzy
         w+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7mX8hu/WWjnwnEyPTlU3MGnHpJuzqdu2Apw48vMC6z4=;
        b=DdcGNXmIPLe53blN0mG7Hm0ozg6EzYpFDUPakwMd2NvDes6ZdSjbbfirVQpzi3i13N
         p1rYeqahrI8Rcmx8dHSSrvzKZMnVjY8M3m4yaLqHT8YocW57qvVERIsA+9g+W/QAfVn2
         FqKU83/i2hb2AtnCWG3Gp06l6KZl+0XdOqyRDd53bv34xejBLM/HmgDqIicSiOsFnDvX
         dQjimCfeZ2PIB7oDZjqxHqrCjRueJW7LdlT2EQlX6VttXDT1Ur7MqLpZVzNZ+E0PUbbt
         UsFr+nzpsPspW2n7/fn8pUD9VJHnfqF+Sy958rX/uBBigfjLuiolxzrkQgQpWW8v2URL
         oYzQ==
X-Gm-Message-State: AOAM530DlmmXFH+APZh81iYZ8JhPSAcq/wF87yvrJhP+6Bz0QfYvORpk
        XzNZ1o/L7tzULH9HjSfoxAke9w==
X-Google-Smtp-Source: ABdhPJxbbizoo6eyMSZAaCuAXhtp8LdMYWIATAGhR85b9Jl9t3L4F4IQXUwdy/72ySrxdyoGZO3coQ==
X-Received: by 2002:a17:906:5006:: with SMTP id s6mr38495933ejj.294.1593951129593;
        Sun, 05 Jul 2020 05:12:09 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-133.ip.btc-net.bg. [212.5.158.133])
        by smtp.gmail.com with ESMTPSA id j64sm1517458edd.61.2020.07.05.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 05:12:09 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 4/4] media: docs: Depricate mfc frame skip control
Date:   Sun,  5 Jul 2020 15:11:28 +0300
Message-Id: <20200705121128.5250-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
References: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depricate mfc private frame skip mode control for new
clients and use the standard one instead.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index a8b4c0b40747..c0760bfc54d4 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2805,6 +2805,11 @@ MFC 5.1 Control IDs
 ``V4L2_CID_MPEG_MFC51_VIDEO_FRAME_SKIP_MODE``
     (enum)
 
+    .. note::
+
+       This control is depricated. Use the standard one
+       ``V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE`` instead.
+
 enum v4l2_mpeg_mfc51_video_frame_skip_mode -
     Indicates in what conditions the encoder should skip frames. If
     encoding a frame would cause the encoded stream to be larger then a
-- 
2.17.1

