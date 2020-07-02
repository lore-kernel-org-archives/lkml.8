Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898CD20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpxj/6h7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGBGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgGBGX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:23:29 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F06C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 23:23:29 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u186so18852459qka.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=POlxROtWP+TdhSt/IwD+NQVip9L3Y5x9YnPtFWg67x4=;
        b=rpxj/6h7LxbFJdRPv4XUXmB3CwjKxdzrNxrDw479CqOJvCJBa15OGqM6qLMrR+P2hV
         /ZnsX4v6hMyD7EThA1EX0nPBd92+MTQq4vMrWxCKUC6IiIPD/MHr4xj34XM0Izk3HgUZ
         yDd2TgxNnkowIC3h7jOoe7mNev/g75SAz4x1RxRc/m1Hqa2GqJUB/B2v/lK0HMBrRiZn
         ehiKDNUi05kNQiJtsQSDHt/ZY7KORFmfB5eedBikViLh061NVy0Ejfu2S7JLg+MxNaY1
         bYCE0U5smeuCVoWoApxKSkUbfIT3tDjD/y+M5jRqHDoy2G8EObzbhe6DDRCDqVyv8Y4D
         SeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=POlxROtWP+TdhSt/IwD+NQVip9L3Y5x9YnPtFWg67x4=;
        b=pmNM/fO4OaqYmO/AI7vtPg6HnGaEnGt8Zx2zm/0iADJwmATBdP9JnzyoSx92oukeMW
         nleH+Dq0Ps6KBG4mihhoi3IvlW4S62R2iYdiBLRZTn95D9qzzB4MKQnN3Y0/x86Fo6hl
         VJyH7ot3TFeDEfrvdupj79tPOIFcPLpVO/ZQhK4GEmbIDGLC55aRdApWXHILSRAbWZ/i
         xGDtElpc5WsmYMz1sIhbfN1ClG5pvwaZBQdeNS4+KnkxFdfssO9eZn98kHHGs/b/ywou
         /Zxd4OXdgA9cQCSE+4n0MfguDSwdYOec8kRCu/9LWwzWUomFZAp7Aho3lgA0h+6m8fAM
         iT0A==
X-Gm-Message-State: AOAM533km8ojPvrqu6Llm5kzGmnYZCIxOdjXzgfh2NOQ1BClBnlglJll
        2Xa7gCn/NYsSnll6hVWnjO+75kz/N5Q5
X-Google-Smtp-Source: ABdhPJy5eHr/trRqCcGcW58GmHYqTpcc6XIc1oWgRIjo/XEkCmsHA7/SrT3ezbzBSGmGU44rU6GXmA+dLl80
X-Received: by 2002:ad4:4645:: with SMTP id y5mr29421993qvv.163.1593671008207;
 Wed, 01 Jul 2020 23:23:28 -0700 (PDT)
Date:   Thu,  2 Jul 2020 16:23:16 +1000
Message-Id: <20200702062320.2903147-1-amistry@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/4] regulator: mt6397: Implement of_map_mode
 regulator_desc function
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsin-hsiung.wang@mediatek.com, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for being able to change regulator modes for
the mt6397 regulator. This is needed to allow the voltage scaling
support in the MT8173 SoC to be used on the elm (Acer Chromebook R13)
and hana (several Lenovo Chromebooks) devices.

Without a of_map_mode implementation, the regulator-allowed-modes
devicetree field is skipped, and attempting to change the regulator mode
results in an error:
[    1.439165] vpca15: mode operation not allowed

Changes in v2:
- Introduce constants in dt-bindings
- Improve conditional readability

Anand K Mistry (4):
  regulator: mt6397: Move buck modes into header file
  dt-bindings: regulator: mt6397: Document valid modes
  regulator: mt6397: Implement of_map_mode
  arm64: dts: mediatek: Update allowed mt6397 regulator modes for elm
    boards

 .../bindings/regulator/mt6397-regulator.txt     |  3 +++
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi    |  4 +++-
 drivers/regulator/mt6397-regulator.c            | 17 ++++++++++++++---
 .../regulator/mediatek,mt6397-regulator.h       | 15 +++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6397-regulator.h

-- 
2.27.0.212.ge8ba1cc988-goog

