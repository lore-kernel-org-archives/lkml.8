Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFDFC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB7820801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgBQQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:05:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgBQQFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:05:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B57DAC7C;
        Mon, 17 Feb 2020 16:05:03 +0000 (UTC)
Subject: Re: Linux 5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <20200217020840.GA24821@codemonkey.org.uk>
 <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
 <8025e1bf-4834-83c6-d12c-4e817f875776@toxicpanda.com>
 <CAHk-=wiG+wjLjuDDNiqfL3iLW25yqsMK_gNEWomyMH=8kxOLwQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <ee0fa89a-a138-efea-7c04-799bbd9ba17c@suse.com>
Date:   Mon, 17 Feb 2020 16:04:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiG+wjLjuDDNiqfL3iLW25yqsMK_gNEWomyMH=8kxOLwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/02/20 05:08, Linus Torvalds wrote:
> On Sun, Feb 16, 2020 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> I assume Filipe wrote this based on my patch here
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?id=c821555d2b9733d8f483c9e79481c7209e1c1fb0
>>
>> which makes it so we can allocate safely in this context, but that patch hasn't
>> made it's way to you yet.  Do you want it now?  It was prep for a much less safe
>> patchset, but is fine by itself.  Thanks,
> 
> I assume it's either that, or revert 28553fa992cb and do it differently..
> 
> I'll leave that whole decision to the btrfs people who actually know
> the code and the situations and what the alternative would look
> like...

So what happened was that the patch was developed against the
integration branch, where we don't use search paths in spinning mode
anymore - this was done by Josef's patch, which itself is not a bug fix
but it's necessary for another bug fix that is only on the integration
branch.

On 5.6-rcX and any other other older kernels we have the search using
spinning locks, that's why we run into this problem.

The solution can be either adding Josef's patch or changing the order in
which my patch unlocks the file range - to do it after the patch is
freed (which releases any spin locks it might be holding).

I've just sent a patch for that:
https://patchwork.kernel.org/patch/11386723/

I'm fine with either solution.

Thanks.

> 
>                Linus
> 
