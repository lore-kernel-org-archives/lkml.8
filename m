Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAC8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F2220870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBKJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:51:57 -0500
Received: from mail.netline.ch ([148.251.143.178]:47311 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgBKJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:51:56 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 04:51:55 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 577EE2A6048;
        Tue, 11 Feb 2020 10:41:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Y5c4P5LHANWr; Tue, 11 Feb 2020 10:41:50 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch [83.76.80.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id E7C9F2A6046;
        Tue, 11 Feb 2020 10:41:49 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.93)
        (envelope-from <michel@daenzer.net>)
        id 1j1S3A-000eJE-I2; Tue, 11 Feb 2020 10:41:48 +0100
Subject: Re: [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     clang-built-linux@googlegroups.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
Date:   Tue, 11 Feb 2020 10:41:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211061338.23666-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
> A recent commit in clang added -Wtautological-compare to -Wall, which is
> enabled for i915 so we see the following warning:
> 
> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> result of comparison of constant 576460752303423487 with expression of
> type 'unsigned int' is always false
> [-Wtautological-constant-out-of-range-compare]
>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> 
> This warning only happens on x86_64 but that check is relevant for
> 32-bit x86 so we cannot remove it.

That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
in both cases, and remain is a 32-bit value in both cases. How can it be
larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
