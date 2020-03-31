Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783462072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645923;
	bh=xy8516SMD+EvkSyeDBZZ3E4unrF2w9SV3kJ/1usvzvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZwxRaBKDQhzWovG4LxH0GZ+pecEin3whpO8koiapPHV8rIGw1OO2wagPFaUlsI0S
	 jRam8FtE5mFdKrmlmoesRX4OrFAXEjT+KKqOJhr9UkL/PD6K6jGpV3hhPsJFG9RZH3
	 hAVeUmtnpbujj2zSOW5ViMgL5ehcSe3zgAIhQjo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgCaJMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgCaJLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B47020772;
        Tue, 31 Mar 2020 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645910;
        bh=xy8516SMD+EvkSyeDBZZ3E4unrF2w9SV3kJ/1usvzvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXxDoXOxd2zPIGlgnvBRAwB8a/QsLEEZ2zyIoD0EHLRe5n/1I3VmIQ/bvzezv1FmK
         QroCbzxQj5lJwX47pmx2S6mjVvu9FzM98BFWJTTWp4jWUV2YdnP/7yLO7xkJ14RFdt
         OGtcgwfpmcZxtWoydQLGmwYeTL4PYe+BvEwOvvoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 033/155] r8169: re-enable MSI on RTL8168c
Date:   Tue, 31 Mar 2020 10:57:53 +0200
Message-Id: <20200331085422.107956996@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit f13bc68131b0c0d67a77fb43444e109828a983bf ]

The original change fixed an issue on RTL8168b by mimicking the vendor
driver behavior to disable MSI on chip versions before RTL8168d.
This however now caused an issue on a system with RTL8168c, see [0].
Therefore leave MSI disabled on RTL8168b, but re-enable it on RTL8168c.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1792839

Fixes: 003bd5b4a7b4 ("r8169: don't use MSI before RTL8168d")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6812,7 +6812,7 @@ static int rtl_alloc_irq(struct rtl8169_
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		rtl_lock_config_regs(tp);
 		/* fall through */
-	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
 		flags = PCI_IRQ_LEGACY;
 		break;
 	default:


