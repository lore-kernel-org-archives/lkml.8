Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB097C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FD2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KL1/NkKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgEHS1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727801AbgEHS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:27:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D2C05BD0A
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:27:35 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f7so1368104pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hN4aOQqQDUCJtoOHCvHdyqo0T+RL3xFpmONUoLpf4BA=;
        b=KL1/NkKRX1oUYO7Z1N00JVKw1P+8x2REeQYN7Q7fhRrD1t6Et+WJx2YsK4Hf/RC4jM
         7cduWWHx/DE4Swjex9x6osHhBCcNe9ec5q2LlkSr1CYh7E6rEDEEConjcTuPOoel7pN4
         BRJXAiM8DzL0QvF3qO5gNLuIKJ4J1g8/h+VuXoT4tVFZ0hqnLlO4i4g5HC3ikNibtTf1
         YhKzedBK7IaqTcL+GFpnhi0hTRDCoZqA5fkQsHu6SH0Ae+swncOm9g3E8RG95OsLmu1E
         yx6RQGSkK/ZVi3zAnpfwgB6y/Rdx38cN+FxMCv3uAzoQIYyOtwiTp3sFpq+/9tOerkLJ
         qgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hN4aOQqQDUCJtoOHCvHdyqo0T+RL3xFpmONUoLpf4BA=;
        b=rF/aOdwnrIFjA9FM6ndl0oEwGh8yO8Te6DByrmzjlakXmwKaGGbfBn6JU0UnXK7Dif
         ZGPkv61JAsTqpN+cMXDZiVNyqvJNQkeNMZiVlWEHDrEkGor+3RUPzTClDtXtcb6xRrKW
         86o8escuDmIIX7n0cvHn1WEUeYYWhWyTQ2Gt6glMp4GHkoAKt4ba56hvuuy4wCMtByuu
         MPeoKYN9FW7SDg98On8B2DuCVnvNuPJQEw9RI7ZjjV4Ejul23sDJerwnrGVGiU4iKWrz
         evFTCP6hkRsvARJfvAoVFj8kOhNKWMVmmNuBPI0AuJx9ntw4QIS6qq1Xlg+IdGgJEGhu
         SQgA==
X-Gm-Message-State: AGi0PuZ4x/qiKdKIV/4+zHly40wL65x24ZUXGO1yeyyZtHjli9TmlSb/
        tZYb6w7Ac05xRe6bhfeNaZ1I
X-Google-Smtp-Source: APiQypJVcjKVXAtc+RhgX8h8rDloj7wN3GTygiGNJPq9kGosRQivY72uQWPhjT9ky30hWj1dOyflFA==
X-Received: by 2002:a63:ef4e:: with SMTP id c14mr3094540pgk.84.1588962454832;
        Fri, 08 May 2020 11:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:9e:e39a:a052:f8c0:a37b:3255])
        by smtp.gmail.com with ESMTPSA id y24sm2248379pfn.211.2020.05.08.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:27:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for Qualcomm IPCC driver
Date:   Fri,  8 May 2020 23:57:03 +0530
Message-Id: <20200508182703.29021-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508182703.29021-1-manivannan.sadhasivam@linaro.org>
References: <20200508182703.29021-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Qualcomm IPCC driver and its binding.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..cc2fb991cc0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14013,6 +14013,14 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/qcom_iommu.c
 
+QUALCOMM IPCC MAILBOX DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+F:	drivers/mailbox/qcom-ipcc.c
+F:	include/dt-bindings/mailbox/qcom-ipcc.h
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 M:	Sean Tranchetti <stranche@codeaurora.org>
-- 
2.17.1

