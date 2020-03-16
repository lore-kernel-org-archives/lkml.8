Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04EFC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3820663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="IjrFgoI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgCPMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:42:56 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60938 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbgCPMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:42:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 465C43F386;
        Mon, 16 Mar 2020 13:42:54 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IjrFgoI2;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XBjVuI07NOqJ; Mon, 16 Mar 2020 13:42:53 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 992493F36B;
        Mon, 16 Mar 2020 13:42:41 +0100 (CET)
Received: from linlap1.host.shipmail.org (unknown [94.191.152.149])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 67AD536044C;
        Mon, 16 Mar 2020 13:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1584362561; bh=ZjAJmGnE4Gu0kwPsPeYsYEjxTOlAy6I1FJmDkbKZfHM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IjrFgoI2d5OMHejM/JpIJrK0hTa46nkc9UfGIFkaTXaFhQBse6QPHnI8zFXyCAVJ3
         i//lde2KmH3M7Ke21lTKJO1mN2hvP3urm9x3R0ztk0lwjTJtfU3xyIDm1LI+HHpVnu
         0iovg0B4Jt7p0UwqRGZrBAn+/4PhwS0khHrlnEMM=
Subject: Re: [PATCH v4 0/2] Fix SEV user-space mapping of unencrypted coherent
 memory
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200304114527.3636-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <db92c338-820a-691b-85b0-602bcd91f5b1@shipmail.org>
Date:   Mon, 16 Mar 2020 13:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200304114527.3636-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, Ingo

On 3/4/20 12:45 PM, Thomas Hellström (VMware) wrote:
> This patchset fixes dma_mmap_coherent() mapping of unencrypted memory in
> otherwise encrypted environments, where it would incorrectly map that memory as
> encrypted.
>
> With SEV and sometimes with SME encryption, The dma api coherent memory is
> typically unencrypted, meaning the linear kernel map has the encryption
> bit cleared. However, default page protection returned from vm_get_page_prot()
> has the encryption bit set. So to compute the correct page protection we need
> to clear the encryption bit.
>
> Also, in order for the encryption bit setting to survive across do_mmap() and
> mprotect_fixup(), We need to make pgprot_modify() aware of it and not touch it.
> Therefore make sme_me_mask part of _PAGE_CHG_MASK and make sure
> pgprot_modify() preserves also cleared bits that are part of _PAGE_CHG_MASK,
> not just set bits. The use of pgprot_modify() is currently quite limited and
> easy to audit.
>
> (Note that the encryption status is not logically encoded in the pfn but in
> the page protection even if an address line in the physical address is used).
>
> The patchset has seen some sanity testing by exporting dma_pgprot() and
> using it in the vmwgfx mmap handler with SEV enabled.
>
> As far as I can tell there are no current users of dma_mmap_coherent() with
> SEV or SME encryption which means that there is no need to CC stable.
>
> Changes since:
> RFC:
> - Make sme_me_mask port of _PAGE_CHG_MASK rather than using it by its own in
>    pgprot_modify().
> v1:
> - Clarify which use-cases this patchset actually fixes.
> v2:
> - Use _PAGE_ENC instead of sme_me_mask in the definition of _PAGE_CHG_MASK
> v3:
> - Added RB from Dave Hansen.
>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
Could we merge this small series through x86?
Patch 2/2 has a

Reviewed-by: Christoph Hellwig<hch@lst.de>

Please let me know if you want me to resend with that RB added.

Thanks,
Thomas

