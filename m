Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81270C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CECE206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggqKLpgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404162AbgFXPEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404118AbgFXPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:04:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97335C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h15so2621971wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GecQ66rmlEvjIvJ7QJtrKlUl0uFGquQecFmVEnG3vQ=;
        b=ggqKLpgIV8maJfSM69W3D1mszs39U+1t28FTlwnkcd84c+gIgGoPdF7HRsq/DM1jMk
         9gqacJBySBP6gXjN151KeET3e+g/ISEwOAe2QvBA2VVsTUgmpGFsUvJcaS0zCbpK8PpK
         M+aW26fbiPFWEyMUqUmXFNJBEcnnX65jccbSs+sWKgE2FztQ4DtJkHSHVvLRRa0xOXG3
         2iYC8lTFzIXBIq6hePP2rZUhhcMAg/AbI9WcyH3NGJwRc/cwRffpnHne6STLhq0zy8Ca
         B6tEj8wsr44ipYX9tEeaSJHZZci9T/rJQqKuCropA5cvL9bD0AGezcuGfPHafWHBXfd/
         BZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GecQ66rmlEvjIvJ7QJtrKlUl0uFGquQecFmVEnG3vQ=;
        b=PT+BiQg74Y5NdVUOkMIQGHZLXi/JzJYnEh0ZK0WTQq/IH/Uy434rg1ryNH64+bE5+S
         Rj/SBzwV6ck+ZduQ8/kFI/McRemDTrz5t+t/rFs6yej2oemo/2Xcp+ObEnEh3NYlsetb
         fQ6VVK00DfvZVorZvSV0uGno7+Uw5RSalRdd0dQl5dp9JTMB5Lrki/s55CWkm9ZBfThr
         p4qFxUB6tnlcw4StN758SGNF2S0nKRb0eOv/IUaPsIOKut00ksNvGR8Mu+o3y5gVtqYN
         wpbftuCE8kdP1xmMSYUz9FMDHO9f4uOGbNoYFmtv0GZL57puJDcYCcF2UhulslkEc47t
         jqzg==
X-Gm-Message-State: AOAM532jar1H0st8HFIQ9uz/o+iudXrPhDYt1jgpCwltQrXw8YlihV2s
        t5gkKp+QYJ/3ot2g03Rqx27qTQ==
X-Google-Smtp-Source: ABdhPJwlPY1Prth3NQ7J8sQFtWPaPtlNsxgKb6muWk22U+5w0GKI8UWdfsvMJUKmL/9pxgQ4mmDiXg==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr31187536wrw.223.1593011080131;
        Wed, 24 Jun 2020 08:04:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id f186sm8200319wmf.29.2020.06.24.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:04:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/8] Fix a bunch of W=1 warnings in Backlight
Date:   Wed, 24 Jun 2020 15:57:13 +0100
Message-Id: <20200624145721.2590327-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (8):
  backlight: lms501kf03: Remove unused const variables
  backlight: lcd: Add missing kerneldoc entry for 'struct device parent'
  backlight: ili922x: Add missing kerneldoc descriptions for
    CHECK_FREQ_REG() args
  backlight: ili922x: Remove invalid use of kerneldoc syntax
  backlight: ili922x: Add missing kerneldoc description for
    ili922x_reg_dump()'s arg
  backlight: backlight: Supply description for function args in existing
    Kerneldocs
  backlight: lm3630a_bl: Remove invalid checks for unsigned int < 0
  backlight: qcom-wled: Remove unused configs for LED3 and LED4

 drivers/video/backlight/backlight.c  | 2 ++
 drivers/video/backlight/ili922x.c    | 8 ++++++--
 drivers/video/backlight/lcd.c        | 1 +
 drivers/video/backlight/lm3630a_bl.c | 4 ++--
 drivers/video/backlight/lms501kf03.c | 8 --------
 drivers/video/backlight/qcom-wled.c  | 8 --------
 6 files changed, 11 insertions(+), 20 deletions(-)

-- 
2.25.1

