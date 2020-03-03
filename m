Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B72DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0966320716
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+mHr36y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgCCE0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:26:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33825 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCCEZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:25:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id y21so806993pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=CxfWkFR7/Hf1KoCgs07vjHkf63viEFscFFv9Lke4q7s=;
        b=G+mHr36y0yILmaCWlshEmzyNE4UXd2HmpG67nDjoJ/brEh5/PosQq707USeu0mHvR+
         fAo+70VA3yj8JTCFnqtP7BA5zTYKXptcP34BZo9+Rhh+vqf4d40OFxGxlen2VYkpESxh
         ypoY8oN4WnbeQ8otr/oxP0UEBsemuMq7+AcZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CxfWkFR7/Hf1KoCgs07vjHkf63viEFscFFv9Lke4q7s=;
        b=iue/qaox2Q5/P3UBAjC0M6G5BVBX++x4F0+M2WTdo+Iz/Ul1BFgCfCa+/48nfLmfTt
         F210OSEqj8vni8Wh6joI2LcQXjpAnjgOp70YkYOKSGfuCY1TivYuSEA/56IAFyLet4nJ
         0l3sQ3CNJZE1qRdDn/Z+Y/RWb8fdnab21Ufnek1v6H+uexWB9VfvU0v/4D0E+KMkSXdo
         yGHRA+78KMsiEzJNuTBrKnx3i9c+H5Io77z5XdPuxXDdn9ENAqeO1Trp8tuC56lC50j0
         tPYy6VJw3poLzVhVBdkUQst/PwB0D2RujsjdvsOxCs1/ULHviXlwEKMrtUwppVx/iR3n
         1tsw==
X-Gm-Message-State: ANhLgQ2xqoukH4Q5WA4eSdY8jEnejcQf2l1bmEppQzWvyFChmO08tFC+
        1DOA+zbGbm+FSQJoiA0PXcC10UzZgFs=
X-Google-Smtp-Source: ADFU+vvoZQ4SBSKOzxHG8Wbn5nBEyB2Q+736EzXccb2bgRebcc171hsjwuHNqJpVIqa3cFWvCMJjIw==
X-Received: by 2002:aa7:947b:: with SMTP id t27mr2390970pfq.212.1583209558779;
        Mon, 02 Mar 2020 20:25:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11sm22680868pff.111.2020.03.02.20.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:25:57 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:25:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [GIT PULL] READ_IMPLIES_EXEC cleanup for -tip next
Message-ID: <202003022019.7A20027@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Please pull these READ_IMPLIES_EXEC cleanups. They've got Acks, and have
been sitting without further commented since v4:
https://lore.kernel.org/lkml/20200225051307.6401-1-keescook@chromium.org/#r
Catalin specifically asked me during Plumbers if I could get this series
refreshed and finalized, so here we are! :) I'd wanted to keep these all
together so per-arch RIE special cases were changed at the same time.

Thanks!

-Kees

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/rie-cleanup-next

for you to fetch changes up to 631551ed971466e4a7ea0b6b11a4ddf2b80513d3:

  arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces (2020-02-24 21:00:51 -0800)

----------------------------------------------------------------
READ_IMPLIES_EXEC cleanups

- Fix READ_IMPLIES_EXEC across x86, arm64, and arm

----------------------------------------------------------------
Kees Cook (6):
      x86/elf: Add table to document READ_IMPLIES_EXEC
      x86/elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
      x86/elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
      arm32/64, elf: Add tables to document READ_IMPLIES_EXEC
      arm32/64, elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
      arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces

 arch/arm/kernel/elf.c        | 27 +++++++++++++++++++++++----
 arch/arm64/include/asm/elf.h | 23 ++++++++++++++++++++++-
 arch/x86/include/asm/elf.h   | 22 +++++++++++++++++++++-
 fs/compat_binfmt_elf.c       |  5 +++++
 4 files changed, 71 insertions(+), 6 deletions(-)

-- 
Kees Cook
