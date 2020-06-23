Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F16C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90D52078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948647;
	bh=ZY0ExcuG9r4DZ3x+ypWUTpri90Go+Mb9v+s8BPYLiTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vMmkhemZy11l9Elj6MM5dfjoKSKtZzMiWtgCq1tsOv6oLBB8ac6Hm26UJ6jphZy/S
	 JspunpM+1j21zQdgHayqhfrBlLVwmWgezFJrdtbrLzZCJ9d/uc49JfWA2U4QpInciL
	 vxOzYXNsiwxsYXCkDCAgpQh3XYD4fmjDuy+PTbUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgFWUCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387895AbgFWUCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F692137B;
        Tue, 23 Jun 2020 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942563;
        bh=ZY0ExcuG9r4DZ3x+ypWUTpri90Go+Mb9v+s8BPYLiTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fquf2UulqVTjxWiwODl4E6U+mIcRkEuoonlUEgOs59512ArdlaMFlWuTmdsd+OUsC
         ec56pHZHWaPYeqEIN60oKqO69nSpFuUDE8swM8/wVarCV1gMF72yRd26P2VGaWPAEB
         iKApkpCO28r4cK2jUWs4rFVQG8Z42DMkSQxXwg28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 048/477] arm64: dts: armada-3720-turris-mox: fix SFP binding
Date:   Tue, 23 Jun 2020 21:50:45 +0200
Message-Id: <20200623195409.880526983@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

[ Upstream commit c2671acbbbd822ef077cc168991e0a7dbe2172c9 ]

The sfp compatible should be 'sff,sfp', not 'sff,sfp+'. We used patched
kernel where the latter was working.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 47fee66c70cbc..0e0491ca2930d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -95,7 +95,7 @@
 	};
 
 	sfp: sfp {
-		compatible = "sff,sfp+";
+		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
 		los-gpio = <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpio = <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
-- 
2.25.1



