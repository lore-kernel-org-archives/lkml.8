Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7444E20853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446237;
	bh=yemiLgmgfEeMx6Uvl3WkBZlw3nU1SWZLvo1NEGlESFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mWsHW2aXy3u3TUBYir0tAfLdNasq2uWAIpqodN8tDn+zMDM1n7LRv30aKx2NtI0ja
	 65i4Z8YaNCMv3NKYdU5Dn90zfuUEouWKkgTT8hE6nR1+1PzgeRjZlJQzaqN+AkWLnf
	 RtZWxNWbaw0wpzwV7ya91Dqj/TPSlKnHWXtSvHcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgFRCKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgFRBVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A1C21D79;
        Thu, 18 Jun 2020 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443307;
        bh=yemiLgmgfEeMx6Uvl3WkBZlw3nU1SWZLvo1NEGlESFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLCcImdPRq4cU4hbfBjyEA0l3PL1oDBcS473Oo+STxXpRmwK0Bj7eVzGsF6vc2SLd
         CHdNlCoicmHZp3cOKLUcXpdirLvLOfQG1e1fypWiEmwxcNhjbQlqe1Qd3niGJIdewO
         lcujVIWNvzfJaXOAY3SnLlI0krUDY5SZrlBmTeIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Staudt <max@enpas.org>, kernel test robot <lkp@intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 245/266] i2c: icy: Fix build with CONFIG_AMIGA_PCMCIA=n
Date:   Wed, 17 Jun 2020 21:16:10 -0400
Message-Id: <20200618011631.604574-245-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8382eb64b424..d6c17506dba4 100644
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

