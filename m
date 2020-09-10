Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEA320829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Hg5YB683"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgIJVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgIJNGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:06:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31887C0617A5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so6622787wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwhhTmIpt9I/D9KrOo2LJ6gPM74tL0wwMib4UYGiVq4=;
        b=Hg5YB683SBcxwBOJuYWAbPVzcbtuI8GTdFc7yNFZkPuGlTOospMoDqTJVh5eyvbHRy
         Lybj7DyI8+K7Gj4Lhk3d5DZUUX1omx6RWWhTFNmdmVJF9M2kdDIy2HrjJHIRoAVuIqYI
         aAsQ4O5g5g4p5Bq9AlB5o80bKRwJX0q/PoLtGW2myp1DbkBjM3pJVR8AjFsqRs0Yzc9P
         t19ntKuWvjd7+1BVfF3FhLHF6JAW3CaxzY6hDQ+zuQWVnU/cZWgmqcubK8dtrDytUqEs
         DSZ5atmiFFgcIw+YPM+v9lSNC1j7IFgjRGLIQv+74i1lAOA3WvLUmXCWbQhFobQcl79m
         KFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwhhTmIpt9I/D9KrOo2LJ6gPM74tL0wwMib4UYGiVq4=;
        b=UxZ0nTpXuuvgmQ35H84Co4qvdV2evndWsC81iExF7Py5aLBlAKSInY6PRQLBfFYtb0
         1szfnhzanBhV7x1k0U1pE15DThyJZw6MlqvZy08Tbv3xulzX+ceOzxpBSu8vbVp/W8Hd
         9dLSbt93JJc6sT6zb1dc6TY/CGiIphgoTfSya/bN3zonhni3kRCcLZpcb42zXlsnck2F
         q9sLtbBrYaBcRu/zTTDL0+vUw31FONGKg63QIZkZIbjvZTjHPVTOkXOV8kXu3r5I3HMN
         +czX/SXH56ge19Xb0VgVNhPhEjimh530xlaUwcGknklkSx+Q7KVdpVjV5csk1zmQd9GK
         /iSw==
X-Gm-Message-State: AOAM533cCgoQl+jq1E1NhZzFo9XQq0MlIXn2CuWq5hU6WQOYcKihb841
        4JJ+uYwHRlVsUhUaebcqmnVU3A==
X-Google-Smtp-Source: ABdhPJzcvEpeSQuLyTVjL7Lr8uyfJn1qlbCPNliUserEbRmtMZTR1dNxSRyJtap07RsrxrZOGLBAwg==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr8910094wra.368.1599743107847;
        Thu, 10 Sep 2020 06:05:07 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 09/11] rtc: rx8010: switch to using the preferred RTC API
Date:   Thu, 10 Sep 2020 15:04:44 +0200
Message-Id: <20200910130446.5689-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200910130446.5689-1-brgl@bgdev.pl>
References: <20200910130446.5689-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use devm_rtc_allocate_device() + rtc_register_device() instead of the
deprecated devm_rtc_device_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 0665878e8843..bb6578aad972 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -447,16 +447,21 @@ static int rx8010_probe(struct i2c_client *client,
 		}
 	}
 
-	rx8010->rtc = devm_rtc_device_register(dev, client->name,
-		&rx8010_rtc_ops, THIS_MODULE);
-
+	rx8010->rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(rx8010->rtc)) {
-		dev_err(dev, "unable to register the class device\n");
+		dev_err(dev, "unable to allocate rtc device\n");
 		return PTR_ERR(rx8010->rtc);
 	}
 
+	rx8010->rtc->ops = &rx8010_rtc_ops;
 	rx8010->rtc->max_user_freq = 1;
 
+	err = rtc_register_device(rx8010->rtc);
+	if (err) {
+		dev_err(dev, "unable to register the class device\n");
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.26.1

