Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC8C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918832073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="y9yAC60A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBKVtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:49:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42869 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBKVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:49:07 -0500
Received: by mail-oi1-f195.google.com with SMTP id j132so14320513oih.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 13:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FVB/FcS1YOjObTBIYNnVwzrPxX/PinI+dOSwT8ez2L8=;
        b=y9yAC60AVrZQixjl326TyeNDbhyODKMwz9kKbdXLmYJ7yuLP7+N/R7imC2n5zmdjsd
         xbQWK68oFv3C0BdUgO/mnokdGoADVVi54e6xpDyWasTg/i9BHP37QqPhIMeru8YsxH81
         L76OFlAE096nnOxGKP1NP0crqf6AQGzM145x0vn2YDA3gi7kemrtwulQmVhIF0KumRDs
         qT24enBkvSv6FAkgalwyqYijjHETJLlx2tCbLwLAShAX4rlYMjAJ94HFB9HlauYK6Rxn
         no/KdVjAPrJon48Fth0FK03FqHomy5Pzl0NvHWL2YUQzxOk1aGvQA3OC0n4hJOnB1hvq
         hgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FVB/FcS1YOjObTBIYNnVwzrPxX/PinI+dOSwT8ez2L8=;
        b=O+h6STbUtnX55tx1XXqV18CNrt1i7JpRTGeo2ZOyf936wwn6Gc//bH5kHTxOiEeW1X
         M5wAXGLDgh7UC8i5lm2SyKhAk6KSAFIIrXGHInoZ7mlBPKUHaTp/mPsBhqT1K6XRdcuD
         QOLg3btMz+tcm1rrujZC1uqrca6YEhVubrr4SHYhE9zwUOxLJfeNrdpKQLWMhIAAy4j5
         st1NhiXPHSRySU2dHDfPVmmSszN8ORlcS/zrgGEek24vI76tXT7yS4L7SOETvDKEQm45
         gKN8Jgrtg1eaS26rzjZVzSDmxl6juxIIeRQU1jSEqSxdrXXPZD7J9HVaB+1l8X+AqKN9
         bzsA==
X-Gm-Message-State: APjAAAUv9AvwxzYZt+lfXyZj5V/PKQ+eJkO2j8e/XLQAUU/FsjmQ1zca
        H2ybainE3hQbZwP+SWpNTs5NEFk6Cf9lpFxkhXPjp4OnnRY=
X-Google-Smtp-Source: APXvYqy8Gw71waEd6oNkzeNXV51JRxA7IyRoFOyWOQUMhEEWpqf0WTeOmjmyRiRWGbyVxa175PNVu9gVDG5VrM6mXw4=
X-Received: by 2002:aca:aa0e:: with SMTP id t14mr4249907oie.149.1581457747093;
 Tue, 11 Feb 2020 13:49:07 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Feb 2020 13:48:56 -0800
Message-ID: <CAPcyv4iQf80XGwYVU3-GnbxU7u+bu2bn=+MwM54WGyG1kN=ddQ@mail.gmail.com>
Subject: [GIT PULL] dax fixes for v5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.6-rc1

...to receive a fix for an xfstest failure and some and an update that
removes an fsdax dependency on block devices. The update is small
enough that I held it back to merge with the fix post -rc1 and let it
all appear in a -next release. No reported issues in -next.

---

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/dax-fixes-5.6-rc1

for you to fetch changes up to 96222d53842dfe54869ec4e1b9d4856daf9105a2:

  dax: pass NOWAIT flag to iomap_apply (2020-02-05 20:34:32 -0800)

----------------------------------------------------------------
dax fixes 5.6-rc1

- Fix RWF_NOWAIT writes to properly return -EAGAIN

- Clean up an unused helper

- Update dax_writeback_mapping_range to not need a block_device argument

----------------------------------------------------------------
Jeff Moyer (1):
      dax: pass NOWAIT flag to iomap_apply

Vivek Goyal (2):
      dax: Pass dax_dev instead of bdev to dax_writeback_mapping_range()
      dax: Get rid of fs_dax_get_by_host() helper

 drivers/dax/super.c |  2 +-
 fs/dax.c            | 11 ++++-------
 fs/ext2/inode.c     |  5 +++--
 fs/ext4/inode.c     |  2 +-
 fs/xfs/xfs_aops.c   |  2 +-
 include/linux/dax.h | 14 ++------------
 6 files changed, 12 insertions(+), 24 deletions(-)
