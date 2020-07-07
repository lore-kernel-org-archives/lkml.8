Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F28C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC202206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="YZEOK9JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgGGWbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:31:32 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53513 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgGGWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:31:32 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EA2DD22723;
        Wed,  8 Jul 2020 00:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594161090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/uH5LVCD2f9ksp83Amofj282y55+pudcW4fgiuCHQE4=;
        b=YZEOK9JNEKRH3b3/6WjZ4kWOC6WJg95FuzdEfb9DrBYZdVXgS3LP8IdejiBLmt4RZvjiRE
        aYs2hFlIxidEC8ir6EGy9oqYIjCyz8J+tZ405vJ4Tcq5AlqFjjNZyx1W8LcN8aFIovJtIW
        pzPnBYC08kesvBhzzhvIhQN8ew+jSvU=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] arm64: defconfig: enable TSN features for ENETC and similiar hardware
Date:   Wed,  8 Jul 2020 00:31:12 +0200
Message-Id: <20200707223114.16355-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer network cards and switches support offloading of certain packet
scheduling, classifying and actions onto the hardware itself. For
example, time-aware and credit based schedulers. To use this feature we
have to enable the corresponding modules. Please note, that this will
also enable NET_SCHED and NET_CLS_ACT as builtin because there is no
module option. The enabled modules should get us a good foundation.

$ scripts/bloat-o-meter old-vmlinux vmlinux
add/remove: 446/215 grow/shrink: 48/31 up/down: 78445/-11519 (66926)
[..]
Total: Before=20452567, After=20519493, chg +0.33%

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/configs/defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e38486b836f4..0aeb9971e086 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -162,6 +162,18 @@ CONFIG_NET_DSA=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
+CONFIG_NET_SCHED=y
+CONFIG_NET_SCH_CBS=m
+CONFIG_NET_SCH_ETF=m
+CONFIG_NET_SCH_TAPRIO=m
+CONFIG_NET_SCH_MQPRIO=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_ACT_GACT=m
+CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_GATE=m
 CONFIG_QRTR=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
-- 
2.20.1

