Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CB420678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699728;
	bh=FSufJe/sjqbSMKxrhxnXPFZKTDBgBvYFuYHtCrwzH5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BBO5urw1n2BA51AmxYBLMgOw//OHKDtCnOyF1KA+mnjTZh/34WWUF50WL/EtNTmwP
	 MmbFH5vM7pp5KvlwZYf/BxGuNmh/pvwsS0wabOBqNRxZYE03NXQvUVM+j3EP5G+eRc
	 bqV6VLUG7M9fDG0MzHzt9zzJGT7F1k8dboiV2PB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgAVN2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgAVN2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:28:43 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A0B205F4;
        Wed, 22 Jan 2020 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699722;
        bh=FSufJe/sjqbSMKxrhxnXPFZKTDBgBvYFuYHtCrwzH5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vi8EU1zqocA+LIAIfuabm/eCuUkzp9UqJKBF6QrAEqUgw3jWrIwtJHsoqbh58L4j6
         5el8ytRW8YMUwKViOLtRfgwZIimWvoxcrE0Uh+T+XPVuSNEFzVIMuMc5H5boUuNOse
         ku1BdEA39NQOpPlRk0i9QmmmR06OE/DLAT4UKZC4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 187/222] ARM: dts: imx6ul-kontron-n6310-s: Disable the snvs-poweroff driver
Date:   Wed, 22 Jan 2020 10:29:33 +0100
Message-Id: <20200122092847.076128270@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

commit 0ccafdf3e81bb40fe415ea13e1f42b19c585f0a0 upstream.

The snvs-poweroff driver can power off the system by pulling the
PMIC_ON_REQ signal low, to let the PMIC disable the power.
The Kontron SoMs do not have this signal connected, so let's remove
the node.

This fixes a real issue when the signal is asserted at poweroff,
but not actually causing the power to turn off. It was observed,
that in this case the system would not shut down properly.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
@@ -157,10 +157,6 @@
 	status = "okay";
 };
 
-&snvs_poweroff {
-	status = "okay";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;


