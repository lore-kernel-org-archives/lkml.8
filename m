Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC44C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572D5207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCmUEtT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbgFYGqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390110AbgFYGq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259EBC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so2129727wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7/cDxvGdffp0R1d8Bbrv1z7a+JwOkzEK0KwjgT2NxE=;
        b=BCmUEtT5UTfVuC8CblpswRBGT7MKphCIGdncmeha98yeFZF1RxkE4l+xGv/tGqHYum
         OA7y8Haiw+RQimK4Bda7ht6soHr43nbRuSKpQJKow84aunLep803VCuEqWLD4Pw5JD0X
         96eXzyQsx45dx26MXUnpGnDy3jpxvAk/wDI/hOHxeUYKXagFUmKRFRU2OagSbsHl0qGt
         3hqH62/Q/B/G57ZQng+i5vaGJeaL08Uf6dM6WYvSIGm4WjFfLQhGVxxCjI7i1u91A4xL
         YpMRNTBntLVloYGvv2ibyEIZ80NwV+J19HiToZeKVO4vSmFhN16plNct104f+WeRmk81
         jkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7/cDxvGdffp0R1d8Bbrv1z7a+JwOkzEK0KwjgT2NxE=;
        b=LwrRonLoCv18xLhGchvrSmXWwaszgJqvUvXkt7Zi9e8Rk7RpxbtwEUASrBA0Vqfrkl
         5rTWg8V6Gj2E7r5SdK4mOv54vSYPeCHOskzOwqATbSBIAkv/9ON+XFF/JN4TQS+RBSQv
         TU2wUf9mlee63Xhl+nhbUJ86S4QgF26H1A8jjnIvXzarw3LIM+/1ZCxOvh/NUwsKz63E
         wG/hyDBJaXLLknHyKmJMeAeB262NLbP4VKN2SVU/VmzR7sdbLjgjrZOrvj0/44Pqm93O
         a9H6pmQHRyvLqybDvVWcFDCMgjNwkLozGXaBS/ih9BpbPmLU6Gf9/YEuC4yNbCnWgWm1
         F/7A==
X-Gm-Message-State: AOAM5329puyTVBjqjwBBWxU/wwopvvaC6yD/CF6CZUlvRnuCg+qhlslm
        nbeRoqF+hEQKHQMrRjqN4ObdjGcCvUQ=
X-Google-Smtp-Source: ABdhPJwYRYFfBlmw34OzXGBG+xQkUxeApPE1s2gVR8CHohOClUiwjOu3so0VAMYdMW4pAEGmwpbrDQ==
X-Received: by 2002:adf:8b18:: with SMTP id n24mr37002049wra.372.1593067583753;
        Wed, 24 Jun 2020 23:46:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 01/10] mfd: wm8350-core: Supply description wm8350_reg_{un}lock args
Date:   Thu, 25 Jun 2020 07:46:10 +0100
Message-Id: <20200625064619.2775707-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Descriptions required.

Prevents warnings like:

 drivers/mfd/wm8350-core.c:136: warning: Function parameter or member 'wm8350' not described in 'wm8350_reg_lock'
 drivers/mfd/wm8350-core.c:165: warning: Function parameter or member 'wm8350' not described in 'wm8350_reg_unlock'

Cc: <stable@vger.kernel.org>
Cc: patches@opensource.cirrus.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wm8350-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/wm8350-core.c b/drivers/mfd/wm8350-core.c
index 42b16503e6cd1..fbc77b218215c 100644
--- a/drivers/mfd/wm8350-core.c
+++ b/drivers/mfd/wm8350-core.c
@@ -131,6 +131,8 @@ EXPORT_SYMBOL_GPL(wm8350_block_write);
  * The WM8350 has a hardware lock which can be used to prevent writes to
  * some registers (generally those which can cause particularly serious
  * problems if misused).  This function enables that lock.
+ *
+ * @wm8350: pointer to local driver data structure
  */
 int wm8350_reg_lock(struct wm8350 *wm8350)
 {
@@ -160,6 +162,8 @@ EXPORT_SYMBOL_GPL(wm8350_reg_lock);
  * problems if misused).  This function disables that lock so updates
  * can be performed.  For maximum safety this should be done only when
  * required.
+ *
+ * @wm8350: pointer to local driver data structure
  */
 int wm8350_reg_unlock(struct wm8350 *wm8350)
 {
-- 
2.25.1

