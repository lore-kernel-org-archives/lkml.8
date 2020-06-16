Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3500C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgFPOyg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:54:36 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63358 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728183AbgFPOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:54:36 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21514579-1500050 
        for multiple; Tue, 16 Jun 2020 15:53:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200616145452.GA25291@embeddedor>
References: <20200616145452.GA25291@embeddedor>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] drm/i915/selftests: Fix inconsistent IS_ERR and PTR_ERR
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Message-ID: <159231920737.18853.4543157798745594821@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Tue, 16 Jun 2020 15:53:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2020-06-16 15:54:52)
> Fix inconsistent IS_ERR and PTR_ERR in live_timeslice_nopreempt().
> 
> The proper pointer to be passed as argument to PTR_ERR() is ce.
> 
> This bug was detected with the help of Coccinelle.
> 
> Fixes: b72f02d78e4f ("drm/i915/gt: Prevent timeslicing into unpreemptable requests")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Fair enough, I had sent out a patch that included this, but never split
it out for early adoption.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
