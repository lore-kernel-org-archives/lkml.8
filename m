Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FCBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05441206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="lvimm1m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgGGWbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgGGWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:31:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90397C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 15:31:32 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CE3C122FA7;
        Wed,  8 Jul 2020 00:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594161091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVcDcSkmskzhtWuWZmwqnLcCdDe2UyqfbALJnlgER2k=;
        b=lvimm1m2PY9PkbJZZqwE8ahtwGb4bCSl/RyhjQR9VnUblPOhCDqcD3N5NSBG/pfjkTQUrJ
        OAqsIn827m4Uxl2m15VoXWqm4maYLQmcSfwQ8k2ORUh2ByoTbuGNvKb+ecu3WXcSUCBH1K
        aAG5Q2kgJmVK0whcViRnXoMwU4UMp0U=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: defconfig: enable CONFIG_FSL_ENETC_QOS
Date:   Wed,  8 Jul 2020 00:31:13 +0200
Message-Id: <20200707223114.16355-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707223114.16355-1-michael@walle.cc>
References: <20200707223114.16355-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the needed network scheduler, we can enable the ENETC
hardware support.

$ scripts/bloat-o-meter old-vmlinux vmlinux
add/remove: 19/2 grow/shrink: 12/0 up/down: 12852/-16 (12836)
[..]
Total: Before=20428273, After=20441109, chg +0.06%

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0aeb9971e086..cc2cbea8e3a8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -304,6 +304,7 @@ CONFIG_FSL_DPAA_ETH=y
 CONFIG_FSL_DPAA2_ETH=y
 CONFIG_FSL_ENETC=y
 CONFIG_FSL_ENETC_VF=y
+CONFIG_FSL_ENETC_QOS=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
-- 
2.20.1

