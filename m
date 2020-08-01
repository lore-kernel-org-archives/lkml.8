Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3032087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596244531;
	bh=eJnSwtcYG/GDRX+u074qA+9PbRSURvS8a3Kgpt9UQwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QZOX5ZWYwIG+JA8AyFYwTICJUbCw17RnLVRFjmAONFxw1k1UEmTozujer/pZyDrEa
	 Q1wBdraLzlcpiSGht17278X6jmxzV67IP4ZKcGEaA4Hh3cKwIqjHVdtMXvcewfNbJs
	 Se/6Y26/Ffb3vKooqKV1crxOGtZDm6vKRySeBQvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHABPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgHABOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:54 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428CF2245C;
        Sat,  1 Aug 2020 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244494;
        bh=eJnSwtcYG/GDRX+u074qA+9PbRSURvS8a3Kgpt9UQwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2NQO8Bxj8TdBaXxOzsyID06xvmq7bQeDwwHEX0dslTRVTtKxZgZ8aJSKr4MdmmcZi
         cLmwYxtnr/d49WCe1taKNwzsWqtUhGOFk+sltCNCrVozwJUjDJZRsvrOyxpw1SInaZ
         C2PsGrwMLNKiMwz+eSt9/nrf6LaZ0GacgMlzyuPY=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 09/13] csky: Set CONFIG_NR_CPU 4 as default
Date:   Sat,  1 Aug 2020 01:14:09 +0000
Message-Id: <1596244453-98575-10-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The C860 processors support 4 cores smp for maximum, so set NR_CPU
to 4 as default

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index fd92d73..ad98b93 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -279,7 +279,7 @@ config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
 	depends on SMP
-	default "2"
+	default "4"
 
 config HIGHMEM
 	bool "High Memory Support"
-- 
2.7.4

