Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93599C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88220737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbgDBV4H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:56:07 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60253 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgDBV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:56:07 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20781912-1500050 
        for multiple; Thu, 02 Apr 2020 22:55:42 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200402213506.GA2767@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz> <20200402213506.GA2767@duo.ucw.cz>
Subject: Re: 5.6-rc7: Xorg hangs, too
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Pavel Machek <pavel@ucw.cz>, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        rodrigo.vivi@intel.com
Message-ID: <158586454333.5852.17002169517772810041@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Thu, 02 Apr 2020 22:55:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2020-04-02 22:35:07)
> [258096.980089] 3 locks held by kswapd0/1034:
> [258096.980096]  #0: ffffffff85851c80 (fs_reclaim){....}, at: __fs_reclaim_acquire+0x0/0x30
> [258096.980114]  #1: ffffffff85850b40 (shrinker_rwsem){....}, at: shrink_slab.constprop.79+0x38/0x270
> [258096.980130]  #2: ffff888197278b90 (&vm->mutex){....}, at: i915_vma_unbind+0x90/0xe0
> [258096.980177] 3 locks held by Xorg/3123:
> [258096.980183]  #0: ffff8881972700c8 (&dev->struct_mutex){....}, at: i915_gem_do_execbuffer+0x690/0x1ef0
> [258096.980200]  #1: ffff88819576e950 (&ctx->mutex){....}, at: eb_lookup_vmas+0x7d/0xd10
> [258096.980215]  #2: ffff888197278b90 (&vm->mutex){....}, at: i915_vma_pin+0xb4/0x750

That's the pair that's causing the trouble.
-Chris
