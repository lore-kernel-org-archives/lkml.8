Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8842BC47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3126B24961
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347486;
	bh=Q6vbFSFsvP1/PVPUMh4N6HimvTPIEBmlU6XjmJ+LSx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEsCIud5nfZNhNKiwM5NJcDDnYQuCO28mR9cVNT4w2StfzIOFKhvoJQVCwkmz8q7m
	 Tj3BeME24xk9BjmF4ER3upk7R8LaQAeZPRgoLzhapIMclD+RFMw7/Q4tb06/9rgluY
	 ZFYjao0zr0uIj9VvjwqyFqFiBiFpJI0aWYiRhnMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgEAPiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729370AbgEAPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB11B24959;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347482;
        bh=Q6vbFSFsvP1/PVPUMh4N6HimvTPIEBmlU6XjmJ+LSx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLXlwnlYM13v2PQiRfNv3a0ERgc+r0tmucBlmapm89I9kUkfrTfYz/KbivrLIxy6y
         uUBzRXA1jt6z3qIHTGQggdOjo1np+mLLcXbDuRjpw0aBr/njAupmXNWpelBAbPVv3V
         sQuFKOiPxW5dc1/XkVKZBNZvpPExRbcY2oDM2aGY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjk-00FE4U-W0; Fri, 01 May 2020 17:38:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 02/14] docs: add bus-virt-phys-mapping.txt to core-api
Date:   Fri,  1 May 2020 17:37:46 +0200
Message-Id: <ccd32aa5231b0e235a555fdecc4c0d274e5a6161.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This describes an old interface used prior the new DMA-API
interfaces. Add it to the core-api guide, just after the
DMA stuff.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../bus-virt-phys-mapping.rst}                                   | 0
 Documentation/core-api/index.rst                                 | 1 +
 2 files changed, 1 insertion(+)
 rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (100%)

diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/core-api/bus-virt-phys-mapping.rst
similarity index 100%
rename from Documentation/bus-virt-phys-mapping.txt
rename to Documentation/core-api/bus-virt-phys-mapping.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index c00aef843341..b70039d458a7 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -84,6 +84,7 @@ more memory-management documentation in :doc:`/vm/index`.
    dma-api-howto
    dma-attributes
    dma-isa-lpc
+   bus-virt-phys-mapping
    mm-api
    genalloc
    pin_user_pages
-- 
2.25.4

