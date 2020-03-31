Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B765C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BA220675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="MxxJCkSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgCaOyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:54:54 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46648 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbgCaOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:54:54 -0400
Received: by mail-wr1-f48.google.com with SMTP id j17so26286101wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=from:autocrypt:to:cc:subject:message-id:date:user-agent
         :mime-version;
        bh=bNPeKhL0/wFJS4BLDawPuhzr3cHojYRTnATW1ukAG8Y=;
        b=MxxJCkSlPSkS4znVFrNLFb3y//EmA+2YCB9SzD/knmck3xCEgv7NP4GMUZCVfA9fdO
         2DojBYX+Bybqf8hyZermfU3zfoU3++jH5CPb0EVFe0/MAkjSU345iW6gv8Wjs2/MoDaU
         P3BdjadSZ6YWB6lC4cM84QQGgfui20kMhs4Ro8Ul+i/K2AaMS7o5P0NKStygihO9i8GW
         KWoOWftTvJbynRe8u0Ddh2VclJPn7rGfbGXzM3rtk6BkHwseSdATmW83o6UkDlJb26Xk
         jUpKujdoLT8FgC8ddJcVrHo7D1s/rbo1MDIYYqha55Iqmep04ovTHEVjomJJvjv8OtmW
         e1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:cc:subject:message-id:date
         :user-agent:mime-version;
        bh=bNPeKhL0/wFJS4BLDawPuhzr3cHojYRTnATW1ukAG8Y=;
        b=Ezzt3jds8PKeJmSBkdZ3uanumSbs2No68NdRAVg5mKQrA0OgKUg9xveNM75g9dXXxg
         B83PMwPc/fYUAlpY3qzHKCTt7MDWuLGN9GaAdieIzq6UN+H47Qz9FBB7mftt/cZf5hXA
         L10sTdXje40TvaRvmWZRADDSqEtdCKXsyh8HVR8n4Ggqfb6mXUqj/ltCPVrERj59Af7A
         1D6qA+3e3auIOCMlPyvDOSJg889BbCYnrzN66fTZukylZe4Xk8Vfo1Re/TYaeKpKMqiY
         7oLUG9RQrSg2DsSUAcsGdk4GL57YbIVWE2cvGvoFvSGScyw0uIZ8KeFPgWfU4Dp8OedO
         rFcw==
X-Gm-Message-State: ANhLgQ1PWXQqe25UXAqL9jSiHzNjfRrbiX4bls7eYZdrz+Tc37HiTIKT
        iRKhGAm+AJYybxhJDoyiOQGzXal3DF1MaQ==
X-Google-Smtp-Source: ADFU+vsfCj35Vj109E7TvxzqNqLyMu6/tIBRiZpcN9Oio2GR+hA+YBYQcZKoKCnRGo3KtuhSV4YfwQ==
X-Received: by 2002:adf:b60d:: with SMTP id f13mr22078166wre.12.1585666490448;
        Tue, 31 Mar 2020 07:54:50 -0700 (PDT)
Received: from [74.125.140.108] ([149.199.62.129])
        by smtp.gmail.com with ESMTPSA id u17sm31967386wra.63.2020.03.31.07.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:54:49 -0700 (PDT)
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arch/microblaze patches for 5.7-rc1
Message-ID: <07af6b9e-1f01-0e2b-c5e0-69041eb2aca6@monstr.eu>
Date:   Tue, 31 Mar 2020 16:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OxY3ke9QSqcofq3HmqExvVtzXqqG1gxLK"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OxY3ke9QSqcofq3HmqExvVtzXqqG1gxLK
Content-Type: multipart/mixed; boundary="suEhTRtVX8bYdm8JZot7qaxTQUYNJBhNT";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <07af6b9e-1f01-0e2b-c5e0-69041eb2aca6@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.7-rc1

--suEhTRtVX8bYdm8JZot7qaxTQUYNJBhNT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the following changes to your tree.
There are some patches in Andrew's queue which also touches microblaze
Kbuild which is also touched by this pull request. But I can't see any
issue in resolution of that conflict in linux-next.
I have tried to merge it with your current HEAD and I can't see any
issue. Please let me know if there is any problem.

Thanks,
Michal

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862=
b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.7-rc1

for you to fetch changes up to 9fd1a1c9b3f2a38a5357a13335e0b9e5f21d093b:

  microblaze: Replace setup_irq() by request_irq() (2020-03-09 14:36:23
+0100)

----------------------------------------------------------------
Microblaze patches for 5.7-rc1

- Convert license headers to SPDX
- Cleanup header handling and use asm-generic one
- Get rid of earlyprintk residues
- Define barriers and use it in the code
- Get rid of setup_irq() for timer
- Various small addons and fixes

----------------------------------------------------------------
Arvind Sankar (1):
      microblaze: Stop printing the virtual memory layout

Michal Simek (8):
      microblaze: Kernel parameters should be parsed earlier
      microblaze: Fix _reset() function
      microblaze: Convert headers to SPDX license
      microblaze: Remove architecture tlb.h and use generic one
      microblaze: Remove early printk setup
      microblaze: Remove empty headers
      microblaze: Remove unused boot_cpuid variable
      microblaze: Use asm generic cmpxchg.h for !SMP case

Stefan Asserhall (4):
      microblaze: Define microblaze barrier
      microblaze: Add sync to tlb operations
      microblaze: Add missing irqflags.h header
      microblaze: Define percpu sestion in linker file

afzal mohammed (1):
      microblaze: Replace setup_irq() by request_irq()

 arch/microblaze/include/asm/Kbuild            |  4 +++-
 arch/microblaze/include/asm/barrier.h         | 13 +++++++++++++
 arch/microblaze/include/asm/cache.h           |  5 +----
 arch/microblaze/include/asm/cacheflush.h      |  6 +-----
 arch/microblaze/include/asm/checksum.h        |  5 +----
 arch/microblaze/include/asm/cmpxchg.h         | 40
+++-------------------------------------
 arch/microblaze/include/asm/cpuinfo.h         |  5 +----
 arch/microblaze/include/asm/cputable.h        |  1 -
 arch/microblaze/include/asm/current.h         |  5 +----
 arch/microblaze/include/asm/delay.h           |  7 +------
 arch/microblaze/include/asm/dma.h             |  5 +----
 arch/microblaze/include/asm/elf.h             |  5 +----
 arch/microblaze/include/asm/entry.h           |  5 +----
 arch/microblaze/include/asm/exceptions.h      |  5 +----
 arch/microblaze/include/asm/fixmap.h          |  5 +----
 arch/microblaze/include/asm/flat.h            |  5 +----
 arch/microblaze/include/asm/hw_irq.h          |  1 -
 arch/microblaze/include/asm/io.h              |  5 +----
 arch/microblaze/include/asm/irq.h             |  5 +----
 arch/microblaze/include/asm/irqflags.h        |  5 +----
 arch/microblaze/include/asm/mmu.h             |  5 +----
 arch/microblaze/include/asm/mmu_context_mm.h  |  5 +----
 arch/microblaze/include/asm/module.h          |  5 +----
 arch/microblaze/include/asm/page.h            |  5 +----
 arch/microblaze/include/asm/pgalloc.h         |  5 +----
 arch/microblaze/include/asm/pgtable.h         |  5 +----
 arch/microblaze/include/asm/processor.h       |  5 +----
 arch/microblaze/include/asm/ptrace.h          |  5 +----
 arch/microblaze/include/asm/pvr.h             |  5 +----
 arch/microblaze/include/asm/registers.h       |  5 +----
 arch/microblaze/include/asm/sections.h        |  5 +----
 arch/microblaze/include/asm/setup.h           |  7 +------
 arch/microblaze/include/asm/string.h          |  5 +----
 arch/microblaze/include/asm/switch_to.h       |  5 +----
 arch/microblaze/include/asm/thread_info.h     |  5 +----
 arch/microblaze/include/asm/timex.h           |  5 +----
 arch/microblaze/include/asm/tlb.h             | 17 -----------------
 arch/microblaze/include/asm/tlbflush.h        |  5 +----
 arch/microblaze/include/asm/uaccess.h         |  5 +----
 arch/microblaze/include/asm/unaligned.h       |  5 +----
 arch/microblaze/include/asm/unistd.h          |  5 +----
 arch/microblaze/include/asm/unwind.h          |  5 +----
 arch/microblaze/include/asm/user.h            |  1 -
 arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c |  7 +------
 arch/microblaze/kernel/cpu/pvr.c              |  1 +
 arch/microblaze/kernel/entry.S                |  1 +
 arch/microblaze/kernel/misc.S                 |  3 ++-
 arch/microblaze/kernel/setup.c                |  2 --
 arch/microblaze/kernel/timer.c                | 10 ++--------
 arch/microblaze/kernel/vmlinux.lds.S          |  3 +++
 arch/microblaze/mm/init.c                     | 14 ++------------
 51 files changed, 67 insertions(+), 236 deletions(-)
 create mode 100644 arch/microblaze/include/asm/barrier.h
 delete mode 100644 arch/microblaze/include/asm/cputable.h
 delete mode 100644 arch/microblaze/include/asm/hw_irq.h
 delete mode 100644 arch/microblaze/include/asm/tlb.h
 delete mode 100644 arch/microblaze/include/asm/user.h

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--suEhTRtVX8bYdm8JZot7qaxTQUYNJBhNT--

--OxY3ke9QSqcofq3HmqExvVtzXqqG1gxLK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXoNZrwAKCRDKSWXLKUoM
IdWFAJ9vgsBEgdwBGzIq5N67ljzNDAy9sgCgkygk+uy0U1EsJn+mcFpzXh0S4dA=
=60tj
-----END PGP SIGNATURE-----

--OxY3ke9QSqcofq3HmqExvVtzXqqG1gxLK--
