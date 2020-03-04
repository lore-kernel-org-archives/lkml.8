Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F8C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA45217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgCDR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:26:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:44324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:26:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DDBB8AD89;
        Wed,  4 Mar 2020 17:26:35 +0000 (UTC)
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
To:     Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>
Cc:     Jann Horn <jannh@google.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
 <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
 <202003031820.7A0C4FF302@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <beb7abda-2648-aae7-31c5-51da6f02380a@suse.cz>
Date:   Wed, 4 Mar 2020 18:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003031820.7A0C4FF302@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 3:22 AM, Kees Cook wrote:
> On Tue, Mar 03, 2020 at 05:26:14PM -0800, David Rientjes wrote:
> 
> Seems reasonable!
> 
> For the race concerns, should this logic just make sure the resulting
> order can never shrink? Or does it need much stronger atomicity?

If order grows, I think we also need to recalculate the random sequence for
freelist randomization [1]. I expect that would be rather problematic with
parallel allocations/freeing going on.

As was also noted, the any_slab_objects(s) checks are racy - might return false
and immediately some other CPU can allocate some.

I wonder if this race window could be fixed at all without introducing extra
locking in the fast path? Which means it's probably not worth the trouble of
having these runtime knobs. How about making the files read-only (if not remove
completely). Vijayanand described a use case in [2], shouldn't it be possible to
implement that scenario (all caches have debugging enabled except zram cache)
with kernel parameters only?

Thanks,
Vlastimil

[1] https://lore.kernel.org/linux-mm/d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz/
[2]
https://lore.kernel.org/linux-mm/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org/
