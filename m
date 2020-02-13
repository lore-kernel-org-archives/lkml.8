Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39BB222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607965;
	bh=5FTzRjw1/Zwsuw4OZcrmHmQF4m1YWiGYPOhd9sYDLHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=krn9EtnoPyqeX9Eob+Dnh8CTwsMjxqRIJUz+7QCjxqB8eFPL1Vwf+TiTpHS7gjGUl
	 zXkAA6TFYp4l8pMvEngGouG80FFq7tUlE6ecZ+oDShboP7iNRw3BmYKWyzuYltdAKe
	 B3z79AyLT53RdPcpDRWGWM0PmkpPcV3jzX/QicIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgBMPcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:32:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgBMP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:44 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A712465D;
        Thu, 13 Feb 2020 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607724;
        bh=5FTzRjw1/Zwsuw4OZcrmHmQF4m1YWiGYPOhd9sYDLHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMFlnHJgUpm2ieYTHaI8d5FdBFU3m9RtFw7OvnNOEsIvBfE9tAfWFVOPbyfbCULvu
         Ku5yz/LoTJ+esFdBmncYJM/Y06J7tmFzcjqEl7vySILlUonh7RDnKUREXMk+Z9Fj0n
         eWFNVpn2xMRzm/NOWUPyg9WEopPtcs8gqiZ1iBPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 069/120] powerpc/ptdump: Fix W+X verification call in mark_rodata_ro()
Date:   Thu, 13 Feb 2020 07:21:05 -0800
Message-Id: <20200213151924.770480303@linuxfoundation.org>
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

commit e26ad936dd89d79f66c2b567f700e0c2a7103070 upstream.

ptdump_check_wx() also have to be called when pages are mapped
by blocks.

Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/37517da8310f4457f28921a4edb88fb21d27b62a.1578989531.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pgtable_32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -218,6 +218,7 @@ void mark_rodata_ro(void)
 
 	if (v_block_mapped((unsigned long)_sinittext)) {
 		mmu_mark_rodata_ro();
+		ptdump_check_wx();
 		return;
 	}
 


