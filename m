Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A06C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5622CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCvvaoCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgHJT0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:26:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729167AbgHJT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597087563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jW0fem5Jmjj0Zx6/HwTIZV0/DFfxiDU26zPyQGABhVY=;
        b=jCvvaoCbggqT8+ZLFOWFckBmAhXRcNAIjN5sXfd8TtFRSprJOZwABEq6NcxtFFHpYDf5th
        yGDW1aJao3Y3kNHZ/Zod1JTN1CjR09eKiWoe2DRScEshAgZvyB45hOoZpCmfE1yKNljMUv
        SHS0KSuvib3gcMmFVjLxlCtFPyYPDKM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-ldIoVdFiNTi0UieuYAKzhA-1; Mon, 10 Aug 2020 15:26:01 -0400
X-MC-Unique: ldIoVdFiNTi0UieuYAKzhA-1
Received: by mail-qv1-f71.google.com with SMTP id z10so7993608qvm.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jW0fem5Jmjj0Zx6/HwTIZV0/DFfxiDU26zPyQGABhVY=;
        b=PdEHvDGvHCA13JzYw1y9aPDRwaPWs/YOsGUeADm0aLq4KDGGDLbuthX7RCzV6pca8j
         Sq/CoRi4D5Hu411kpHbHSuPP4qM9dW4Ysnbq+pwr+jEtV41d3b3i/CKR8u0aXKsah4nI
         kNt7h6Jsp6fpK8fKc/vJXFvSfHofeExMEmW4/d9AhrW/jci6o2CWyHYyAY2vdk216LZ6
         VP8+lnqueMWR3alzbT4O0FMIMoYNIt4zDJaxp0uc8VoISlT7/4+Gl/PorTWr6JHJpDie
         yCAd/m1GUjbaYp2cU7KVEdqQq7UMj7BnIoQu5KQ2e7aPMuP/VAQtWzg2e4ULJpfj+kiE
         XmsQ==
X-Gm-Message-State: AOAM531A0JOBUPBmcKcJ8HPIAbqdMd3Epbe4SCpUuB6HcQDD00ZykNr3
        wqWexE/VnMaLv1+hJ9RU54KIVDPVkHb0a3qNVVX70hHZA32CVfYMXR2bHcx2YCVrchD1HId16SE
        snFwW4cu+ciWt86S6ROQZDXPz
X-Received: by 2002:a0c:f681:: with SMTP id p1mr22661604qvn.248.1597087560682;
        Mon, 10 Aug 2020 12:26:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZu5Y1a7ZFALxLczh2/NRooWYBVXrMgno7Bp8kSPcXz04fI7U/kb7Ai6dmhiMH/so/YqBlaQ==
X-Received: by 2002:a0c:f681:: with SMTP id p1mr22661586qvn.248.1597087560490;
        Mon, 10 Aug 2020 12:26:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 139sm14690740qkl.13.2020.08.10.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:25:59 -0700 (PDT)
From:   trix@redhat.com
To:     maintainers@bluecherrydvr.com, anton@corp.bluecherry.net,
        andrey.utkin@corp.bluecherry.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: tw5864: check status of tw5864_frameinterval_get
Date:   Mon, 10 Aug 2020 12:25:18 -0700
Message-Id: <20200810192518.8822-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

tw5864-video.c:773:32: warning: The left expression of the compound
  assignment is an uninitialized value.
  The computed value will also be garbage
        fintv->stepwise.max.numerator *= std_max_fps;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^

stepwise.max is set with frameinterval, which comes from

	ret = tw5864_frameinterval_get(input, &frameinterval);
	fintv->stepwise.step = frameinterval;
	fintv->stepwise.min = frameinterval;
	fintv->stepwise.max = frameinterval;
	fintv->stepwise.max.numerator *= std_max_fps;

When tw5864_frameinterval_get() fails, frameinterval is not
set. So check the status and fix another similar problem.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/pci/tw5864/tw5864-video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index ec1e06da7e4f..a65114e7ca34 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -767,6 +767,9 @@ static int tw5864_enum_frameintervals(struct file *file, void *priv,
 	fintv->type = V4L2_FRMIVAL_TYPE_STEPWISE;
 
 	ret = tw5864_frameinterval_get(input, &frameinterval);
+	if (ret)
+		return ret;
+
 	fintv->stepwise.step = frameinterval;
 	fintv->stepwise.min = frameinterval;
 	fintv->stepwise.max = frameinterval;
@@ -785,6 +788,9 @@ static int tw5864_g_parm(struct file *file, void *priv,
 	cp->capability = V4L2_CAP_TIMEPERFRAME;
 
 	ret = tw5864_frameinterval_get(input, &cp->timeperframe);
+	if (ret)
+		return ret;
+
 	cp->timeperframe.numerator *= input->frame_interval;
 	cp->capturemode = 0;
 	cp->readbuffers = 2;
-- 
2.18.1

