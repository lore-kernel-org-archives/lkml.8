Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4525C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E93720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608443;
	bh=EZnF+QuJO+sub9/aDn4PIsMh2MpwJZKmxruzUZa2+uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L7q1jZRMZzQer2uGClo0tLzCibxxd06rPaJuNnRY0fluRXy5to37LeK5D2vniGVkp
	 8I9PC7f4fs27l+WC387Ar1Sp3q8sWrCn3ubDWSIcqldp7oG6H2Rz1nJxAo3MErRAQS
	 lww+Rm/spooEVtuZpNSm2bOLF3jcsiloUWdJlP0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgBMPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgBMP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:39 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FC3206DB;
        Thu, 13 Feb 2020 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607719;
        bh=EZnF+QuJO+sub9/aDn4PIsMh2MpwJZKmxruzUZa2+uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNVZCv4QqOYRz1oaZRfaNICqHgbWdWyEMhlcaK1oBvCPl4jPlG6H5rkPcg/i8lIFZ
         1ewotJVxWGVQaYPQs9DF2KAJ2pn0mvWHDplbomvjTk1rB0I21QknmBU4fAQnHW0s/q
         L6QwyuKqDY41nsOw95Mhn+sWy8Eg2iuWxqm+ZGe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Denis Odintsov <d.odintsov@traviangames.com>,
        Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 5.5 061/120] arm64: dts: marvell: clearfog-gt-8k: fix switch cpu port node
Date:   Thu, 13 Feb 2020 07:20:57 -0800
Message-Id: <20200213151922.185020505@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

commit 62bba54d99407aedfe9b0a02e72e23c06e2b0116 upstream.

Explicitly set the switch cpu (upstream) port phy-mode and managed
properties. This fixes the Marvell 88E6141 switch serdes configuration
with the recently enabled phylink layer.

Fixes: a6120833272c ("arm64: dts: add support for SolidRun Clearfog GT 8K")
Reported-by: Denis Odintsov <d.odintsov@traviangames.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -408,6 +408,8 @@
 				reg = <5>;
 				label = "cpu";
 				ethernet = <&cp1_eth2>;
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
 			};
 		};
 


