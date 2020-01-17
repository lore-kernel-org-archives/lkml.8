Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1824C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A1214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2avq/Wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAQJ7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:59:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAQJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:58:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so6810413wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qs32CPE+6w8H62hd9kXr/ee/9U4Omu1sZciOmm+hYl8=;
        b=F2avq/WjQTkOblM6OBaohDkNkFC/G/rzHjdCB9gkWGztwFXHHLMQAEUFo437ob2btR
         kbj0Oj3lHdUxPFsEo+CaW1ACvtXvJl2EkqR0VpSmKR0sRe/ImmNVEUpVre4OnXYM99Dq
         magfKT++abV11SaIJD+AYaG245Qw5xjCzho73AwemJ9Fahz3jpPy1PcHaCWITjNYxMn5
         vWs0O9wGbzSCm5biNcq5AlR9vyIynXA5ZO3E9m6H7IsTKX2WSuZtXITmJc4HII84tm+5
         GsHAuhK07k1QXb6MwT9SEEr3kBzbO7JEZYuzojx2szjPkmbzNcGWHuprwGaqWFLbrJW4
         CbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qs32CPE+6w8H62hd9kXr/ee/9U4Omu1sZciOmm+hYl8=;
        b=OyVx3kvslmLTbpZmTRwH2FOM5uLlpPsQMkeldZbE276g79tPX3V37ZBH7a4sTDGzsU
         cj8kHDGd8I2LBqBxm6tSMnSoWDcqdh/CduojowmrVwn9EqiB3DNPvr07ZpjjQ8e6IpQ+
         Ltu4q01D76Xj8LACXqYlxygzt6rkGB9KI3dsAEZCcwj5g8Vp6yBwAOWw4lTRtQF/V34z
         WtdqaXjUY+INSsfHA5cnvsPKpEgv0Ax5E8V20DQ86hwvj6URtX5FR1jkl4MlImo38une
         8+RnBTnSHgyQlhSn99Mm5wOXFpD1XCH1mT3J/VM/yDnTyqKyjB8AuEpjjVM7Zygw88aZ
         lagQ==
X-Gm-Message-State: APjAAAXnR+BSL2piZaa9tSAuzyr+ylJb/88but0eGUd2xnri6h5QYh5T
        yyrdH0TFxv6Y8WuPQGcfv7oPKw==
X-Google-Smtp-Source: APXvYqyd8UlYY4DGVzaOxKU/U/u//HxKkMgytc4CTZO/eE/zbcYiEzSU/sWZAbV5hhhv1BsLkwtrVA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr3880069wmg.154.1579255111881;
        Fri, 17 Jan 2020 01:58:31 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:31 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 10/12] interconnect: Check for valid path in icc_set_bw()
Date:   Fri, 17 Jan 2020 11:58:14 +0200
Message-Id: <20200117095816.23575-11-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.

Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 10dde5df9251..f277e467156f 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	size_t i;
 	int ret;
 
-	if (!path || !path->num_nodes)
+	if (!path)
 		return 0;
 
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
