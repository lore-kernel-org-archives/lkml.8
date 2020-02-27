Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A33C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C42469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582823871;
	bh=sa147JV2FGJUDr6ETosgy8EqpM2VYq5KtE1TuAGkaxY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=GKHsUYUdFznTuo/Jj1D9/8l6KE2OOElxHZrK4Y8PVKjsVPXG4FumMx7o+gepegVoX
	 lhixCeFEwMVItX+SD7HJ5gz4/gUNJa4+W6T7yzDtbPpv70jy1d2D4n5Fn/tGSljt2C
	 Pq7EHZ8clCG4Id/kdCcjdrvNBjODAlvtugP24kho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgB0RRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:17:50 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:27297 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgB0RRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:17:50 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 01RHHYix032552;
        Fri, 28 Feb 2020 02:17:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01RHHYix032552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582823855;
        bh=hshphCwI9hlBaEv/EA7m0UL3MjbTptk/dX4jdB/N3zo=;
        h=From:Date:Subject:To:Cc:From;
        b=Nc5bCj+kuNzNVfc5EfU6LUTx5nBvC/a5sO37DXECEzJP5UpgO1SnLWuecp4Ba2TJN
         +mRFGKLWFabTjWChAvByMdzB+88Z6mOzQXe++KOOjm7EheAQb6YedB5OLvWYq9Q4S3
         lNa7W5GkUXXYeJoW8XwDGBHO8t3aKE+hnq0wQZN+p9JDAOiJRI8Y8QBSiVPNDp8sH5
         fM9F0itHxafY0lt2r41+loIFxa/KZMX2AgwhUHT1OEtTsYmjpqEXDgIJJT7vqRv8Ux
         BWpBBc+9CxDRqndPaifL4CrIVfXilgCHC2P8i1wj7z3NYGJL2/z+b1ddnLYBo++A0n
         sbG3UTWkPa3ZA==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id c7so1237460uaf.5;
        Thu, 27 Feb 2020 09:17:34 -0800 (PST)
X-Gm-Message-State: APjAAAWVHfH0+NJY0KCqfTsk7z1PPrVaUcRylBACedlZ1p3nWWhlpLdd
        wSyAQ0zirZJca5QNkDo/mmXklwofbBD5JyUzmEI=
X-Google-Smtp-Source: APXvYqydl8esFpucwUoItXP6yoV9ufMtub38hFn1IFr/D1DHXbSbZGqn5FTEXUWg/LpmrNeEF1EhUGGSLyd78y3FINU=
X-Received: by 2002:ab0:3485:: with SMTP id c5mr2874123uar.109.1582823853252;
 Thu, 27 Feb 2020 09:17:33 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Feb 2020 02:16:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDV1hBV_4U6wHHMFfxsxctFhVpk4gUQ+pYMay1i4Memw@mail.gmail.com>
Message-ID: <CAK7LNASDV1hBV_4U6wHHMFfxsxctFhVpk4gUQ+pYMay1i4Memw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.6-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some more Kbuild fixes.
Thanks!


The following changes since commit f8788d86ab28f61f7b46eb6be375f8a726783636:

  Linux 5.6-rc3 (2020-02-23 16:17:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.6-2

for you to fetch changes up to eabc8bcb292fb9a5757b0c8ab7751f41b0a104f8:

  kbuild: get rid of trailing slash from subdir- example (2020-02-27
10:03:27 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.6 (2nd)

 - fix missed rebuild of DT schema check

 - add some phony targets to PHONY

 - fix comments and documents

----------------------------------------------------------------
Masahiro Yamada (6):
      kbuild: remove wrong documentation about mandatory-y
      kbuild: fix DT binding schema rule to detect command line changes
      kbuild: remove unneeded semicolon at the end of cmd_dtb_check
      kbuild: add dtbs_check to PHONY
      kbuild: add dt_binding_check to PHONY in a correct place
      kbuild: get rid of trailing slash from subdir- example

Randy Dunlap (1):
      kbuild: add comment for V=2 mode

 Documentation/kbuild/makefiles.rst | 5 +----
 Makefile                           | 4 +++-
 scripts/Makefile.lib               | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)


-- 
Best Regards
Masahiro Yamada
