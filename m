Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B67246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kgn+3P9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCBI2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:28:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:28:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id o15so10707451ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gI/JDL1Wx8nFohMqc9CK4+V7cJXPQia3eW5lIJu+x/Y=;
        b=Kgn+3P9O/U+faU0qvawFHExSGZwH8rhtL71T7+Sbn0N8eVh9D2i3h8NjoYL6fqg/rs
         6KRhlGZFMAO+Tl5zx/GImTAUYx68AkHdoysf6pk+2VN+Cqwf8iUU25a+Zt24oIJM2GNZ
         SUAh09yhezJuVyONzHTmbuFIsR2AJwy1S2T2DnEpSzpwHAMCVMW2562+8aTg/ynP++GR
         Ro6BEyj4t6q9y/zJJBhYcgg+6NtMxu4mF3telGibEMvbNpTC+Y0iCy73wzITJyWoT1RZ
         SDTujyqjXwCjyCB1yNp8CWDxbq8+iM10m+5j9ZkiI8O8yxr5dU/7eoNRWT3to8VuSIPD
         rDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gI/JDL1Wx8nFohMqc9CK4+V7cJXPQia3eW5lIJu+x/Y=;
        b=HknHzKUG+VDq4jVT5k6/AS1LxQdwpaVLgcugf5tuZDx2tlIXP9BrOIK2t83imJF1zr
         Oa1MNjhlPskoc+zcstb4qSFpsLLl6ueQnAvUfoE2uNToebOx43jVCoyB1SvExGCM7hGy
         BZRK0vJIkP6RlyTbn6aUeMAG78mpvnXG9+JYUy/Nx630dVtxCU1fSfEayw8PWtfQT+e/
         QGh7TmhRkAgrBKFHjvlU/uG+R9R42QS7DP5KyUdFNHoaQFWW8hqrCxPE4qwjnOfUJjAx
         K+mYmT+8w96LkZKzmOVNWT+/Jd6bfmcztmUtjTTRo37AMm/8DSj5d3gshPk0t7re7IFb
         P5sw==
X-Gm-Message-State: ANhLgQ3Xj1xfr/wPG8Yijy76E+eqfmyoswrUeHleZEtqeq2IkGebyZSN
        V/miDz4u9g9oJEClBXBEULFqsUlSjfWw8bZcseKj/w==
X-Google-Smtp-Source: ADFU+vsFmGtvm64OwRrbUe6sxD91S6yku24dp48uac8AWEk1QrZr4l3dD1lXGsN5/IrIRBsbogGWJMcp1iuT0aE6huI=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr10884152ljk.73.1583137716931;
 Mon, 02 Mar 2020 00:28:36 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 Mar 2020 13:58:26 +0530
Message-ID: <CA+G9fYtAM-m0jygud+i0ymU+XknV9_GcAbDQChiD2NZjvQ+D3w@mail.gmail.com>
Subject: Linux-next-20200302: arm64 build failed
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        rppt@linux.ibm.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, suzuki.poulose@arm.com,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-Next 20200302 arm64 build failed due to below errors,
Suspecting patch causing this build break.

87d900aef3e2  arm/arm64: add support for folded p4d page tables

Error log,
-------------
arch/arm64/mm/mmu.c: In function 'unmap_hotplug_pud_range':
include/linux/compiler.h:284:1: error: incompatible type for argument
1 of 'p4d_page_paddr'
 ({         \
 ^
arch/arm64/include/asm/memory.h:270:45: note: in definition of macro
'__phys_to_virt'
 #define __phys_to_virt(x) ((unsigned long)((x) - physvirt_offset))
                                             ^
arch/arm64/include/asm/pgtable.h:629:42: note: in expansion of macro '__va'
 #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
                                          ^~~~
include/linux/compiler.h:293:22: note: in expansion of macro '__READ_ONCE'
 #define READ_ONCE(x) __READ_ONCE(x, 1)
                      ^~~~~~~~~~~
arch/arm64/include/asm/pgtable.h:628:52: note: in expansion of macro 'READ_ONCE'
 #define pud_offset_phys(dir, addr) (p4d_page_paddr(READ_ONCE(*(dir)))
+ pud_index(addr) * sizeof(pud_t))
                                                    ^~~~~~~~~
arch/arm64/include/asm/pgtable.h:629:47: note: in expansion of macro
'pud_offset_phys'
 #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
                                               ^~~~~~~~~~~~~~~
arch/arm64/mm/mmu.c:827:10: note: in expansion of macro 'pud_offset'
   pudp = pud_offset(pgdp, addr);
          ^~~~~~~~~~

ref:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=juno,label=docker-lkft/716/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
