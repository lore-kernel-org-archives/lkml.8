Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0502067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgHYJzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:55:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:51130 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbgHYJzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:55:33 -0400
IronPort-SDR: pZu2LfBsiVj80GfFJ7utuJxX/JPdglIhYbZDdo5w3o0V+/Zim3KVkxeXjlr6PKC5hT5DyEgMH2
 6M+6tJgX20FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136139931"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="136139931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 02:55:32 -0700
IronPort-SDR: SO5pteS+3BNVXHt9gxEDvxYfrNdjv2PGu99rQW43zfRbMCLaRf+GnKSUtkkxGAnJx8qQxEgSIX
 vtC4BDimXcuw==
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; 
   d="scan'208";a="474283564"
Received: from mmoerth-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.32.133])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 02:55:28 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
In-Reply-To: <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com> <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com> <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com> <20200820092349.GA3792@amd> <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com> <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz>
Date:   Tue, 25 Aug 2020 12:55:25 +0300
Message-ID: <87tuwr59te.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2020-08-20 09:16:18, Linus Torvalds wrote:
>> On Thu, Aug 20, 2020 at 2:23 AM Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> > Yes, it seems they make things work. (Chris asked for new patch to be
>> > tested, so I am switching to his kernel, but it survived longer than
>> > it usually does.)
>> 
>> Ok, so at worst we know how to solve it, at best the reverts won't be
>> needed because Chris' patch will fix the issue properly.
>> 
>> So I'll archive this thread, but remind me if this hasn't gotten
>> sorted out in the later rc's.
>
> Yes, thank you, it seems we have a solution w/o the revert.

For posterity, I'm told the fix is [1].

BR,
Jani.


[1] https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/


-- 
Jani Nikula, Intel Open Source Graphics Center
