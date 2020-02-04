Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3469A2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dou1HxKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBDLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:08:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:08:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id m10so1965715wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 03:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=from:autocrypt:to:cc:subject:message-id:date:user-agent
         :mime-version;
        bh=nXNQPeTx3VWuxwG3xcGt5hQeGg6l1f+l/YFGqISqiUE=;
        b=dou1HxKK4K55Ne5BnZNGGG7Wzc8tyFRFIB5M1PYYeLomiqTFljnO3HeV5HxqagnfVo
         whMB2NbOZoFHTgXT6HWyE1nSOWahh458VLcKbhGtFtT2u0ePR9h1a5gVJU7OputsTZ7T
         m6YanLA1WvSFrPT75G90G5sY/5EeNoDOVBtiTPHqWwI02Hmf6SW7HTtw9w8x+2WqBzDX
         bGT1MmblEHxInNEPYfy+DQ/7s0GhFGP9lRqZOC2zVYJ6yjCXWs70D5D5qG8ax0JxnIqh
         eaZE0B+3FUFyYcKq+JT0Z2IXVmq74vsOhCvah1BlXuxmTsNgs9Dj84CMEelQRQ8AoOCu
         S39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:cc:subject:message-id:date
         :user-agent:mime-version;
        bh=nXNQPeTx3VWuxwG3xcGt5hQeGg6l1f+l/YFGqISqiUE=;
        b=Tu4Gjon2YwjmCRA3R10V55MQQsOmheXbvhO8RHUa2ycbawmog+E8EkdX9Z22nfAB1d
         4Y/MJ5oUHVtH+BI/kCGarOvfzgAQAd/h+oMtlXqLCTEvM9dXe6jGUoohbfdxpd787GYV
         KRUz7Z9bUqKV0ZtCmW7260jKO0S0dweFdGncyX7GLct81KqJtxCaVJ/26NmkAEGy9iAN
         mA1JWdonThG7524cDXgI6vkzcap3QJ519OJMI/Nrd/ZONN6577T2x25j759FA3sf8dZc
         J9A0NBtkdZy/4x1F7yQd9zWgze7g6DfCZpVBszKOWwDk+DB7udaUts7T6m35Gs/3y1gy
         kPrg==
X-Gm-Message-State: APjAAAWA8vZxQrNy088V4zh4EadMrKV1VawnGA5G20ZuPtSiwZnFH1yz
        ZhyhygL/LScHasNCR9lBg92YXDvECl912Q==
X-Google-Smtp-Source: APXvYqy0DrzfWnLOPt4sFskdsNiv1RD0rqjYZfvwVeL93s+YzQ49Ifa5e6U81Xq3uGMfAfCX8TEpjg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5129542wmb.174.1580814513453;
        Tue, 04 Feb 2020 03:08:33 -0800 (PST)
Received: from [173.194.76.108] ([149.199.62.130])
        by smtp.gmail.com with ESMTPSA id l15sm29096963wrv.39.2020.02.04.03.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 03:08:32 -0800 (PST)
From:   Michal Simek <monstr@monstr.eu>
Autocrypt: addr=monstr@monstr.eu; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] arch/microblaze patches for 5.6-rc1
Message-ID: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
Date:   Tue, 4 Feb 2020 12:08:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PVLRZ5YsLnGWkAoO65oHS6PUx7n8ceEv0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PVLRZ5YsLnGWkAoO65oHS6PUx7n8ceEv0
Content-Type: multipart/mixed; boundary="wesOwkT7Wp3FKuE8ixawvQkkFiONf5Bfm";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <92cc6617-e2c3-e3b8-cf20-c8ccf748d37a@monstr.eu>
Subject: [GIT PULL] arch/microblaze patches for 5.6-rc1

--wesOwkT7Wp3FKuE8ixawvQkkFiONf5Bfm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the following patches to your tree. I have also including my
patch for dma-contiguous.h suggested by Christoph and acked by others
with Microblaze CMA wiring.

Thanks,
Michal


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c3=
5a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.6-rc1

for you to fetch changes up to 6aa71ef9bcf9d8688c777dfbff340348cb89a5b4:

  microblaze: Add ID for Microblaze v11 (2020-02-04 11:38:59 +0100)

----------------------------------------------------------------
Microblaze patches for 5.6-rc1

- Enable CMA
- Add support for MB v11
- Defconfig updates
- Minor fixes

----------------------------------------------------------------
Manish Narani (1):
      microblaze: defconfig: Disable EXT2 driver and Enable EXT3 & EXT4
drivers

Michal Simek (5):
      microblaze: Align comments with register usage
      microblaze: Sync defconfig with latest Kconfig layout
      asm-generic: Make dma-contiguous.h a mandatory include/asm header
      microblaze: Wire CMA allocator
      microblaze: Add ID for Microblaze v11

Shubhrajyoti Datta (1):
      microblaze: Prevent the overflow of the start

 arch/arm64/include/asm/Kbuild           |  1 -
 arch/csky/include/asm/Kbuild            |  1 -
 arch/microblaze/Kconfig                 |  1 +
 arch/microblaze/configs/mmu_defconfig   | 10 ++++++----
 arch/microblaze/configs/nommu_defconfig |  2 +-
 arch/microblaze/kernel/cpu/cache.c      |  3 ++-
 arch/microblaze/kernel/cpu/cpuinfo.c    |  1 +
 arch/microblaze/kernel/head.S           |  8 ++++----
 arch/microblaze/mm/init.c               |  4 ++++
 arch/mips/include/asm/Kbuild            |  1 -
 arch/riscv/include/asm/Kbuild           |  1 -
 arch/s390/include/asm/Kbuild            |  1 -
 arch/x86/include/asm/Kbuild             |  1 -
 arch/xtensa/include/asm/Kbuild          |  1 -
 include/asm-generic/Kbuild              |  1 +
 15 files changed, 20 insertions(+), 17 deletions(-)

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--wesOwkT7Wp3FKuE8ixawvQkkFiONf5Bfm--

--PVLRZ5YsLnGWkAoO65oHS6PUx7n8ceEv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXjlQqQAKCRDKSWXLKUoM
IbSpAJ41SeO54Cpg9E5rzp17EgQ60Uhc5ACdHWlNIWoIEJuBsmlt7Ib/uY5O8W0=
=poJj
-----END PGP SIGNATURE-----

--PVLRZ5YsLnGWkAoO65oHS6PUx7n8ceEv0--
