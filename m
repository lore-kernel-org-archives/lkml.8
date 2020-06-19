Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E72C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B6C20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580973;
	bh=F56PYJf7LzlvOVbm708My6zGxN14mmdq2iquiOLJAwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kgr1lTenAjLcn1NUlRDPqmZEpiEochsFFdDqEj7om2GWKmij/x1dTSpqieAXKsD+N
	 Exbue297n4A/lHpwRdWYbHohQD3bOIp5H2HLqVuMe5n16nrkPuq5ze+mbVp3tQ/h8o
	 bTurqFkMzDSNogqhKuCueb6K2WT9qvpYS1vdTMcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405055AbgFSPgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393776AbgFSPbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1663E20757;
        Fri, 19 Jun 2020 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580666;
        bh=F56PYJf7LzlvOVbm708My6zGxN14mmdq2iquiOLJAwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM3Q7qXsOjD7gG0lK5SSLZE7c+TfHNZKdUy1pD4RSQ7Cz5trrynH+ydSLqH5Uy6g+
         Q29xqTChVp1XNicRB8Ym02pZ9FHK2+XyVgGinTAJSAgYSJG2LCU7A8Q8z0Dhik8d8o
         OSAzWcq7SmyO1SWrf2MMxX9wqErRj4Ao1rcVlh9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.7 336/376] ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on Aries
Date:   Fri, 19 Jun 2020 16:34:14 +0200
Message-Id: <20200619141726.237940532@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

commit 869d42e6eba821905e1a0950623aadafe1a6e6d3 upstream.

SDHCI1 is connected to a BCM4329 WiFi/BT chip which requires
power to be kept over suspend.  As the surrounding hardware supports
this, mark it as such.  This fixes WiFi after a suspend/resume cycle.

Fixes: 170642468a51 ("ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/s5pv210-aries.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -454,6 +454,7 @@
 	pinctrl-names = "default";
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	keep-power-in-suspend;
 
 	mmc-pwrseq = <&wifi_pwrseq>;
 	non-removable;


