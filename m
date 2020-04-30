Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E18C47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6757A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262800;
	bh=DGsx6h/Swi27aAMJQlbcrw/nxI9G75+HiBG54132wHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvOjsUbo8WG8ParGE8loBqcyziJp9KqEbmvoxSm/S+kKNjpb7+tLMPCI9jL7qeNXd
	 JI8hJq97+VSRuZ+C634qsfD9NH90YiDU/N3cCrJbNHBGyqAgPrWEzjYvBMSzwyQpS6
	 KmS6taPte3Rm+JLpw3rU8strHVbo3fBjb+Z4YWaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgD3QGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgD3QEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4E32499C;
        Thu, 30 Apr 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=DGsx6h/Swi27aAMJQlbcrw/nxI9G75+HiBG54132wHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7bLXBIdis3/P3r5maKygrUkusCX8BbpuHEQ80yP0kt6Mj5DP4IAsVbaB7PIQOU48
         TqqlVqcoaHq0FRM2u/TojaoL+d5iYxuy82TGJjBAI97jNNIRAUAsz75kr4U4N0Y2mh
         Uf8O7oUC+yxeL+dJNyfkX4MFBgqAs3W9mw40JqpQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxGu-UB; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 35/37] docs: networking: convert team.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:30 +0200
Message-Id: <970a11887c8007cc02fbb99f6890c36616be286e.1588261997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588261997.git.mchehab+huawei@kernel.org>
References: <cover.1588261997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not much to be done here:
- add SPDX header;
- add a document title;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst              | 1 +
 Documentation/networking/{team.txt => team.rst} | 6 ++++++
 2 files changed, 7 insertions(+)
 rename Documentation/networking/{team.txt => team.rst} (67%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 89b02fbfc2eb..be65ee509669 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -108,6 +108,7 @@ Contents:
    switchdev
    tc-actions-env-rules
    tcp-thin
+   team
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/team.txt b/Documentation/networking/team.rst
similarity index 67%
rename from Documentation/networking/team.txt
rename to Documentation/networking/team.rst
index 5a013686b9ea..0a7f3a059586 100644
--- a/Documentation/networking/team.txt
+++ b/Documentation/networking/team.rst
@@ -1,2 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====
+Team
+====
+
 Team devices are driven from userspace via libteam library which is here:
 	https://github.com/jpirko/libteam
-- 
2.25.4

