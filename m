Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC60C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEDE24656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Y+tFDavK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgAOSmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:42:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38316 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgAOSmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so13533449lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQi5j8JTBadieNuHQvun4Nhn0WsX0zOu+KSCmRcocMw=;
        b=Y+tFDavKfTAIQRCwVG7AT4PnWn3bq7fYNdvvOKvqPTFpNm2lOs9VAT1Vimc+6fQC2D
         fuHE7xVNxUQoprzYyXWidkvQ/phOXCRPN0DNK4pv0+YgjIq/fhSnWVA+94Yj9E4PTW5H
         kccgQeoh15Zxceok+qU60qT6ap+MjVijPhhXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQi5j8JTBadieNuHQvun4Nhn0WsX0zOu+KSCmRcocMw=;
        b=HQk1iMmWqZKbFOc1CijOOJcxG0zb7ws1qHVAz243aj9AU3l/h8kc7j/e3jmkSVSVq3
         we/87VWEeoSBdo+WluDWg8Oru+3Cn3k253V+ZA1A3CrWYolGmpZI2VsVyuy/arEJOIeM
         h8b1ZKK42VxMqTv0sqC12I4xikb1T4FMCrp9PL5EITsX61G4I/LWVuEG3CKlSQivESB3
         gePXAqJoiLYtqWUbwEq35uareI8CvnaQsjkthYRUdOwPXeSpk5XvSohrTXgrkzYNb1Ux
         H4n9TuDwsI3XVsPRmzfb5lp68gR4ecuHM7C6G/v0w8meb4veOneFu77jtIScvy9/nTZJ
         bFyA==
X-Gm-Message-State: APjAAAVdI1RgTFSNinx4jAcLh10N/myrT3majdM1HpLLk1WSDUGJ3lKa
        w1hi4/WXVD+7TOxexQcHpLCg7g==
X-Google-Smtp-Source: APXvYqweLkN1XwDa2jiAARQMdlC2F+FWGmX481dMSXWAkGpjF9WpSY7JFOGxU+L+hgz30HWy9kjiWw==
X-Received: by 2002:a05:6512:15d:: with SMTP id m29mr155505lfo.51.1579113720789;
        Wed, 15 Jan 2020 10:42:00 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:42:00 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] devtmpfs: simplify initialization of mount_dev
Date:   Wed, 15 Jan 2020 19:41:51 +0100
Message-Id: <20200115184154.3492-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
References: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a bit of ifdeffery by using the IS_ENABLED() helper.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 963889331bb4..693390d9c545 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -30,11 +30,7 @@
 
 static struct task_struct *thread;
 
-#if defined CONFIG_DEVTMPFS_MOUNT
-static int mount_dev = 1;
-#else
-static int mount_dev;
-#endif
+static int mount_dev = IS_ENABLED(CONFIG_DEVTMPFS_MOUNT);
 
 static DEFINE_SPINLOCK(req_lock);
 
-- 
2.23.0

