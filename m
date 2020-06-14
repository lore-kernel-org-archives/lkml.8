Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F3EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC4520747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Wjxn1rKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFNBmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:42:00 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:60422 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgFNBmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:42:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49kxyv2dkZz9vYxQ
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:41:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U-3v5otTq2Y9 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:41:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49kxyv10Zsz9vYxL
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:41:59 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49kxyv10Zsz9vYxL
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49kxyv10Zsz9vYxL
Received: by mail-io1-f69.google.com with SMTP id r11so8834939ioa.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpBLca7Vpqp9NG1nh6LCEacLvQmpL511GojbmNx9nJ4=;
        b=Wjxn1rKfuw9BdNj2jJqRd7zUXS9Idph8gy/wDlJtPVuwZrLE8Aka8rkIwQd9yNRv2j
         mp6xtnBdLpUQvYUCouBoe9YCvCw1QHEELjP3WK4Wxk9OXb6mMtjzG8CQh0GtUppw9Gc6
         dWbbxPDrdmVsUt4miSIsz6UNxBDG5POTtsldrhrjfLt2vmWM2qnFUamAhzuoCEMYvYRM
         VXIZ7l8w6zQBftrBD7x8nr4Uxx/FaS3nOoynwTxUiZnFUjE+pGvrkpZBhxP+mMpisWO8
         TKz/cSX1R2QUiUafPIrU5iN7W6xqcwTwaJHIvFlhxLmt13rKt5GEnbhqL66pT/WMeaE2
         wadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpBLca7Vpqp9NG1nh6LCEacLvQmpL511GojbmNx9nJ4=;
        b=UtHTMQNpbih6sxLMT5IgvKq0DGKGpnU/SdeMkbQAPxIO9dnN5ZaFHcu/Klpu1ra81r
         EC0uyhB0gV6ur+Df2hUH/obsyWdMKmB0E39ra5Y7q8S7Up3VtkeWtKhObOQhtRmwRU7m
         Hcpfith3nwNsaFYlpYQyX7POCGvIMFyF1LEl8U2EmfwaXkuIkvNLS1QgruQMHZRGuMV2
         G3yeU7N7a8xXzlPILp4KYh6vdm5t3t/KKe9FOG3XTfWTY9GgZEkYBQ//Wj2SyHc0cj72
         sq5OBv0SaURUNTw48E+ACe7HKZTMJ3bZMF7leeF/GDr6xP4I5fe3osOatoLSzb9+luJX
         6snA==
X-Gm-Message-State: AOAM531HqWvRqj93GUCUgQqdOjUCMhnA2EAhg0l7w+G0WMZL3fj83zqo
        xHrh/iIGXGsFjAwDs1lKdZzfcvjfF/vSQVo2HlUX/0wCmhLtS/QJoDkzwC8XipFfhBzJfbzDxQg
        es6Ik0O3Tu2WK1vgzV5DN6rrbpSGR
X-Received: by 2002:a92:d704:: with SMTP id m4mr19565773iln.248.1592098918707;
        Sat, 13 Jun 2020 18:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBLK54k4OZ8RbUQudZFJkUsqfkSvb0zM96jD7mAQJP4d+aXqcGxn5UyF7jykVx6il8g76RcA==
X-Received: by 2002:a92:d704:: with SMTP id m4mr19565762iln.248.1592098918550;
        Sat, 13 Jun 2020 18:41:58 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:d65:8ac4:1b02:86ac])
        by smtp.gmail.com with ESMTPSA id y5sm5644372ilp.57.2020.06.13.18.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:41:58 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix multiple instances of reference count leaks
Date:   Sat, 13 Jun 2020 20:41:56 -0500
Message-Id: <20200614014156.122729-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
ref count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 8 ++++++--
 drivers/gpu/drm/nouveau/nouveau_gem.c | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ac93d12201dc..880d962c1b19 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1026,8 +1026,10 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 
 	/* need to bring up power immediately if opening device */
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	get_task_comm(tmpname, current);
 	snprintf(name, sizeof(name), "%s[%d]", tmpname, pid_nr(fpriv->pid));
@@ -1109,8 +1111,10 @@ nouveau_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long ret;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	switch (_IOC_NR(cmd) - DRM_COMMAND_BASE) {
 	case DRM_NOUVEAU_NVIF:
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 4c3f131ad31d..c5ee5b7364a0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -45,8 +45,10 @@ nouveau_gem_object_del(struct drm_gem_object *gem)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (WARN_ON(ret < 0 && ret != -EACCES))
+	if (WARN_ON(ret < 0 && ret != -EACCES)) {
+		pm_runtime_put_autosuspend(dev);
 		return;
+	}
 
 	if (gem->import_attach)
 		drm_prime_gem_destroy(gem, nvbo->bo.sg);
-- 
2.25.1

