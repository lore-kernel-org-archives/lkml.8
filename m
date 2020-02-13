Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136AC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCA720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608180;
	bh=brwYKlmau825gDmimRPicwKuw/d51BOfakanpJf4+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSnmtFHgXAJ2LJELjVZ06PqqNmLyiy/ah0t1vwo0l5rve0m2EuiWFwS4wC83VJ8a/
	 ys4D1J20K8nX+El9mXwsv2V36KNJ/8hHLH/zOkkcBcqOOq+jft6Fy6rYuDbV9IDL6Y
	 rgi3nfNrZ/3L+NnxIopeR5gLa5u8SdiqF2iWwLyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbgBMPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgBMP10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:26 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833B52468C;
        Thu, 13 Feb 2020 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607645;
        bh=brwYKlmau825gDmimRPicwKuw/d51BOfakanpJf4+aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uq0WfYi+udvEGPF8qniFAXiKrpqGfK/inKPJ4I/C4VKLvLrynr8pOjBKzZFbqlSa4
         8FT6kCdaaz/oFJyXEgg/npoYXbmO6JyTN1ZJ9qtJJifxvDBr3X6KIE6WDoYyqQdngv
         fCgbn78CZc++GIx3tHcjGnSWAS0qOE50s4Zwf7H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 54/96] powerpc/ptdump: Fix W+X verification call in mark_rodata_ro()
Date:   Thu, 13 Feb 2020 07:21:01 -0800
Message-Id: <20200213151900.389377364@linuxfoundation.org>
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
@@ -221,6 +221,7 @@ void mark_rodata_ro(void)
 
 	if (v_block_mapped((unsigned long)_sinittext)) {
 		mmu_mark_rodata_ro();
+		ptdump_check_wx();
 		return;
 	}
 


