Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4444CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE3920792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 23:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Edt0rD6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFMXEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:04:42 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60984 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMXEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 19:04:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49ktTM6Slgz9vYTt
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4bVuNY2uwFug for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 18:04:39 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49ktTM4qprz9vYTh
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:04:39 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49ktTM4qprz9vYTh
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49ktTM4qprz9vYTh
Received: by mail-io1-f70.google.com with SMTP id w2so8769513iom.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vdWthCsmOsBiHMJwiA3g9GCqF/ZUI6PIYJxkxVMjZH8=;
        b=Edt0rD6Yt02A/FMLC1/3iWyMUZULyWs4zPYMO1nwpQz4AKx88deJY9VPwnjFkVAIdw
         kkJpM78kvFvwUyN/G2xmEetRViIQBSUtLQJ8MHV1tC+Umei/gQp/YNM4dbJh1pAxcaaN
         HXNwOSXVM8SoJCS2nQu/dASQ3p+DkWsDn2QNHiAUC5gSg6jnBzpW0VArxHYrmJYTaorT
         +IwYA72fIoDNfYYIpRDk5u9lNKHHzH2O8KIqXDrvbs44FvNMKvDvJyGPQm8hctAbdh5X
         GCvjJP0O2st2YGsdaioTAJqjXlRtU/4b43v7VNdDE74YbKuh2AtuxzdP7V67C546UweH
         V1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vdWthCsmOsBiHMJwiA3g9GCqF/ZUI6PIYJxkxVMjZH8=;
        b=GMaECZdQ8eoayPrjhpk/z92kipMiDivxLqqk1dWYakSOcjHkrx9vy9M2HdvB20EHoF
         i9SgA6ZZyFdsWjsFsicO/18/2QlfekqOQDMgER/FdQmQ128kKDSkVnepN+Zskrs0n3mE
         7UmdqZjYGx1CnMERdlfJYDQ//jBB1P6JcFr7NxUzfGTMK/BuZyNcYxHNkhBl/tq8mPw1
         gXvllrEjZmmGGz2Hk+aTXxpaSnZsI3Bn/9WQSdMwFM+Dg0UMoGgaZpQcgqE2jeH9OAL9
         uBjo2ohNuflXM2qzyLv3e17IT4vCHtZ4y6q2CxNCBDeruNmn9F5zHXHAx0dHdZvkUFae
         e48A==
X-Gm-Message-State: AOAM530ZlPW0H+FS9Z9trR++HjBxqF0tDBb3yiOenRYIEiS8mV8/vC05
        2duxVtou9CGO7xUA5vKHzpJJf2rXM9J5FWVNr0p0cMiEuph1k+Ea2LL4wOgyXTDXR9t5AqzpaYH
        oWe/ynOUiWU/uZ0sltR9k+uw2hmXn
X-Received: by 2002:a92:b699:: with SMTP id m25mr14652659ill.208.1592089479229;
        Sat, 13 Jun 2020 16:04:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2Amm5x/e+7fkof5wamzDW0mUfhmnXCG35Wi4I575sv2CQNQ8SYgfivVcBHqk1UbbABGletA==
X-Received: by 2002:a92:b699:: with SMTP id m25mr14652640ill.208.1592089478980;
        Sat, 13 Jun 2020 16:04:38 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id m90sm5546517ilb.79.2020.06.13.16.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 16:04:38 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: rcar-vin: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 18:04:32 -0500
Message-Id: <20200613230432.13025-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code. Thus call pm_runtime_put_noidle()
if pm_runtime_get_sync() fails.

Fixes: 2a18fbec1dab ("media: rcar-vin: Move pm_runtime_{get,put} out of helpers")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index f421e2584875..06808be35f98 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -835,8 +835,10 @@ static int rvin_open(struct file *file)
 	int ret;
 
 	ret = pm_runtime_get_sync(vin->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(vin->dev);
 		return ret;
+	}
 
 	ret = mutex_lock_interruptible(&vin->lock);
 	if (ret)
-- 
2.17.1

