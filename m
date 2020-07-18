Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32743C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05E6F2074B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hULWg5e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgGRHZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgGRHZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:25:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770CC0619D2;
        Sat, 18 Jul 2020 00:25:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so13254825wrl.8;
        Sat, 18 Jul 2020 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dKmmlTkJ/UK1rBdA5rLoQaKVO8RXmU6FeHJYL7jfrss=;
        b=hULWg5e/Woha7mtNXrFt49+AHIYkexrt8rcI6w4zndMhKK47SrMHwi6pnrPAyK1Psu
         kCLBz0xef4+bP40lXPyUiS5WCoAC/P2bsQweER7fSNS3iHXe9kxASVFcHgE6yOCB2wxj
         GvEicGY4ef1tPo0UCkKgF2VctGxdbcE1RQ4VX/rMZm+NisDTDuonBBo6fDXCrdDVYXPB
         vHIx/Qynek5hbd+rdZZBoGwnFej38me6BkyN5vgkDBrHIta2+avlzsV9PkWOVkJFT1xD
         Pyq/9ZL1sKhbDPbzzwoUFVmQ5smIKvh9Z7KZ/73QJ7pkVnrcx+n3416O+y3AjFdBf0UN
         WXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dKmmlTkJ/UK1rBdA5rLoQaKVO8RXmU6FeHJYL7jfrss=;
        b=hg17IFN/Kgcmw1DH/TbXswEPfMTSaF7YncfCvFpnZJyutvhH3o3d70VgS0p7f3UN7u
         tuSGPpAR65rAGxoho9jIDsX2bheHKNP2t3b9EDfkF4++YEiWNRL62U0rBgl7eNCGTTsK
         6qrkRCe3C5QRSdZSCBFCsMBPPp3mNrf1JZ7I0Qy70xs/OLBCc/NjJBxoUJfW7xy8ZRgR
         sVJfJkPV2f9+3htt49K95UB4SAQ6LTQ3ub5h4vnXb0t9WyyexIo3VAxB8bOeKB7pMBnQ
         XPLWtHNmoT6uuXwkKEBAjbu1czAB8fTo23yPENtNamFFBPB9JZMZrM02CTgDaIhIJzT7
         qPow==
X-Gm-Message-State: AOAM532w0w9WYSPajDz6fZELpDJQQYTYBVn2s3UH8ryGbigteolpZmbL
        bSXslhoCppfx0dGaCI3YTs0=
X-Google-Smtp-Source: ABdhPJz6pZ2GZOEtBjMTXW3ONHReL3SZ/nRUksYF8p5JqWsqUrczP2SwHKfQ+DWsmLkyh+WFUFUZgA==
X-Received: by 2002:a05:6000:d0:: with SMTP id q16mr14502799wrx.166.1595057136678;
        Sat, 18 Jul 2020 00:25:36 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c7sm19550192wrq.58.2020.07.18.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 00:25:36 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/2] arm64: dts: meson: add more SM1 soundcards
Date:   Sat, 18 Jul 2020 07:25:30 +0000
Message-Id: <20200718072532.8427-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for LPCM audio over HDMI interfaces
to the Khadas VIM3L (reusing the same config as the VIM3) and the
HardKernel ODROID-C4 devices. I'm sure support can be extended to
include other hardware but this gets the HDMI port working as a
minimum capability. I have personally tested with both devices.

Christian Hewitt (2):
  arm64: dts: meson: add audio playback to odroid-c4
  arm64: dts: meson: add audio playback to khadas-vim3l

 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 88 +++++++++++++++++++
 .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 88 +++++++++++++++++++
 2 files changed, 176 insertions(+)

-- 
2.17.1

