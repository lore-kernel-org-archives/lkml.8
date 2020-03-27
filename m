Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27234C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EB820578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4bES7e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgC0G67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:58:59 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:40776 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0G67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:58:59 -0400
Received: by mail-ot1-f41.google.com with SMTP id r19so2859462otn.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0OvgzAUpJOb5U0m6XVla+IjaXNlPer0DBm+gmB2qBB4=;
        b=A4bES7e6LdCzvpj80XAcy0n6U4veuE/qDWGvby2jJcgM+/RPFGWdasYCAOn11/6fOO
         m0g5lZ9pyLRWKb6FiRJY+FtJbcSwShv1bNB1ajmUXjl5Vilvpk5Le1W1ulZ94zqJAJ/3
         Q9jnEw61OgPC/f+JMRJZlL4b+1TTn3ynX/9NRNaan0Fe8At0G8rWH11gMX4l+LdPi7nS
         jLTgOMCm15gT8BGktGUe8PGDG5VqaIbeXe/U0RrhpJc8NpWv/fx/1CI+GLNGNNcSZqqK
         jZ0loHhNJEVD/Iu3VwJiMLn0GaAK/kmU6LpgzaWrSYqsYF1FzFnQj97xedT7HkEBEAZ3
         UhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0OvgzAUpJOb5U0m6XVla+IjaXNlPer0DBm+gmB2qBB4=;
        b=UNQpqceuN7NdAC1gqZ53VJTZ6ikh/Py1IxJbYLqQnMmGjB5gWZyPWDUk112dcoz/b7
         MmNAYJqo/5H//BcpYOb5vTnIhKYVNg/2ajmwWYKzI4fjRALo8MZpNE92BzUTfHSv96ZS
         SPjDCEPA73sejX5bSnEYI0qFUttn7p0Flo6r1wmxA89mzTnX51pwS0NhkLFFgDQdydGh
         Vijlh5c5pXs9itFW95dIHgQ9UeP1JqhhMoNJYMtzl1j2GLrGueY8/sW88GQD8bF2JOxG
         UGVqjFbo3h1mn/8XHd54ppNLmDkEOpZaT56Op0CNNjIXwFS85CYc/k5Oajj2IYj4XoUR
         a5eQ==
X-Gm-Message-State: ANhLgQ19uBVVTljC/fK8G8TSIvUBqpZbZKDkfApvhouIlwBf073NKoNh
        aVVgfoK2fdQrPQchgvxB6kzj3d/Eg51WFeQ28hw=
X-Google-Smtp-Source: ADFU+vsN+CBLq7qZ8M51XGNT/SlTLkXGErxUW4g9/CgvsRZQshcve9+asKn+qyXR7fEP22LHUmSOPJlRZ7jauLjKboE=
X-Received: by 2002:a9d:4802:: with SMTP id c2mr6462122otf.78.1585292338382;
 Thu, 26 Mar 2020 23:58:58 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Mar 2020 16:58:46 +1000
Message-ID: <CAPM=9tx=PisdA7qzEBz+n9Sqc4YfSpaSV-ja3tf7MjBnZ=_NXg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.6-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Pretty quiet some minor sg mapping fixes for 3 drivers, and a single
oops fix for the scheduler.
I'm hoping nobody tries to send me a fixes pull today but I'll keep an
eye out of the weekend.

Dave.

drm-fixes-2020-03-27:
drm fixes for 5.6-rc8/final

radeon/amdgpu/dma-buf:
- sg list fixes

scheduler:
- oops fix
The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-03-27

for you to fetch changes up to c4b979ebcafe978338cad1df4c77cdc8f84bd51c:

  Merge tag 'amd-drm-fixes-5.6-2020-03-26' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-03-27
13:03:17 +1000)

----------------------------------------------------------------
drm fixes for 5.6-rc8/final

radeon/amdgpu/dma-buf:
- sg list fixes

scheduler:
- oops fix

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-misc-fixes-2020-03-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.6-2020-03-26' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Shane Francis (3):
      drm/prime: use dma length macro when mapping sg
      drm/amdgpu: fix scatter-gather mapping with user pages
      drm/radeon: fix scatter-gather mapping with user pages

Yintian Tao (1):
      drm/scheduler: fix rare NULL ptr race

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/drm_prime.c             | 2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
 drivers/gpu/drm/scheduler/sched_main.c  | 2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)
