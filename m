Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AF120870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgGCNwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:52:46 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59307 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgGCNwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:52:45 -0400
Received: from [192.168.0.4] (ip5f5af280.dynamic.kabel-deutschland.de [95.90.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 967DB20225AE1;
        Fri,  3 Jul 2020 15:52:43 +0200 (CEST)
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
 <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
 <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <c9f3e69b-1868-0a1f-e5f8-85db7bebfb4d@molgen.mpg.de>
Date:   Fri, 3 Jul 2020 15:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wimBucBdC+tzFEuFJU5X1UFTVWo+AHMvQTSkCcVnTT-ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus, dear Christian,


Am 02.07.20 um 21:42 schrieb Linus Torvalds:
> On Thu, Jul 2, 2020 at 7:42 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> I'm just not sure how well this is received upstream because it only
>> covers u32
>>
>> On the other hand that is probably also the most used.
> 
> Not necessarily true. I'd argue that "unsigned long"  is equally
> possible for some bit mask (or other hex-likely) type.
> 
> So don't call it just "hex". Call it "hexint" (the hex does imply
> "unsigned", I feel - showing hex numbers with a sign sounds insane).
> 
> That way, if somebody ends up wanting it for unsigned long values,
> we're not stuck.

Good idea. Don.e

> Another option is to just say that hex values always have bit _sizes_.
> So "hex32" and "hex64" would also make sense as names to me.

I went for int to be consistent in the naming, and kstrtouint is used in 
the macro.

> While at it, should the hex numbers always be padded out to the size?
> The example Paul used doesn't have that issue (high bit being set).
> 
> Bbut often it may make sense to show a 32-bit hex number as "%#08x"
> because it really makes things clearer when you're looking at high
> bits, say.
> 
> It's really hard to tell the difference between "just bit 27 set" and
> "just bit 31" set otherwise, and that's not all that uncommon when the
> bitmasks are sparse.

Also good idea. Done.

I just sent out the v2.


Kind regards,

Paul
