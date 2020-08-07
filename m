Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC4220866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="R68A8k1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHGIaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:30:01 -0400
Received: from mxwww.masterlogin.de ([95.129.51.220]:36148 "EHLO
        mxwww.masterlogin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:30:01 -0400
Received: from mxout4.routing.net (unknown [192.168.10.112])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id 83489962D9;
        Fri,  7 Aug 2020 08:29:59 +0000 (UTC)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 3A2B610149E;
        Fri,  7 Aug 2020 08:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596788999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wsClCJOlh8nQcRXuQ4gJeORkwcWKsYRo9CkahiSVwFs=;
        b=R68A8k1ZYv6NmCjF4ynccSvMG+0EG5Q2uB/fdU6Ij2znksMXcHYzj0RrReHIoZAwoODh3u
        DllYIHVIC966t3eRHy9qegKLq8GSfwYq1PP4pQsKP7RGaF1eNaO2sSXiiuHndIN7kOc/p2
        3epNkwIVOhf4KzfMUCZdbLPW79HLGxE=
Received: from localhost.localdomain (fttx-pool-37.60.0.190.bambit.de [37.60.0.190])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 80E39406DF;
        Fri,  7 Aug 2020 08:29:58 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] move/add display relevant nodes to mt7623n
Date:   Fri,  7 Aug 2020 10:29:56 +0200
Message-Id: <20200807082956.7004-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

based on series from David Woodhouse [1]
i moved more display-nodes out of mt7623.dtsi to new mt7623n.dtsi
and changed last part from my series [2] to add these nodes to this new dtsi

[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=329209
[2] https://patchwork.kernel.org/patch/11700699/

Frank Wunderlich (1):
  arm: dts: mt7623: move more display-related nodes to mt7623n.dtsi

Ryder Lee (1):
  arm: dts: mt7623: add display subsystem related device nodes

 arch/arm/boot/dts/mt7623.dtsi                 |  99 -------
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  72 +++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  72 +++++
 arch/arm/boot/dts/mt7623n.dtsi                | 270 ++++++++++++++++++
 4 files changed, 414 insertions(+), 99 deletions(-)

-- 
2.25.1

