Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39015C2BA17
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D74D2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzGjDNzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbgDBXf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:35:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43257 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390120AbgDBXf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:35:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id k5so4478934oiw.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FJ9qyX/ERFGH+sL2RwXnAwjcoDdSnfygv2TE0DrkPWo=;
        b=SzGjDNztDQhVQbdwBpZrpTB3sigb0d9gr0rb2ilzE5gv1OYeKmKhHVxgHuoB5EpDRr
         y5sK3xSBlLZz4I+rnBbmgsTE62hfp7wCJA9hSRNfaBJ2W7oE9trpYaBsBH6uk1JQH/Mb
         uxOw7OTviVCDrKdGrmMnlQuF1qZmnLa/4Xg+ZH5ksJo54THi+HjVMFyAf5WcyWaM8vWk
         iL5o5CAY+sm4smqIc3weyp+y0XAtZ8Pkn1S0PQUOflNTQfky+nJLOn8IT6RldJL5b9gG
         2aB6Tqw3K8I7n/84CgmfPjFD5hr6MvwcN8zTqz/KYCpw0jrTdW/S/8u5cd3bFF/H/BlE
         v9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FJ9qyX/ERFGH+sL2RwXnAwjcoDdSnfygv2TE0DrkPWo=;
        b=jiI9A3e47b8N0wVPuBWPhgBXjCMSYwJGT374L/qRYK6ykxMZfmzO1bIItMwcy/aVEU
         VJl9jZ96MLbbHswQS2SrNSqE/NJIJOV6WQcHd23s31J9MCGtfpiqSQQMbyrZq+394pXw
         xqt3pFiSq+mLk66m/ekWsGV1SSjlI1sc1AIozvGpc/h0nSpaCin2ppvsjiJD4bSICJu0
         kRSpuqY7pmjcl3g27Kvp2vrxq1sNCC0JrBSPhYcwIaBduX3GM+X6hoPz7JR9PcufPmhd
         FuDTThvx2IG0v3MLsMaYEwuNoPZiLtzpo4e0wl9G6REfm8ze36UgmZM6kspaC6JVXMnM
         U8MQ==
X-Gm-Message-State: AGi0PubuvzrdbAygYnkyL8H8PxLbXMH+TDoxyTR4If2Pmm+JKIZBwq0u
        CvREJXCHq9eNMOzYE97p5dKijDxT1fdCdBHRoArFoYBjtQc=
X-Google-Smtp-Source: APiQypJTQCO1O4Bgs3Gvhy9fyJ3ltnUEFJm8VzH3M/nuCD+9qFLUrR2PFdZacna+b1hbGXGm6k+tb7uaA25CpVSNW1s=
X-Received: by 2002:a05:6808:b1a:: with SMTP id s26mr1073671oij.150.1585870555434;
 Thu, 02 Apr 2020 16:35:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 3 Apr 2020 09:35:43 +1000
Message-ID: <CAPM=9tz_FMuxj+RH3VqzVyN2yQC9xy8vePAz14HPKtVfEXs2iA@mail.gmail.com>
Subject: [git pull] drm ttm hugepages feature pull for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the second pull, it has some changes to mm in it that should
all have acks on them. The first dax constify arg patch got an ack on
the list from Matthew Wilcox and Dan Williams after the MR was sent,
but I didn't think it was worth a resend for that.

This adds support for hugepages to TTM and has been tested with the
vmwgfx drivers, though I expect other drivers to start using it.

Dave.

drm-next-2020-04-03-1:
drm: add support for hugepages to TTM
The following changes since commit 59e7a8cc2dcf335116d500d684bfb34d1d97a6fe:

  Merge tag 'drm-msm-next-2020-03-22' of
https://gitlab.freedesktop.org/drm/msm into drm-next (2020-03-31
16:34:55 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-04-03-1

for you to fetch changes up to 0e7e6198af28c1573267aba1be33dd0b7fb35691:

  Merge branch 'ttm-transhuge' of
git://people.freedesktop.org/~thomash/linux into drm-next (2020-04-03
09:07:49 +1000)

----------------------------------------------------------------
drm: add support for hugepages to TTM

----------------------------------------------------------------
Dave Airlie (1):
      Merge branch 'ttm-transhuge' of
git://people.freedesktop.org/~thomash/linux into drm-next

Thomas Hellstrom (VMware) (9):
      fs: Constify vma argument to vma_is_dax
      mm: Introduce vma_is_special_huge
      mm: Split huge pages on write-notify or COW
      mm: Add vmf_insert_pfn_xxx_prot() for huge page-table entries
      drm/ttm, drm/vmwgfx: Support huge TTM pagefaults
      drm/vmwgfx: Support huge page faults
      drm: Add a drm_get_unmapped_area() helper
      drm/vmwgfx: Introduce a huge page aligning TTM range manager
      drm/vmwgfx: Hook up the helpers to align buffer objects

 drivers/gpu/drm/drm_file.c                 | 141 ++++++++++++++++++++++++
 drivers/gpu/drm/ttm/ttm_bo_vm.c            | 161 +++++++++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/Makefile            |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  12 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c |  76 ++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c        | 166 +++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c   |   5 +-
 include/drm/drm_file.h                     |   9 ++
 include/drm/ttm/ttm_bo_api.h               |   3 +-
 include/linux/fs.h                         |   2 +-
 include/linux/huge_mm.h                    |  41 ++++++-
 include/linux/mm.h                         |  17 +++
 mm/huge_memory.c                           |  44 ++++++--
 mm/memory.c                                |  27 +++--
 16 files changed, 692 insertions(+), 28 deletions(-)
 create mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c
