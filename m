Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CABDC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343C82076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gf0FiKG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgDGUHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:07:01 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42014 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726760AbgDGUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:07:00 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86FF2C009F;
        Tue,  7 Apr 2020 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586290020; bh=NrhHNH3f+3FQE+9DPc/+IuZm7ze9b7W1iIHaLrTu378=;
        h=From:To:Cc:Subject:Date:From;
        b=gf0FiKG7/WzEnZJtMc01f2npq2NV+VghtZTUbh/WVkUVfxtNQgKcClL5XCcbDwoHF
         1JEvvYP99/aJekihiIdW2egHnEA4ZUyxfcrG7doJcvm35oZtOdHpAP18aVFu4FGFE0
         Z+FP+1HpYAN/qnXPtiRKk2YPXpfooGLcoN2WeMj/xDOaeQAvAaFJuhewMUHs7U4vxV
         bmkO6eFZFoxgoErVyoQV7veLl6qRecAQWt8wu5Vc5Pk8eiA3n9zm1PvZXg5SbXJgTB
         yg/n1q8GS5tzI1jzGTUb6IrhWnGamqC8mD81W3QwCh0cY4HOANz5bLNT5hJ5O0ot2s
         y1WCjCyQICkLw==
Received: from paltsev-e7480.internal.synopsys.com (ru20-e7250.internal.synopsys.com [10.225.49.23])
        by mailhost.synopsys.com (Postfix) with ESMTP id 35A64A005C;
        Tue,  7 Apr 2020 20:06:54 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: [plat-hsdk]: fix USB regression
Date:   Tue,  7 Apr 2020 23:06:42 +0300
Message-Id: <20200407200642.12749-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today the CONFIG_USB isn't explicitly present in HSDK defconfig
as it is implicitly forcibly enabled by UDL driver which selects CONFIG_USB
in its kconfig.
The commit 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
reverse the dependencies between UDL and USB so UDL now depends on
CONFIG_USB and not selects it. This introduces regression for ARC HSDK
board as HSDK defconfig wasn't adjusted and now it misses USB support
due to lack of CONFIG_USB enabled.

Fix that.

Cc: <stable@vger.kernel.org> # 5.6.x
Fixes: 5d50bd440bc2 ("drm/udl: Make udl driver depend on CONFIG_USB")
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * fix typo, add tag for stable

 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 0974226fab55..aa000075a575 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -65,6 +65,7 @@ CONFIG_DRM_UDL=y
 CONFIG_DRM_ETNAVIV=y
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.21.1

