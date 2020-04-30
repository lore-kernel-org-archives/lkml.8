Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701A4C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD9020775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262690;
	bh=y89XgCliJz/lr+EFnLNa4NvHX8zoBcMdweKkt+ervZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/nVmnoB4MEfKVV28LakH09X/zdWcucG+araawuq5uW+fDZejvrI3I8OZRpCxMci0
	 tTltHPxr8Nh4F6qrGt2wPh6cr8CdrZhtWfsFLiKhF9G37/ek0tQQw0Bg4XOgZkWIYz
	 GysL33VU4haLi7MpSC8SBKJdRzGo7uRBzKIAKA6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgD3QEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgD3QEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE3224988;
        Thu, 30 Apr 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=y89XgCliJz/lr+EFnLNa4NvHX8zoBcMdweKkt+ervZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onXcx5v9IUwcGRuvP6XNnWcUOIYsowOD3xMwX/tp+gC9bj+Ocd+XOrQMnFnUPtdPC
         zW0GlT1QirV8GHRAsqnAFW9iomI0tAVo3jtuQ4cVmFJS7tGZFlCt/kaWoYqfKnOXkV
         LgIbHbIasDOozTIIyyAOrrapElJpxms5+CyQlsJg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxGL-O8; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 28/37] docs: networking: convert secid.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:23 +0200
Message-Id: <814b804b6dc239b2d2ba1d4759e58b145f3fbf8a.1588261997.git.mchehab+huawei@kernel.org>
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
 Documentation/networking/index.rst                | 1 +
 Documentation/networking/{secid.txt => secid.rst} | 6 ++++++
 2 files changed, 7 insertions(+)
 rename Documentation/networking/{secid.txt => secid.rst} (87%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 1761eb715061..8b672f252f67 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -101,6 +101,7 @@ Contents:
    regulatory
    rxrpc
    sctp
+   secid
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/secid.txt b/Documentation/networking/secid.rst
similarity index 87%
rename from Documentation/networking/secid.txt
rename to Documentation/networking/secid.rst
index 95ea06784333..b45141a98027 100644
--- a/Documentation/networking/secid.txt
+++ b/Documentation/networking/secid.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+LSM/SeLinux secid
+=================
+
 flowi structure:
 
 The secid member in the flow structure is used in LSMs (e.g. SELinux) to indicate
-- 
2.25.4

