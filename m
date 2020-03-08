Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9479C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9820866
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgCHQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:48:51 -0400
Received: from mailoutvs59.siol.net ([185.57.226.250]:49417 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726297AbgCHQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:48:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 965575220C8;
        Sun,  8 Mar 2020 17:48:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v2jujWa3tyxe; Sun,  8 Mar 2020 17:48:48 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 4F3D952200D;
        Sun,  8 Mar 2020 17:48:48 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id C9FB1521FDF;
        Sun,  8 Mar 2020 17:48:47 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] arm64: dts: allwinner: h6: orangepi-one-plus: ethernet and HDMI
Date:   Sun,  8 Mar 2020 17:48:38 +0100
Message-Id: <20200308164840.110747-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series enables ethernet on OrangePi One Plus and HDMI output o=
n
OrangePi One Plus and OrangePi Lite 2 (shared DTSI).

Note that patch 2 (HDMI) is based on top of:
http://lists.infradead.org/pipermail/linux-arm-kernel/2020-March/716661.h=
tml

Marcus Cooper (2):
  arm64: dts: allwinner: h6: orangepi-one-plus: Enable ethernet
  arm64: dts: allwinner: h6: orangepi: Enable HDMI

 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 33 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 26 +++++++++++++++
 2 files changed, 59 insertions(+)

--=20
2.25.1

