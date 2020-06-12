Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB62C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3463B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 10:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf9B6yfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:17:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA4C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:17:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so4125141pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NuFUeTohvLpQWGhiqBdRsl/f7g8QqSrYLrklZCYzpe4=;
        b=mf9B6yfne8i5p+FK67Vk9AiEK5fD4PvBFIip527ISBpgGePf2EnzbA3MdmU9LFWoBW
         FNeOb36cqMG+AOdSZuKhKOxarUNXkIcY0LNdbWmwN0ooWmSvGMfBHYPAsqBVvsHH/guu
         g/ay8oAFqRLes9MnNInE3NxYZFMzoP+Klm+sUPyCGe1grUoJqLXGO63kOh9VDRM8hC0h
         +gqT/Xs5CpcaQtaegXvVEFWdCWtbjpiseq3xKEazpATYTj7s1vKpUBKymR76MOdxSpRN
         QFpSAn0ZZqh5FQEevGgspmRv4P/uhmsuT7cdpjTOh7eODGQmrmGDSJLp1r01AIvB7tKl
         WsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NuFUeTohvLpQWGhiqBdRsl/f7g8QqSrYLrklZCYzpe4=;
        b=kEeYqhXcopy+U9i1vXqsznwuiWxS1qGJMnwZrPHqa+1UVKWWFJEJNZ93eQ54f+Jw8X
         AOsO7qm2IxkmPX97gDnvLSX967guUuH/26ohYP9JZ5Hl9/1bSwGdi6tu6RPHoPoZoxAc
         SXuAk2RzNFpZLugkSoAD1hHyTxTxAxCG5Y9Ha6gWrktHhurZYoCwefqHLj6FXTdox5Pg
         1kdRWynhAHl/5tyQtd4fgsbvL9FkwmpcB+y59w+G5L+1b1iUTOdtaKzolKBF/lDycTbX
         NeWzeH75O4fSXV4kaBT7h7dGRbzLFkbi9QjSPY4kbTdzyIWhjv0Pe6bhI1RN1BQb7aad
         tHBA==
X-Gm-Message-State: AOAM533lNATHC1Q+EgNTs873/5BY5omeBfC+miBubaT8FClqNV2+5rnY
        Atruz9zY2lmo8rlAvNggmiUlnT4a
X-Google-Smtp-Source: ABdhPJwEHIXkVHC+92pBUECg3eFaNPBwA7ppYh+HoSCnhECs/00e4Cd2PLigErL2X54s3fHED5dqPQ==
X-Received: by 2002:a17:90b:188c:: with SMTP id mn12mr12284862pjb.8.1591957037151;
        Fri, 12 Jun 2020 03:17:17 -0700 (PDT)
Received: from localhost ([49.205.222.116])
        by smtp.gmail.com with ESMTPSA id w190sm5685388pfw.35.2020.06.12.03.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 03:17:16 -0700 (PDT)
Date:   Fri, 12 Jun 2020 15:47:14 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [RFC 0/3] ARM: copy_{from,to}_user() for vmsplit 4g/4g
Message-ID: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

copy_{from,to}_user() uaccess helpers are implemented by user page
pinning, followed by temporary kernel mapping & then memcpy(). This
helps to achieve user page copy when current virtual address mapping
of the CPU excludes user pages.

Other uaccess routines are also planned to be modified to make use of
pinning plus kmap_atomic() based on the feedback here.

This is done as one of the initial steps to achieve 4G virtual
address mapping for user as well as Kernel on ARMv7 w/ LPAE.

Motive behind this is to enable Kernel access till 4GiB (almost) as
lowmem, thus helping in removing highmem support for platforms having
upto 4GiB RAM. In the case of platforms having >4GiB, highmem is still
required for the Kernel to be able to access whole RAM.

Performance wise, results are not encouraging, 'dd' on tmpfs results,

ARM Cortex-A8, BeagleBone White (256MiB RAM):
w/o series - ~29.5 MB/s
w/ series - ~20.5 MB/s
w/ series & highmem disabled - ~21.2 MB/s

On Cortex-A15(2GiB RAM) in QEMU:
w/o series - ~4 MB/s
w/ series - ~2.6 MB/s

Roughly a one-third drop in performance. Disabling highmem improves
performance only slightly.

'hackbench' also showed a similar pattern.

Ways to improve the performance has to be explored, if any one has
thoughts on it, please share.

uaccess routines using page pinning & temporary kernel mapping is not
something new, it has been done by Ingo long long ago [1] as part of
4G/4G user/kernel mapping implementation on x86, though not merged in
mainline.

Arnd has outlined basic design for vmsplit 4g/4g, uaccess routines
using user page pinning plus kmap_atomic() is one part of that.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain/

Last 2 patches are only meant for testing first patch.

Regards
afzal

afzal mohammed (3):
  lib: copy_{from,to}_user using gup & kmap_atomic()
  ARM: uaccess: let UACCESS_GUP_KMAP_MEMCPY enabling
  ARM: provide CONFIG_VMSPLIT_4G_DEV for development

 arch/arm/Kconfig               |   9 ++
 arch/arm/include/asm/uaccess.h |  20 ++++
 arch/arm/kernel/armksyms.c     |   2 +
 arch/arm/lib/Makefile          |   7 +-
 lib/Kconfig                    |   4 +
 lib/Makefile                   |   3 +
 lib/uaccess_gup_kmap_memcpy.c  | 162 +++++++++++++++++++++++++++++++++
 7 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 lib/uaccess_gup_kmap_memcpy.c

-- 
2.26.2

