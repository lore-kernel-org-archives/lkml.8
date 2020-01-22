Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A8BC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AB120678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699685;
	bh=xDfirEVkKa3S5RImQWGG1TGOLnNlHUP/nL7HMGpbgog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nq4sVDBmZuAdCZVjH9RZ7gfXzUZ0rhdRH00TkYTxnCfaceLCOdAWDS85OLaJGg1RU
	 oXfUJ5eluZOT3rALHOuN/VgO+/SizNd9YD0qlXyI7X6Z0teO922K2XElmy/hw9DVWM
	 Yga8He3hx8j8k4Gwagma3EfARDAE95pa+S+kTb4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAVN2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbgAVN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:28:02 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07029205F4;
        Wed, 22 Jan 2020 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699681;
        bh=xDfirEVkKa3S5RImQWGG1TGOLnNlHUP/nL7HMGpbgog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wn+Zg1xJ3NZ/FSWiePjz+bbcapMuWo590O2ujagrliZ8nDoDfAHXIUKVb8/WJgBCB
         Xm7ouWrqB1cyycs6LCCTe+rhXdWDDXrvTSucT8lEckUcqf9y7dGwVFz5UDVjmnpcAL
         yMwk6SmNOyCDxxdq+08dXUWthhxcqKX4LwiBIV64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.4 190/222] arm64: dts: juno: Fix UART frequency
Date:   Wed, 22 Jan 2020 10:29:36 +0100
Message-Id: <20200122092847.285024823@linuxfoundation.org>
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

From: Andre Przywara <andre.przywara@arm.com>

commit 39a1a8941b27c37f79508426e27a2ec29829d66c upstream.

Older versions of the Juno *SoC* TRM [1] recommended that the UART clock
source should be 7.2738 MHz, whereas the *system* TRM [2] stated a more
correct value of 7.3728 MHz. Somehow the wrong value managed to end up in
our DT.

Doing a prime factorisation, a modulo divide by 115200 and trying
to buy a 7.2738 MHz crystal at your favourite electronics dealer suggest
that the old value was actually a typo. The actual UART clock is driven
by a PLL, configured via a parameter in some board.txt file in the
firmware, which reads 7.37 MHz (sic!).

Fix this to correct the baud rate divisor calculation on the Juno board.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515b.b/DDI0515B_b_juno_arm_development_platform_soc_trm.pdf
[2] http://infocenter.arm.com/help/topic/com.arm.doc.100113_0000_07_en/arm_versatile_express_juno_development_platform_(v2m_juno)_technical_reference_manual_100113_0000_07_en.pdf

Fixes: 71f867ec130e ("arm64: Add Juno board device tree.")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/arm/juno-clocks.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/arm/juno-clocks.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-clocks.dtsi
@@ -8,10 +8,10 @@
  */
 / {
 	/* SoC fixed clocks */
-	soc_uartclk: refclk7273800hz {
+	soc_uartclk: refclk7372800hz {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <7273800>;
+		clock-frequency = <7372800>;
 		clock-output-names = "juno:uartclk";
 	};
 


