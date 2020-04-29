Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745ABC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DB9206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD2Gqj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:46:39 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58235 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726355AbgD2Gqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:46:39 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21054240-1500050 
        for multiple; Wed, 29 Apr 2020 07:45:58 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200429030051.920203-1-natechancellor@gmail.com>
References: <20200429030051.920203-1-natechancellor@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/i915/gt: Avoid uninitialized use of rpcurupei in frequency_show
From:   Chris Wilson <chris@chris-wilson.co.uk>
Message-ID: <158814275688.18349.12896739005148519908@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 29 Apr 2020 07:45:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2020-04-29 04:00:52)
> When building with clang + -Wuninitialized:
> 
> drivers/gpu/drm/i915/gt/debugfs_gt_pm.c:407:7: warning: variable
> 'rpcurupei' is uninitialized when used here [-Wuninitialized]
>                            rpcurupei,
>                            ^~~~~~~~~
> drivers/gpu/drm/i915/gt/debugfs_gt_pm.c:304:16: note: initialize the
> variable 'rpcurupei' to silence this warning
>                 u32 rpcurupei, rpcurup, rpprevup;
>                              ^
>                               = 0
> 1 warning generated.
> 
> rpupei is assigned twice; based on the second argument to
> intel_uncore_read, it seems this one should have been assigned to
> rpcurupei.
> 
> Fixes: 9c878557b1eb ("drm/i915/gt: Use the RPM config register to determine clk frequencies")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1016
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks.
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
