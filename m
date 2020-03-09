Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F53C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2A32464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgph5n7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCIUnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:43:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35070 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:43:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id d79so10487676ywd.2;
        Mon, 09 Mar 2020 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W96PN6ds+wdrCUeWOa0/t1r6nDW2vDzBWxyYM20D4zQ=;
        b=lgph5n7yX5ys/mm5ELbKsKK21ihxpUNK7n6KISWhAOvj6yXMVbTXuOx+ePTAkVTvw0
         imIArQ7bOBaQVhnLbdsuHEjw6Uh4rjLAckYb8DFiyQitu68hC677X6nf/kXzxkOV+9nL
         VUa+gjWVTclKKu8HKecjyQdXUQvpxGWnyq41+hpVMColtGT9eLXpkXrQkuqebjB8MMXa
         lpZbePk4wsWMiCL4K4UybkeQ2aQDr0QTqrvRgJeRZGSfklI5ROzusWf92s7riAP76wlh
         hm1LsXF0FwLXUmsf9EFd9T+WOx8iN0aGim8v78eyCqKFisXJpvv4A1DgktGPd5p0D/ep
         7l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W96PN6ds+wdrCUeWOa0/t1r6nDW2vDzBWxyYM20D4zQ=;
        b=ionKulr+Or0IIviCG4uwp6OEgSRnSRHnA/6LvurXd2anX6mOFWUtGSReHxu4loQbaz
         cFPEdz/9YOTSc+LDlq0g+e0fAIlB8xUB9rWW/ujzinGPhziJ3gWl10T2W8bluxgwqPQC
         wm+57pd0xmjC2zrsKaVzGsHcnkwWMYKbi2A3bCCUEYAPE70Vx1ORHcMbh/5QHrdLX0lX
         tYeUOI+be1rksd/WENcNSakVgWH2jIaDTYTHXLXruDKYXCgWq789LqUVyY3kn3igN2bb
         hUl3VUQbLj0+dluuGOryOGYMvea9YLASbrFfY8XoeT3nE4hXyk6IJtfBzD71QzF/W2LF
         5Pcw==
X-Gm-Message-State: ANhLgQ0eVqYMayO5WiLrWdVj5wJeIBSkHs2bb0F1bLF9R66ABC04+tJP
        U2AcXdmTz3cLcUbwiVq+CrY=
X-Google-Smtp-Source: ADFU+vsQ7xiZjy67vd7Eov49CAky+jEQLedS5Gk2D1inMTWRwfH94qO2vCskueyLpzo0r0btX9lHsg==
X-Received: by 2002:a25:d405:: with SMTP id m5mr17164053ybf.2.1583786634235;
        Mon, 09 Mar 2020 13:43:54 -0700 (PDT)
Received: from farregard-ubuntu.kopismobile.org (c-73-177-17-21.hsd1.ms.comcast.net. [73.177.17.21])
        by smtp.gmail.com with ESMTPSA id s63sm17998768ywd.82.2020.03.09.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:43:53 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/5] Support the Allwinner F1C100s USB stack
Date:   Mon,  9 Mar 2020 15:43:21 -0500
Message-Id: <20200309204326.27403-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner F1C100s has an MUSB-based USB peripheral.  This patch
series implements support for it alongside existing Allwinner support
code.

This series was originally written by Icenowy Zheng for Linux v4.14.
I've rebased and bugfixed that work against mainline and tested it on
both the Lichee Nano and my custom hardware.

This resubmit is unchanged from the series I sent a couple weeks ago,
although I've expanded the Cc: to the linux-usb list.

George Hilliard (3):
  dt-bindings: Add new F1C100s compatible strings for USB
  phy: sun4i-usb: add support for the USB PHY on suniv SoC
  musb: sunxi: add support for the suniv MUSB controller

Icenowy Zheng (2):
  ARM: suniv: add USB-related device nodes
  ARM: suniv: f1c100s: enable USB on Lichee Pi Nano

 .../phy/allwinner,sun4i-a10-usb-phy.yaml      |  1 +
 .../usb/allwinner,sun4i-a10-musb.yaml         |  1 +
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts  | 16 ++++++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi          | 29 +++++++++++++++++++
 drivers/phy/allwinner/phy-sun4i-usb.c         | 11 +++++++
 drivers/usb/musb/sunxi.c                      |  8 +++--
 6 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.25.0

