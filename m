Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C492DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A277B21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Eq1PJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgGSOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:50:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA55C0619D2;
        Sun, 19 Jul 2020 07:50:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so15429412wrv.9;
        Sun, 19 Jul 2020 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUqLFtjizIDo67kZSDAuxTvDZ8v5hpCknWjlNVsJDEE=;
        b=G7Eq1PJQEyo8Takx/kaoykf4sk2/Xa1qsLGrafGiL8XQGE29sZLmx1ECnQuj/OBfHl
         dB3FB7qhSLBZ8EEjKI1t7h2fioIKfHRGdRFHB2Hun7yq2nkIcFaoNOAnLs0mncD2jZuZ
         Z+aEEPMPtmj7tPH+uyy/9jj7avxhM5DVK4WrmG/Z2+0aZM8XXBW8P7uTJlsRO/MsYO3L
         auqYIb/2kG0WJWuWZ5rfJ+3cYUcS9zErm28ppynDT62SlbtLzXoYIW9awCdktV+pijym
         /gIVw/oMoOFgp1yuIZtjWn6LWJ3A2rrQ/0Mw6wSQovG415EgsY4EsRLLNo/7GpnQH3mJ
         Virg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUqLFtjizIDo67kZSDAuxTvDZ8v5hpCknWjlNVsJDEE=;
        b=R9nYfO4MKx6X9VCvFL2x4BF0EX2IYgqSRV1bSRtJoZ0y7nurP4A2hgXtl8YyJKTQOz
         XGa8Nb4eDj07ke5Xv8lBe5532TE972sWcrZO0OASQEhxmr6Fw6V2yQUN/hEJFWYN2mpz
         ktvKGmYt3jH0RCY2xUSqgVP/AFeAowv0KHePVwhp79wV0g38QKb23ujrbSkNXEfAvpdO
         moiIklfchtwEeu7zOTSqf+zrC6rFojGk05z1pTCiT3NHvqYs63FF0AHIRThvIfK7IRbS
         jzd5pa+1Pr+eyVAPS191maNFfDqx278/TbkESNTAP8gEtFjfCiLaQtDrvKpnDpp+4coZ
         KA2g==
X-Gm-Message-State: AOAM532+igXbbLUKMBx/KY6m5xCGH9UhzyLLW55GoL4w+k0O1jHsKiG2
        adeNUsYzB/xJIB/iS8vTC8w=
X-Google-Smtp-Source: ABdhPJyNOMc9VuTGG3PC6b6FayRsZXsh0Mt8lFi6GRDpdpnSz9+N2I9pPXKA4OpE4DzP1iscXAosOg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr18012777wrt.174.1595170237975;
        Sun, 19 Jul 2020 07:50:37 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-179-3.netvisao.pt. [84.90.179.3])
        by smtp.gmail.com with ESMTPSA id d13sm26422755wrq.89.2020.07.19.07.50.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 07:50:37 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     linux@armlinux.org.uk, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] rtc: pcf8523: Make DSM for battery switch-over configurable from DT and enable it for the cubox-i
Date:   Sun, 19 Jul 2020 15:50:26 +0100
Message-Id: <20200719145028.3370-1-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

The pcf8523 has two configurable modes for the battery switch-over functionality:
(i) the default mode and (ii) the direct switching mode. For the default mode to work (at the
moment the only driver option), a filtering circuit consisting of a series resistor of 1 kOhm
and a capacitor of 3.3 microF must be added to the VDD pin input to guarantee a voltage drop
of less 0.7V/ms for the oscillator operation reliability (see pp.54 of the datasheet).
Some boards (e.g. the cubox-i) do not include such circuitry and are designed to work only in
direct switching mode. In fact, this is the recommended mode in the datasheet for hw designs
where VDD is always expected to be higher than VBAT.
If DSM is not enabled, after a power cycle, the voltage drop may be too high causing the
oscillator to stop working momentarily and the REG_SECONDS_OS bit to be set.
This causes userspace applications such as timedatectl and hwclock to fail when obtaining
the RTC time (RTC_RD_TIME: Invalid argument).
Hence, this patch set makes DSM configurable for the pcf8523 RTC in the device-tree and enables it
for the board where this issue was detected - the cubox-i. Note that if the RTC comes from an
inconsistent state, the software reset will override any power management options set during the
probe phase. Thus, pm is also enforced in pcf8523_start_rtc.


Miguel Borges de Freitas (2):
  rtc: pcf8523: Make DSM for battery switch-over configurable from DT
  ARM: dts: imx6qdl-cubox-i: enable DSM for the RTC

 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt |  7 ++++++-
 Documentation/devicetree/bindings/rtc/rtc.yaml        |  7 +++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi                |  1 +
 drivers/rtc/rtc-pcf8523.c                             | 13 ++++++++++---
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
1.8.3.1

