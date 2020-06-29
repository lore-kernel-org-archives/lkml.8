Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8049204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgF2S7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:59:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:65096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgF2S6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:58:49 -0400
IronPort-SDR: r0gTR4kA870baJipU5/F7+kqTjWM+Vymr8J9luNv8m9xikrmZL+y/ZIJeZWXg3qvLwRzyOu76F
 u2iAbVTPYN0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147476356"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="147476356"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:36:58 -0700
IronPort-SDR: 5CFwUUYKezJG8uwxTNaFRlfpaxiNMkat09ftU4z9soCcHoKdEwEioot3wnIBcTlovzfFv0+hht
 Xo0iwVpojXtw==
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="454118198"
Received: from unknown (HELO localhost) ([10.252.54.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 01:36:55 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [git pull] drm fixes for v5.8-rc3
In-Reply-To: <CAPM=9tyuBF_AmAMxL1U=ofd4=kxN_39-EOW3c3rGNFyb4=ut8Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAPM=9tyuBF_AmAMxL1U=ofd4=kxN_39-EOW3c3rGNFyb4=ut8Q@mail.gmail.com>
Date:   Mon, 29 Jun 2020 11:36:52 +0300
Message-ID: <87tuyumfob.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020, Dave Airlie <airlied@gmail.com> wrote:
> Usual rc3 pickup, lots of little fixes all over, The core VT
> registration regression fix is probably the largest, otherwise ttm,
> amdgpu and tegra are the bulk, with some minor driver fixes. No i915
> pull this week which may or may not mean I get 2x of it next week,
> we'll see how it goes.

Been really quiet here, basically I only got GVT fixes pending.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
