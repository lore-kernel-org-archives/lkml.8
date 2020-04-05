Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB63C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46826206F7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjExk6h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDEKtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:49:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgDEKtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:49:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so13898919wrl.1;
        Sun, 05 Apr 2020 03:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv9/IWXnJ1yoMpi3TirvEFglVe/Qk5su9GHmZ1S9fvw=;
        b=mjExk6h0SjDMiFmot3d7kbacUhaCJ2rJUaHjRag6KYbL1sKo310SOL1FvgVioCuMJE
         AfN74pbWGyQdoV9kbee/HsesCoTxJnVudn9an0lEC0jBKQRMT65byzkYEtchI8d1Ugy+
         HDwJuMA0zHQUj4MxS9mTyxLmo9tNRGgJ0gpxcVIwcXxHPhlAP+0Qxjs3oy2mRdL0X8MT
         MLt8AGq1PeoqPZeewzypXrFFgS1iOPhmUY0e7qobHLIEZ+d40UhKTuAhjX4o6Yr3oSyo
         T7P+ZUavVbah3wm95NhoNRcYQylcqXoZZpNkjiYRIndGsw8iLsilqRcQ9faMcbfmV8la
         uq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv9/IWXnJ1yoMpi3TirvEFglVe/Qk5su9GHmZ1S9fvw=;
        b=SB/abBsgi6m8Neie8CNPYbQNd9Qa5N3KekCSojGV8PcZNBvwWfQ1E2XdtdZznxc780
         wzSKc5JLbvMMkq67MXpJpYtgU4bT7bMl4MqX58uL/+w+lX+HXnpeZN6qUhxj8nvmW5Zy
         Go3vem5WjsCpMaQpZ83maKCQ76PyDzEE8hq5cz9q24CLZRpQUHH8xVE44cc/7lt+UJyc
         /33XT1Eh8QLLYjlVLpqhIpMR2NuPeKJKWbjUno+EwWFtYi6hbExy/thFqrUOmV20IJgh
         sTdcz9TI+dVr+R8gGkglyeOM2y4QRX2e4LjORd9wr6V5utkN7RYVu7ahCnTNa/Dn9XwY
         KlDA==
X-Gm-Message-State: AGi0PuYmKXSCIkEVnLoLmqJ0JxhEcGLh+vwt6VFmgIfdyIrNpw6zjBY6
        vC2+6ZbyYaee2yleeXA3hM/z/U121hM=
X-Google-Smtp-Source: APiQypI5EMi4kSaqvdloUF+bXudrs3VbGb3tMM6vkimF6JXmXh9exzeuX4ABGCQELzS/I9fiEaAo0w==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr18068000wrx.236.1586083756474;
        Sun, 05 Apr 2020 03:49:16 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id u13sm21606411wru.88.2020.04.05.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 03:49:15 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 0/7] Add support for Allwinner H6 DVFS
Date:   Sun,  5 Apr 2020 12:49:06 +0200
Message-Id: <20200405104913.22806-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunxi maintainers and members,

Now that required drivers are merged we can contibute on DVFS support for
Allwinner H6.

This serie is based on Yangtao Li serie[0] and Megous works[1].

Most of the OPP tables are taken from original vendor kernel[2].
Plus there is a new CPU frequency @1.8GHz.

I wrote a simple script to randomly set a frequency during a random time[3].
With this script and using stress-ng during a day I didn't see any issue.
Moreover I have tested specifically the 1.8GHz on my Beelink GS1, max thermal
80°C is reached after ~10min and then the SoC oscillates quickly between 1.5
and 1.8GHz.

I also test that that offlining CPU0 and doing DVFS on other CPUs works.
As CPU regulator is only set for CPU0.

But maybe it doesn't cost much to set the regulator for all the CPUs?

Jernej test the GPU devfreq on several H6 board particulary the Tanix TX6 which
doesn't have a proper dedicated PMIC and doesn't had any trouble with it.

Do you think I can enable GPU OPP for all H6 Boards?

Also Yangtao Li enable DVFS for OrangePi and Pine64, as I can't test them I
didn't reenable these boards. Please, let me know if you want me to add these
boards in this serie.

Thanks,
Clément

0: https://patchwork.kernel.org/cover/10815117/
1: https://megous.com/git/linux/log/?h=ths-5.7
2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e2

Clément Péron (4):
  arm64: dts: allwinner: h6: set thermal polling time
  arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
  arm64: configs: Enable sun50i cpufreq nvmem
  arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Beelink
    GS1

Ondrej Jirman (2):
  arm64: dts: allwinner: h6: Add thermal trip points/cooling map
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

Yangtao Li (1):
  arm64: dts: allwinner: h6: Add clock to CPU cores

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  10 +-
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 103 ++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi |  74 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  44 +++++++-
 arch/arm64/configs/defconfig                  |   1 +
 5 files changed, 226 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

-- 
2.20.1

