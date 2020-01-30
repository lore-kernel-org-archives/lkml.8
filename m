Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F83220708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412034;
	bh=pBbkWger8tZjIN0c+USbxlCHm4Vvwu2dG1OSnPeHvY0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QMPdmAFYop7daj2claPjduakqnjXmYU/W1Bx0lryazQfJQ9zkHftqHwMXoQTAo6g/
	 SkxfGNqTNN8rgMdvsSnVjB+1RhCsu00jJ/lqbLlh2EWxOlk3gv0Q3p/GQ+BdBiZmlf
	 NY2UcTQDRZCiCVeHW/cbifbxq3Z/phjmt4hM626A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgA3TUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbgA3TUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:20:33 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A62A206D3;
        Thu, 30 Jan 2020 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412032;
        bh=pBbkWger8tZjIN0c+USbxlCHm4Vvwu2dG1OSnPeHvY0=;
        h=From:To:Cc:Subject:Date:From;
        b=eEO2o50Ip+plgetOYoMDcGok1zn+2ob77Wo/zFSQy2znxEEoPy9B2jhpPWICzglQW
         +I0jSfdG+DHg8Dk7nLieFqBTJRlBSj5pElJLheQzdiTDDFPKrFDJzVIvovciKfZxIW
         BPsbWsT7g4heQgk2yfbzX147uBFfHJjhmdWCWjis=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] nds32: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Thu, 30 Jan 2020 20:20:24 +0100
Message-Id: <20200130192024.2516-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/nds32/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
index 40313a635075..f9a89cf00aa6 100644
--- a/arch/nds32/configs/defconfig
+++ b/arch/nds32/configs/defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="nds32le-linux-"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
2.17.1

