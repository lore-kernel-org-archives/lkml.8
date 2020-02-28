Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B99C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1AD24691
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fctCtUQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1Gcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:32:52 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:55942 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgB1Gcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:32:51 -0500
Received: by mail-pj1-f44.google.com with SMTP id a18so864029pjs.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtcRx/xrQcP0C0zv1gSyxKTgfZjSQZqO9VhWjTr/Rf8=;
        b=fctCtUQXeEJuPvJTvnsSzRpmaM69ybDBogj8K0in5rgbuquVAaguD7FvrQdIoJQ18d
         gh5r3RY8/kRzkPcP0ILXzEC7n0X9FnHwrWynuI1FChMQtzZkU4mDjdoRY8YsCIXBr5QC
         4lsX+vmTpX2j7cTQJZCT6shFP1sb1CEYZf/hgqskdiGhq+LEfpTLywFZfhXSAQG0bHoT
         eMs5fDaoqke19VeezsAb0N6zzye0sR4hTxDUpcEtU82x3j2NzK8OCUECmJQPoEf4nafi
         qjS1JC682spxFN3dQQT0xw7RRq2WfX05SLrtnaR6TxyVaGYV1oyV/yiIKfl7uoUa5yF9
         a08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dtcRx/xrQcP0C0zv1gSyxKTgfZjSQZqO9VhWjTr/Rf8=;
        b=G68TDLsdXPcaVwXgKdrVTuNPUW6YAR+qoPg7dV1dyR+blwJ8dpCU+RO0DE22iTLKZU
         2uEQ70JscqT0mU3REW9m8FjR4YTwNZdewkYuOq+qURwaNnsJP8CIqVqWNv72tlvXIE1V
         8OnHynHYqvAVJrLKIiuTUCdgEoCOAvFguN4jhkr+4flnHg9X9sWODQTJz/SZLW8dkdLO
         tg0fGqzDJg7vDCjeuzn1KB6VuZVV1NX4A4fq1BGoSaAjt7D4Fz0w5KG2Zrt2rK6/fBKR
         Fgtso9sW9Q5mpl1FKJXRkD1ZBYAC756k0qJEHmgY0azTT6a+l8x2mYUK1Su1GVQdTmlV
         Xozw==
X-Gm-Message-State: APjAAAU62pLnEgZ9rFzazB3nwrnCoPyIkNhKkucs1TpV+UDAsQDgcXbs
        0PkgeD0kRmDr02d8LMidrR4ravfuCcc=
X-Google-Smtp-Source: APXvYqz9kjSDoKMHEw4EyvHBEIxPfo4zgvKkRo5JXyyFZ8yKQKx+Rc+7EnCJ4hfYEadj0CglZKMFsw==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr2724487plq.132.1582871570204;
        Thu, 27 Feb 2020 22:32:50 -0800 (PST)
Received: from localhost ([103.249.89.56])
        by smtp.gmail.com with ESMTPSA id x7sm5555746pgp.0.2020.02.27.22.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:32:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 0/3] Cleanup dtbs_check warnings for tsens
Date:   Fri, 28 Feb 2020 12:02:39 +0530
Message-Id: <cover.1582871139.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make dtbs_check pass for tsens bits. I'm working on another series to
cleanup other DT warnings for QC platforms.

Changes since v3:
- Fixed up subject prefix
- Added acks.

Amit Kucheria (3):
  dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
  arm64: dts: qcom: msm8916:: Add qcom,tsens-v0_1 to msm8916.dtsi
    compatible
  arm64: dts: qcom: msm8996:: Add qcom,tsens-v2 to msm8996.dtsi
    compatible

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                     | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

