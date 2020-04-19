Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F56C38A29
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3700214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 05:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUNF53ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSFx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 01:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 01:53:28 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4EC061A0C;
        Sat, 18 Apr 2020 22:53:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so5235748lfc.5;
        Sat, 18 Apr 2020 22:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1qrRdfAfZTNG8C2xZODPVLiP1lsHDHNtbAuMSlM5XWs=;
        b=kUNF53epSMt9B8o64l0Q9iBjt6Sdx5q1Y4jifHIiotiq9kw49rYLkGnyR7cnEF2EJM
         l1wKyyN8e93Sl3Bf9IjqsTFh6vYCDFsSZ/jVY/n5TYNxn8ccDZyQMlgxlVN6UKKM7sMZ
         tojuZIFdK3+plJitSDgcGUaB48HdnEbMEMSCv9m0CayAKVMRdYSdM77UFJq5724WYQx/
         mb2UZI5fs8jdxmYyK3e8ALtiZ8vw0JL72AmNYgeDhepigNlO/N5rHDLRFM2uqIiU/b2a
         E2fzlcSywc8eRowTkw+coLBPAPsPuwFtXzXiPEsLKcWG31fXphbg4FyEP6JwxZCXbuIi
         LHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1qrRdfAfZTNG8C2xZODPVLiP1lsHDHNtbAuMSlM5XWs=;
        b=Y9xQ//iS0fx1JgfS25T0hsWpz+cHZEGaCYAGcySHq/RmJVtiSJzVR0ygM4Zq2FBT+c
         A6ODCSLV1evObNSjUtaAXlseafarLtp+7VEOCBOESp/fi+RShWM1sz+KMZHGiJ4y1owW
         EyOzElCy7eTzV4k4nJda6TpM53L1B3u+lRZEllzKQ5GEviFvEs0hgDnZgy5BHpPj0jFQ
         1Rq84NY8QcAH5FSMh8T6p9yJW/VmFcZpTrU5ziAI8bqTQoKtlZcib/cxr4R2RxwmAp+o
         8kK9IWKqWI5sPW0GPICeXIFcwnTsmtyDeWzymbYC86BLSB+gJWTb9c1iKywIUQ94hpf+
         hYWw==
X-Gm-Message-State: AGi0PuYXtiofuwQly4iQ4asYhyA4LZ3vAQJJt7+mbiFovJzRMyWnr51k
        J/+HPlsDK4BQRHGYASAxE08=
X-Google-Smtp-Source: APiQypJC5Bac5Q6fvsZfuKKznBhjkUaBzG+YWW1BYq0fxHBBjVZMQ2V4BovjT+WZs5Ex1F2va6ByjA==
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr6916190lfe.154.1587275606868;
        Sat, 18 Apr 2020 22:53:26 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h7sm3366247ljg.37.2020.04.18.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 22:53:26 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/4] arm64: dts: meson: add GT-King and GT-King Pro devices
Date:   Sun, 19 Apr 2020 05:53:18 +0000
Message-Id: <20200419055322.16138-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Beelink GT-King and GT-King Pro devices
which are based on the Amlogic W400 reference design. The series depends
on the common W400 and new audio dtsi created in [1]. It supersedes a
previous attempt to upstream support [2] which was refused due to the
duplication of dts content.

[1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=273479
[2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=249421

Christian Hewitt (4):
  dt-bindings: arm: amlogic: add support for the Beelink GT-King
  arm64: dts: meson-g12b-gtking: add initial device-tree
  dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
  arm64: dts: meson-g12b-gtking-pro: add initial device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |  2 +
 arch/arm64/boot/dts/amlogic/Makefile          |  2 +
 .../dts/amlogic/meson-g12b-gtking-pro.dts     | 39 +++++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-gtking.dts    | 16 ++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts

-- 
2.17.1

