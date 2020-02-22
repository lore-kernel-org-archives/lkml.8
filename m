Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA86C35673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F26206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 22:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="XBA6uXQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBVWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:31:59 -0500
Received: from vps.xff.cz ([195.181.215.36]:33592 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgBVWb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 17:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582410716; bh=Yq812b9dvmMvlOpVbFocve2A4ZWeDAWktAf3SUmQJNk=;
        h=From:To:Cc:Subject:Date:From;
        b=XBA6uXQZQgeroYn6XRO5ZIrFk/vJeE53pw5X6bXrBmcqJstTEYSSQH5wuyvsSaYhq
         g3FgW/dtXKoxLMjwIt8eh5WU82SsvmZWhBEE2NWx+D0w70GSvvINCjyR9GqtF+deiY
         bYLEHg/lQqUH1O3ANkmYMBe6kC+ffjMiJdy75GYM=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] Assortment of fixes for TBS A711 Tablet
Date:   Sat, 22 Feb 2020 23:31:50 +0100
Message-Id: <20200222223154.221632-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some issues with camera overvolting, USB-OTG/charging,
and WiFi OOB interrupt being stuck.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (4):
  ARM: dts: sun8i-a83t-tbs-a711: OOB WiFi interrupt doesn't work
  ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesn't like such a high voltage
  ARM: dts: sun8i-a83t-tbs-a711: Fix USB OTG mode detection
  ARM: dts: sun8i-a83t-tbs-a711: Drop superfluous dr_mode

 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.25.1

