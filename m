Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22DB20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuEcNv5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgGRG5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:57:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F102DC0619D2;
        Fri, 17 Jul 2020 23:57:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o2so20541535wmh.2;
        Fri, 17 Jul 2020 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pyjWDtKMxx4/68tXkVpiBJVCOhw66qo2kRjsgA+vwPA=;
        b=ZuEcNv5k9Z0KZbqh/KPRDsLCM6yeWEL+b4iJp7dXRBzCc45ij1G8/u9fz4MMuhdKlW
         7ZX6kuFpXr6FvTWUzPkCzngLws8K0HaiMUods4h4UAvvJSwzX/jX2Z68ccUJkNp6WLQo
         VjrgzgnmVezt0s0zwXHJyAQJ3mtPUjGOrz9hsh9B3Hiiq4G8T84q7kmcpQFy6gBTBWvC
         81udRbRsiHE03035wEkE6B/LeF26HHAM7+5tS05cwZQYRJWmFDq9YQVX8Y0WZ6phS6RI
         EOhrO/0Cf6zhSc1hiO8u2eTaGS1gKc8eZU/iV22M5PJegqCQUrYVO8eYEIaFRGf9XMRF
         cl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pyjWDtKMxx4/68tXkVpiBJVCOhw66qo2kRjsgA+vwPA=;
        b=th2wDo4NydX10xF/xAaB/XAJso9JDSkcZtKuDx+P+TRus57/87q3kq78FsXyTC6qsl
         KmXhgbjl4FkIfDgDSACcd8XCpqQEbgPZ2UXtobzhwP6SCK4OCO+Da5Zg51SjjixpKu8l
         DTp9aDHWO9z14O3Uubc87zqNieLBPM61chNX3IEST9COZWYO9raZvIIyHhzJmHm9s3ma
         tWIhakSURSJ1fbBVm6myOqkDM+O3xUd6tq3PdQXX5zdL5nqbCxIpT0tzUEpylv3y8QQF
         b1rzpZ5wzeOlItQQNUeyDZczWgzW8m5Ptw3XhQ0YLrSsPutyvorhIRrc6u9MA0oaci6U
         4LlQ==
X-Gm-Message-State: AOAM531J0RnTrv3PHG6E8AcD8OkRHVelU7N8K3HFww53t1MpePN714ck
        IkMV6lSToerbmEuzykJd/PE=
X-Google-Smtp-Source: ABdhPJxMqh5d+Cifnno+A3aQ3358AxXfuypnLtn+XMRwXlPwY9BWTNOeBgzdyhXgVDCffOKXu1KJzg==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr12983342wmi.85.1595055464539;
        Fri, 17 Jul 2020 23:57:44 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x5sm18749191wmg.2.2020.07.17.23.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:57:43 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 00/12] arm64: dts: meson: add more GX soundcards
Date:   Sat, 18 Jul 2020 06:57:27 +0000
Message-Id: <20200718065739.7802-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chewitt <christianshewitt@gmail.com>

This series adds basic support for LPCM audio over HDMI and S/PDIF
interfaces to GXBB/GXL/GXM devices without support. I'm sure audio
support can be extended in places (some devices have internal DACs
and headphone hardware) but this gets the HDMI port working as a
minimum capability.

I have personally tested with the khadas-vim2, odroid-c2, and both
wetek devices as I have them, and there are positive forum reports
from users with vega-s95 and some no-name P20X box devices.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Christian Hewitt (12):
  arm64: dts: meson: add audio playback to a95x
  arm64: dts: meson: add audio playback to khadas-vim2
  arm64: dts: meson: add audio playback to nanopi-k2
  arm64: dts: meson: add audio playback to nexbox-a1
  arm64: dts: meson: add audio playback to odroid-c2
  arm64: dts: meson: add audio playback to p201
  arm64: dts: meson: add audio playback to p200
  arm64: dts: meson: add audio playback to p212-s905x dtsi
  arm64: dts: meson: add audio playback to rbox-pro
  arm64: dts: meson: add audio playback to vega-s95 dtsi
  arm64: dts: meson: add audio playback to wetek-hub
  arm64: dts: meson: add audio playback to wetek-play2

 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++
 .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 ++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 ++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 ++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++
 .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 ++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 ++++++++++
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 +++++++++-
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  | 80 +++++++++++++++++++
 .../boot/dts/amlogic/meson-gxm-rbox-pro.dts   | 80 +++++++++++++++++++
 12 files changed, 624 insertions(+), 3 deletions(-)

-- 
2.17.1

