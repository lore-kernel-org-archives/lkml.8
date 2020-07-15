Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0548C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6866206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJNtHxOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGOPGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgGOPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1164C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so6165550wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=GJNtHxOOPRZtWeTHohDWQFHqjfvGxwnNJdz6voIjChor1Ex7zIh4RYKL7WWFAzR67l
         f7K6Mns+x6QufGhR0YGwcwSB6Ksx1+20gB3D0ECOxU5kJQGoqjY8exCJTAt8dQkkp3es
         KBfkVws4SnYAGHAmAiNEENKUgAG1i+aKYJjtbRNcMGdddULPquE6SyXgXnJMWKLw3ESF
         qAiZll4KqluNRYd8wNJwHDavMEF6i/6Yw2Ywx+6HqNXeMzoIymgEW3MHNV0mpfIhR9qG
         qCXTeImq1wgSxS2sBsd/telggQixF4aMfmSfSnxUZK5dN1xRAf/sqplOCqD1E6kuaGjW
         hUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KGFwubHFzcLZa75OH2QfePfgNHp1yNFJ+5dMrYJqOBc=;
        b=t+MA4q7b1DWsJ7ToRiOs+iducpOImhTPsW5G3SE2evhr13jM6HAaG9CkONEWdQKfaE
         8/GwwZDDDRSXGYVJ+HrChlVDBfYhc0ZBilen4MtD3uku4zLE5tslZoDSMOxmRMJEgIfL
         u4ELGuT6fOT7TYotv71XIH+P37UWsaD/cNtI4rDsmrIL4l7LrZ/AdD2oSs3x2UgmTTh0
         /+D6r2ceN8n7RpoxfJBWrx2NsigE+3rt6+7CqBGJzS53ZvTP9HNN4Mpj5s7MdACG/x4n
         57/irCp5VKIGWy6rOBWV3LDpsCK7znzNMcRvFTWiSFN+77PEOhcr3ko88eN8QddM6tOA
         VIjA==
X-Gm-Message-State: AOAM531ZkGkUPbVSwNs8MVp2JmH8aTcU0Lnf1DhIHjqP47qcY1amUrMu
        9ODW7nSFP4zRK+jH44az8zPvjA==
X-Google-Smtp-Source: ABdhPJxcPdfqVlAgwpuDa0tcwDk1FMUSmp8ir4ZG/rOkWM0vMSIRi4JhoDhnJtEr1vPL8BvGTLjNhw==
X-Received: by 2002:a1c:e285:: with SMTP id z127mr9115336wmg.162.1594825596325;
        Wed, 15 Jul 2020 08:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:35 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Martin Sperl <kernel@martin.sperl.org>
Subject: [PATCH 01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
Date:   Wed, 15 Jul 2020 16:06:19 +0100
Message-Id: <20200715150632.409077-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc function parameter descriptions must be in '@.*: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'spi' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'test' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'tx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:897: warning: Function parameter or member 'rx' not described in 'spi_test_execute_msg'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'spi' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'test' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'tx' not described in 'spi_test_run_test'
 drivers/spi/spi-loopback-test.c:970: warning: Function parameter or member 'rx' not described in 'spi_test_run_test'

Cc: Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-loopback-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index b6d79cd156fb5..9522d1b5786d5 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -885,10 +885,10 @@ static int spi_test_run_iter(struct spi_device *spi,
 /**
  * spi_test_execute_msg - default implementation to run a test
  *
- * spi: @spi_device on which to run the @spi_message
- * test: the test to execute, which already contains @msg
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi: @spi_device on which to run the @spi_message
+ * @test: the test to execute, which already contains @msg
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: error code of spi_sync as well as basic error checking
  */
@@ -957,10 +957,10 @@ EXPORT_SYMBOL_GPL(spi_test_execute_msg);
  *                     including all the relevant iterations on:
  *                     length and buffer alignment
  *
- * spi:  the spi_device to send the messages to
- * test: the test which we need to execute
- * tx:   the tx buffer allocated for the test sequence
- * rx:   the rx buffer allocated for the test sequence
+ * @spi:  the spi_device to send the messages to
+ * @test: the test which we need to execute
+ * @tx:   the tx buffer allocated for the test sequence
+ * @rx:   the rx buffer allocated for the test sequence
  *
  * Returns: status code of spi_sync or other failures
  */
-- 
2.25.1

