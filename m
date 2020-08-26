Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED67AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2FC20897
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBiZVZxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgHZLvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgHZLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:50:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1527FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:50:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so772437plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YamHvfkP8QzJYhuEjb0/KnD0eM3ZI++KpyFGM28MyaU=;
        b=mBiZVZxDCvUt6hLD48mg3Q12FL0jsNUjeakdVaFYreSg+6zLizvcH7tOYA4wRmTTut
         wIRIJ8dVERDNCPc+80jOIqaToeBcOSL5ZS7Tpm2PL7/CPYx06WJ+MsEAxd8bvpIq9Z/7
         MTCNTwed9PIYasztEIAiWwLt68PZEymEWPKIT39Je/TA/Dnsdys/fb6XzLofGnbYc3Kf
         60p2IGvt1TF5ERJbECNEeCRD1GO27gjcKJXwNgBV6+JsRjVFoa3iQG3gE1Qj0/P4dqgy
         GfD4vA4g7BHKFEjT23GkDssilnM5F4pYiUVuLOoDfvedhc+7jePoG1R9fxG8HtR8dTex
         2asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YamHvfkP8QzJYhuEjb0/KnD0eM3ZI++KpyFGM28MyaU=;
        b=HHrLnGWAW6lZ8TLPZ/yBk0CXeutKqczfCb9jOlxX2fFcVaUEUW0Wi/JNhcQkMTtFnr
         ONlslW0hs3E8q3IyIijjKPNz7UKXzCRF7mn5oVsvHCUrsKpQKFKyjtyGq1th+KafiIa2
         ATASaLgAR/i3pd9YVNDwFjJaxMJlxw5KOyr+3gF1TfaaJ0l5Hr0o5WgNoEP0XTd3eWhE
         cuf6nV+Mri5D25aI3eSyHWrHeOt+Jn7GO3Edh5VE58RdvH+K3dHImuZLUzR1ZbNJlEtS
         G2s6bmyw/nm8s5DueBfihUuslF22lRb81KBmo5fDuT/Gqqyuu/i8GNKmwI9+qv6NfJe4
         9LIA==
X-Gm-Message-State: AOAM533ohvd6VMH0LdyB9SSB8yA/SaqFMkAl7cL1X7Hrfveo/e5fW42r
        Cqt7Ih9WdToZjIUSlVtRNqiegQ==
X-Google-Smtp-Source: ABdhPJw8Oo/HMnBPg30gLaQd8tsLpFWkUn2/9H03cnOA39gJU2XV4GJz2To+Kk1+/bfcON40cB1AdA==
X-Received: by 2002:a17:90a:550e:: with SMTP id b14mr5698261pji.64.1598442640224;
        Wed, 26 Aug 2020 04:50:40 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id q2sm2261270pgs.90.2020.08.26.04.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 04:50:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 0/3] opp: Allow opp-supported-hw to contain multiple versions
Date:   Wed, 26 Aug 2020 17:20:27 +0530
Message-Id: <cover.1598442485.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan and Dmitry,

Here is an attempt to solve the problem you guys faced, I have tested it
locally and works with my expectations. Please see if they solve your
problems.

Dmitry: I sent another message for you in patch 3's comments section.

--
viresh

Viresh Kumar (3):
  dt-bindings: opp: Allow opp-supported-hw to contain multiple versions
  opp: Allow opp-supported-hw to contain multiple versions
  ARM: tegra: Pass multiple versions in opp-supported-hw property

 Documentation/devicetree/bindings/opp/opp.txt |  53 +-
 .../boot/dts/tegra20-cpu-opp-microvolt.dtsi   |  36 -
 arch/arm/boot/dts/tegra20-cpu-opp.dtsi        |  67 +-
 .../boot/dts/tegra30-cpu-opp-microvolt.dtsi   | 512 ---------
 arch/arm/boot/dts/tegra30-cpu-opp.dtsi        | 986 +++---------------
 drivers/opp/of.c                              |  47 +-
 6 files changed, 214 insertions(+), 1487 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

