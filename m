Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063E9C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F22217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="aClxP9hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgBEWsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:48:42 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57964 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBEWsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:48:41 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E20FD5C406B;
        Wed,  5 Feb 2020 23:48:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580942919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=tBtu8B42mNFXo0ApOnr9YHTy4lOe3v9EM8sVU3KDriA=;
        b=aClxP9hOfUae4u21PzuVsB8WUA5RhBSd/UM7Hdz/J/PN726NUE724SUfRo3AA5aAZwuBFB
        jOLf+ZLjSGCoSjOX9EpAxTp5ACzwciMrYTQRhJ7MexzyPhJ0LDB3R7FoNAYU3qh1X2ytKv
        lssJthU0irgBNngOpDmgM9c3KOxmClo=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, linus.walleij@linaro.org, akpm@linux-foundation.org,
        nsekhar@ti.com, mchehab+samsung@kernel.org,
        bgolaszewski@baylibre.com, armlinux@m.disordat.com,
        benjamin.gaignard@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] arm: make kexec depend on MMU
Date:   Wed,  5 Feb 2020 23:43:44 +0100
Message-Id: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

arm nommu config with KEXEC enabled doesn't compile
arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
use in this function)
             crash_size, SECTION_SIZE);

since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
over one year without anybody noticing. I have only noticed beause of
my testing nommu config which somehow gained CONFIG_KEXEC without
an intention. This suggests that nobody is actually using KEXEC
on nommu ARM configs. It is even a question whether kexec works with
nommu.

Make KEXEC depend on MMU to make this clear. If somebody wants to enable
there will be probably more things to take care.

Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96dab76da3b3..59ce8943151f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1906,6 +1906,7 @@ config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
 	depends on (!SMP || PM_SLEEP_SMP)
 	depends on !CPU_V7M
+	depends on MMU
 	select KEXEC_CORE
 	help
 	  kexec is a system call that implements the ability to shutdown your
-- 
2.25.0

