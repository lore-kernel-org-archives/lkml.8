Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FF220723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BTy7Qzvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgEVWTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:19:06 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:47072 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731062AbgEVWTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:19:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49TLVw2FlYz9vYdY
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YxPhssXlttNJ for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 17:19:04 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49TLVw0Yshz9vYdT
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 17:19:04 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49TLVw0Yshz9vYdT
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49TLVw0Yshz9vYdT
Received: by mail-io1-f70.google.com with SMTP id w4so8310605iol.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xf86DUDR0KCytTZe0PoPEVKJWswyj76Qc8cwS/5pEd8=;
        b=BTy7Qzvia67Px1tEvWTi8X/NeNB6jPnEST1ETVo7uBwyZ8Wkew6opFNFU8mNZzW21R
         nNJWn2xhDpBNOD7j3Cqf8M9TKnEA2ESWSydG4JQQoGk92GLN4GiEptxM9qn653V3LfWm
         zR5YMeRMAhWXAYm6MITvDwZequAwm9QG2kyc1w82icjZ3Epz/qAhABqHLh9SCu83Nnht
         ky7cXtHlMl0IFuKy3ERdiQqKPI3GxOFe9PbIeujOsk/eetVdQFtkqjF1ZxhM5b0vv6QN
         cCwKam8UCdajHSyeHNTBnSIWQJzPsZVO4AMp6WGTvZ2GS+ykM4DahQlwnrzZHGVYr66w
         89MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xf86DUDR0KCytTZe0PoPEVKJWswyj76Qc8cwS/5pEd8=;
        b=pDI+0FF7lQchBi0vhZMF0Xw6JB5JCUjDo6Ll3r7gr+DKs3iF/CXT6d53eDql4/pi8b
         8MTzB3oJFp6V2YwbxEQj3WgJtIuksVjRjMycqIBDMx8MJ4EXHZhM1yAp3aw5H1u4cDtD
         tUz7M/PpdWkHVcjMXBGjYMFHadpEwrCU/NqDvdrEsjJAwBnnwxiEG0W4c5+IKIyFs/b7
         qhx74Hz4sUQHZfU1K9qqZSJDr5jRUcpfBI1Ng212WVsvZM8jvKmB0Rf4UEiqdzIr81SG
         LOQ28+buaAXqKcgFsPOg8xuP8LAyPx3C48eCYoGjvXfSSiSekfKxMcjLyFVEGk+NgSRV
         8UJA==
X-Gm-Message-State: AOAM533Aw5VUsViUdpQK9hr6F7/vz+VHDKIdEhTUE88fYieXpr1kaCkk
        rUX4cEosnzLzGRX/wJpmACRU0VFcCbeWlKoKjHunHGVQUyAXT6NQSwyuKdWbBmanAJhuf9DRbGW
        LqtzEHmlctRItFVJZhIVg+JnIKqYA
X-Received: by 2002:a92:c7a4:: with SMTP id f4mr15370411ilk.44.1590185943580;
        Fri, 22 May 2020 15:19:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+J0ruAKNhsdIwEN+ydT0VoCKGFWbQcj4ml3xYNL1KOfJyA/BR/ZbR8JROJoT/OQqoIenz1Q==
X-Received: by 2002:a92:c7a4:: with SMTP id f4mr15370380ilk.44.1590185943240;
        Fri, 22 May 2020 15:19:03 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id 7sm4210431ion.52.2020.05.22.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 15:19:02 -0700 (PDT)
From:   wu000273@umn.edu
To:     sylvester.nawrocki@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] media: s3c-camif: fix missing disable in tegra_adma_probe().
Date:   Fri, 22 May 2020 17:18:55 -0500
Message-Id: <20200522221855.7891-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

"pm_runtime_enable()" was not handled by "pm_runtime_disable()"
after a call of the function “pm_runtime_get_sync” failed.
Thus move the jump target “err_pm” before calling pm_runtime_disable().

Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/media/platform/s3c-camif/camif-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index c6fbcd7036d6..12ee49638f44 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -500,8 +500,8 @@ static int s3c_camif_probe(struct platform_device *pdev)
 	camif_unregister_media_entities(camif);
 err_alloc:
 	pm_runtime_put(dev);
-	pm_runtime_disable(dev);
 err_pm:
+	pm_runtime_disable(dev);
 	camif_clk_put(camif);
 err_clk:
 	s3c_camif_unregister_subdev(camif);
-- 
2.17.1

