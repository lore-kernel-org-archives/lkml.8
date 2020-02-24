Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEFC35DE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F3120732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgBXXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:31:50 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33299 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgBXXbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHS1d3Gz9sQt; Tue, 25 Feb 2020 10:31:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587108;
        bh=dgwevY/cbVBUKvHBjKo8eRwTGaVpoR07XLgC87drZAs=;
        h=From:To:Cc:Subject:Date:From;
        b=OlLvd/khE22BvAY7FkF1axztd0x6G5QdCblYJx6mhD2FFaXz0Nte1soEfRJvZmUUB
         Tcsm8tmBQq8uY0+8acHI97OQMBfj3nMij37tUBjUUus30ciwBaOCXWNbFltiiZ4fGG
         Itdx7yFMSQb6CwFonqg7wvSKQxqM3W0G0kyoBPrP+IONe8JP+Mj1fcKjHCz3S2Tg+2
         1Nz8t5vLXwmctNMU+Jms2l99/b5nxQ5fBAQJES5+Bcv4QkfNbv2dO/cNXrcJIdLX5C
         OfTMOGfqriVzjaL2WDwrJn72xlGK6AzExIMDEQD9wj8K+bfDNTf8HQAKwRmWdAPAry
         jXRTDNk+j8V4g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/8] powerpc: Update MAINTAINERS
Date:   Tue, 25 Feb 2020 10:31:39 +1100
Message-Id: <20200224233146.23734-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A while back Paul pointed out I'd been maintaining the tree more or
less solo for over five years, so perhaps it's time to update the
MAINTAINERS entry.

Ben & Paul still wrote most of the code, so keep them as Reviewers so
they still get Cc'ed on things. But if you're wondering why your patch
hasn't been merged that's my fault.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc38928..339bc3e53862 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9601,9 +9601,9 @@ F:	arch/powerpc/platforms/powermac/
 F:	drivers/macintosh/
 
 LINUX FOR POWERPC (32-BIT AND 64-BIT)
-M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
-M:	Paul Mackerras <paulus@samba.org>
 M:	Michael Ellerman <mpe@ellerman.id.au>
+R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
+R:	Paul Mackerras <paulus@samba.org>
 W:	https://github.com/linuxppc/linux/wiki
 L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
-- 
2.21.1

