Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A95C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E912074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Hj+qKjLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFNChK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:37:10 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:33848 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgFNChI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:37:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kzBW0HCYz9vK04
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OP8FBSOVnWMj for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:37:06 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kzBV5k6Bz9vJyw
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:37:06 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kzBV5k6Bz9vJyw
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kzBV5k6Bz9vJyw
Received: by mail-il1-f199.google.com with SMTP id q14so9425056ils.18
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RQEF7X2he2CIvCAF0xeze50vGbmiUj8obcSj3YpGnsc=;
        b=Hj+qKjLqwxKZdFHcqhGL4RCVKHV6fP3Oer7rzrgPPWYbv35lGkAst5QgPc8y3nLRCp
         vKVaxl7tk1u8PZMNFAetQYQ6NwzqplGIsXILrLiVUysqIKuvbFEb3y0fL7NeZDA6eBqI
         pO96/Au+eO/frA1E4LLC+lPvS8hR2UvICjeKU9R3le1ae4tglEaeUVDybiZKisk2cU69
         JZ8sbETmJsW/DFxNKzIkJXdJ9tsV1lNSfpS/+4EkCHBrpLSK44iXq7e4QFYuFza1Hz8M
         Zi+3fmlSvQPyovl/+DtnyRguBKLN0yPRjqYUnqP4JoEqzyj84WdoVHPHGf9oZzOLGrVX
         3bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RQEF7X2he2CIvCAF0xeze50vGbmiUj8obcSj3YpGnsc=;
        b=jkYFTl9ZuWOjfQJoz8/3SfN2zklv8giaKM5bmaRFoWytUp6x2+RmR42sr6cp3omAsB
         BJXZBtE69utVOryyF6S6vclUIzK6Qk7M1XzpmtDZ/yIZOudEGnUzkVCVpOp3qTpTDOeL
         mCtiEiYRQzyNFH6xWupoJ6YvrnMWBg12UPAf2I9ioE/JUeRxi/MtUWbeB7b9RJShdbG/
         firzKuB37ygixuazQkE7VS0h6rUhLT0CW2ZIYL4wZUC8PuhFpcTR5Xq5YvHvd7iIs79t
         ZcIlMZLZT/tEUYQMUFKxWcMf3TYBYGKU3Z/X2An/l3GDKGkJlJFBaPD8Fo9Vs50tjTT0
         /tRw==
X-Gm-Message-State: AOAM532HvoJbaefFBERI1bRWjuNlxk+Qi+7DKGO4xxHiRrVRmKhSnAqU
        Dn56h5pfwTqYzS4XIgjyFFttEPm6i5Jd7t700KEQN5HGFiqQruvnuf0Oi4mObXFs77jdkE2sm6Z
        8l28KXTDJjZTTdgLB7B6E198BUDk3
X-Received: by 2002:a92:cf09:: with SMTP id c9mr19732355ilo.143.1592102226322;
        Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ86ckYqx5vk+JKvHiE51xf49YXvXEFvQYRO/7UldKAKo+GnZzsRu2IiSnX8jxysU/4zFyPw==
X-Received: by 2002:a92:cf09:: with SMTP id c9mr19732342ilo.143.1592102226008;
        Sat, 13 Jun 2020 19:37:06 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id 18sm5499967ion.17.2020.06.13.19.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:37:05 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Hugues Fruchet <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: stm32-dcmi: Fix a reference count leak
Date:   Sat, 13 Jun 2020 21:36:59 -0500
Message-Id: <20200614023659.25979-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put is not
called in error handling paths. Thus replace the jump target
"err_release_buffers" by "err_pm_putw".

Fixes: 152e0bf60219 ("media: stm32-dcmi: add power saving support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index b8931490b83b..fd1c41cba52f 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -733,7 +733,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret < 0) {
 		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
 			__func__, ret);
-		goto err_release_buffers;
+		goto err_pm_put;
 	}
 
 	ret = media_pipeline_start(&dcmi->vdev->entity, &dcmi->pipeline);
@@ -837,8 +837,6 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 err_pm_put:
 	pm_runtime_put(dcmi->dev);
-
-err_release_buffers:
 	spin_lock_irq(&dcmi->irqlock);
 	/*
 	 * Return all buffers to vb2 in QUEUED state.
-- 
2.17.1

