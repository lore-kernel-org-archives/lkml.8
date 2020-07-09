Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4567AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3672077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQF13Um3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGIPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:31:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44799 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgGIPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594308694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ZF+I2jn+WkRqYcMn9LbEqt6wxaWBW8Jnk837a3yZsFE=;
        b=OQF13Um3Rc42bWSeRZhEXagbwvOMkjDtZ4QAO4YjyJao0p6+QvmhBYq75s959rSxtAwoSs
        174sNGpnGomsJHw9kkNLU2WI653qCKABGruvRZ3rCmBbwn+iN2sUAw+Nwr7z2ELU3+mDx8
        w8xg64FW4xf3yl9IZagpje9kBs4f1LA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-vegBVbeLPvy1uXhzQKPOGg-1; Thu, 09 Jul 2020 11:31:32 -0400
X-MC-Unique: vegBVbeLPvy1uXhzQKPOGg-1
Received: by mail-qt1-f197.google.com with SMTP id t36so1878390qtc.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZF+I2jn+WkRqYcMn9LbEqt6wxaWBW8Jnk837a3yZsFE=;
        b=dFwxp8Ir290+v1lJbAWYvWRmgI37PQJXb4yjP3nTEfcJxQHHJP4XvcxGcFC1+GzIws
         KI5pTdBPqLTvHzi6NsgIvs4c2UKphsj9eoLwJjwJ0ZyeUEF7tfIVPljMRzIiYkymRC63
         vxyvYU3xhdAZYjFXqTkPGyBgmS1q1iZUVn50L7nJDPJDuJWCqspG/h2KVQFM8oUpJCXX
         uEC+zVTwppyAuydmurKWeYOSh2GAW29q5+pHUutPc/6w13EOdFXJrvMg8yTnUm0/V7lL
         NEd8xWXRl3C/0dsVCvVxhtd4vQDIm76hdMkVeH4Hi+IqWGZN9+RxqhBM+e1WYPi+4663
         RN9Q==
X-Gm-Message-State: AOAM5322JTjPbfdoq+fO7RSU2rF7SYiaHwJvWOVli2sGFH7Hc0wirGZA
        VB/VK7GkcYcIAGlB0JPeARMYPv6zK1fDG4ikHojwdZPm6n47x0VwwO4JO4ORy/dCb+8YKOg+twb
        2bJebagV1dHjAjr3FWMBo0Qwi
X-Received: by 2002:ac8:6d16:: with SMTP id o22mr67048631qtt.155.1594308691787;
        Thu, 09 Jul 2020 08:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuzlQ/zRnRg6aKupLEhOGOFNbX7xinSDyoHVWfvx1a9HRueZosec+t8HilVZakl0PGoS8tlQ==
X-Received: by 2002:ac8:6d16:: with SMTP id o22mr67048603qtt.155.1594308691540;
        Thu, 09 Jul 2020 08:31:31 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l3sm3832360qtn.69.2020.07.09.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 08:31:30 -0700 (PDT)
From:   trix@redhat.com
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3] bus: fsl-mc: fix invalid free in fsl_mc_device_add
Date:   Thu,  9 Jul 2020 08:31:19 -0700
Message-Id: <20200709153119.5051-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

fsl-mc-bus.c:695:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(mc_dev);
        ^~~~~~~~~~~~~

The problem block of code is

		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
		if (!mc_bus)
			return -ENOMEM;

		mc_dev = &mc_bus->mc_dev;

mc_bus's structure contains a mc_dev element,
freeing it later is not appropriate.

So check if mc_bus was allocated before freeing mc_dev

This is a case where checkpatch

WARNING: kfree(NULL) is safe and this check is probably not required
+	if (mc_bus)
+		kfree(mc_bus);

is wrong.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 v1: add a comment to explain freeing uniqueness
 v2: add gregkh's suggestion to comment.
 
 drivers/bus/fsl-mc/fsl-mc-bus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 40526da5c6a6..839d96d03f0d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -691,8 +691,16 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	/*
+	 * mc_bus allocates a private version of mc_dev
+	 * it is not appropriate to free the private version.
+	 * Which means we have to check the pointer before freeing it.
+	 * Do not remove this check.
+	 */
+	if (mc_bus)
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.18.1

