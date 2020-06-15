Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC60C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289A620739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqYVnyLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgFODi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFODiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:38:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236DEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:38:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k6so1273645pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HnHM3J+bDKwkRPdfs7jfYoRrpz30LWs87Ov1z3GBhfI=;
        b=nqYVnyLcncpBshp6K/Vh4ubGWmRgbjeBzNIWcgdqhvxVuCfSzUubHKnd1AeWrD6IwI
         NbLFVuDtT1gldAQxH8PTxYB0lVjscrK6dzdOohWawXEK6m1k+wAjV9NHoER0mO1YHeyd
         8vrughnfDJI/BRDULro0zcZkJOBR/6wGnktIbEY6QDVwJRjHMYcAlMfQveeaJcvfb2Bu
         gn1lTCYrMKd5GxS7OQL7ABQd+RD+AJDny4rh464bk4ZvYBLLHs5ajMLzEbbUmrkDBdxz
         0k/3EfBQ3KfJc6Q2uMViaJMaC9mRxYrsUSVrvewAVxZpj2VuNWJvVQIlznMoz6pGhraH
         TfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HnHM3J+bDKwkRPdfs7jfYoRrpz30LWs87Ov1z3GBhfI=;
        b=uKFfVw9iH0CS7fJ44RHE8NiCxr408LhmzOD3kV0JtSSc9pWLW+cqJloUjUUCn68F+E
         FV2VGer2/7vCUPJiIxrnf+KwLO/RGo/jXuyTC7hvxw4TBPi7odF7HsAdIckpYGYQ3XqC
         zxGQMAHIIOulbM9AynwLEMcMM0bj5gEeJIFogfmZJ6u1KAUyhj6biBWiIN7GNKFLRKjk
         O+8eYCM5v/ZqztP/LVqdJhOI0irvbe/xzEnBYpJZvqDYyWxSmRy9LNn2uUtYIxcZ8IyC
         Rerp5YTyxMzQRQDqxLt4UpXpieUIyv+CCUrpnuBXjMlmxgHkzeOmCAtrKekJeMiotRK2
         +iTw==
X-Gm-Message-State: AOAM531yKuAy1j03EnZ8tqWZkFx7sj5DdbRZICKNDjeThCh4Fn3c4VaW
        86G6XXlTriprJUVTvZoiIqLp2Em6vJf49Q==
X-Google-Smtp-Source: ABdhPJws8kio/IQYrgtW19iY6BHncEWZZ8efAcrBTbgKgXwVguHQzV64s8XBZ9WCIMB53r0SSS2giw==
X-Received: by 2002:a17:90a:c257:: with SMTP id d23mr10008520pjx.103.1592192333625;
        Sun, 14 Jun 2020 20:38:53 -0700 (PDT)
Received: from localhost.localdomain ([36.5.193.138])
        by smtp.gmail.com with ESMTPSA id o22sm7525194pfd.114.2020.06.14.20.38.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2020 20:38:53 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     =?UTF-8?q?Herbert=20Xu=C2=A0?= <herbert@gondor.apana.org.au>,
        =?UTF-8?q?=C2=A0Greg=20Kroah-Hartman=C2=A0?= 
        <gregkh@linuxfoundation.org>,
        =?UTF-8?q?=C2=A0Eric=20Biggers?= <ebiggers@kernel.org>,
        =?UTF-8?q?Jonathan=20Cameron=C2=A0?= <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?=C2=A0wangzhou1=C2=A0?= <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kbuild-all@lists.01.org, Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] crypto: hisilicon - fix strncpy warning with strscpy
Date:   Mon, 15 Jun 2020 11:38:37 +0800
Message-Id: <1592192317-10566-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
References: <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strscpy to fix the warning
warning: 'strncpy' specified bound 64 equals destination size

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
v2: Use strscpy instead of strlcpy since better truncation handling
    suggested by Herbert
    Rebase to 5.8-rc1

 drivers/crypto/hisilicon/qm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 9bb263cec6c3..8ac293afa8ab 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2179,8 +2179,12 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 		.flags = UACCE_DEV_SVA,
 		.ops = &uacce_qm_ops,
 	};
+	int ret;
 
-	strncpy(interface.name, pdev->driver->name, sizeof(interface.name));
+	ret = strscpy(interface.name, pdev->driver->name,
+		      sizeof(interface.name));
+	if (ret < 0)
+		return -ENAMETOOLONG;
 
 	uacce = uacce_alloc(&pdev->dev, &interface);
 	if (IS_ERR(uacce))
-- 
2.23.0

