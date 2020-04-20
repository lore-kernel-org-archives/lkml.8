Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C4C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DCC20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Guafrsrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDTNA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727887AbgDTNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66BC061A0C;
        Mon, 20 Apr 2020 06:00:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so11296928wmh.0;
        Mon, 20 Apr 2020 06:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLRkNUC0u8y4cndEyQmhJ4/AMRxri6A7MsmPh0pI6+0=;
        b=Guafrsrt31ugkSwaonhtK4a4Hphyi0I7eEyxYe+CjssxoStxFkwfW8u33foia70FUe
         J+B8nta1g7jcV9SFm4uMFkyqlZGttssBNRy5qO47cLYTFjw65OD8q6fwwL5PjZGYi+5D
         CdfWUKOUW1rS8BSq8HeG3xnlkv0HdEFef4r1Mxs6bH1reC9qsWYeRkPRhnMnc1d05n2l
         3s/VJNSRzN9dijfHwutPDyiVImaeCF1/ZPj+mw8PjvEaoJClOXFEWlOW9tO8mb+etML0
         Djf4x0OtY+R7l2OA6o2KcVbQQ666KPGquDZlOUlcnK/hK5d7GWnIc8nB/B7A+KgPP/Qk
         KfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hLRkNUC0u8y4cndEyQmhJ4/AMRxri6A7MsmPh0pI6+0=;
        b=bbl/QvFgx1tf4Sn2mMEsnxGgAEIY3slWC4QandwfZftQMTSALw17YrshusSFO+38Ft
         AKX3WtymcchEZE9VEfdlWgdCjbiLeMfUryjwkFF81CfDlYiZLZQHl0Et9EIuYvdiDAzL
         /LMBcgng9y9Qk4+Et00uaw0feZO/PevcxEd7+6P1HMeHzDdMovusTXXIIMdreKVQKevf
         IagOqJeHNsnxYoWE31JtKUg0zUCLed41qdeDJXsRiBefusoXXzUpxQKBL9X4Jn4rO0Wj
         SS3hzo0eIaPMtDjqxVz93pVD4n/e8RjuhxvDBqBr+vYCsRyyOu5WCzNK54t15puIHWS9
         clBg==
X-Gm-Message-State: AGi0Pua7JjkL2V/0fyQ3CEHWssFhODQJEa+VN3CQFfRTjwqasM7WDC5v
        iweFqs0bpXB/zJR7qpvsEmY=
X-Google-Smtp-Source: APiQypLQWZp2tO6tV7r3+Yt3ozomCC/p/Kk9A59i6gZud1dPxFUxRQnxr7sVEOETuwb9WfTMxhZomQ==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr19245449wmf.168.1587387624237;
        Mon, 20 Apr 2020 06:00:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 0/9] Add support for Allwinner H6 DVFS
Date:   Mon, 20 Apr 2020 15:00:12 +0200
Message-Id: <20200420130021.3841-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the same as v4 and v3 on top.
I have also fix the commit title for Pine H64 as we now only enable CPU DVFS.

Sorry for the noise,
Clément

Clément Péron (6):
  arm64: configs: Enable sun50i cpufreq nvmem
  arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
  arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
  arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
  arm64: dts: allwinner: Sort Pine H64 device-tree nodes
  arm64: dts: allwinner: h6: Enable CPU opp tables for Pine H64

Ondrej Jirman (2):
  arm64: dts: allwinner: h6: Add thermal trip points/cooling map
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

Yangtao Li (1):
  arm64: dts: allwinner: h6: Add clock to CPU cores

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   9 +-
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   3 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  43 ++++---
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  13 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  36 ++++++
 arch/arm64/configs/defconfig                  |   1 +
 7 files changed, 207 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi

-- 
2.20.1

