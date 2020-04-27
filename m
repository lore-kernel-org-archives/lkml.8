Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA35C82A00
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7420575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588025073;
	bh=gQlY14y91kcptdZNtY5zBKxsEhtdicdMmT1yCxkyPsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w9JmHzoIE2InU/5qBqZMEXMnbXYEcKgSQKurkTcCDNdAoBwFpfxrNfPv2KI99dsSX
	 cjfQaebYemNEuJlIaxOrHMR0Ywy+uRHlg7Zx8lhR2xEJ9fKZ49gQgVysZMjlhlO3zd
	 QWKXeCl4tcjPCow35GcVUfPPvOSUZG897IQWhNRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgD0WEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgD0WCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:02:00 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB5A21D90;
        Mon, 27 Apr 2020 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588024916;
        bh=gQlY14y91kcptdZNtY5zBKxsEhtdicdMmT1yCxkyPsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NX3b/iqrP/erbDp256UpJdo+WWLxBtlRLXYCRXJb9CzdkPZ0M90QlE4z+q6FUrnvY
         vtHDzAizyKpSAYMk9xG0UKVa6TA+rv5OfOwZocmZHsvSYjujOehCOrQc4oYwMwT5t3
         l2zu5s0/lo2QCkuOziEJQepUj1h0HLgz5TlrxU3E=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jTBp4-000Iou-U5; Tue, 28 Apr 2020 00:01:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 16/38] docs: networking: convert defza.txt to ReST
Date:   Tue, 28 Apr 2020 00:01:31 +0200
Message-Id: <daf94777b04389cbde0f098396202875b6559c53.1588024424.git.mchehab+huawei@kernel.org>
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
- use :field: markup for the version number;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/{defza.txt => defza.rst} | 8 +++++++-
 Documentation/networking/index.rst                | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/networking/{defza.txt => defza.rst} (91%)

diff --git a/Documentation/networking/defza.txt b/Documentation/networking/defza.rst
similarity index 91%
rename from Documentation/networking/defza.txt
rename to Documentation/networking/defza.rst
index 663e4a906751..73c2f793ea26 100644
--- a/Documentation/networking/defza.txt
+++ b/Documentation/networking/defza.rst
@@ -1,4 +1,10 @@
-Notes on the DEC FDDIcontroller 700 (DEFZA-xx) driver v.1.1.4.
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+Notes on the DEC FDDIcontroller 700 (DEFZA-xx) driver
+=====================================================
+
+:Version: v.1.1.4
 
 
 DEC FDDIcontroller 700 is DEC's first-generation TURBOchannel FDDI
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index e17432492745..c893127004b9 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -51,6 +51,7 @@ Contents:
    dccp
    dctcp
    decnet
+   defza
 
 .. only::  subproject and html
 
-- 
2.25.4

