Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD46C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26A120B1F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 18:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOklp3B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDKSVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 14:21:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42226 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgDKSVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 14:21:53 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so4942396ljp.9;
        Sat, 11 Apr 2020 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASv+/VA0JLllwIfA9iH/eNy9Ro4gJxQYRzDP5e5zYwM=;
        b=ZOklp3B6Wwr6hQCeRz5UVPsq9df/Nw+eRRo7wtvtHSGHqJnO13b4BtcNraGHZ4+7Mh
         6xqu1eyLxKjuNxoPesFDzn8yiomWOp9ONbkEVTt1DUWGKBUEcnwhujaYD9VAJ0/Fu3Wx
         ufaEli6G49GOdpSMSfpqGnMEXrMpKFC0etzZnm0nY1pSmLwyC5eHBSR2Vz14+w6ITOQg
         6c/ElanFrfKVo4e6XApxxf4KRJP1SikOeG++P5GY8fqZ2sKYEzoyQ3UalkjWL0Un32MR
         oAdNoQH4ak9rps/KwHZ8kqc+kisItvlGQqDz/awA6rgUBK2KEuundJD6Bg4FfgebQY4l
         52KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASv+/VA0JLllwIfA9iH/eNy9Ro4gJxQYRzDP5e5zYwM=;
        b=BOA9ccZO6A1kiq2depUCdP+5iRloSGYKwZ160PQpRQPeUvSu5E27ur3hSe9ACym+E8
         Jj47Z1KAPOVcptRFQvX2fy8S/DzI90MnMLsrZIT9w82s2cAJiDqHI4uBMnkA7d8qiKhS
         rNtVMy5Q8kQ3moJ+yHNxtDng78m1ur6Ucb8Op9zkKc96H5EX8LSJAoRTi+AWHAS5tAGN
         iA4oDfJOaCuJivhdNKvZakBhL4kmou7lIUBTfZePu6p3kgTfbxyGoC+gEDABZM3SH2Vu
         VPO4nJi/+jLJ1O814RyBby/4/OmxazeFIOUqQj6am+XufhZt3eJGlzrn5rxWGlNCi0xG
         Cyug==
X-Gm-Message-State: AGi0PuZxz9fTkfLAB7ypIJ3s95kiMoTCHcTRi+YAqlmfiAsGm9lUQD0c
        KW+Cpxql2uJ3+7Qf21IpnskgXzks1VpKBg==
X-Google-Smtp-Source: APiQypLA+zDlsQCYdRbHZB7BmugazrgJAOGPZg0aIqZ7CO78HcQ55wumux8mR1QAUKf5l+Mtt9cw+Q==
X-Received: by 2002:a2e:b4d1:: with SMTP id r17mr6125610ljm.117.1586629311627;
        Sat, 11 Apr 2020 11:21:51 -0700 (PDT)
Received: from localhost ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id o6sm2035558lja.70.2020.04.11.11.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 11:21:50 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Daniele Debernardi <drebrez@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v2 0/5] ARM: dts: qcom: klte: Add support for hw keys, flash and usb
Date:   Sat, 11 Apr 2020 21:21:17 +0300
Message-Id: <20200411182122.2677248-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for gpio-keys (volume up/down + home), internal flash storage
(sdhci), and usb (for usb-ethernet) for the Samsung Galaxy S5, codename klte.

v1: https://lkml.org/lkml/2020/4/9/927

changes in v2:
- do not include PMA8084 PMIC node in the msm8974 dtsi, instead only declare it
  in the device dts.

Daniele Debernardi (5):
  ARM: dts: qcom: msm8974-klte: Add pma8084 regulator nodes
  ARM: dts: qcom: msm8974-klte: Remove inherited vreg_boost node
  ARM: dts: qcom: msm8974-klte: Add gpio-keys nodes
  ARM: dts: qcom: msm8974-klte: Add sdhci1 node
  ARM: dts: qcom: msm8974-klte: Add USB node

 .../boot/dts/qcom-msm8974-samsung-klte.dts    | 294 +++++++++++++++++-
 1 file changed, 292 insertions(+), 2 deletions(-)


base-commit: 873e37a44b1ee8ad4628ca257dc51c0c7c654326
--
2.26.0

