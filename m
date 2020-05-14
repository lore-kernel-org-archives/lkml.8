Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49482065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483263;
	bh=eZRcI0qpAtMv8iWDAH9TOYTs+TyskQuVqxXt3Acec28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyDwkklKSOXb6Em+GWiYeAHNwTW3OGF0LPTBphGSxK1TX556sr0jWGSX5oH5RaZxL
	 ghixnor7v3F3lru+aOy1thYY/rEz8or8WVslMDAdVTiitw8JBudO+Ubnvz0Heae5KB
	 0v+OYTh3LNvDN7dP/AjRn6VP2JO7PEkyjep6UAnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgENTHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgENSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:53:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665AF206DC;
        Thu, 14 May 2020 18:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482410;
        bh=eZRcI0qpAtMv8iWDAH9TOYTs+TyskQuVqxXt3Acec28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2WMnAh2FDL19ZvKEn1JWhq8v1szTxolbxwO3Vtcjow1HmqUJTXyIpIyI4Z8UsvqF
         iVYlxllGAm0rvWZ7pMdYfB6GE4Pv1cIji4HmKCVhK6I9bUCt9fAN4SVwx/97qXMe+1
         2JEh8OZxfk1D8v7je+yR0zey+8sIoLoatBWd40fQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.4 15/49] most: core: use function subsys_initcall()
Date:   Thu, 14 May 2020 14:52:36 -0400
Message-Id: <20200514185311.20294-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gromm <christian.gromm@microchip.com>

[ Upstream commit 5e56bc06e18dfc8a66180fa369384b36e2ab621a ]

This patch replaces function module_init() with subsys_initcall().
It is needed to ensure that the core module of the driver is
initialized before a component tries to register with the core. This
leads to a NULL pointer dereference if the driver is configured as
in-tree.

Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/1587741394-22021-1-git-send-email-christian.gromm@microchip.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 8e9a0b67c6ed3..0c9560bbd9a6d 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1602,7 +1602,7 @@ static void __exit most_exit(void)
 	ida_destroy(&mdev_id);
 }
 
-module_init(most_init);
+subsys_initcall(most_init);
 module_exit(most_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Gromm <christian.gromm@microchip.com>");
-- 
2.20.1

