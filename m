Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D497AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CAD206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580986;
	bh=tdnXPkzzN60g0ORiSgP4WZO2FES1YL776lnidbC0W1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z5bhW0i+VB2jUoq1IQ7KltFXtLWedpun2FZJHTHxLYqqMv+NSJAjqXGqYZZm/6G0v
	 QxSpsbGhXX24PHrabZQULO/kOorZRQVaK892+5cWjFJCBAzhJevS0uT3k50hh1j9c9
	 NIGRyf4KeHvdY0gN4ryh1/ynxB7QTgUKPj4TteD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405066AbgFSPgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404826AbgFSPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A0821973;
        Fri, 19 Jun 2020 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580653;
        bh=tdnXPkzzN60g0ORiSgP4WZO2FES1YL776lnidbC0W1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5cptoJ1pZQnLsYIv1pu89PlMWN7IymBZS3mbBaOlqADPP/wZ1Xwkerqm9gE9by6a
         jPoVMMGyFsvLisM9YFodXr2f9qxJyMPKTLe+uaiRY2BfWMWnWQLsoTd2wv4CM+nWfn
         bYNpr7wfroBPTrCJSFemdgxKfyj0RSJ68j4jh1ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.7 331/376] ARM: tegra: Correct PL310 Auxiliary Control Register initialization
Date:   Fri, 19 Jun 2020 16:34:09 +0200
Message-Id: <20200619141726.000022172@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
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
@@ -107,8 +107,8 @@ static const char * const tegra_dt_board
 };
 
 DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
-	.l2c_aux_val	= 0x3c400001,
-	.l2c_aux_mask	= 0xc20fc3fe,
+	.l2c_aux_val	= 0x3c400000,
+	.l2c_aux_mask	= 0xc20fc3ff,
 	.smp		= smp_ops(tegra_smp_ops),
 	.map_io		= tegra_map_common_io,
 	.init_early	= tegra_init_early,


