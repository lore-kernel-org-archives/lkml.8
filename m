Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BCCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4202168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607868;
	bh=1C2F05DTQ5vhQOubAguPuMs/IxDOxndvtOJ7j2bd/NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TFEnBnENLsfCPktjqi9MC5fm4AuflHjZoaJKCVnp3d61KHUvFpaD4VF1LOnY1qGlG
	 NMNFdNFlxXlhxISqgFOz9NY7i2U7pCLo5NWDEhc8fTjzvOkm6JCxGl6eGFs6wnnkT+
	 DtHNCRP7ALo6DtpJ/uwLUhliP6QTuCv0WrZrrVF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBMPbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgBMP1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:43 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0313D24671;
        Thu, 13 Feb 2020 15:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607663;
        bh=1C2F05DTQ5vhQOubAguPuMs/IxDOxndvtOJ7j2bd/NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUsyoDlnj/DTYwhyQICyNZvGby+0wlJdJVic1iXUzBzUdhCV+mpAM7oAw+kxDuYew
         OLfIrwiiOrnpWzh+9onSPVWnw0K3MUIyAPd3hGusVkc5LHZNmEpPdk2DP/5Mjnr6SB
         LetkYKQ1Mxrv16pCEH9btmOlaMs2XfYgHD2nAMcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 55/96] powerpc/ptdump: Only enable PPC_CHECK_WX with STRICT_KERNEL_RWX
Date:   Thu, 13 Feb 2020 07:21:02 -0800
Message-Id: <20200213151900.681059691@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
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
 


