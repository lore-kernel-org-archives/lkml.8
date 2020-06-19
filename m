Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B952193E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579092;
	bh=fFGf0BX5UV6jrwH74nzNaDfF4N/fsX/1nVfVZ3eUof4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0XK18i9NZwd1kK1fdNHMQ9rgAHx/zldbdoir71YIfigGqaBMIQWEzfn8ncE1dR9mO
	 ZL4+8/5PaIhdzaaOOibB6ckgvp+R0lNbRLYJlmU4vkEZPhJA8YGmgxzCZfpUWJMTrr
	 LZRXrcFncL6MidCfpbdefkIaQu3D8nQzVwC2wBwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391201AbgFSPEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391191AbgFSPEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B24421841;
        Fri, 19 Jun 2020 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579087;
        bh=fFGf0BX5UV6jrwH74nzNaDfF4N/fsX/1nVfVZ3eUof4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8oJcHZgRa3XULr7m4BMsiPFADoXpgKUev3KlDMAqq/vBeplNYWxRlPQ5isYdOiXV
         ni18u0Eigf3hAXlzhdsjmaKJUuHCQMQCZ75coNjqT16cM9+ArdxaQXCNo84SjiQQrl
         PrrskZWw/xUUGyYS4tq5pkqbzmfk6JoZhD4AM2xQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.19 254/267] ARM: dts: s5pv210: Set keep-power-in-suspend for SDHCI1 on Aries
Date:   Fri, 19 Jun 2020 16:33:59 +0200
Message-Id: <20200619141700.847335784@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
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
@@ -374,6 +374,7 @@
 	pinctrl-names = "default";
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	keep-power-in-suspend;
 
 	mmc-pwrseq = <&wifi_pwrseq>;
 	non-removable;


