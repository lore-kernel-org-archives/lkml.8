Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BCC2D0E8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9A4206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEmiAiE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1Iwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:52:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgC1Iww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id z5so14086918wml.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nnCKRfRYRVtQ8LCYwwqPwbfqWqGkXGfrBnpMFb83p/0=;
        b=AEmiAiE+gXoOFUd/+f6z1lJgmklaBWp7mSYZAcf1oHaH6nIpLr5uPH7Dt/K2nnofWP
         NQrD1gBuhHQ3WgJOThcjfwEF2kxSprkzKybcUgayXPlkQDON9XZxPGuUMvxonWLGHSEl
         uMQKocKbTVKATxN4vQiISNPnGc6o69lB2x/Mgqk4z05RdtTfI2LPZG6o7jENB7o0J0Nz
         gtlCHywyRdjHAHkj8Z7h2wHFPlK9iBNRRuu383YEYkoAiVSGObtcbsQGQQVcN7nou+SC
         Djl8wcoIxgGz6sYMDdaaDeGZsCdABLjIIte4UMbOewFh92xn8mrBuiyB7EB5/Zc6hURB
         yAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nnCKRfRYRVtQ8LCYwwqPwbfqWqGkXGfrBnpMFb83p/0=;
        b=QS4BrnTCOk+GqgwdYiPJ+YgTNRMyIOLMwlAvGuXv7kl4S2bhOCYCq4Hrp1KK9X2UHu
         m7greuzoNDQsmwBKLfRB8o5hexpgSH6bejzSr4zMavg48bNVndi5VA1L2tTZN0Fhqz47
         LjM+eNPYVWMbPhM2Nzgi5napP+kSLeXW7Q+AxVe9495D22iG5kk/Lb4D5OOPW5vFkssc
         VjjkJWhkGl1a3T/fmSsfJDMbr8pkUpF7lUAPg9tStEcPj6ZpXX8wjgFlUGLv8Qp6/y3L
         ON4sPgH8PHCHERDV1flF3UQb5h/1PPai7vam04pepwXFsaVhDOCEa3gHlF3sRH9S5qqb
         OZsA==
X-Gm-Message-State: ANhLgQ1+fbvlh3DTKp+29yVQdXVFK+LLHjDFXsIXE9FkqiGeIJunp/K6
        ZdfeYkx3UG/rWh+uK0YH8xotyGYj
X-Google-Smtp-Source: ADFU+vsbB6gteDp8LJES5mWWiU5xeHdLsz4mEPPsFTp6xlGpsPdnRRrVa9fJ81N2I4dBFcP0ruXFSA==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr2986988wmm.117.1585385570019;
        Sat, 28 Mar 2020 01:52:50 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:49 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5/6] habanalabs: print warning when reset is requested
Date:   Sat, 28 Mar 2020 11:52:37 +0300
Message-Id: <20200328085238.3428-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system administrator asks the driver to soft or hard reset the
device through sysfs, the driver should display a warning in the kernel log
to explain why it suddenly resets the device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 4cd622b017b9..e478a191e5f5 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -183,6 +183,8 @@ static ssize_t soft_reset_store(struct device *dev,
 		goto out;
 	}
 
+	dev_warn(hdev->dev, "Soft-Reset requested through sysfs\n");
+
 	hl_device_reset(hdev, false, false);
 
 out:
@@ -204,6 +206,8 @@ static ssize_t hard_reset_store(struct device *dev,
 		goto out;
 	}
 
+	dev_warn(hdev->dev, "Hard-Reset requested through sysfs\n");
+
 	hl_device_reset(hdev, true, false);
 
 out:
-- 
2.17.1

