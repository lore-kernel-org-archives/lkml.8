Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7239CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC6B2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChFks/XE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbgFYTRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406523AbgFYTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BADFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so6637139wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+r7WAzJKscpz2A7LfanwlEQFW/6BOounTqgY0FCqgHk=;
        b=ChFks/XEc7bzV0CTcMWfhB7IgCRQxU/ix22NfRn6vDTUiSMVowVLaUl6yu7QMlcVVZ
         HIpJw4xTHVybS62gdWM1VHFFBSK0dTQm5ovklGSePPlvX4kAkJhIkf4FubT+ZkZ9yhij
         CTVZrQko7ww3J9imShFnpURQHqUoLNB/YAfvXak+Efsy+I07bcLsAD++oVv9gQA5rUe/
         1Nm5+BIUSvod+52HYDbqpSQKJogjRpztt5k8ZN6oHSxjr2MOUuZLeddwge1f5DpitMgp
         toasWrca/RulM3TnAxEnjBxB38zyKS1zf5HDbx2hn5aZZWbfKiCM/W50ed83S/NIjsYg
         8+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+r7WAzJKscpz2A7LfanwlEQFW/6BOounTqgY0FCqgHk=;
        b=cfcx5urKHm7d+cWPme6ehwnEDpgBwS8x5LN8ofC6Wj2B6R1Utx8Lx0A/a7y0jfTb3x
         gcdRHDAuwO0ZYv1bI4RY1AKF9Jb2o9jO+Kh9LTWHr+R+B0HzOtlWwSkJCo1YITn6wQr1
         N4+bLkMmlPk7kQT8AB4xgDolZN2CM7Qm6McNFDskgZRLSqBWV8Gjk/n+hI6Oepqsz573
         DZRBNjhQBoKX3BarrvkVB2yB1DyyHQvtIHizXAaeeUJqwu8MxQMiTZ5ibS7yBKcsS0rz
         AD4XkQUUSWhU3mJHp8Eb0D6ZjOnS/4mAP7g9WD1cE/LeKma4DkfyN7Ua1Hvg19TVg54C
         Lusw==
X-Gm-Message-State: AOAM531E3uO2dMB4JwObQT/RuZLj34B9S99MaTzSuqg+QRuhua2DQ0u2
        cNimHuIjLE1+GFhWXSiyPPc9EeOVDu8XvQ==
X-Google-Smtp-Source: ABdhPJxocm800/ZlJ2PBjWP1tsP9WN64x1zPnFXiyjxHxw49nomSN71rB9+UScUF2TFK7UoUqEPKzw==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr5484694wmj.54.1593112638103;
        Thu, 25 Jun 2020 12:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND 04/10] regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
Date:   Thu, 25 Jun 2020 20:17:02 +0100
Message-Id: <20200625191708.4014533-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't any code present within the current kernel to
override this 'weak' function.  Besides returning '0', which
is never checked anyway, the whole function appears to be
superfluous.

Consequently fixes W=1 warning:

 drivers/regulator/dbx500-prcmu.c:113:27: warning: no previous prototype for ‘dbx500_regulator_testcase’ [-Wmissing-prototypes]
 113 | int __attribute__((weak)) dbx500_regulator_testcase(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/dbx500-prcmu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index f604c8db6d0e9..c3ad6aa6b5d37 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -110,13 +110,6 @@ static int ux500_regulator_status_show(struct seq_file *s, void *p)
 }
 DEFINE_SHOW_ATTRIBUTE(ux500_regulator_status);
 
-int __attribute__((weak)) dbx500_regulator_testcase(
-	struct dbx500_regulator_info *regulator_info,
-	int num_regulators)
-{
-	return 0;
-}
-
 int
 ux500_regulator_debug_init(struct platform_device *pdev,
 	struct dbx500_regulator_info *regulator_info,
@@ -152,7 +145,6 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 	if (!rdebug.state_after_suspend)
 		goto exit_free;
 
-	dbx500_regulator_testcase(regulator_info, num_regulators);
 	return 0;
 
 exit_free:
-- 
2.25.1

