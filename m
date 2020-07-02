Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18345207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4qGOuIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGBDPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGBDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:15:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423BC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 20:15:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h10so3146797ybk.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 20:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lgjLNEI2c702nruZIf8/qVC3N2Yvj7eOc3xFcCXk4qE=;
        b=V4qGOuImI1av0lSmyLMJk52j2TEqAgPFSpa2IGTBg3P335rupJ/XJFDEVy6u3Y3nsa
         RxGOc5CrUOcD0Hx1SSX6EsLwS/YkM3rm9xE7r0RMJomNXcFqqngBD9LKQ8sdqsSMBuqt
         foksl0EJRlKlIsuDBk/TgVcq3AHjtf2S0T+hEssU9vC+kvaffGNehyx0mKdLema/9UQw
         76RivxWXQWWYbxnExz2m43fP0sc2RHIrz4bpQR6k8ck94uD8U3TW8qjdcGeItG3XDGWq
         8Lujvxr2kTUxQd9xNXkHoQ6fZKN3quOY96H0T651b5HMoiiTWgJvhDIqQoH5h8TlH97H
         1F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lgjLNEI2c702nruZIf8/qVC3N2Yvj7eOc3xFcCXk4qE=;
        b=SH4B8zQ1zvtU3rxTCCQ3JvfUHuWOAUpm+OmHHwQpyTaxoW2ZlokZmIcCkWx0/ZRsxa
         VhWKFTukbhZDNF2rjFW+6xEE6HXT4WvyOBUGYye7+7bpiwySFL1uweREmFH09gaya3YY
         E+ezv64BPZWBZ3U8USLQd+PrNib3gOwDaCVHKlU49VBUFQaGBUWgicJNmauPVRLRaWhS
         cJ6EgRx3GIjxhvrj2SdF2C06o1NlFiwDkZSe7NQ7YyG1NhYimjU+sBQJ3aN25p0oUuXL
         rNpaedMFwykzDhyjO57CSuoof2NRrxxdjjP1c/lOjin2ynCzAZyOWNCUPw00l0PcKWH5
         3cBA==
X-Gm-Message-State: AOAM530i0ZY6yEqHUp8l/FMsnlYXZbHG99IvvPo2QhYj1iV9DquLXHlM
        sPIK7szTJNWx+NG7gI93cewIZAnyMnC4
X-Google-Smtp-Source: ABdhPJzMQo9PQ5D19hZdsGpjI7T+hKX4gBcCSrIxKzFL0IBLXNR6rgDXemM3ITzN7p5dT0NF4XRTdRDj3BcM
X-Received: by 2002:a25:84cc:: with SMTP id x12mr43165655ybm.454.1593659744675;
 Wed, 01 Jul 2020 20:15:44 -0700 (PDT)
Date:   Thu,  2 Jul 2020 13:15:21 +1000
Message-Id: <20200702031525.2662441-1-amistry@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 0/4] regulator: da9211: support changing modes
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsinyi@chromium.org, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for being able to change regulator modes for
the da9211 regulator. This is needed to allow the voltage scaling
support in the MT8173 SoC to be used in the elm (Acer Chromebook R13)
and hana (several Lenovo Chromebooks) devices.


Anand K Mistry (4):
  regulator: da9211: Move buck modes into header file
  dt-bindings: regulator: da9211: Document allowed modes
  regulator: da9211: Implement of_map_mode
  arm64: dts: mediatek: Update allowed regulator modes for elm boards

 .../devicetree/bindings/regulator/da9211.txt  |  4 +++
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  |  4 ++-
 drivers/regulator/da9211-regulator.c          | 30 +++++++++++++++----
 .../regulator/dlg,da9211-regulator.h          | 16 ++++++++++
 4 files changed, 47 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/regulator/dlg,da9211-regulator.h

-- 
2.27.0.212.ge8ba1cc988-goog

