Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3429120866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="uqimuOg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgHGI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHGI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:28:31 -0400
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240FC061574;
        Fri,  7 Aug 2020 01:28:31 -0700 (PDT)
Received: from mxout3.routing.net (unknown [192.168.10.111])
        by forward.mxwww.masterlogin.de (Postfix) with ESMTPS id D24B8962D2;
        Fri,  7 Aug 2020 08:28:24 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout3.routing.net (Postfix) with ESMTP id 6350E6046B;
        Fri,  7 Aug 2020 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1596788904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LTTAvZt84zMEQxdjDVX1V/pS94sBHBnf+fd0mzHYS/Y=;
        b=uqimuOg/kuqp201562Tk5tMiic7EnABOEvs/isx7WG+CtjSeH2dKoqLArQs+ySCEX70ix6
        U0jevTWjWKzlMTBSt9EqBh7V/OawRj62Pdrr4ALsqU/DHLAHhd85eTAvr49/PsmP7M4tWZ
        LkQtRB7QwmFj7Mc6FQDoBy6sWhaKAsw=
Received: from localhost.localdomain (fttx-pool-37.60.0.190.bambit.de [37.60.0.190])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id B424B808C6;
        Fri,  7 Aug 2020 08:28:23 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Fri,  7 Aug 2020 10:27:52 +0200
Message-Id: <20200807082754.6790-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Subject: [RFC PATCH 0/2] move/add display relevant nodes to mt7623n

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

