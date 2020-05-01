Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DCC47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61C4208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588344373;
	bh=10r26z69r9wu8Pq+TQWNjuhSpIIYfOTBaBhJ/i5UtVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK8aHRtwBcNKIeTZ86lEYp2cXQloN0ZESYZj6gtAv/e62B5QBOdUkNYUsOshdGvhG
	 bmtBCdGUL6XR7BO2iNI6ZpZwcN4FGHJFhowRldCq9+z8ikVi/aSlNcZi8A/KWX13Cn
	 jgx8L1/s91nugJ03A8mQw1hfigchYZ/u4CPfkMtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgEAOp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgEAOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:45:11 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E92D224963;
        Fri,  1 May 2020 14:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344308;
        bh=10r26z69r9wu8Pq+TQWNjuhSpIIYfOTBaBhJ/i5UtVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKOl8p+sEWPnaOBMIxC3Zz2MKex5RfAXLalcBFKIF2tho9+twe61M6SXDRWmpiHVx
         iUwjhEdbATDgePPfx4bdMehyjzv93NZi/qU9ECKC3B42ffBDwscjjcndoS+XoVsTWo
         3M7bS78L6Wo2Pbn/tUrmx++pwMGzsBULrdB/eqWQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUWuU-00FCfV-6x; Fri, 01 May 2020 16:45:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 37/37] docs: networking: arcnet-hardware.rst: don't duplicate chapter names
Date:   Fri,  1 May 2020 16:44:59 +0200
Message-Id: <9cbadbb1186788433909bd365c8a3f01543b9d40.1588344146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since changeset 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst"),
auto-references for chapters are generated. This is a nice feature, but
has a drawback: no chapters can have the same sumber.

So, we need to change two chapter titles, to avoid warnings when
building the docs.

Fixes: 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/arcnet-hardware.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
index b5a1a020c824..ac249ac8fcf2 100644
--- a/Documentation/networking/arcnet-hardware.rst
+++ b/Documentation/networking/arcnet-hardware.rst
@@ -1296,8 +1296,8 @@ DIP Switches:
 	11111           0xC400 (guessed - crashes tested system)
 	=============   ============================================
 
-CNet Technology Inc.
-====================
+CNet Technology Inc. (8-bit cards)
+==================================
 
 120 Series (8-bit cards)
 ------------------------
@@ -1520,8 +1520,8 @@ The jumpers labeled EXT1 and EXT2 are used to determine the timeout
 parameters. These two jumpers are normally left open.
 
 
-CNet Technology Inc.
-====================
+CNet Technology Inc. (16-bit cards)
+===================================
 
 160 Series (16-bit cards)
 -------------------------
-- 
2.25.4

