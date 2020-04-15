Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F3A206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvxVgWlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393553AbgDOGW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389994AbgDOGWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:22:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E7C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:22:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t4so867709plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7ztLwR0nrzj14bfkYxl4aJo2UR6d2mLG0ia7JK8sEE=;
        b=CvxVgWlbWjZSIJo5Xm1E2EQr1dEP5seT3eF+i8JK2W/3XQ/jyY2U3u6WQCqFgodlET
         O0bcdK/L3W8CEXqMemVVI6jAYYGBl+tjh5tAiUw7HNVvOOecm9876AFBDxIFY3lCGyIr
         bm+zH0C25JB90ZIM/5besoq7HEVcxXaVu5UHEgwAglxGnozMaw+KqAfpw5WznYRzRXYX
         7PjHgkkWfU4ErZbNZQJo/KzxfU7+JtN6ZLHtR5aBelXwVO0PYLsEAvWs4ff36O6SuaB5
         +ElhUSMiZwDH/gqu0To6GS6hZYvn/xrFVgCPUL2Ts9xgGJ+QFJE5WjqUU96MFtNWsFUY
         mbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7ztLwR0nrzj14bfkYxl4aJo2UR6d2mLG0ia7JK8sEE=;
        b=TknkbsRnMuJp9hePtnFzgKF7N3zWwbKWix8S/98iFxSfcvr1jEy+m3Vf0Ip9xe9gJu
         hie1UO5USbef0i8rcHswIqFF70ZP4KS0z1RoCh5T+PiRcJTb+B+h7o916cGTQrm38Iza
         /ilOq3xkscfHFwcWoCG+BJGz6/cZr/bApodSM0jCu+PCW74nv6G1Pz2VXzp1Yzw+Lnr6
         aX2mlCOLFvOJaPplCAiQLwNLwksIX+LZTbWUhpq1G0VaclxO3+bnF/Yc5EhArP3Vgh+I
         AbJZ7+wUllSFW+KuOyu417iGtFL5+P3U3jp+txZb4m6P/OXCMfPWZ4SMrZcSBknkEuMX
         ipBw==
X-Gm-Message-State: AGi0PuYYPg2ZNIkQEBrtUQolHQzc8x4ZoJiHesIEguAGElgoNqhT031B
        51sHTb+kDshdUxhLj/1/oLgPeA==
X-Google-Smtp-Source: APiQypKWBS5ovDriytB8DRjNlCjsW7YgYHmuwGauDfW3GBOM5hji6Wr1BmawS8I+rA7IQhD0HZadoA==
X-Received: by 2002:a17:90a:ac18:: with SMTP id o24mr4468175pjq.62.1586931737426;
        Tue, 14 Apr 2020 23:22:17 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nu13sm14032899pjb.22.2020.04.14.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:22:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Qualcomm SM8250 PRMHPD support
Date:   Tue, 14 Apr 2020 23:21:52 -0700
Message-Id: <20200415062154.741179-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpmhpd resources for SM8250 and add the relevant node to DT

Bjorn Andersson (2):
  soc: qcom: rpmhpd: Add SM8250 power domains
  arm64: dts: qcom: sm8250: Add rpmhpd node

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 51 +++++++++++++++++++
 drivers/soc/qcom/rpmhpd.c                     | 19 +++++++
 include/dt-bindings/power/qcom-rpmpd.h        | 12 +++++
 4 files changed, 83 insertions(+)

-- 
2.24.0

