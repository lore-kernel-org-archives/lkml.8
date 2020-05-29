Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C241C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69462078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUbkmIff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437994AbgE2AVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437625AbgE2AV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:21:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0AC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:21:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e10so435755edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4pM5c1cQ3g56121SjZ45rsEvKVQSMwyRfhGxq2A2I20=;
        b=IUbkmIffxEwqCpMwWLh1vmsPQ7VxJcD3qTZG5Ka6UZWTllIoAkYpB74ISHCgk23NWl
         9P+Sz5avR05RP7ETk8tXcR6ruiCLRscFWAm4f/gQGeu8cfe9aZkEnKtQIip1f6dl+UfZ
         VDQ+rXM7LAXWxRbf/4ur+ojXUPwthzE/WPRqXXJU8F9CnfIMElxpTNWhYJnxc43zYEao
         tKXsTRw0md60MgAcId0a1MV14eQMp1QqEOFTtdsQp6+9TXGW2E2Pgit80kCY/rp7Qm7I
         DqkK7p+NwyYn6hqf+83Sd/QzExwTFhQjqO5QRF3NtbomWPFc1wkHbVLz/IxgLHqVDjcV
         oUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4pM5c1cQ3g56121SjZ45rsEvKVQSMwyRfhGxq2A2I20=;
        b=pqaVWy887p2pJW+B66Ip9W9RIEDQ0BfZgrUMV/E17r9e1dPAv9NSmoVbH4+zzOSY5+
         dci369hgLTgY75ydypANg+kcU3A6U3MOAFGa9ZBfP+sV9QTCqe3Seb07OqlMnn3IvjA0
         ctno2Fp8SOqsfwS/VhDtmbhmD9pSHkgdWdwpvOg+o1GK1N2assLno8GUbboKLJaXtjV5
         5YNhvIDV0ZS8FAdJrynts2AJW1cH5xfLJAq7L8gaAavVZ3iSEw6t+Sbw2J5q6X2KS8ek
         xG4J665YOslmObK66TVvQ6kfeGeZtrKHB94xMhpqWgWtIUcZKQwvY/ELhMpt8ZJ9eEZw
         YoMw==
X-Gm-Message-State: AOAM533SVIcYj4AwHTBja6su9OcQ427HiLDw9uV0Ij4r9vtv3CwB0hpx
        QUgUzUysbvzfV3jz1xhBK940CiRJIYYJiNX1Lcd26xY/LWs=
X-Google-Smtp-Source: ABdhPJz/E46YBu3Op2fxf9zP7Ifln5J3gZRDb1qfZb962EaMW3NEaM7dW9urbQHxeErnZ6p4gm4h2PbwmVr93qTF1fA=
X-Received: by 2002:a50:9547:: with SMTP id v7mr6158307eda.78.1590711684741;
 Thu, 28 May 2020 17:21:24 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 May 2020 10:21:13 +1000
Message-ID: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Seems to have wound down nicely, a couple of i915 fixes, amdgpu fixes
and minor ingenic fixes.

Should be it until the merge window.

Dave.

drm-fixes-2020-05-29:
drm fixes for 5.7 final

i915:
- gcc 9 compile warning fix
- timeslicing fixes

amdgpu:
- display atomic test fix
- Fix soft hang in display vupdate code

ingenic:
- fix pointer cast
- fix crtc atomic check callback
The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-05-29

for you to fetch changes up to d099f415d50c3980339479f56f124f8bfa6875bc:

  Merge tag 'drm-misc-fixes-2020-05-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-05-29
09:25:23 +1000)

----------------------------------------------------------------
drm fixes for 5.7 final

i915:
- gcc 9 compile warning fix
- timeslicing fixes

amdgpu:
- display atomic test fix
- Fix soft hang in display vupdate code

ingenic:
- fix pointer cast
- fix crtc atomic check callback

----------------------------------------------------------------
Aric Cyr (1):
      drm/amd/display: Fix potential integer wraparound resulting in a hang

Arnd Bergmann (2):
      drm/i915/pmu: avoid an maybe-uninitialized warning
      drm/i915: work around false-positive maybe-uninitialized warning

Chris Wilson (2):
      drm/i915/gt: Incorporate the virtual engine into timeslicing
      drm/i915/gt: Prevent timeslicing into unpreemptable requests

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.7-2020-05-27' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-05-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2020-05-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Paul Cercueil (2):
      gpu/drm: ingenic: Fix bogus crtc_atomic_check callback
      gpu/drm: Ingenic: Fix opaque pointer casted to wrong type

Simon Ser (1):
      drm/amd/display: drop cursor position check in atomic test

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   7 --
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   2 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  31 ++++--
 drivers/gpu/drm/i915/gt/selftest_lrc.c             | 118 ++++++++++++++++++++-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   2 +
 drivers/gpu/drm/i915/i915_pmu.c                    |  84 +++++++--------
 drivers/gpu/drm/i915/i915_priolist_types.h         |   2 +-
 drivers/gpu/drm/ingenic/ingenic-drm.c              |   6 +-
 8 files changed, 192 insertions(+), 60 deletions(-)
