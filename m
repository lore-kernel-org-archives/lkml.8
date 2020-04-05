Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383F3206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTY8TD7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgDERgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50368 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDERgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so1280058wmc.0;
        Sun, 05 Apr 2020 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRF6N8cRuZvvVCXMCOyMNsHazept9Ws44rtULXoUZv0=;
        b=tTY8TD7uDnvBkw/UoC8Tk43vS+8cikFxHyF9Om2gvwsmg+ktlq4rr31JyEUUafawmX
         bNfBrHvRqtWcuOfPacBJGOLPkY9/GHptKl1Wg4VeTcSodNXbjhEX5cxwZDqGouCSyqFO
         5bsfr1Otud+9TNhTCn6Z1FPh4CNm5kStnSBksV2D006oWRzsOOUwR/u+YJ/iZxFvD1C7
         5XcxfksQYbjLpzX8WGaoVNhfj6fiB4z6VGv4xVLO3ttinhEVh7+33e/tbm5BqC0ECApm
         PItcxqN3sN4j7Ck9f0BCkWTlsfTrf8uOA5D/PXrJeg/wZ3Y7JTauiqMzZdtjr4bjPELg
         ClkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRF6N8cRuZvvVCXMCOyMNsHazept9Ws44rtULXoUZv0=;
        b=eqSms++q9FiWVnVYHEi7bG/ypk0Dct4j2evGKwkEvfnaSb4U6PmdiVNiutlBW71FUx
         mqgxq4UXuU8ZqWxg6ngC92JowBqc6RQjDHZ4k73jtgp2jFLO4XtV+mJTq2AP5kuLw1dK
         JJquz48TF3nlwK3r+QEQWFMUYCZTu/N1GjLuXtKVYJZP0dV+LfKa5KIf+xcP4DuqaSXl
         sbI+K+CAKrKd9RRLNK2S6zokbaf36xGnUbBkUuJwHdV8QX89CJCS8FWxYg2odvhXreyx
         fHh/NVKdSPORZiJrO2CYdhF/gPTK+OllPXiD0VuqvbuuozMZ63janzJhsWB/ZHOHDQ72
         7I6Q==
X-Gm-Message-State: AGi0Pua9RDAb7hPfKGxYXroU0u4KVsI5cFqYqX/RGDthlpPR//Kfe3XO
        4526I6q1UT4wjATZ4Z9CFzk=
X-Google-Smtp-Source: APiQypJEdQdYeNEp0+y3WDmC4ooJao1v/Bv+H68S8EDXP68odyUR9G3QLytTafla8bD+dMOGZ5fhcQ==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr9998785wmg.58.1586108165177;
        Sun, 05 Apr 2020 10:36:05 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:04 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/7] Add support for Allwinner H6 DVFS
Date:   Sun,  5 Apr 2020 19:35:54 +0200
Message-Id: <20200405173601.24331-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunxi maintainers and members,

Now that required drivers are merged we can contibute on DVFS
support for Allwinner H6.

This serie is based on Yangtao Li serie[0] and Ondřej Jirman work[1].

Most of the OPP tables are taken from original vendor kernel[2].
Plus there is a new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.

I wrote a simple script to randomly set a frequency during
a random time[3].
With this script and using stress-ng during several hours, I didn't
see any issue. Moreover I have tested specifically the 1.8GHz on my
Beelink GS1, max thermal 85°C is reached very quickly and then the
SoC oscillates quickly between 1.5 and 1.8GHz. So i have added
1.6GHz and 1.7GHz my board now oscillate slower between 1.5GHz and
1.6GHz swapping every second and temperature is also morestable.

I also test that that offlining CPU0 and doing DVFS on other CPUs
works. As CPU regulator is only set for CPU0.

But maybe it doesn't cost much to set the regulator for all the CPUs?

Jernej test the GPU devfreq on several H6 board particulary the
Tanix TX6 which doesn't have a proper dedicated PMIC and doesn't
had any trouble with it.

Do you think I can enable GPU OPP for all H6 Boards?

Also Yangtao Li enable DVFS for Pine64, as I can't test it.
I'm waiting for his ack or someone who has a Pine64 and can test this
serie before reenabling this board.

Thanks,
Clément

0: https://patchwork.kernel.org/cover/10815117/
1: https://megous.com/git/linux/log/?h=ths-5.7
2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e2

Changes since v1 (thanks to Ondřej Jirman):
  - Remove Polling thermal
  - Add Orange Pi boards
  - Remove minimal voltage change for Beelink GS1
  - Add ramp-deplay for GPU and CPU regulators
  - Push to thermal point to 85°C (Allwinner set them to 100°C and 115°C)
  - Added 1.6GHz and 1.7GHz to OPP table. 

Clément Péron (4):
  arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
  arm64: configs: Enable sun50i cpufreq nvmem
  arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink
    GS1
  arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Orange Pi
    boards

Ondrej Jirman (2):
  arm64: dts: allwinner: h6: Add thermal trip points/cooling map
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

Yangtao Li (1):
  arm64: dts: allwinner: h6: Add clock to CPU cores

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  10 +-
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi |  74 +++++++++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  10 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  36 ++++++
 arch/arm64/configs/defconfig                  |   1 +
 6 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

-- 
2.20.1

