Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071F0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B1E22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258295;
	bh=hlzry09vfblQCH17lYd45+z4FSPaJl6SUXXtsfStYoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wz3p0ls+ih+zMeSNOI66tESBuWFoeCbFAWBCs27MTC/OFErNr3eIWpzWDx7axwl5C
	 h+T0IEPLl1cBhpbbOFHxCfabBL2Tm3Za4VkpgJ/6xZvpSfZbybeP953ghHH1n13cwI
	 B9fOAEVzS12Nb9HJiM1bb1qPgGWK7oimj+hb571U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgHXIiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgHXIiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:38:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ACAC22B43;
        Mon, 24 Aug 2020 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258288;
        bh=hlzry09vfblQCH17lYd45+z4FSPaJl6SUXXtsfStYoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xa97x8AiWygqctiD3xEuIHD7hXYLI2KpsF2qm90OKLrqEhCqY6oTVGEzqgw0XoWZB
         aLoIkuZI1aHV1P6ZrxMctkVD6PsPiFnkilYvXkSB6Dhe1fvYkbwabGgdAIlDJQX1f/
         n0qaEu6RsbjWvapF4JqeSCmYGtVpkTBRF82UficA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 5.8 143/148] efi/x86: Mark kernel rodata non-executable for mixed mode
Date:   Mon, 24 Aug 2020 10:30:41 +0200
Message-Id: <20200824082420.872500412@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

commit c8502eb2d43b6b9b1dc382299a4d37031be63876 upstream.

When remapping the kernel rodata section RO in the EFI pagetables, the
protection flags that were used for the text section are being reused,
but the rodata section should not be marked executable.

Cc: <stable@vger.kernel.org>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200717194526.3452089-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/platform/efi/efi_64.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -268,6 +268,8 @@ int __init efi_setup_page_tables(unsigne
 	npages = (__end_rodata - __start_rodata) >> PAGE_SHIFT;
 	rodata = __pa(__start_rodata);
 	pfn = rodata >> PAGE_SHIFT;
+
+	pf = _PAGE_NX | _PAGE_ENC;
 	if (kernel_map_pages_in_pgd(pgd, pfn, rodata, npages, pf)) {
 		pr_err("Failed to map kernel rodata 1:1\n");
 		return 1;


