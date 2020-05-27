Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB74C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21B720776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgE0Pn6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:43:58 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59692 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730386AbgE0Pn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:43:58 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21311296-1500050 
        for multiple; Wed, 27 May 2020 16:43:53 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200527140526.1458215-2-arnd@arndb.de>
References: <20200527140526.1458215-1-arnd@arndb.de> <20200527140526.1458215-2-arnd@arndb.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        "Robert M. Fosha" <robert.m.fosha@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drm/i915: work around false-positive maybe-uninitialized warning
Message-ID: <159059423232.30979.11698525690770673738@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 27 May 2020 16:43:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-05-27 15:05:09)
> gcc-9 gets confused by the code flow in check_dirty_whitelist:
> 
> drivers/gpu/drm/i915/gt/selftest_workarounds.c: In function 'check_dirty_whitelist':
> drivers/gpu/drm/i915/gt/selftest_workarounds.c:492:17: error: 'rsvd' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> I could not figure out a good way to do this in a way that gcc
> understands better, so initialize the variable to zero, as last
> resort.

Does it look neater if we initialise it as a local? No.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
