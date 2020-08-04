Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7A92086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtoKZecr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgHDEuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:50:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgHDEuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596516604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=291IS5a+Koe7ZFOAeLnmWhju7u/xBkE2pYZR4dECKSI=;
        b=OtoKZecr8bMX5dFEHZKWDOSfSzlLaAJsggAL8f/GQh0uhs3A/BB8W4ViIeiyKngdkhQXsH
        ytMWDR4oi6QIoHWWYBbCif4E4RVkYktTA1eUabK+o3EIaialIXXexz3h3N0GBpjzCZLXFc
        G/MSLyhG8ZQLhMENgGddKYxoS80Clz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-mHqv7QeiOHeKynowbcDWIA-1; Tue, 04 Aug 2020 00:50:02 -0400
X-MC-Unique: mHqv7QeiOHeKynowbcDWIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26444800469;
        Tue,  4 Aug 2020 04:50:01 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 636AA10013D7;
        Tue,  4 Aug 2020 04:49:54 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com, dyoung@redhat.com,
        bhe@redhat.com, k-hagio@ab.jp.nec.com
Subject: [PATCH 3/3] kexec_file: correctly output debugging information for the PT_LOAD elf header
Date:   Tue,  4 Aug 2020 12:49:33 +0800
Message-Id: <20200804044933.1973-4-lijiang@redhat.com>
In-Reply-To: <20200804044933.1973-1-lijiang@redhat.com>
References: <20200804044933.1973-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when we enable the debugging switch to debug kexec_file,
always get the following wrong results:

kexec_file: Crash PT_LOAD elf header. phdr=00000000c988639b vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=51 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000003cca69a0 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=52 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000c584cb9f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=53 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000cf85d57f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=54 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000a4a8f847 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=55 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000272ec49f vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=56 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000ea0b65de vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=57 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000001f5e490c vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=58 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000dfe4109e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=59 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000480ed2b6 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=60 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000080b65151 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=61 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000024e31c5e vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=62 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000332e0385 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=63 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=000000002754d5da vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=64 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=00000000783320dd vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=65 p_offset=0x0
kexec_file: Crash PT_LOAD elf header. phdr=0000000076fe5b64 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=66 p_offset=0x0

The reason is that kernel always prints the values of the next PT_LOAD
instead of the current PT_LOAD. Change it to ensure that we can get the
correct debugging information.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 41616b6a80ad..e2c03b4ce31b 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1323,10 +1323,10 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
 		phdr->p_align = 0;
 		ehdr->e_phnum++;
-		phdr++;
 		pr_debug("Crash PT_LOAD elf header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
 			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
 			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
 	}
 
 	*addr = buf;
-- 
2.17.1

