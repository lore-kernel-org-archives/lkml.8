Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96AAD206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725510;
	bh=OwzI0aRK/h+F2kEP/UMIb+22nVLukoXCw8gc0x42/Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gr+UJe0WOph4GOhoflkqfMV9DW8UVr4mVbds5PWeczU9ONmL7nwuS6nGos/CM/hZg
	 QcreUsFYde8E73AxPaB5X2bs/UTrdrtW0K4u6TuACFvtrZ74j3MoiJfKcR+1x8+QXs
	 VntfiskblT13MuwnIhy0TwHy3AVgfoR0QTrNyjc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgFIR61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733235AbgFIRzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4FD420734;
        Tue,  9 Jun 2020 17:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725323;
        bh=OwzI0aRK/h+F2kEP/UMIb+22nVLukoXCw8gc0x42/Tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhvQ4WK+0agroZSzLtw2tCe2bvkahMg0g+oDh5BB7Lg9tsWnDBPjXcqdLxdIoRBXd
         sz9Fl20MEaMLaMiwbUIJevpg4wZ7j1BaDpUcdWnc0EwsccxhYJHqxakxPr4jgliegb
         w3BP9PRKe6s9+YH+p0If9nyStJYDDITP745CnTjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 5.7 13/24] serial: 8250: Enable 16550A variants by default on non-x86
Date:   Tue,  9 Jun 2020 19:45:44 +0200
Message-Id: <20200609174150.415424984@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Triplett <josh@joshtriplett.org>

commit 15a3f03d5ec0118f1e5db3fc1018686e72744e37 upstream.

Some embedded devices still use these serial ports; make sure they're
still enabled by default on architectures more likely to have them, to
avoid rendering someone's console unavailable.

Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reported-by: Maxim Kochetkov <fido_max@inbox.ru>
Fixes: dc56ecb81a0a ("serial: 8250: Support disabling mdelay-filled probes of 16550A variants")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Link: https://lore.kernel.org/r/a20b5fb7dd295cfb48160eecf4bdebd76332d67d.1590509426.git.josh@joshtriplett.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -63,6 +63,7 @@ config SERIAL_8250_PNP
 config SERIAL_8250_16550A_VARIANTS
 	bool "Support for variants of the 16550A serial port"
 	depends on SERIAL_8250
+	default !X86
 	help
 	  The 8250 driver can probe for many variants of the venerable 16550A
 	  serial port. Doing so takes additional time at boot.


