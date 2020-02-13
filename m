Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FA0C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608016;
	bh=1C2F05DTQ5vhQOubAguPuMs/IxDOxndvtOJ7j2bd/NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFtOb0g7RENWNSAh4KPLXss4JJYwBX2VTnauBx1RB7+NG0f2Yj/1H/zyYufarNtZ0
	 4zOTIPyRSQChHubfSu26ScZaY1aLDXkdUhUkPY6PZekA1XrmfIBrkDI+pH5uQ2elP8
	 km8CWQnteT141lidejOFH8jDQXiT4hdHeYiYQXXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgBMPde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbgBMP3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:03 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F86206DB;
        Thu, 13 Feb 2020 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607743;
        bh=1C2F05DTQ5vhQOubAguPuMs/IxDOxndvtOJ7j2bd/NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYIo9CT1gsGRD5iDoUe6N3cpORY0GFNJXCsEs/YN2RFkTVTVCXqpQ6q8mTyP70zt1
         xdqf4kElwg5YQ7z2IwpQWpZSpC6fZQ7f89qel0+xGI5QNREdDT2oPMefKQRBQTtoaO
         mt8An3UFj8P3hRkAApwBXjF6ciQU9k0lyTbE1iME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 070/120] powerpc/ptdump: Only enable PPC_CHECK_WX with STRICT_KERNEL_RWX
Date:   Thu, 13 Feb 2020 07:21:06 -0800
Message-Id: <20200213151925.053136745@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit f509247b08f2dcf7754d9ed85ad69a7972aa132b upstream.

ptdump_check_wx() is called from mark_rodata_ro() which only exists
when CONFIG_STRICT_KERNEL_RWX is selected.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/922d4939c735c6b52b4137838bcc066fffd4fc33.1578989545.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -371,7 +371,7 @@ config PPC_PTDUMP
 
 config PPC_DEBUG_WX
 	bool "Warn on W+X mappings at boot"
-	depends on PPC_PTDUMP
+	depends on PPC_PTDUMP && STRICT_KERNEL_RWX
 	help
 	  Generate a warning if any W+X mappings are found at boot.
 


