Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C82C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5547C208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+HVeM3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgCaWTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:19:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51336 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbgCaWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so1721781wmk.1;
        Tue, 31 Mar 2020 15:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=r+HVeM3maVxMRhkBI7oLDen47oS7HmRaPaSjtAMU02gVLwkshUft66tvURvWjSHxzR
         W109P8EYraukDqPYd8tl4WZSOGZcjoj66uh+Pd19kJbFzIGvTicWLxfWOYXmvLpf4yoZ
         qaxc8yXXj0+ER78L7fdtD9V+EOBZYzeMMRBDE6QM1jEkZI0JPmclXzngUDxkBi1EirK5
         XxPelKRY/Sn1ZZ6sGQLY3fc690TcWfccJtgsZEASCW8aRKJdm2xzXdxiWwD+dc96hccZ
         E0hwISOFccljqEVLfbYHGcMeXwVmuDYhbyPVvX1LdJUtXt1uQolmDp09qhPp45tro5WI
         jRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhOtbK0ZVL1ABebYKJYf0UxxzluO0JY5MJfCTLBiR34=;
        b=P8ENSrS6fPaYpWQQgXmXIBhWiwJ4rBtmYSeDjs7uXtc6vE5SF0c3V9DCgrXtSbVpZR
         pzw2EDAWZy82K+Ng71R+Grtclu8AMG/gcMGu1/gNeL3WNQMNssynbb72PHi1K1qO3Uhm
         vcSsRjrXL+UWB6nBj0VqmjNygBKA6DJq0smVnG1iUArP1yNCmXdYUwhLvBDPnF7Xg4cE
         q8wXlzFVqp0FLuNYJbdVYuVDZfYk4YS9y9plWx+lFod/s+jzY1B+m3qeTNN6QTIgnuWk
         LbmU7TC0Iu4V7mpa9Ih2LiXjckP5GhkZwm/d/R7vLFLi+vwb+UHOMmNTwY2cGCzoqtpl
         fX8w==
X-Gm-Message-State: AGi0PuZOGvjvZJP51nQtzvy0UTUYnNKUPUYIDQtvjV4IiXMuK7NCS/RQ
        /ltPF05bi/H/eGmM1GX+K2k=
X-Google-Smtp-Source: APiQypJq3gyQgChBKAlZCKqwaP7n5oYFR+3hgCYHrGm0DKxPp6ZWxDRlhXaG/69yP7aWPAzciCh/lg==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr1009518wme.107.1585693178288;
        Tue, 31 Mar 2020 15:19:38 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id a186sm9940wmh.33.2020.03.31.15.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:37 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: tegra: Enable native timers on Jetson AGX Xavier
Date:   Wed,  1 Apr 2020 00:19:14 +0200
Message-Id: <20200331221914.2966407-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331221914.2966407-1-thierry.reding@gmail.com>
References: <20200331221914.2966407-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Enable the native timers on Jetson AGX Xavier to allow using the
watchdog functionality to recover from system hangs, for example.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 623f7d7d216b..d68588f2709e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -52,6 +52,10 @@ memory-controller@2c00000 {
 			status = "okay";
 		};
 
+		timer@3010000 {
+			status = "okay";
+		};
+
 		serial@3110000 {
 			status = "okay";
 		};
-- 
2.24.1

