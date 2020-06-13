Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F22C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E7B20792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="lfurDX56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFMXN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:13:59 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:55544 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgFMXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:13:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49kth51FM4z9vYdP
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MYrtAo2FeTNp for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:13:57 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49kth46gTSz9vYdM
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:13:56 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49kth46gTSz9vYdM
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49kth46gTSz9vYdM
Received: by mail-il1-f197.google.com with SMTP id q24so9258652ili.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lp/57Kv3gzuXj/K9oQ77nASFzku70Zj4jK0Z7RozDsE=;
        b=lfurDX56hYBZrhdFYqEBnv2irvi2WRAzXzjIzOMzTNHuv42xHT5JVvBul2r6yRZfSr
         Cedk/u4yLdw8aRqEc/y4ItmczY/Wy46YSJdJrRMiyu6axMe091p2oVRathwkVLAjctph
         O1ryAN6KCqcJBCUYQiS5rpomqGicoXiT0GBMpThSYx8h/WfcepNjKEwEdueyxHsiT/QC
         QuMW8qQhASGbepJxBMeb2/E+/u9MHhAnP4kSZh7r1eGnqZTnwEm5ywzhNHk5NVpJQ75p
         aeacfU6DR3UAp/DccV5MCqEE1fH4GmLxOcOkkO/DPszNBMyGWO8UrRz2Jk+okWcCDdSo
         lqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lp/57Kv3gzuXj/K9oQ77nASFzku70Zj4jK0Z7RozDsE=;
        b=ZFSA/+Qf4wegxmFwM/+bvJv/x312Z4UJY0DctpqucdTr32OBiRINPtodk8N1it1j6u
         DhZQzc+TeMgE62HNqGvIUhNjtiNN4YXveFvss80RFZv24CXD0gB8LRbGZWkriwzBbOxt
         H4NW4NFAMFjoAJd+pOlksd00aj6vs6jKNDQBJcK6wInGi+VBnJ5Uxbc8gTV7aIxQ+ky8
         13dGQFY7q2cFd/RfkfITXEb87DU86yupBuf4S6E05ntmgLxjX0BsasWHAruen6Q2PZsP
         pzEyaLLaGt46TayQ7UjCxZQUAN+TOXcmJAmKlwGzHlT2ukRIpBzXtFP577F79xqH+umI
         Xt9w==
X-Gm-Message-State: AOAM530n6PqKVgxMMG40p2T03+f10+NZhwC4UPyOtsUbZAXYUd/HV18J
        QS2jZVLQHXWNQUikRgM6adkXmYPIcB2xDrwN1l2l8iqDeU+lq59S5mef7j3M4JhI8CBISbsQM12
        BgjNXs+zwkFdYXmjEryCGZ9bgj9ga
X-Received: by 2002:a05:6e02:ef2:: with SMTP id j18mr19983908ilk.69.1592090036463;
        Sat, 13 Jun 2020 16:13:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztT1frvvFPpkKu648hyiONgeEYkHge5KRR8FaxCVSOS07PFim7J0gL5UIgkxz52VKBRrECXA==
X-Received: by 2002:a05:6e02:ef2:: with SMTP id j18mr19983882ilk.69.1592090036227;
        Sat, 13 Jun 2020 16:13:56 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id b8sm5368985ior.35.2020.06.13.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:13:55 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: rockchip/rga: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:13:49 -0500
Message-Id: <20200613231350.15504-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/rockchip/rga/rga-buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index 36b821ccc1db..bf9a75b75083 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -81,6 +81,7 @@ static int rga_buf_start_streaming(struct vb2_queue *q, unsigned int count)
 
 	ret = pm_runtime_get_sync(rga->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(rga->dev);
 		rga_buf_return_buffers(q, VB2_BUF_STATE_QUEUED);
 		return ret;
 	}
-- 
2.17.1

