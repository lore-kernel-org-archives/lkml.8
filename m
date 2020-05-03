Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10085C47256
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56362071C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 20:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgECUa2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 16:30:28 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52895 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729034AbgECUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:30:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21101115-1500050 
        for multiple; Sun, 03 May 2020 21:30:23 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200430221016.3866-1-Jason@zx2c4.com>
References: <20200430221016.3866-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, bigeasy@linutronix.de,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] drm/i915: check to see if SIMD registers are available before using SIMD
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, stable@vger.kernel.org
Message-ID: <158853782127.10831.11598587258154009671@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Sun, 03 May 2020 21:30:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason A. Donenfeld (2020-04-30 23:10:16)
> Sometimes it's not okay to use SIMD registers, the conditions for which
> have changed subtly from kernel release to kernel release. Usually the
> pattern is to check for may_use_simd() and then fallback to using
> something slower in the unlikely case SIMD registers aren't available.
> So, this patch fixes up i915's accelerated memcpy routines to fallback
> to boring memcpy if may_use_simd() is false.
> 
> Cc: stable@vger.kernel.org

The same argument as on the previous submission is that we return to the
caller if we can't use movntqda as their fallback path should be faster
than uncached memcpy.
-Chris
