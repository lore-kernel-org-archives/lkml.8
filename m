Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684CC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F1320679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBQKTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:19:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:46853 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQKTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:19:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:19:52 -0800
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="223784660"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 02:19:51 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Christian Kujau <lists@nerdbynature.de>,
        intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm: bugs.freedesktop.org is no longer accepting bugs
In-Reply-To: <alpine.DEB.2.21.99999.375.2001141825300.21037@trent.utfs.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <alpine.DEB.2.21.99999.375.2001141825300.21037@trent.utfs.org>
Date:   Mon, 17 Feb 2020 12:19:48 +0200
Message-ID: <87y2t1v7ln.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Christian Kujau <lists@nerdbynature.de> wrote:
> Hello,
>
> this should apply cleanly to drm-tip.
>
>
>     drm: bugs.freedesktop.org is no longer accepting bugs.
>     
>     freedesktop.org Bugzilla is no longer in use and new DRM bugs
>     should be reported to https://gitlab.freedesktop.org/drm/intel
>     instead. While we're at it, update some URLs of still-open bugs
>     that have been moved to the new bug tracker.
>     
>      drivers/gpu/drm/i915/Kconfig           | 3 +--
>      drivers/gpu/drm/i915/i915_gpu_error.c  | 2 +-
>      drivers/gpu/drm/i915/i915_utils.c      | 2 +-
>      drivers/gpu/drm/radeon/radeon_device.c | 2 +-
>      4 files changed, 4 insertions(+), 5 deletions(-)
>     
>     Signed-off-by: Christian Kujau <lists@nerdbynature.de>

Thanks for the patch, we've ended up fixing this with commits:

3a6a4f0810c8 ("MAINTAINERS: Update drm/i915 bug filing URL")
ddae4d7af0bb ("drm/i915: Update drm/i915 bug filing URL")

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
