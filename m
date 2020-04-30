Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA33C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ED82076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588262750;
	bh=Lyeq7K/r25Ek9OlC3TUWDQxSiAmaBzlOKd/J+NU8JtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kV7pn/446TlGXu+55ld/OMQ4xV/XzPyZy1/IU7uPVtttfrR6Wg6CAAYLXCn4Z2x7d
	 g8hXHX1/ZllQ2dPaWgl42Pr9dqqm4XzImFKwL0Lesffy7nkZyo5W4KKf0rlndj85ZG
	 duJ+X5ReP/uGjeLQG8+0CySbliGMZYb58ccJWaL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgD3QFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgD3QEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:04:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6AE924999;
        Thu, 30 Apr 2020 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588262676;
        bh=Lyeq7K/r25Ek9OlC3TUWDQxSiAmaBzlOKd/J+NU8JtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMII9dVNxHbDdvPlywzsyeDEYL6BmP1cc+UK8DhQdCxTH9rSKRN3G/lnXRP+iWCNr
         JJwxjqLT9LNt8n4kl/EhkyRToFlbhzVG7glM5tuisG/n0r5se2tTH6iYwQX+fwPqRn
         Hkkaw1mmUnEHp1OmD5Y7dTvw7MOeGtI27S0hmmqU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBfu-00AxGp-TK; Thu, 30 Apr 2020 18:04:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 34/37] docs: networking: convert tcp-thin.txt to ReST
Date:   Thu, 30 Apr 2020 18:04:29 +0200
Message-Id: <cb01fc26bebe16f98c4985b1e6de3ee3079706e9.1588261997.git.mchehab+huawei@kernel.org>
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
- adjust identation, whitespaces and blank lines where needed;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst                      | 1 +
 Documentation/networking/ip-sysctl.rst                  | 2 +-
 Documentation/networking/{tcp-thin.txt => tcp-thin.rst} | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)
 rename Documentation/networking/{tcp-thin.txt => tcp-thin.rst} (97%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index f53d89b5679a..89b02fbfc2eb 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -107,6 +107,7 @@ Contents:
    strparser
    switchdev
    tc-actions-env-rules
+   tcp-thin
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 38f811d4b2f0..3266aee9e052 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -886,7 +886,7 @@ tcp_thin_linear_timeouts - BOOLEAN
 	initiated. This improves retransmission latency for
 	non-aggressive thin streams, often found to be time-dependent.
 	For more information on thin streams, see
-	Documentation/networking/tcp-thin.txt
+	Documentation/networking/tcp-thin.rst
 
 	Default: 0
 
diff --git a/Documentation/networking/tcp-thin.txt b/Documentation/networking/tcp-thin.rst
similarity index 97%
rename from Documentation/networking/tcp-thin.txt
rename to Documentation/networking/tcp-thin.rst
index 151e229980f1..b06765c96ea1 100644
--- a/Documentation/networking/tcp-thin.txt
+++ b/Documentation/networking/tcp-thin.rst
@@ -1,5 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
 Thin-streams and TCP
 ====================
+
 A wide range of Internet-based services that use reliable transport
 protocols display what we call thin-stream properties. This means
 that the application sends data with such a low rate that the
@@ -42,6 +46,7 @@ References
 ==========
 More information on the modifications, as well as a wide range of
 experimental data can be found here:
+
 "Improving latency for interactive, thin-stream applications over
 reliable transport"
 http://simula.no/research/nd/publications/Simula.nd.477/simula_pdf_file
-- 
2.25.4

