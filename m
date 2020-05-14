Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E7AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6414820727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5Py7dZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgENS7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728607AbgENS7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:59:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93398C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:59:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so12951746pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Udc+Jc9NUEP6E7cY+ReeRSJCDBsUse9YWoji+YKh8tc=;
        b=C5Py7dZrCpwP1j5EaOkkkAbsqKg3U/CQuIlFebASGJoVCo0ixxe5EdT8RS1Qi6b+nr
         MiU5CVV9F34Bc5Mpg8VmCiANAEggwr/L4RrlgKzVwBBzRCO57MF+8iZLLuMkTRheBp51
         SUCrAlebMCotD9JETyxuLzqzJ67xa89EuE0NZNBgbtu7veUzGxdHfLjNlfHsQliOuIxO
         375MPefTLjP+BPLhwrQfmmzx6tBaIPhZcMLz41Vg44bufVmJAKlAQaJnsOrbhyddVU0x
         oeNzIBBIlb1Kq8los1f2nw9yq/zREuc5LBXMlthaF8AvxOXs79NSCBJzLaGNRmWR57ZR
         FdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Udc+Jc9NUEP6E7cY+ReeRSJCDBsUse9YWoji+YKh8tc=;
        b=dKrQHrGgnLVXkEf9JTctdqfb4omEJvGdMlmznAh4VsDnUhF2LGOk7s378PkpShmQHx
         mK2azGR6TVbUvLh8K+IflYuBX6SdMX2XjAvDr3Y2xY1/W5AIRrxyFJhZ7jLMsdbwlXge
         B8qEG+911VmjqeL3CSxI+A5GdS1yHYd3nAJbmE2uCxlxloVUMLmBhrU1VpveJc0ZlCQK
         1fUDZZG7uPyhrwtxN2MNt25Ci4gT2BrC4CZvqsl37KzeN/rZ5P+VxVWUH4mIFheHmiRW
         QQcUjuQon/Gvde2JqztYmNAABZNg3siW5eHTOKE9JYA5n1uFDl8rAkHB6WdL6JPhHlQj
         dawQ==
X-Gm-Message-State: AOAM5310qS1TbdQbYziGwhaXulRTzC/8VkCGfzHEi6wSSOgG8H+dKbq/
        U5wJpSeaqdj8d4oUzqeNJBDXSg==
X-Google-Smtp-Source: ABdhPJyjEyU0z0Z1QDDvXc+BFps8nttKBctW7RJqvPKSuCP47oksGkwPHVQJ8xZUbhxSHY8OMtKj1w==
X-Received: by 2002:a17:902:6b01:: with SMTP id o1mr2199plk.64.1589482784953;
        Thu, 14 May 2020 11:59:44 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id fh18sm38563994pjb.0.2020.05.14.11.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:59:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] remoteproc: wcss: Fix arguments passed to qcom_add_glink_subdev()
Date:   Thu, 14 May 2020 11:58:56 -0700
Message-Id: <20200514185856.1598945-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <202005150242.0AdaUqnG%lkp@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently qcom_add_glink_subdev() was extended to also take the glink_ssr
identifier as an argument and I missed this while applying '8a226e2c71bb
("remoteproc: wcss: add support for rpmsg communication")'.

Fixes: 8a226e2c71bb ("remoteproc: wcss: add support for rpmsg communication")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_wcss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index 48d16d81f94d..88c76b9417fa 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -560,7 +560,7 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	qcom_add_glink_subdev(rproc, &wcss->glink_subdev);
+	qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
 	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
 
 	ret = rproc_add(rproc);
-- 
2.26.2

