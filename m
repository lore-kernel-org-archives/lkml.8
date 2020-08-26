Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC092074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UdinP/Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgHZQsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbgHZQpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9E8C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so528099pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wk7DlN4RR6k6lg+nX/WYTS8+aJhqAF/kFILSCMp8TGw=;
        b=UdinP/YbA0u1t4KDbjuAf+r71DAWjgY3RPz9ZScLNzkB7tPAhMeHX9QmzC9malvaJF
         hoj9Qwbdr4GuV/WOxVpVYRdSZi46IYmQXewQvgP6oA1/VfZ6BFNX6Bd9YHSeErmBJqv8
         yiP3pd4ykmjYYOi/+0ds2XovLu2/QdPHghSjYtKuw5i8xKHp5waepuCI/l2+9IciBIJd
         3wI5yo+0meEJJg5WPfOX/Zx/4R4WNhVfcFKPW7GQ6fVFsmsvcXUjO16zSVY7TJph+RUC
         WPwsHa7jskkpIjIuBp1MnDdy9KRecBHrpp8IBOMggvj7+3+aTWG/1gSXa5fistCF+sx7
         Kg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wk7DlN4RR6k6lg+nX/WYTS8+aJhqAF/kFILSCMp8TGw=;
        b=LLjW1vulvJ9G0hbfeshq3E5J1yh4nMADIyYxp+xHbLnbTjPWJzfruxkz9E8SxZ2Dv5
         L112Hvx9DBEy2a8KqJxjpiOqitzKpPckVQMtOIbKqzbSXC+FH7pJ4+B8sB5VmCweyEbv
         kSf1xpsWJXgKeloLccx/E3hcbUO4OKUnKQYXwtl7UvbF8qve+XN4djKhXofF45InSxHs
         s005PYk3zF7sWU3SYlaRryRxL/8xCF7hxX00nnucbPzY/C+Bu4UYJbZJCHMTHbxJiBK4
         WrG6BTwZgq57oEYqXbSlSVaVAV/58uYx5PXqKqlQ5ez5mDg1QzZjTOiOnMFf1TN8hlXJ
         0+TQ==
X-Gm-Message-State: AOAM531Z+AHnh23K5d4dpuVaO6/uia5sxaeUBx6K1GTshYwVt+oKzIB3
        w7fWT068yCunGPngMHqXnzjdpjy/f0X2tw==
X-Google-Smtp-Source: ABdhPJwFq1VHZ9E5J6KXkMZQVDNWMO5HD2gW4DuTbXKm53qunGivmzlikr0J4TcdsZaxi16+X87t0w==
X-Received: by 2002:a17:90a:d908:: with SMTP id c8mr1106186pjv.4.1598460341768;
        Wed, 26 Aug 2020 09:45:41 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id u3sm2548878pjn.29.2020.08.26.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 09:45:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] remoteproc: Properly deal with a stop request when attached
Date:   Wed, 26 Aug 2020 10:45:26 -0600
Message-Id: <20200826164529.224476-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826164529.224476-1-mathieu.poirier@linaro.org>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to stop a remote processor
that has been attached to by the remoteproc core.  For that to
happen a rproc::ops::stop() operation need to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_cdev.c  | 5 +++--
 drivers/remoteproc/remoteproc_core.c  | 6 +++++-
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index b19ea3057bde..d06f8d4919c7 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -37,10 +37,11 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 
 		ret = rproc_boot(rproc);
 	} else if (!strncmp(cmd, "stop", len)) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c6c6aba66098..95bb40b4ebb3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1619,6 +1619,10 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	/* No need to continue if a stop() operation has not been provided */
+	if (!rproc->ops->stop)
+		return -EINVAL;
+
 	/* Stop any subdevices for the remote processor */
 	rproc_stop_subdevices(rproc, crashed);
 
@@ -1857,7 +1861,7 @@ int rproc_shutdown(struct rproc *rproc)
 		return ret;
 	}
 
-	if (rproc->state != RPROC_RUNNING) {
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED) {
 		ret = -EPERM;
 		goto out;
 	}
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index c152d11a4d3c..6134d2f083ce 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -113,10 +113,11 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
 	} else if (sysfs_streq(buf, "stop")) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
-		rproc_shutdown(rproc);
+		ret = rproc_shutdown(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

