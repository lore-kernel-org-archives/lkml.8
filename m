Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BF0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675B821582
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758248;
	bh=L+Ikupj+IFEDs2uQWYss5cx/n2qJx75URb+/NaeoKVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmlyLuvAKICVACN+7znREpbo3ixNxK5h9FmppLVFegv60nfXKuDz95TI++oJ3Fisx
	 dN+qWLLXRgui+9oRU/6L6XrhzZY0V+qIdAPGRS/7bkbKLuLeqjT+jxMxfZHa6PX9H9
	 iMk+RxHAXmD58E/+eg03dUFoHBn6BnTO7hraC7/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgDAQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbgDAQYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:24:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7702921556;
        Wed,  1 Apr 2020 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758238;
        bh=L+Ikupj+IFEDs2uQWYss5cx/n2qJx75URb+/NaeoKVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oucIUFlfQxqs2HJ5FzfSxIJoWpurBx/qM7G1hWuJKXLW8AjIW90YuFTLrL8AtnHlG
         diX/3DXxA6ux3nK3RtrQHutQd/9NXPqmOtulAccZrNDkmunX1D2IQLi8Hnzj8TB0YK
         Qsqp3ZgKdhnccXTStkKj5ozmiJBSowW/WrAaRv3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 027/116] r8169: re-enable MSI on RTL8168c
Date:   Wed,  1 Apr 2020 18:16:43 +0200
Message-Id: <20200401161545.844314694@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
 drivers/net/ethernet/realtek/r8169.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7249,7 +7249,7 @@ static int rtl_alloc_irq(struct rtl8169_
 		RTL_W8(tp, Config2, RTL_R8(tp, Config2) & ~MSIEnable);
 		RTL_W8(tp, Cfg9346, Cfg9346_Lock);
 		/* fall through */
-	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
 		flags = PCI_IRQ_LEGACY;
 		break;
 	default:


