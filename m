Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384BC206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDTTNz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:13:55 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64580 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725896AbgDTTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:13:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20963990-1500050 
        for multiple; Mon, 20 Apr 2020 20:13:47 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1587361342-83494-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1587361342-83494-1-git-send-email-xiyuyang19@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/selftests:  Fix i915_address_space refcnt leak
From:   Chris Wilson <chris@chris-wilson.co.uk>
Message-ID: <158741002592.19285.15203193760043173103@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Mon, 20 Apr 2020 20:13:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xiyu Yang (2020-04-20 06:41:54)
> igt_ppgtt_pin_update() invokes i915_gem_context_get_vm_rcu(), which
> returns a reference of the i915_address_space object to "vm" with
> increased refcount.
> 
> When igt_ppgtt_pin_update() returns, "vm" becomes invalid, so the
> refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in two exception handling paths of
> igt_ppgtt_pin_update(). When i915_gem_object_create_internal() returns
> IS_ERR, the refcnt increased by i915_gem_context_get_vm_rcu() is not
> decreased, causing a refcnt leak.
> 
> Fix this issue by jumping to "out_vm" label when
> i915_gem_object_create_internal() returns IS_ERR.
> 
> Fixes: 4049866f0913 ("drm/i915/selftests: huge page tests")

Actually,
Fixes: a4e7ccdac38e ("drm/i915: Move context management under GEM")

> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Other than that,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
