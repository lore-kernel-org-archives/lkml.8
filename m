Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BBAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CB720A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596482037;
	bh=eAFPHhOTT8ewuYM7h+9ksB4z3CD7yToQUetdl//RYpM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xmnjSNi7/hhWqNfRTyA8qUpuvrNuIlFkcTBdnMOZHdyNRU6XPvEk7jbuP9U2QUU1l
	 7mFSKsiobjhQM0V/+UNf9G3q7WTl03GXT8L4f5iB8i7Fj/imHRZAo//pYocYOB+Ql0
	 LDXY3UQBje4t3A9jAL1WJeWcWGpT6nm7CyJhviWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHCTN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:13:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D7CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:13:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so13240107ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=t98ZjRfUQ2zIDQ9pifSZAAIwbRrIcr++IX5GfcqsxGU=;
        b=ER3VTVetOfnnIr/JsPEZv4NQoaKHz5fNbAza68iFjnusoDXZkV0S2EMvarro6I+qXI
         +lBtx3xin+0DD61Gl3UOO5aQ6lT2n3NeRQDKbikDcyfylM0Eh27qS5GtPm8WEDecrQ1u
         C7yTWrWfa5ysNH0NJWo7FCclnm5b6S1f/nNTPj0ceRRMx0XufcS9Mwd6fXAaEEGlT2eH
         y+zm5KaMtrXSFYgnDIhihNhHggDetmBHBqZvGAOXrUkzexmy3WtYd4BILWRC1/fJCrG0
         ElKCs9cZfGP11he31Ql++tpOGOKt1RAj7+lpbY4pCYIJ0E/KY6Y9C0yie57hJFpdH7F2
         01yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=t98ZjRfUQ2zIDQ9pifSZAAIwbRrIcr++IX5GfcqsxGU=;
        b=VNoccDCUNmGTo231KH3fqGITyztASsCFlY5TD9jnCHThH9bop0rNi+eSldT7hD64uz
         hvCVkatDV7VQoT3ggDLTy01XFWEEsN23aHQn8TpwThiKd3Ajslltpc9LjWVQUl5mzkgs
         1fVd7qkzAPnsT5tiH0goagtX4E2cwN+gzmJ4cQbwagAPZDgkJgWosy0y/8B0kYWbVAHe
         t2avFRtFZHVHZSYPzZzUv+zuaypbZm5ciIIEgll2DkQUh8zOPdXTmN7gqc9wiUXBVo0c
         m3+qYMbRWSrBTA9xghpGn52TwUga4qZYVUZSXl9V1mylfZ1hOVGggwLcvz6G5IlJ+1Lm
         /Lwg==
X-Gm-Message-State: AOAM530rlOz3OHEBGMraAVJepTdpNtXMviJgq3BOup7FIS7SNwkYVIgt
        jixhvzP1FZhsX4rcPmZQd0ZHoAkm
X-Google-Smtp-Source: ABdhPJwEtVyHA8dbMM97huk+VnsIoYWKR5JNGAanv7nMxw9mfuNVJqUrwrv9CicXoYehK+Wz5c5ZIw==
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr4462288ejk.94.1596482034673;
        Mon, 03 Aug 2020 12:13:54 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 92sm5373523edo.7.2020.08.03.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:13:54 -0700 (PDT)
Date:   Mon, 3 Aug 2020 21:13:52 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v5.9
Message-ID: <20200803191352.GA1352094@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/platform git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2020-08-03

   # HEAD: 3bcf25a40b018e632d70bb866d75746748953fbc x86/efi: Remove unused EFI_UV1_MEMMAP code

The biggest change is the removal of SGI UV1 support, which allowed the
removal of the legacy EFI old_mmap code as well.

This removes quite a bunch of old code & quirks.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
steve.wahl@hpe.com (13):
      x86/platform/uv: Remove support for UV1 platform from uv_time
      x86/platform/uv: Remove support for UV1 platform from uv_tlb
      x86/platform/uv: Remove support for UV1 platform from x2apic_uv_x
      x86/platform/uv: Remove support for UV1 platform from uv_mmrs
      x86/platform/uv: Remove support for UV1 platform from uv_bau
      x86/platform/uv: Remove support for uv1 platform from uv_hub
      x86/platform/uv: Remove support for UV1 platform from uv
      x86/platform/uv: Remove vestigial mention of UV1 platform from bios header
      x86/platform/uv: Remove efi=old_map command line option
      x86/efi: Delete SGI UV1 detection.
      x86/efi: Remove references to no-longer-used efi_have_uv1_memmap()
      x86/platform/uv: Remove uv bios and efi code related to EFI_UV1_MEMMAP
      x86/efi: Remove unused EFI_UV1_MEMMAP code


 arch/x86/include/asm/efi.h         |  20 +-
 arch/x86/include/asm/uv/bios.h     |   2 +-
 arch/x86/include/asm/uv/uv.h       |   2 +-
 arch/x86/include/asm/uv/uv_bau.h   | 118 +-----
 arch/x86/include/asm/uv/uv_hub.h   |  34 +-
 arch/x86/include/asm/uv/uv_mmrs.h  | 712 -------------------------------------
 arch/x86/kernel/apic/x2apic_uv_x.c | 122 ++-----
 arch/x86/kernel/kexec-bzimage64.c  |   9 -
 arch/x86/platform/efi/efi.c        |  16 +-
 arch/x86/platform/efi/efi_64.c     |  38 +-
 arch/x86/platform/efi/quirks.c     |  31 --
 arch/x86/platform/uv/bios_uv.c     | 173 +--------
 arch/x86/platform/uv/tlb_uv.c      | 243 ++-----------
 arch/x86/platform/uv/uv_time.c     |  16 +-
 14 files changed, 86 insertions(+), 1450 deletions(-)
