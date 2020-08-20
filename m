Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6865CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3998D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918643;
	bh=Mlre0NfdZn5TVHGLM/JcqLK5nl+zozSKCg2mXww6fb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e2sMVi7cV/55eQ200Zu1JYK3Sa+jRvvlIkmDEv/P4r5e3MYd1D40NUCQhimPU6FiU
	 t2IqXUggJw0tYmQQ2yGi/ztZGL7J7B7DP6WbjbwS+OMuUd8Raab8ZugQ5YeWev23nm
	 KMMH4M4vDamsclZ9xDcOYFqEu3l35DD8+cZ3wmqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgHTKRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgHTKQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:16:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDC020658;
        Thu, 20 Aug 2020 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918606;
        bh=Mlre0NfdZn5TVHGLM/JcqLK5nl+zozSKCg2mXww6fb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TuQzP43rdH/7ZyNkq7BbVc71SbH+VOg1b8JAHmR+zEvjRmuVZeYZnOWhjXoPYRI+V
         3XhoKKl7s2D4cE/HilANZOoqNjdaUM0BdNhZo+dVSEbxSyh0Rofhsz4ofZaZt2fDZy
         Bk2GAcQELsYw+BRv0B6WxLAQClheZupDW58lqc6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rich Felker <dalias@libc.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 220/228] sh: landisk: Add missing initialization of sh_io_port_base
Date:   Thu, 20 Aug 2020 11:23:15 +0200
Message-Id: <20200820091618.505578616@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0c64a0dce51faa9c706fdf1f957d6f19878f4b81 ]

The Landisk setup code maps the CF IDE area using ioremap_prot(), and
passes the resulting virtual addresses to the pata_platform driver,
disguising them as I/O port addresses.  Hence the pata_platform driver
translates them again using ioport_map().
As CONFIG_GENERIC_IOMAP=n, and CONFIG_HAS_IOPORT_MAP=y, the
SuperH-specific mapping code in arch/sh/kernel/ioport.c translates
I/O port addresses to virtual addresses by adding sh_io_port_base, which
defaults to -1, thus breaking the assumption of an identity mapping.

Fix this by setting sh_io_port_base to zero.

Fixes: 37b7a97884ba64bf ("sh: machvec IO death.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/mach-landisk/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index f1147caebacf0..af69fb7fef7c7 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -85,6 +85,9 @@ device_initcall(landisk_devices_setup);
 
 static void __init landisk_setup(char **cmdline_p)
 {
+	/* I/O port identity mapping */
+	__set_io_port_base(0);
+
 	/* LED ON */
 	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
 
-- 
2.25.1



