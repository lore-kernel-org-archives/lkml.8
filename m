Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D1EC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D7D2084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCHN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:59:09 -0400
Received: from mailoutvs57.siol.net ([185.57.226.248]:40339 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726259AbgCHN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:59:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AC9F3521E09;
        Sun,  8 Mar 2020 14:59:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iyjirCZ5qHHv; Sun,  8 Mar 2020 14:59:05 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 55D16521EBB;
        Sun,  8 Mar 2020 14:59:05 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 9529D521E09;
        Sun,  8 Mar 2020 14:59:01 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 0/2] rtc: sun6i: Make external oscillator optional
Date:   Sun,  8 Mar 2020 14:58:47 +0100
Message-Id: <20200308135849.106333-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is implementation of idea discussed here:
https://lore.kernel.org/linux-arm-kernel/20200117183901.lkieha3hu6nz2hoj@=
gilmour.lan/T/

Part of first patch commit message:

Some boards, like OrangePi PC2 (H5), OrangePi Plus 2E (H3) and Tanix TX6
(H6) don't have external 32kHz oscillator. Till H6, it didn't really
matter if external oscillator was enabled because HW detected error and
fall back to internal one. H6 has same functionality but it's the first
SoC which have "auto switch bypass" bit documented and always enabled in
driver. This prevents RTC to work correctly if external crystal is not
present on board. There are other side effects - all peripherals which
depends on this clock also don't work (HDMI CEC for example).

In this series I fixed only H6 based boards since improper settings have
real impact due to explicitly forbidden fallback to internal oscillator.
Since most boards actually contain external oscillator, I wonder if it's
better to leave external oscillator in common H6 dtsi and just delete
clocks property in rtc node and ext. oscillator node in board dts file?

What do you think?

Best regards,
Jernej

Changes from v1:
- added comments to driver to make more clear how clock registration
  works

Jernej Skrabec (2):
  rtc: sun6i: Make external 32k oscillator optional
  arm64: dts: allwinner: h6: Move ext. oscillator to board DTs

 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 11 +++++++++++
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts  | 11 +++++++++++
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi   | 11 +++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts    | 11 +++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi     |  8 --------
 drivers/rtc/rtc-sun6i.c                          | 16 ++++++++--------
 6 files changed, 52 insertions(+), 16 deletions(-)

--=20
2.25.1

