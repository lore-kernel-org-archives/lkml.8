Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B42C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D4220775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262881;
	bh=yFi98m0dMb+zcVAw2IGTkDdl9KK+Ps1SAKk7Nkf6Fwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZYUvV29AZgMX+W5o5niKaf9xH1NLcLUxpHtoA1tvWIHFLuEngqZpn3MQy1UFWu/mG
	 ZwwDYMOjFBkSvdK4j8ITDxuc1aShWcvKXTVw92HyDrKkPsanEcbY3hFzFIXa38w1xr
	 p+rh09z4qDnwjh7RuMypNCDuR4PsX75qHVtSkFwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgD3QIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgD3QEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:37 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6C124953;
        Thu, 30 Apr 2020 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=yFi98m0dMb+zcVAw2IGTkDdl9KK+Ps1SAKk7Nkf6Fwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SVqXcieMewTFeMAntOPvpidXTy5lXp7EMl/8ayfKMojHuwESUkG9XscmShiHFbVk
         /0PIShBLnclxg1Clp4W+xd5TVFMRUgrW9V37gCrdfljiPkHIbOpfpo82av6k6uxA7K
         lbuYLggRuZg6LkOqbeCm09ff7Z1L60nBWOMMFnWI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxEu-8O; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 10/37] docs: networking: convert netfilter-sysctl.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:05 +0200
Message-Id: <5e9c77b49925c2154cc30b7c18f89d9db29ce9ed.1588261997.git.mchehab+huawei@kernel.org>
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
- add a chapter markup;
- mark tables as such;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst                    |  1 +
 .../{netfilter-sysctl.txt => netfilter-sysctl.rst}    | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)
 rename Documentation/networking/{netfilter-sysctl.txt => netfilter-sysctl.rst} (62%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 5a320553ffba..1ae0cbef8c04 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -83,6 +83,7 @@ Contents:
    netconsole
    netdev-features
    netdevices
+   netfilter-sysctl
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/netfilter-sysctl.txt b/Documentation/networking/netfilter-sysctl.rst
similarity index 62%
rename from Documentation/networking/netfilter-sysctl.txt
rename to Documentation/networking/netfilter-sysctl.rst
index 55791e50e169..beb6d7b275d4 100644
--- a/Documentation/networking/netfilter-sysctl.txt
+++ b/Documentation/networking/netfilter-sysctl.rst
@@ -1,8 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Netfilter Sysfs variables
+=========================
+
 /proc/sys/net/netfilter/* Variables:
+====================================
 
 nf_log_all_netns - BOOLEAN
-	0 - disabled (default)
-	not 0 - enabled
+	- 0 - disabled (default)
+	- not 0 - enabled
 
 	By default, only init_net namespace can log packets into kernel log
 	with LOG target; this aims to prevent containers from flooding host
-- 
2.25.4

