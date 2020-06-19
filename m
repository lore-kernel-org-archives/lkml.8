Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3920FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CE221841
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579089;
	bh=lZGs5YKuHh6WGc7H6x/l+k89JKiDGhYKU+t4quqo3c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gl/B7RN7o8FZluhiig7e+6fvJFpULq4CeBdmfQNA+XPtsn5FPUWQXa+eY36KiFfw6
	 QKCOMGV28SIZOrYjI6XfWH2ImS+GZXG3UGwO1rGDM/dk/aBggrx0/AaZ0mfz/alT9O
	 jU/3XkbjsHC6OrfIprTW58STE0Wh904/mdsVBy+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391193AbgFSPEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391175AbgFSPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:04:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D862E21974;
        Fri, 19 Jun 2020 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579079;
        bh=lZGs5YKuHh6WGc7H6x/l+k89JKiDGhYKU+t4quqo3c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWVbMY4dXkoWZzNXBkFNT3J1TU4AF3uu6phZUVnLF2wigLhMC+CgZdUpn132Hm5Z0
         UsqxnbAZtSx7eFkJqp+SLe5x+8uDjvshwy7tsZkKwxVqY/7Yh/Lv9K1MirvTULDbeo
         JK7vT+W3hSJwTwe+cJQQyBqd0cgLPCV2INAb55a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 4.19 251/267] ARM: tegra: Correct PL310 Auxiliary Control Register initialization
Date:   Fri, 19 Jun 2020 16:33:56 +0200
Message-Id: <20200619141700.714765950@linuxfoundation.org>
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

From: Dmitry Osipenko <digetx@gmail.com>

commit 35509737c8f958944e059d501255a0bf18361ba0 upstream.

The PL310 Auxiliary Control Register shouldn't have the "Full line of
zero" optimization bit being set before L2 cache is enabled. The L2X0
driver takes care of enabling the optimization by itself.

This patch fixes a noisy error message on Tegra20 and Tegra30 telling
that cache optimization is erroneously enabled without enabling it for
the CPU:

	L2C-310: enabling full line of zeros but not enabled in Cortex-A9

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-tegra/tegra.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -112,8 +112,8 @@ static const char * const tegra_dt_board
 };
 
 DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
-	.l2c_aux_val	= 0x3c400001,
-	.l2c_aux_mask	= 0xc20fc3fe,
+	.l2c_aux_val	= 0x3c400000,
+	.l2c_aux_mask	= 0xc20fc3ff,
 	.smp		= smp_ops(tegra_smp_ops),
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra_init_early,


