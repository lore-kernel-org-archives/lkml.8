Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA10B207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/nrsGr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgFIGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFIGpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:45:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A448C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 23:45:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w20so9874344pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78YJd++6MCBi2czAoFZXzyiyrvV2k69cWVDs4OQn+lo=;
        b=t/nrsGr8iL1/BoJDB1p1upet1q7RmIROeK7bEKJ9cZ4CZDK9JDA7DrOHHZWQuRlJy9
         SHLBkPeQgt7/i735xV63sxeSrPW3aDxqIe2qafsUs40YBz+vR1+gFct+f3nhsfeb+FKd
         9L/vBl28GMgpO9ynJs0BhsnxOCam7/eBpT/N/CFXzk0+p2lxk5oNRydca6mFAnUyx4Bv
         Z7v+am3PKvBOAeuuOp2aN8STSymwCjhUsQbC4lLTp7S6HhrshxD11sjGZod8ffi3QTEw
         d6g9XbjM40uNjxg7LsuTUa4vxJHPmPy8vcH0BMkMzKFnmLukun+x2iCFe3YnrIDKmTfr
         CWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78YJd++6MCBi2czAoFZXzyiyrvV2k69cWVDs4OQn+lo=;
        b=Lcoho/z0GcBih58R0CW76vRqnwbHpwfG86Lh/1krV79BXCnrenV4HW/6R3CBo9I/fd
         g6AMEOvfF/9ZXSoSOBaqaikMDs3z7vEGJL9TUemLEa+M3QnOQZ1eGioYKl0LC3OHgqEQ
         gxCU+thIXxRHP0b27WRVbuBbvYZVK+oJii/s7hbKoCUjlBp82ZxNzY7NajDeVzYqFCvU
         NM3ycqktIQ0zlXE/QIZcHLHHiyLTTwZbBgB4Z+DLK7xnFL618sb3O8Elqq0QKXuHujU3
         DvP5mARLlmSuqnOWP29vuerOquEet/f6ZYxhFRPH3vkbkA6yM5nn+jAqecUFRIKtFpeU
         Am1Q==
X-Gm-Message-State: AOAM532GC2ZwnyOEKvl08U24mGxAE6iIWPttsB7EsuQMCuF3SUpDs9zi
        izUtZsYvkMzpwOts+tpR7XwYlKHMxs8=
X-Google-Smtp-Source: ABdhPJzzHJ2cZxqknv0bUpqxO4eV9Txk0TkcHbipkebWGGkPuiPsGng15YmIaWcMDZ5/YRmsQqJMjA==
X-Received: by 2002:a62:cd87:: with SMTP id o129mr23636055pfg.74.1591685101324;
        Mon, 08 Jun 2020 23:45:01 -0700 (PDT)
Received: from localhost ([45.127.45.147])
        by smtp.gmail.com with ESMTPSA id b4sm8944451pfg.75.2020.06.08.23.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:45:00 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, sibis@codeaurora.org,
        manivannan.sadhasivam@linaro.org, dmitry.baryshkov@linaro.org,
        Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Add thermal support for SM8150, SM8250
Date:   Tue,  9 Jun 2020 12:14:53 +0530
Message-Id: <cover.1591684754.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add two new compatibles, the devicetree entries for the thermal zones and
wire it up to the cpufreq cooling device.

Amit Kucheria (3):
  dt-bindings: thermal: qcom-tsens: Add compatible for sm8150, sm8250
  arm64: dts: qcom: sm8150: Add thermal zones and throttling support
  arm64: dts: qcom: sm8250: Add thermal zones and throttling support

 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 811 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 766 +++++++++++++++++
 drivers/thermal/qcom/tsens-v2.c               |   2 +-
 4 files changed, 1580 insertions(+), 1 deletion(-)

-- 
2.25.1

