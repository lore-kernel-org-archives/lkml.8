Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D2C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB33C22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4X2OaYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgGTLYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgGTLYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:24:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE85C061794;
        Mon, 20 Jul 2020 04:24:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so24835181wmf.0;
        Mon, 20 Jul 2020 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=we7ZOPNX5bncne4MzulbXaLTxuq90c6Q451uL4ylMtY=;
        b=k4X2OaYS8OXBJM7sCwS70Ri/5W0j21FIYJyuyl3wjKX5ADod3E+yiXaddKeSNZ6JDd
         mWks0S0fu4YLkFLFYk3AxL+MPqQmCMFbJ4v0jQDL32+/9MWV9qvTRhjAsy16TJ71FSsT
         Tvo+OnzrRvsLBPj3rOaHtZlzsuzBu/R0Zkawwh+fA2Dr2wneVsbH+R+NE2qgfci2jeZd
         QofW3jw0h4jkgW3CtKUdNTAfHWcAKMtny/ORnXcq06EaSDcBdq9oZV23XpPOQmRv1x6c
         iU/pIthPS52zHHiNGCDLGSvghjIzemwms81ljfXfvyNnJ6nYeLoLngTTUNn0XCTdgCXp
         cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=we7ZOPNX5bncne4MzulbXaLTxuq90c6Q451uL4ylMtY=;
        b=WVj5avJstoFaXBseCRaFYCelcFHSIS6HEZQLpLyXbr2sXqhA3u7Vr95O1Qnfic4/Ch
         I/vcpV3mICIIiOv9nBwMGR2aX6NZ3+M1ZGAl1/vo5RXpVw2vgGxEJv64nlqqcCSC8uqB
         1hvQxZIxCqW8i4nV1HQ3QUktxd9BnV+mZHvJHNJTxpuRZPjzuP20u8UTmzFBWNxLSKdm
         de6jedUE25T1AmauUUH7E1tNG79y2zCXaTCdSXw1erMlX/28OzVD3YLHyjW/IPJDBfoH
         Y41S/6NXD8nX4nx3atu5OXXFyB/PlZqoh1sue5TpPu143aQZdjuWvi9whyMm3bihrmAv
         /ihg==
X-Gm-Message-State: AOAM530mFCGrwb5zqS5xY+2O4JAtq19MNg0McZp+y2awmTLzMoKAnXri
        Bf6yHbHHXlxxU6ky8sN5Yvg=
X-Google-Smtp-Source: ABdhPJwCtUYUYWCIdai0FsptVERDa5OY4vy/4d1ENbWgHYiQcvBtZxGqbXPp+Om57vNI+m3fUPmUjQ==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr21400592wmg.56.1595244275589;
        Mon, 20 Jul 2020 04:24:35 -0700 (PDT)
Received: from localhost.localdomain ([148.63.172.143])
        by smtp.gmail.com with ESMTPSA id t4sm33452942wmf.4.2020.07.20.04.24.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:24:35 -0700 (PDT)
From:   miguelborgesdefreitas@gmail.com
To:     a.zummo@towertech.it
Cc:     baruch@tkos.co.il, linux@armlinux.org.uk,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        miguelborgesdefreitas@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] rtc: pcf8523: imx6qdl-cubox-i: Make DSM for battery switch-over configurable from DT and enable it for the cubox-i
Date:   Mon, 20 Jul 2020 12:23:58 +0100
Message-Id: <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>

The pcf8523 has two configurable modes for the battery switch-over
functionality: (i) the default mode and (ii) the direct switching mode.
For the default mode to work (at the moment the only driver option), a
filtering circuit consisting of a series resistor of 1 kOhm and
a capacitor of 3.3 microF must be added to the VDD pin input to guarantee
a voltage drop of less 0.7V/ms for the oscillator operation reliability
(see pp.54 of the datasheet). Some boards (e.g. the cubox-i) do not
include such circuitry and are designed to work only in direct switching
mode. In fact, this is the recommended mode in the datasheet for hw
designs where VDD is always expected to be higher than VBAT. If DSM is not
enabled, after a power cycle, the voltage drop may be too high causing the
oscillator to stop working momentarily and the REG_SECONDS_OS bit to be
set. This causes userspace applications such as timedatectl and hwclock to
fail when obtaining the RTC time (RTC_RD_TIME: Invalid argument).
Hence, this patch set makes DSM configurable for the pcf8523 RTC in the
device-tree and enables it for the board where this issue was detected
- the cubox-i.
Note that if the RTC comes from an inconsistent state, the software reset
will override any power management options set during the probe phase.
Thus, pm is also enforced in pcf8523_start_rtc.

Changes in v2:
- Added extended commit message for git history
- Separate dt bindings documentation into a single patch

Miguel Borges de Freitas (3):
  dt-bindings: rtc: pcf8523: add DSM pm option for battery switch-over
  rtc: pcf8523: Make DSM for battery switch-over configurable from DT
  ARM: dts: imx6qdl-cubox-i: enable DSM for the RTC

 Documentation/devicetree/bindings/rtc/nxp,pcf8523.txt |  7 ++++++-
 Documentation/devicetree/bindings/rtc/rtc.yaml        |  7 +++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi                |  1 +
 drivers/rtc/rtc-pcf8523.c                             | 13 ++++++++++---
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
1.8.3.1

