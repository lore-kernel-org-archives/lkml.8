Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83495C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623C821473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941472;
	bh=3tC9DxM18mKL+1U6l7Oo5Sr5fzZeZQoNICJo4BJT8sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBkpwaYPGcRF2WdNqYUKdyP3Et1F8youYrejAgc+JpZg+vi9d0e0uWdi/FxiUxQ94
	 QQK1WBZx//I9Uy4pAz670RK1PEQX9WsQjSB5XLsZ007SNJCgbLF1K+HDt8l7eVvkGl
	 O9vWeGshP9eaB2tvcxPE0h38ZpnZIX3svQ8DeATI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEHMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgEHMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E21921473;
        Fri,  8 May 2020 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941464;
        bh=3tC9DxM18mKL+1U6l7Oo5Sr5fzZeZQoNICJo4BJT8sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mNd8FWhNMNYCVSrDN4aqShWdmC8HTVAHRqQ/NcLWQyceHeCDw2Bh+PoKFU++NrRxS
         +SkZrutS2zFYF3817rIjmURr1UKglapyvpBoEBHwOxrA/2GFyOiCCyIvBe10alYdo9
         2GP0Bof5D+B5gbPxzh6Xw5nR4VBtbjgECgSo1jW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 042/312] ARM: dts: kirkwood: use unique machine name for ds112
Date:   Fri,  8 May 2020 14:30:33 +0200
Message-Id: <20200508123127.515499494@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit 9d021c9d1b4b774a35d8a03d58dbf029544debda upstream.

Downstream packages like Debian flash-kernel use
/proc/device-tree/model
to determine which dtb file to install.

Hence each dts in the Linux kernel should provide a unique model
identifier.

Commit 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS
devices") created the new files kirkwood-ds111.dts and kirkwood-ds112.dts
using the same model identifier.

This patch provides a unique model identifier for the
Synology DiskStation DS112.

Fixes: 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS devices")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/kirkwood-ds112.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/kirkwood-ds112.dts
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -14,7 +14,7 @@
 #include "kirkwood-synology.dtsi"
 
 / {
-	model = "Synology DS111";
+	model = "Synology DS112";
 	compatible = "synology,ds111", "marvell,kirkwood";
 
 	memory {


