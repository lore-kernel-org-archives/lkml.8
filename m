Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AC7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A5120656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262035;
	bh=UmVLrulrz7y0vsYi+sucxUOxaw1JJyO9h46ojzPoEiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qp2LACPl5llbCB1j5e/80W5WLo+J2i6Q3y8CPzU4wVh5j0wQJvmaTk/9bBZbXjmhP
	 bG+KRa/kmfXAwt6B8iCQvG0yu9nu80ATqDZB6E+DMP+VhQv8en2EXprXEknkmYLcsA
	 RH6nxrrxMoZg6RdwhXLDJ+uv8gCS5UXVodVvO3lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgGTQUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387601AbgGTQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:09:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57D62064B;
        Mon, 20 Jul 2020 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261398;
        bh=UmVLrulrz7y0vsYi+sucxUOxaw1JJyO9h46ojzPoEiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+672YuBVz09QDbPEDw2BeqS8EvzL8Km3zzs+5rvj5SN2VaNASXcKRuMl3CDibxB9
         7TmlNZJV6ReIRFsrrim2nQRFUrCgXtHFt6hltLcyOeAz02sLtv9647vPFHTBswj1YO
         eqIAN4gY/YHwnru3nnJFne7ZhToABLuoBzxiewHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 101/244] clk: mvebu: ARMADA_AP_CPU_CLK needs to select ARMADA_AP_CP_HELPER
Date:   Mon, 20 Jul 2020 17:36:12 +0200
Message-Id: <20200720152830.636548955@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 8e3709d7e3a67e2d3f42bd1fc2052353a5678944 ]

When building arm32 allmodconfig:

ld.lld: error: undefined symbol: ap_cp_unique_name
>>> referenced by ap-cpu-clk.c
>>>               clk/mvebu/ap-cpu-clk.o:(ap_cpu_clock_probe) in archive drivers/built-in.a

ap_cp_unique_name is only compiled into the kernel image when
CONFIG_ARMADA_AP_CP_HELPER is selected (as it is not user selectable).
However, CONFIG_ARMADA_AP_CPU_CLK does not select it.

This has been a problem since the driver was added to the kernel but it
was not built before commit c318ea261749 ("cpufreq: ap806: fix cpufreq
driver needs ap cpu clk") so it was never noticed.

Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lore.kernel.org/r/20200701201128.2448427-1-natechancellor@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index ded07b0bd0d5e..557d6213783c7 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -42,6 +42,7 @@ config ARMADA_AP806_SYSCON
 
 config ARMADA_AP_CPU_CLK
 	bool
+	select ARMADA_AP_CP_HELPER
 
 config ARMADA_CP110_SYSCON
 	bool
-- 
2.25.1



