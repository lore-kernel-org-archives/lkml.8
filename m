Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C8C82A01
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E920575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588025081;
	bh=xBkzNBy2YhJi/8RK1Om5eioEswOWWQFUH8yKwJvvfgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIBGtwvSuDLvjABqCW3nGn2lXmATQ9+KqqU3NQjcwSKUZ5Got6BNOxDIwgN7EV6Xm
	 q413tc2WtVoKMyo1ANcUJ4ezmBApB2jaDRtMwC+FjVA94jAB96+5fP/hvFs0qXX4g/
	 iDpQzPZNbFD2hoO7Sy+Ib0wYW1poa8aACtpzpqXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD0WEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgD0WCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:02:00 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99282223C;
        Mon, 27 Apr 2020 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588024917;
        bh=xBkzNBy2YhJi/8RK1Om5eioEswOWWQFUH8yKwJvvfgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfwAVJgU5xU8hFba4Fet0WG5uwzHpKjNy+G/Q25LQwj2hZUVA+6KsS/oqUZIck34i
         NDF9MuK088cyhYRJHoOPU8d2T4m9FB63KZjzgS+t+MbQntQGI7tUIZwKXgo3G4qZ+w
         1gKY389t7znH0SKWVaiRj758Lc0d/ILVCIOErS48=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTBp5-000Ipd-52; Tue, 28 Apr 2020 00:01:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 25/38] docs: networking: convert generic_netlink.txt to ReST
Date:   Tue, 28 Apr 2020 00:01:40 +0200
Message-Id: <8ed7ad58fc10c5343722f7bcda07e712e41f7d0e.1588024424.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588024424.git.mchehab+huawei@kernel.org>
References: <cover.1588024424.git.mchehab+huawei@kernel.org>
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
 .../networking/{generic_netlink.txt => generic_netlink.rst} | 6 ++++++
 Documentation/networking/index.rst                          | 1 +
 2 files changed, 7 insertions(+)
 rename Documentation/networking/{generic_netlink.txt => generic_netlink.rst} (64%)

diff --git a/Documentation/networking/generic_netlink.txt b/Documentation/networking/generic_netlink.rst
similarity index 64%
rename from Documentation/networking/generic_netlink.txt
rename to Documentation/networking/generic_netlink.rst
index 3e071115ca90..59e04ccf80c1 100644
--- a/Documentation/networking/generic_netlink.txt
+++ b/Documentation/networking/generic_netlink.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+Generic Netlink
+===============
+
 A wiki document on how to use Generic Netlink can be found here:
 
  * http://www.linuxfoundation.org/collaborate/workgroups/networking/generic_netlink_howto
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index d34824b27264..42e556509e22 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -60,6 +60,7 @@ Contents:
    fore200e
    framerelay
    generic-hdlc
+   generic_netlink
 
 .. only::  subproject and html
 
-- 
2.25.4

