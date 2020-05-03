Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D378C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47EA206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Qeo0JMru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgECSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 14:22:50 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:36758 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgECSWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 14:22:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49FZ950hcRz9vJrJ
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 18:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mIIAnGvec9_V for <linux-kernel@vger.kernel.org>;
        Sun,  3 May 2020 13:22:48 -0500 (CDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49FZ946l7Xz9vFHx
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 13:22:48 -0500 (CDT)
Received: by mail-qk1-f197.google.com with SMTP id j12so4242421qkl.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44UH4OZK/PHghykhYyE3yItp0PnnhS36mAT7ZC5+7gg=;
        b=Qeo0JMruk9M86TsRUveVEUvjTHwFL8pMp4RmUzoYKYQ2Anr583oI1WR1RqZ7BYoAxm
         2hXRMzXwvpX9uL39D2bCoHlLG9/Um5+eN1mqRw4kAfGxo8PoWRyCoeZNk+cRAH0RcKIi
         bo7v4sjlN8cL6Cj9/VkCcBnOB4GOGoYF0t/wPbIIidDA/SXd5YD68JsLY2GILMUJ+NOz
         2GxaIWy9ISuK3fQjqtWjEBXdya7NtqykbX7NdXP++M1kwmEFCT56iJ8Y9Bo0l4vhQPWG
         77uxQ1z6oDpgMuTJgMg2smnRUKED52KD05/6m+UYkT2rHNgiQrsQ05j152NRteQB6oz9
         kJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44UH4OZK/PHghykhYyE3yItp0PnnhS36mAT7ZC5+7gg=;
        b=tDe4SDO6tFXY0DFlvnCEHb/CCipQF/MeVpQ1d2D2W7AKvIHzOajMYSkKMcg6WYDH9A
         NtRFDpRc548JgwodCljC9tBSkrUSxX0VfMyEdf4ErJSdu6ojFrA1TCA3bFlIi41PDFFJ
         IizNxHylwlDd9snfn1GLE/zVaCOpT3Gu72kiBk0ltrNkU6Hrve9CGJft2TpdX11M9Hft
         74QF5aTsbKthFT34OutpO+w/LgTjmfti/C4tNRRzBL35k6lLv4wMNoxYdv+qO4MexxVm
         bye28D8f26534nJsSsXtEuTAadYSZPaTQxIGqT/2gzlBQLEw6EVEQM0/EIOsxIrT6CVy
         itNQ==
X-Gm-Message-State: AGi0PubOdzCfRIzhDCpkK03InMgY1JclZ3gKVc7gXzoP8jd9A6cY8ZE4
        7nBGI4bEiQQpzyf9FQuqjQri54E8wcb1fJ52xnkSc8IRiyoQrEovhTpADIUqsGHQWYQFVpgTvTK
        /yp0RzdLWWEm/miCFplNXfjoIiqAs
X-Received: by 2002:ac8:6751:: with SMTP id n17mr14156530qtp.16.1588530168303;
        Sun, 03 May 2020 11:22:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJRLv5dHefXW50lpSlndW5FvoT6o8IaByWKvbRXvRFcNjtZRAACEV+oYHlKNP1xZa75T4OBoA==
X-Received: by 2002:ac8:6751:: with SMTP id n17mr14156503qtp.16.1588530167813;
        Sun, 03 May 2020 11:22:47 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id c6sm7791877qka.58.2020.05.03.11.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 11:22:47 -0700 (PDT)
From:   wu000273@umn.edu
To:     a.zummo@towertech.it
Cc:     alexandre.belloni@bootlin.com, Markus.Elfring@web.de,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH v2] rtc: mc13xxx: fix a double-unlock issue
Date:   Sun,  3 May 2020 13:22:35 -0500
Message-Id: <20200503182235.1652-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function mc13xxx_rtc_probe, the mc13xxx_unlock() is called
before rtc_register_device(). But in the error path of
rtc_register_device(), the mc13xxx_unlock() is called again,
which causes a double-unlock problem. Thus add a call of the
function “mc13xxx_lock” in an if branch for the completion
of the exception handling.

Fixes: e4ae7023e182a ("rtc: mc13xxx: set range")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/rtc/rtc-mc13xxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc13xxx.c b/drivers/rtc/rtc-mc13xxx.c
index afce2c0b4bd6..d6802e6191cb 100644
--- a/drivers/rtc/rtc-mc13xxx.c
+++ b/drivers/rtc/rtc-mc13xxx.c
@@ -308,8 +308,10 @@ static int __init mc13xxx_rtc_probe(struct platform_device *pdev)
 	mc13xxx_unlock(mc13xxx);
 
 	ret = rtc_register_device(priv->rtc);
-	if (ret)
+	if (ret) {
+		mc13xxx_lock(mc13xxx);
 		goto err_irq_request;
+	}
 
 	return 0;
 
-- 
2.17.1

