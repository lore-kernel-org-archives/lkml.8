Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NO_DNS_FOR_FROM,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC1320714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Wf9cvdC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFNDtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:49:40 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49594 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgFNDtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:49:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49l0pC1GRTz9vYl6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aQ5MUf1Y3cuj for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:49:39 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49l0pB6kfbz9vYlC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:49:38 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49l0pB6kfbz9vYlC
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49l0pB6kfbz9vYlC
Received: by mail-io1-f72.google.com with SMTP id t23so8993197iog.21
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1+vh6OG/QUv5B+RXf21E17kUY/OAo+QLI1El2T7f9A=;
        b=Wf9cvdC5nYTLESnBGjFs5H+m4gR41K5mKAyxwxMujg7aORiW44VNGewQa6tiLEyQXy
         EX5umggItrf803SFsKC9noyeOEEb1Haazy2WqVffiKBgTvUm7SGZm81SFe3A2/3oI2VQ
         WlFUHPAgdSIiHWV7HJaczZCQLCltnr/ARTKyvpune1eyGps8UJtTW8q5jkSAYBCBxLxS
         r2yQsrdNDzpBFWEoy8qhp424L36X6KRh9j9hy9YhtgPEbz88/GBW7JLCMhD9/9uHVDvQ
         l2NaQUHX+uVKe+TgFJeCeN8jrMMty81F4Vlrvl5bk1dxfv+zkbCdi7FfyWGSRUwF6Ee0
         iqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1+vh6OG/QUv5B+RXf21E17kUY/OAo+QLI1El2T7f9A=;
        b=NypzXkQSaaIHZs7c6SM4Wr1MmakO5r5/rmytPEPCRMEB+DMuYdX/nblF7SFaFLFEy+
         aarCFcmSJNqWwQ+I5AK1Jtb5tn5czcsbKh2PdzErOd1VrLZbRBg1bfXsj1WtRRnkb7Hr
         gsmdNGqEOCq9iXdNLOSWOHcIm8CRe5dogQZlTOIM8tRm78GwFgsmVFDRuamnLfxUEHHK
         bIHJLiBwTCP0TLyA40R0swpVd97Cm5jDmANmqaQTl1CW0SeiZmwkVOeg5kwMmbsQm95r
         K2HP+raTuKZAjMbgdniDCsPXxQ65LmeiAwKOPHSXED4sVNQ7R4fCwH6nC37gRDjHs0wP
         /2Ug==
X-Gm-Message-State: AOAM533CUx7TBl6b+nO1UW8MYK9Kt46MfjhtnimhE+p2cVWmUY2bjVx6
        bKYEpzUWigV8Cdj1eB0DMlanTmB7JZ9HUOU1WvwzKnpamukgPvPgnmmWb2YOfavnztelL6wYOAK
        grLGI2ZtJdm2RlhuR7iy0tp1QGHjf
X-Received: by 2002:a6b:6c11:: with SMTP id a17mr21363991ioh.154.1592106578408;
        Sat, 13 Jun 2020 20:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIz+DnykNu8A0FtFIEczu08OPFfxQukZJAyO+7HED9qRP8TT/s0v4vyYoK9nOrzGd9DYs+0g==
X-Received: by 2002:a6b:6c11:: with SMTP id a17mr21363979ioh.154.1592106578128;
        Sat, 13 Jun 2020 20:49:38 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id y3sm5682508ioy.40.2020.06.13.20.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:49:37 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: bdisp: fix reference count leaks due to pm_runtime_get_sync
Date:   Sat, 13 Jun 2020 22:49:36 -0500
Message-Id: <20200614034936.130872-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index af2d5eb782ce..098914ca4f68 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -512,6 +512,7 @@ static int bdisp_start_streaming(struct vb2_queue *q, unsigned int count)
 				v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
 		}
 
+		pm_runtime_put(ctx->bdisp_dev->dev);
 		return ret;
 	}
 
@@ -1371,7 +1372,7 @@ static int bdisp_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to set PM\n");
-		goto err_dbg;
+		goto err_pm;
 	}
 
 	/* Filters */
-- 
2.25.1

