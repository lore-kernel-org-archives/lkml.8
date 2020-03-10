Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137BEC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E123E215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVCO8OjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCJPoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:44:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45050 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgCJPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:44:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so3091485pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIsaWOEHxjug8g0g5/0Qzw0eVOmGpg/y1+33ZgTLwjA=;
        b=MVCO8OjA2rtv741bXG1qlXebeKR27QDNKzfmeVtPyXZ3TPZxs8YcC5fXvblTfIBMhr
         8Rmptzy+mmCMqHvur+VwzSbINSqmoQg5cSrlz2uK4tkvimd6+BhsZRQ8khU2SK+nSW9s
         mnPgJn1YJhmaDx1WkFIvZfZZXjaywRPuIjCTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIsaWOEHxjug8g0g5/0Qzw0eVOmGpg/y1+33ZgTLwjA=;
        b=M3S8oPxLlB2NWoO6T0gBuWyb05f+OAHVhp4GeRLwmGNECHTCW0WuCGTPwm6JLabuGx
         eo5Grb85bAb619H9A3ssl5VWglS33MVGgtgHw8rpG4pLEMP3pyihKQi9gbIKKdtCtDoR
         lGcy38TTJrqK2pCmx11oMVQPqFBAiJNl9krKUiA7LETpNCJNOZzWIV6G9KLZl42YK3JL
         duYvFW7qwuF9daS9eusUPmUTp65sGerS+Dd3YFMhsAZ6S2sjoUG2TNO17RE6vZ5I9lEL
         ZvzPx1GKPjUoub6zQ3CEeQEaHN3xlNjNiHKgbqVlOU88D6NI09xOmr616L5zWQpsX4Fs
         /WVQ==
X-Gm-Message-State: ANhLgQ1Y4HSLmgs/xaOetBFFR1cyh2IWxTJIuhaVaMo00x5QzIv7j2c+
        KG1fHVPfSU4wcUHgHOYfwq0fkA==
X-Google-Smtp-Source: ADFU+vuQQtHPpdmf0a5BQtG857BP7ac/ZYqv494NvarEUDhctHRIIQgLBGaNCs3sMduSmQusLdJrHQ==
X-Received: by 2002:a62:e808:: with SMTP id c8mr23178666pfi.111.1583855043409;
        Tue, 10 Mar 2020 08:44:03 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m12sm2731090pjk.20.2020.03.10.08.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:44:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 3/3] i2c: qcom-geni: Drop of_platform.h include
Date:   Tue, 10 Mar 2020 08:43:58 -0700
Message-Id: <20200310154358.39367-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200310154358.39367-1-swboyd@chromium.org>
References: <20200310154358.39367-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver doesn't call any DT platform functions like of_platform_*().
Remove the include as it isn't used.

Cc: Alok Chauhan <alokc@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 2f5fb2e83f95..18d1e4fd4cf3 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -10,7 +10,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
Sent by a computer, using git, on the internet

