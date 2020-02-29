Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE17C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E9724699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NomLyUZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgB2OKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:10:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41284 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgB2OKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:10:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id u26so6406473ljd.8;
        Sat, 29 Feb 2020 06:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q1D9zlcvNyYo46fhZp8SkasZqL/qaSdiAry5tMG2fAw=;
        b=NomLyUZQLLmi+T6Pk4g7aRbCnrybttmZOL2ID0dn6OeLEPUjqdidyiSlY5KQkEczm6
         9XGZ6VS1iMlkwXSdfo+WLR4SIiL4XpvBffncXi9P5B3I3qc5vnmRpmBotLDGsQ/TuUsg
         VDfalj69WXCPI1QuoqXAzBtIWNg/5RJWGdJvmh8EMuTqVpg6w0s2U7EtO3p6NM0QGi+A
         G7a3nyPKKqYuhgoiymMf0rdb4aVU5PlXWSdt2StPCrJ3zRVpKqQI0xd3gVUkMBtv8bOY
         M2KnIkgJVHPNho/FsPLlQuxFlNZKgj2xz4NC+9JFoGqbY/+auFvb/aWqZAQ9KDFKGhQ/
         fgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q1D9zlcvNyYo46fhZp8SkasZqL/qaSdiAry5tMG2fAw=;
        b=ublu0C1JLh+ZXJMAByYM+rPlxcX2bUs+idRbBuHqi5fgu+a0Xpb/8K6uSavKKAHfn1
         LSTP+sUAo8Y+4DAzl8l9mzNvCNXaIeHczvJdKv54w0f7ltAECIqzXkBplEX+EFI+S9i6
         NwDpTfRTT5s1qX1WXLCPAbM6qRNt/ipJOmuRCKj4mTyNbJEkeiV8d1y97e9HnHn3nbOe
         6YPgYwzq5UJx0v67qEWyS77YEBQEXGzu5GNJCrUXeCKqydDMXp9GLoRNrqs5bRr3pXTO
         LlEebNYGktuGDEiKpCkOzNMvlXhzYCFPysifVrqWeFXOFnDyczJbg4jHbOUnZEb34I3l
         eYCA==
X-Gm-Message-State: ANhLgQ0M0qKLGUcWZWlYaGyFynrJeTPtkKv7GW8bHKRSlNf9yfOl647C
        PRi0oZb2J7ooRqaJwVJpV3E=
X-Google-Smtp-Source: ADFU+vt8sOTpYv6VA6Nc47IHgZZX7w5n6LB0r6W1CMkeuA37qXQZc8NAkGzxKVZ2YFkIgTxvpt9x2g==
X-Received: by 2002:a05:651c:545:: with SMTP id q5mr6126951ljp.139.1582985404026;
        Sat, 29 Feb 2020 06:10:04 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j11sm7104124lfb.58.2020.02.29.06.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 06:10:03 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: meson: add dts/bindings for Beelink GT-King
Date:   Sat, 29 Feb 2020 18:09:11 +0400
Message-Id: <1582985353-83371-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Beelink
GT-King set-top box.

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for the Beelink GT-King
  arm64: dts: meson-g12b-gtking: add initial device-tree

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts  | 557 +++++++++++++++++++++
 3 files changed, 559 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts

-- 
2.7.4

