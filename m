Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31BFA206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944278;
	bh=zRJLePaQ3ENRoQlS1Yj61UK3T4FdMPdUtgqv3iygGH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XX5ZUPNzZlhuOlBYpqv6CmlG/8mncOtj546Tsa2gvFogL7vwQd6plJNv7HcKWuSUC
	 IkdSgfbDJczHJ28DFUs0ICniM5tJwTgHPY+GVziK/Ex7iYvdz7R78DCeaoztQ5aM9t
	 vvMYPTPVb9i1UgckS8qVJrSgswcZnQ6Tjb4MTR/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgFWUbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391187AbgFWUbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:31:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC94206C3;
        Tue, 23 Jun 2020 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944266;
        bh=zRJLePaQ3ENRoQlS1Yj61UK3T4FdMPdUtgqv3iygGH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybGjK/xw879PfaoNQaUrf+jGpF+9tLA+ZqemMbQ3So9yw3qLl+BCjMUwxQXVl5nAK
         ruHM5yTbTLEQ7+u0czUIipJQheQ3GDvoowQbMxuzmvTKc5Og8TkfdRVrxkCJ3+7wqb
         zwDCaUxBtLf70L5bL+5TirFbKuoQTPWKRrDGR6K8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Max Staudt <max@enpas.org>, Wolfram Sang <wsa@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 238/314] i2c: icy: Fix build with CONFIG_AMIGA_PCMCIA=n
Date:   Tue, 23 Jun 2020 21:57:13 +0200
Message-Id: <20200623195350.312495911@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Staudt <max@enpas.org>

[ Upstream commit cdb555397f438592bab00599037c347b700cf397 ]

This has been found by the Kernel Test Robot:
http://lkml.iu.edu/hypermail/linux/kernel/2006.0/06862.html

With CONFIG_AMIGA_PCMCIA=n, io_mm.h does not pull in amigahw.h and
ZTWO_VADDR is undefined. Add forgotten include to i2c-icy.c

Fixes: 4768e90ecaec ("i2c: Add i2c-icy for I2C on m68k/Amiga")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Max Staudt <max@enpas.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-icy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-icy.c b/drivers/i2c/busses/i2c-icy.c
index 8382eb64b4241..d6c17506dba4a 100644
--- a/drivers/i2c/busses/i2c-icy.c
+++ b/drivers/i2c/busses/i2c-icy.c
@@ -43,6 +43,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 
+#include <asm/amigahw.h>
 #include <asm/amigaints.h>
 #include <linux/zorro.h>
 
-- 
2.25.1



