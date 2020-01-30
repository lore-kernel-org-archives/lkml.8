Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CEFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CB4206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412078;
	bh=JjNDVJm+v6HWDhnhInttXBEV3fn14//iNMHEewyjbmU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n3NlLYFmoq3q2TcESY+AGljDqydjoalbY9WRhE0ewQMexdUIi2xwDybyuCHsTHJP4
	 gOjN3G9AS2dDZyBdIsjlInWrZrpUw5SFQOspZBkEN9QUh+RN7R8RR6GwobIOh6WsL5
	 z1GttcFYCDwX3SMD99e6/vfVbGxxtrLCriT+hpZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgA3TVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbgA3TVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:21:17 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D290206D3;
        Thu, 30 Jan 2020 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412076;
        bh=JjNDVJm+v6HWDhnhInttXBEV3fn14//iNMHEewyjbmU=;
        h=From:To:Cc:Subject:Date:From;
        b=zUmQ+u4BkxmGfeOUI8WwSq1SbFxKIzuVcQaChR/h+kuMhEOOTvdcM9xpu+Js6fyVl
         zWj8QwJmW3aG0X2Er9ohpGLt/sFBJOl2cUOORIaxy94VkR39YS+Xnjlt+JKO1407UU
         NamPrJp2f/FJy/YwpNX64fGSrKoPW+6puX+eFc3A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] hexagon: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Thu, 30 Jan 2020 20:21:10 +0100
Message-Id: <20200130192110.2605-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/hexagon/configs/comet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..9e0da536c0c6 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -2,7 +2,6 @@ CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
-- 
2.17.1

