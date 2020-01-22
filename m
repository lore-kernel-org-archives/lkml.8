Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F9C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B95B2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686621;
	bh=FwLbWFeFbvdUrH5giB50SJAEdUAePu1BlpASRib3hG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lm7Euh3eTb+MUEs9jr3j5XTQi9vZgaa8RdHOqiDTs9sGaNdXzBUtMJODIhrPR9Rtg
	 dJjE0/FF9UB9OSdFJTC/VvBnI9zsU2oKM8qvOSLAbX2E1CUVJifQnN78pgqq9lSx8g
	 MRwb3GV0x7w89g3OGgJOu6y98toQAEzZFPN0/riA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgAVJic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733027AbgAVJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:38:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D74A2467F;
        Wed, 22 Jan 2020 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685906;
        bh=FwLbWFeFbvdUrH5giB50SJAEdUAePu1BlpASRib3hG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IINMkjGF4qQrSNAUvfXcpZUu5fknQPZKw8WqY3bwWWwvsUneFXRNG3+pQw4NWeC7X
         4NR5o9ww5wpqELbJx+tMhuO/kVJYDmQaeaNqFdP7NY6LB4JyNarHmnLqqn4dAf59rk
         HGFP4uNFvykfe6/3S+UOPyk2gGwo4mlMZULw/4iY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.14 07/65] ARM: dts: am571x-idk: Fix gpios property to have the correct  gpio number
Date:   Wed, 22 Jan 2020 10:28:52 +0100
Message-Id: <20200122092752.331828273@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 0c4eb2a6b3c6b0facd0a3bccda5db22e7b3b6f96 upstream.

commit d23f3839fe97d8dce03d ("ARM: dts: DRA7: Add pcie1 dt node for
EP mode") while adding the dt node for EP mode for DRA7 platform,
added rc node for am571x-idk and populated gpios property with
"gpio3 23". However the GPIO_PCIE_SWRST line is actually connected
to "gpio5 18". Fix it here. (The patch adding "gpio3 23" was tested
with another am57x board in EP mode which doesn't rely on reset from
host).

Cc: stable <stable@vger.kernel.org> # 4.14+
Fixes: d23f3839fe97d8dce03d ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/am571x-idk.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -93,7 +93,7 @@
 
 &pcie1_rc {
 	status = "okay";
-	gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
+	gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
 };
 
 &pcie1_ep {


