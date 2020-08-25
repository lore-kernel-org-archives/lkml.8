Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE458C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C3D207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHYROZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:14:25 -0400
Received: from mailoutvs2.siol.net ([185.57.226.193]:34294 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbgHYROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:14:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 38058524B30;
        Tue, 25 Aug 2020 19:14:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XHJMv2YnN3Bq; Tue, 25 Aug 2020 19:14:07 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E4B2C524B0B;
        Tue, 25 Aug 2020 19:14:06 +0200 (CEST)
Received: from localhost.localdomain (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 99FFB524B30;
        Tue, 25 Aug 2020 19:14:06 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/3] ARM: dts: sun8i: r40: Enable IR on BananaPi M2U
Date:   Tue, 25 Aug 2020 19:13:55 +0200
Message-Id: <20200825171358.1286902-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series first adds nodes to R40 DTSI and then enable IR receiver
for BananaPi M2 Ultra board.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (3):
  dt-bindings: media: allwinner,sun4i-a10-ir: Add R40 compatible
  ARM: dts: sun8i: r40: Add IR nodes
  ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable IR

 .../media/allwinner,sun4i-a10-ir.yaml         |  9 +++--
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  4 +++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 36 +++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

--=20
2.28.0

