Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C597C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2937520656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxZFLhkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFKIjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFKIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:39:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207EC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:39:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d15so3324314edm.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Jt69eBlMhftqx8Dq8Pz0jiYvo6ytNHDe7koTS1ms+pI=;
        b=nxZFLhkwo4sP6AWmBPZkr63bEC/8MW8U75TZkOCxIbVTBfNFPL0mk8kcjT7xUE6UBy
         y94lUvzzH62bHqnDjdusHnfc7CyvOJSxNP0y0if/fXKu+k1bNmdTcYHazpVa0oGmcg28
         2J2XH21D2zf/+kftXNVG0JkUPk6rBGFSNpsK78Yu4UAFoNCVCS7Jp7VH3VcclFRNsjUF
         9RRo2ReLqKfa8zpVZtgVQaWU6C5BmS3kCJjKbNY07DM7ZI1oDr9tepK0FrKX7QWimZcn
         gWpioeCD44VEcYOS5NNDdlLJPPLBsjO9gsSj0QICd420olLKzzUk9fyUEG0UseLxfiST
         RyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Jt69eBlMhftqx8Dq8Pz0jiYvo6ytNHDe7koTS1ms+pI=;
        b=W4yKhMstn2XCNWCrikjrPMvCcguNTg+AuvGxc7y0J7yJs47i9tGY7nHsdwVBCxLBAX
         U+52pqlqa4eJ4Yet5Qv477lq64f9HWLV3/j13hRxwf/oj6ugBc1GEXzIKB+/sfh2wnUE
         5yHghtZ1ArBrdMal4EG95Z/S7ZzGWml9H7vFrKmZPTjk2MQLkzUL8NKn3SV8q6TVlNbq
         /cJpJWd/ZYKA+0NFzSAlhYr3I1MT9B2XtKL/cVXhA/tTK9ZJxWzDV2ULxW0o0RIpY6Uj
         Rv3k5/QKfu2DKo5blFlZB31WnYkNWUWZoT9igE857ixfJo0t1VUyRyolVMvthyTv394u
         CJFQ==
X-Gm-Message-State: AOAM533FGt53jWhPXRzAeERJG+gK7omyUaIcQCsPjCkVLKoi44CK57JF
        6lbantXzOrO5DR84bt8ai3YgtI5lP4OpTDcCWfZAs93o
X-Google-Smtp-Source: ABdhPJy5hJspyiNYrlGvO+ocRla/Mn05EuhoMs0ELNp6CGUyPq7wCaBaKd7//pzT+bDbrBQIE44nDtC9AJYM1apPoXQ=
X-Received: by 2002:a05:6402:1481:: with SMTP id e1mr6060527edv.113.1591864745013;
 Thu, 11 Jun 2020 01:39:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 11 Jun 2020 18:38:54 +1000
Message-ID: <CAPM=9tyM72CtJbA4Q9wKnft6oQoMLGEt=xCYBcPn9wK9F=+Uwg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.7-rc1 (updated pull)
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

This is the update of the pull I sent earlier today, it's got a couple
of more fixes along with the i915 fixes. One sun4i fix and a connector
hotplug race The ast fix is for a regression in 5.6, and as mentioned
previously one of the i915 ones fixes an oops reported by dhowells.

definitely taking tomorrow off now :-)

Regards,
Dave.

drm-next-2020-06-11-1:
drm fixes for 5.7-rc1

core:
- fix race in connectors sending hotplug

i915:
- Avoid use after free in cmdparser
- Avoid NULL dereference when probing all display encoders
- Fixup to module parameter type

sun4i:
- clock divider fix

ast:
- 24/32 bpp mode setting fix
The following changes since commit 8d286e2ff4400d313955b4203fc640ca6fd9228b:

  Merge tag 'drm-intel-next-fixes-2020-06-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-06-08
11:59:57 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-06-11-1

for you to fetch changes up to 66057dd1d1cf2149e0f5fdaee58d6ea69bc98048:

  Merge tag 'drm-misc-next-fixes-2020-06-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2020-06-11
17:51:15 +1000)

----------------------------------------------------------------
drm fixes for 5.7-rc1

core:
- fix race in connectors sending hotplug

i915:
- Avoid use after free in cmdparser
- Avoid NULL dereference when probing all display encoders
- Fixup to module parameter type

sun4i:
- clock divider fix

ast:
- 24/32 bpp mode setting fix

----------------------------------------------------------------
Chris Wilson (2):
      drm/i915/gem: Mark the buffer pool as active for the cmdparser
      drm/i915/display: Only query DP state of a DDI encoder

Colin Ian King (1):
      drm/ast: fix missing break in switch statement for format->cpp[0] case 4

Dave Airlie (2):
      Merge tag 'drm-intel-next-fixes-2020-06-10' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-fixes-2020-06-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

Jani Nikula (1):
      drm/i915/params: fix i915.reset module param type

Jernej Skrabec (1):
      drm/sun4i: hdmi ddc clk: Fix size of m divider

Jeykumar Sankaran (1):
      drm/connector: notify userspace on hotplug after register complete

 drivers/gpu/drm/ast/ast_mode.c                 |  1 +
 drivers/gpu/drm/drm_connector.c                |  5 +++
 drivers/gpu/drm/drm_sysfs.c                    |  3 --
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 56 ++++++++++++++++++++++----
 drivers/gpu/drm/i915/i915_params.c             |  2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h             |  2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c     |  2 +-
 8 files changed, 60 insertions(+), 14 deletions(-)
