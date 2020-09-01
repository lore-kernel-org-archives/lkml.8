Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E59D206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974831;
	bh=gFg3mT5egsP14MTeQNbTG7x7JmJeEAdQR1uiseNTQp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJSrwaafeWrygIx43HQOKz4fevraIymLiVXBQJ0dUL5bBTbkLCHJkSRYEEyhCm1hJ
	 Mm7WPl6XIEd+7UL3VAlqT7mSiIXdpIq/GiUKKcL4A689QhBjR9dtfGQtzNl55wTxSd
	 AuD9P1lSrcYywewvYDdCrMqj8O0ZC9syz0qfH7pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgIAPk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgIAPip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:38:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CF22168B;
        Tue,  1 Sep 2020 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974723;
        bh=gFg3mT5egsP14MTeQNbTG7x7JmJeEAdQR1uiseNTQp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ln7baXd+P4KP4a9aMO1omaJB61U5y6Di7alvq19fzcCfpd7LVxdr254roaqSiAea6
         gNXRRUILyYWP+QdXnn1M4m/zmKYAd8vsI9n5+2mGcPEF/09DhuW0eKHWHyOMyVjU9P
         StGGVKNWfvHfDX8eRF5cUB0xA8k31vSNdRwOCL7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 069/255] powerpc/spufs: add CONFIG_COREDUMP dependency
Date:   Tue,  1 Sep 2020 17:08:45 +0200
Message-Id: <20200901151004.038118585@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit b648a5132ca3237a0f1ce5d871fff342b0efcf8a ]

The kernel test robot pointed out a slightly different error message
after recent commit 5456ffdee666 ("powerpc/spufs: simplify spufs core
dumping") to spufs for a configuration that never worked:

   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_proxydma_info_dump':
>> file.c:(.text+0x4c68): undefined reference to `.dump_emit'
   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_dma_info_dump':
   file.c:(.text+0x4d70): undefined reference to `.dump_emit'
   powerpc64-linux-ld: arch/powerpc/platforms/cell/spufs/file.o: in function `.spufs_wbox_info_dump':
   file.c:(.text+0x4df4): undefined reference to `.dump_emit'

Add a Kconfig dependency to prevent this from happening again.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200706132302.3885935-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/cell/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 0f7c8241912b9..f2ff359041eec 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -44,6 +44,7 @@ config SPU_FS
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	depends on COREDUMP
 	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
-- 
2.25.1



