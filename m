Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523AF2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438112AbgE2Akz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388613AbgE2Aky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:40:54 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FFC08C5C6;
        Thu, 28 May 2020 17:40:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeT4s-00HFcr-Il; Fri, 29 May 2020 00:40:50 +0000
Date:   Fri, 29 May 2020 01:40:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCHES] uaccess i915
Message-ID: <20200529004050.GY23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234025.GT23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Low-hanging fruit in i915 uaccess-related stuff.
There's some subtler stuff remaining after that; these
are the simple ones.

	Branch in uaccess.i915, based at uaccess.base.

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

