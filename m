Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F98C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D322075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596050528;
	bh=im/Skr+RSitv+QS9lfsNu6TQc11/QO3AkE6upmYrxFU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KQz7qzoyLIq6Djc4obwfDjRDh6eYTTakd1ppBv+/aP5/HtCj64+V2sTsoFIZ7kI1H
	 YKV641rNbX7c4NJv/YHWHKK8cofHLQvRlNPrILfO+T5WWcGY7qkQRzhvoMU2TKMT8t
	 pz0u2saL25b4zF1pb656KSN+sm465J6hp8c1lFVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgG2TWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgG2TWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:22:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 728B82068F;
        Wed, 29 Jul 2020 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596050524;
        bh=im/Skr+RSitv+QS9lfsNu6TQc11/QO3AkE6upmYrxFU=;
        h=From:To:Cc:Subject:Date:From;
        b=H5Sp/TLggHLS7KSawOh4ic9cqEe6NVAkbagE+my8U8H/Sk5nouxHydTyuMEEmhWR5
         5+0cIcLFdYgqY703eG/IbFewLe8bwv9jwLYI86XcbSvj4dnx5xOhnn6ocB+K3Bu7Aj
         tjb2N+y7SE0zAwajyQTOSNURotwtP2lYx7rh4soQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>
Subject: [PATCH] MAINTAINERS: Drop Vincent Sanders from Simtec S3C boards
Date:   Wed, 29 Jul 2020 21:21:54 +0200
Message-Id: <20200729192154.7146-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sanders' email bounces with code 550 (user does not exist) so
remove the entry from Simtec S3C24xx boards.

Cc: Simtec Linux Team <linux@simtec.co.uk>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5d7cf3c3aaa..371db77df175 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15819,13 +15819,11 @@ F:	drivers/video/fbdev/simplefb.c
 F:	include/linux/platform_data/simplefb.h
 
 SIMTEC EB110ATX (Chalice CATS)
-M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 S:	Supported
 W:	http://www.simtec.co.uk/products/EB110ATX/
 
 SIMTEC EB2410ITX (BAST)
-M:	Vincent Sanders <vince@simtec.co.uk>
 M:	Simtec Linux Team <linux@simtec.co.uk>
 S:	Supported
 W:	http://www.simtec.co.uk/products/EB2410ITX/
-- 
2.17.1

