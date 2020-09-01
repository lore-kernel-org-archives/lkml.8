Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C17FC28E83
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0A52067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979002;
	bh=wWrsBSoomeH4DSGAdrpLjOIFXXCeyh5X5tzUvZwC4SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHB0EBfUPKxUSKqXspCBqN6uFQHlqvnwkpDhM8HEyTn3DeZCvW4xS01Qex/Qxj6Du
	 zw5dGjXWdaW+Ri/Of5f/OVjE1ZzyUXQiinl6qNWKjMBIuAtYUdElffQ+WFQTwB98zu
	 G4HioMnR/bVAKdzudxEF48iPktxIbpHRcqkGg6mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIAP0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729790AbgIAPXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51E1320FC3;
        Tue,  1 Sep 2020 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973794;
        bh=wWrsBSoomeH4DSGAdrpLjOIFXXCeyh5X5tzUvZwC4SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zI9xAoc5HCacW4dOXTG+y4GMHIugpHvvUQkretbzDa3WHfbCauP5NRKyMyE8B9mmM
         7OkQq12gZXZ6rZfdfJaeNr32ACE9hPuc2V+KQXOIMjBpy5qAwgQ4b3ajPqNiiPVvD6
         +L076+l7zqKRt644UOhYxmRo9fgYZ3+FwNT6O2uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/125] powerpc/spufs: add CONFIG_COREDUMP dependency
Date:   Tue,  1 Sep 2020 17:10:04 +0200
Message-Id: <20200901150936.951624858@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
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
index 9f5958f169234..741a8fa8a3e6b 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -46,6 +46,7 @@ config SPU_FS
 	tristate "SPU file system"
 	default m
 	depends on PPC_CELL
+	depends on COREDUMP
 	select SPU_BASE
 	help
 	  The SPU file system is used to access Synergistic Processing
-- 
2.25.1



