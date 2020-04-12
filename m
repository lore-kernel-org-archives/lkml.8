Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C1EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9598E206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIouA633"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9598E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgDLRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgDLRkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:40:07 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E21C0A3BF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:33:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m8so6699911lji.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqXdwaROdeqIddDJWAnUAB3A8A8bFJlYtL6MGb2s/vw=;
        b=uIouA633MGmMPi38mufwLK2Pn6s3EErihVLplll0QAPlxnIPv19I+PUjrJlhOYCf6R
         IzKKGWasvrHhPYFn6tMNt9qyL5RLjHDfMstd76qsGvVYjapANY1gSM7crTCkTxPgsZNN
         wKGLiMU9FOnVDy7nFcq2cumSDj5DSeNyKFRu5qkV9N+KSQMMrDJZ2weAQ+5CDb1ucbd3
         f/buDeZ/Z7hDIUrY6MYm08fimVD/HL6iqGZ17szK+RvB77aLd9uxT/1si79RFGkYbwxD
         mLMYoY4UZaIJ6rGd/8gkWtTlrWzI/yPngkY93rP0CLvB51eXvWVVoeoZE3e0OhlaL0XC
         581Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XqXdwaROdeqIddDJWAnUAB3A8A8bFJlYtL6MGb2s/vw=;
        b=HnMpNA/MVCBH3ZrYxW0+qhYghbdNcPuie95ax7qcr81ftcruqhcvhuvUUSWFIw/jdU
         bByhdlDB24ZEJDx7yEhfC0Y4zWzixqLGUaiUzlWySnEqgE99CThsxRlM0BFCdNuws01P
         RnLxL39Gks7xYJJ+DR+3V9BaFe0/H5jE5A8W3YLlYMKo4rF0CMXjlmRK5TG1KAQmq1zg
         oMRCnExLaBgm9xBudj+DKrbOTyW9oWwPtWPCNgu3Smm+aCe3eTvf8pQDaPaNoDS+ub9N
         UvT2DdNWPcFBFBV4klwV6Ptk8d3bo28ZsnF7qvzT11jA6PkMJWYUdFQFsknLVDQOJAo7
         O55A==
X-Gm-Message-State: AGi0Puavhzwrh/c3LtEMUP9UXAfRq2guTwG4vzcS8E/VYK/t2nSf69Sf
        GgMaDFuoV5E7aQ+BGlkd+VTMI97Q
X-Google-Smtp-Source: APiQypI9i+kHBSgJNXgLJCPoXSzarIOiFOq66nx7OTBTs/XFeyH1KhYc/UWCESTnmbo/ojDHBdLQrg==
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr8343800lji.110.1586712783851;
        Sun, 12 Apr 2020 10:33:03 -0700 (PDT)
Received: from alpha (84.188.smarthome.spb.ru. [80.249.188.84])
        by smtp.gmail.com with ESMTPSA id 28sm6398249lfr.7.2020.04.12.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 10:33:03 -0700 (PDT)
Received: (nullmailer pid 846531 invoked by uid 1000);
        Sun, 12 Apr 2020 17:37:37 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: replace rtw_malloc/copy_from_user sequence with memdup_user
Date:   Sun, 12 Apr 2020 20:37:16 +0300
Message-Id: <20200412173716.846469-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memdup_user is shorter and expressively.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 22 +++++--------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 0aff01bb69c3..d5968ef9f43d 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -2012,14 +2012,9 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 	if (!p->pointer || p->length != sizeof(struct ieee_param))
 		return -EINVAL;
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
-	if (!param)
-		return -ENOMEM;
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		return -EFAULT;
-	}
+	param = memdup_user(p->pointer, p->length);
+	if (IS_ERR(param))
+		return PTR_ERR(param);
 
 	switch (param->cmd) {
 	case IEEE_CMD_SET_WPA_PARAM:
@@ -2789,14 +2784,9 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	if (!p->pointer || p->length != sizeof(struct ieee_param))
 		return -EINVAL;
 
-	param = (struct ieee_param *)rtw_malloc(p->length);
-	if (!param)
-		return -ENOMEM;
-
-	if (copy_from_user(param, p->pointer, p->length)) {
-		kfree(param);
-		return -EFAULT;
-	}
+	param = memdup_user(p->pointer, p->length);
+	if (IS_ERR(param))
+		return PTR_ERR(param);
 
 	switch (param->cmd) {
 	case RTL871X_HOSTAPD_FLUSH:
-- 
2.24.1

