Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D820738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203744;
	bh=EFNKS77dZ7JREvsu2Qadjxd1ODT0DyKamudiBn1y88k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rSXngtP027NThSVGeKiYlj9gIpSz1oO36d7NdxUwVKXqwGuDZ2zGISAPoQYMuRqdf
	 IyWiCh/8ZPjS+K2lvRfzfxDw2LyjgRP7P4Ufabxs5aKt0mo/0szEOnS80fxBwiI5c5
	 f01xenR2hoXQ4Nc7jHXGk3Uf6g+I5BQtT3ZnIQq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgFOGtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31BBB20B80;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=EFNKS77dZ7JREvsu2Qadjxd1ODT0DyKamudiBn1y88k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmY6NG9a8RnC/CClm0meBiSyVJihxG8vhFm3Inbzggy3ccOF3c6VOyTDiVT5K84MO
         x7dmsdiq6g1D38x97ldxb+hL5UaS8Iw7BiOx5BAb3AjrjQ8GCxbJFgEUus9tBnnlju
         xuGmDycTeH3iHaN3Kfk5RAFi5uLeZVk0OAF1ec50=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nno-6X; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 25/29] docs: add bus-virt-phys-mapping.txt to core-api
Date:   Mon, 15 Jun 2020 08:47:04 +0200
Message-Id: <89c6d3afc558d0ae8f002d53de45e61bc13c565f.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
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
index ee6957100dec..721e40a8c65b 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -87,6 +87,7 @@ more memory-management documentation in :doc:`/vm/index`.
    dma-api-howto
    dma-attributes
    dma-isa-lpc
+   bus-virt-phys-mapping
    mm-api
    genalloc
    pin_user_pages
-- 
2.26.2

