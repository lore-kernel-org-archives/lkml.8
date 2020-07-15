Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0EB20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGOJH0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:07:26 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:55118 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbgGOJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:07:26 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21823895-1500050 
        for multiple; Wed, 15 Jul 2020 10:06:56 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200715032104.32052-1-yuehaibing@huawei.com>
References: <20200715032104.32052-1-yuehaibing@huawei.com>
Subject: Re: [Intel-gfx] [PATCH -next] drm/i915: Remove unused inline function drain_delayed_work()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
To:     YueHaibing <yuehaibing@huawei.com>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Date:   Wed, 15 Jul 2020 10:06:54 +0100
Message-ID: <159480401488.3188.7146761465651932968@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2020-07-15 04:21:04)
> It is not used since commit 058179e72e09 ("drm/i915/gt: Replace
> hangcheck by heartbeats")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Indeed, it is no more.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
