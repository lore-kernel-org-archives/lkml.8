Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D95820801
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgFJU2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgFJU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:28:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5331AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:28:42 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jj7Kv-006d70-IQ; Wed, 10 Jun 2020 20:28:37 +0000
Date:   Wed, 10 Jun 2020 21:28:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [git pull] uaccess i915
Message-ID: <20200610202837.GV23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Low-hanging fruit in i915; there are several trickier followups,
but that'll wait for the next cycle.

The following changes since commit b44f687386875b714dae2afa768e73401e45c21c:

  drm/i915/gem: Replace user_access_begin by user_write_access_begin (2020-05-01 12:35:22 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.i915

for you to fetch changes up to 7b3f0c4c56b08a86f890cad3599242c78c683aa9:

  i915:get_engines(): get rid of pointless access_ok() (2020-05-01 20:35:42 -0400)

----------------------------------------------------------------
Al Viro (5):
      i915: switch query_{topology,engine}_info() to copy_to_user()
      i915: switch copy_perf_config_registers_or_number() to unsafe_put_user()
      i915 compat ioctl(): just use drm_ioctl_kernel()
      i915: alloc_oa_regs(): get rid of pointless access_ok()
      i915:get_engines(): get rid of pointless access_ok()

 drivers/gpu/drm/i915/gem/i915_gem_context.c |  5 ---
 drivers/gpu/drm/i915/i915_ioc32.c           | 14 +++----
 drivers/gpu/drm/i915/i915_perf.c            |  3 --
 drivers/gpu/drm/i915/i915_query.c           | 62 ++++++++++-------------------
 drivers/gpu/drm/i915/i915_reg.h             |  2 +-
 5 files changed, 28 insertions(+), 58 deletions(-)
