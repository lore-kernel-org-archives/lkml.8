Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23596C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC9821739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="er5LfDur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgCDLpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:45:49 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:37304 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgCDLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:45:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 668EE3FB73;
        Wed,  4 Mar 2020 12:45:47 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=er5LfDur;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EcSh4HWbh2Xn; Wed,  4 Mar 2020 12:45:46 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id EEF0A3FAA1;
        Wed,  4 Mar 2020 12:45:43 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 392DE36013E;
        Wed,  4 Mar 2020 12:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1583322343; bh=J7vi1SSK9oTq2TFusYQOaJCHsRuel1r15G53fbJc+fM=;
        h=From:To:Cc:Subject:Date:From;
        b=er5LfDurrbWSmTRg3WLmK4YKulGzV4r97/4xu4KsfbwadmpWhqfXplBPyH4rwp27B
         F3cqZBVgcL3609lbdHycswLRWiTuNbO38pZy52peaGnz8FZKZ5DsgxKXZ4oJnnLeFj
         vqtFZByZfR5E1161zHqYo704FrelfDwJO3rzSl6Q=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     x86@kernel.org, Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v4 0/2] Fix SEV user-space mapping of unencrypted coherent memory
Date:   Wed,  4 Mar 2020 12:45:25 +0100
Message-Id: <20200304114527.3636-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes dma_mmap_coherent() mapping of unencrypted memory in
otherwise encrypted environments, where it would incorrectly map that memory as
encrypted.

With SEV and sometimes with SME encryption, The dma api coherent memory is
typically unencrypted, meaning the linear kernel map has the encryption
bit cleared. However, default page protection returned from vm_get_page_prot()
has the encryption bit set. So to compute the correct page protection we need
to clear the encryption bit.

Also, in order for the encryption bit setting to survive across do_mmap() and
mprotect_fixup(), We need to make pgprot_modify() aware of it and not touch it.
Therefore make sme_me_mask part of _PAGE_CHG_MASK and make sure
pgprot_modify() preserves also cleared bits that are part of _PAGE_CHG_MASK,
not just set bits. The use of pgprot_modify() is currently quite limited and
easy to audit.

(Note that the encryption status is not logically encoded in the pfn but in
the page protection even if an address line in the physical address is used).

The patchset has seen some sanity testing by exporting dma_pgprot() and
using it in the vmwgfx mmap handler with SEV enabled.

As far as I can tell there are no current users of dma_mmap_coherent() with
SEV or SME encryption which means that there is no need to CC stable.

Changes since:
RFC:
- Make sme_me_mask port of _PAGE_CHG_MASK rather than using it by its own in
  pgprot_modify().
v1:
- Clarify which use-cases this patchset actually fixes.
v2:
- Use _PAGE_ENC instead of sme_me_mask in the definition of _PAGE_CHG_MASK
v3:
- Added RB from Dave Hansen.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
