Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD8C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A472080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBJRHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:07:14 -0500
Received: from mailoutvs19.siol.net ([185.57.226.210]:47066 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727558AbgBJRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:07:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 12934521B5F;
        Mon, 10 Feb 2020 18:07:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xnyPHZsLLLki; Mon, 10 Feb 2020 18:07:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id B727E521AFF;
        Mon, 10 Feb 2020 18:07:09 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 03CA2521467;
        Mon, 10 Feb 2020 18:07:04 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 0/5] arm64: dts: allwinner: a64: Enable deinterlace core
Date:   Mon, 10 Feb 2020 18:06:51 +0100
Message-Id: <20200210170656.82265-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 contains deinterlace core, compatible to the one found in
H3. It can be used in combination with VPU to playback interlaced videos.

Please take a look.

Best regards,
Jernej

Changes from v1:
- use number instead of macro in patch 3

Jernej Skrabec (5):
  dt-bindings: interconnect: sunxi: Add A64 MBUS compatible
  clk: sunxi-ng: a64: Export MBUS clock
  arm64: dts: allwinner: a64: Add MBUS controller node
  media: dt-bindings: media: Add Allwinner A64 deinterlace compatible
  arm64: dts: allwinner: a64: Add deinterlace core node

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |  1 +
 .../media/allwinner,sun8i-h3-deinterlace.yaml |  6 ++++-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h         |  4 ----
 include/dt-bindings/clock/sun50i-a64-ccu.h    |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

--=20
2.25.0

