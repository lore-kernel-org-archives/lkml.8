Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C62074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592263496;
	bh=A1WtQ1g1KpuIoeDmUFz8cD7kNho/1KEAJNFhI19+fW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PkqqOAlSrhNyxPfp40JwCdRjTzfhg/hgRSwFMPukeW9xN1dtbVMefQL0XfFD/Y++v
	 E5hukomywW2HLv+8auDdbO+C1JrtMnWzaieZmcmx8UEhebhtYQz+vtUSYX0brOtbun
	 WAU8lg0m4CpDq6nMjzOR8wL9EIglDuVgkFarXj6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgFOXYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:24:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgFOXYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:24:55 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5837520739;
        Mon, 15 Jun 2020 23:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592263494;
        bh=A1WtQ1g1KpuIoeDmUFz8cD7kNho/1KEAJNFhI19+fW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7R4ygtCRRIUtvMslXYWBKsSZ9NSbN1miUpQPSMxM0M3wcuQp1bO9uoUTK27hIWdo
         Qe8XSY9e0va7dv61OjfOgMr6kwxf9AbQl+fkrq1wQkSEbpULQFSjiceEN0mAwY0b3G
         ZYTeVmRNhfHvixz5I3h5bqzE245TYxm1y8QZRq8A=
Date:   Mon, 15 Jun 2020 19:24:53 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace: warn when modpath is needed
 but is unset
Message-ID: <20200615232453.GF1931@sasha-vm>
References: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
 <20200615222427.60126-1-sashal@kernel.org>
 <CAHk-=wid9pjXmafH_-F6TooC9j7nfqKweWbHKzENkk+YHTo=AQ@mail.gmail.com>
 <CAHk-=wh2VeXjf0vPXSJzaV3zk6iNEfnumn6YDQF44OmEcGpoYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wh2VeXjf0vPXSJzaV3zk6iNEfnumn6YDQF44OmEcGpoYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:43:31PM -0700, Linus Torvalds wrote:
>On Mon, Jun 15, 2020 at 3:37 PM Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>>
>> Well, that looks straightforward.
>
>Hmm. Decided to test it. It warns for every case: a bit excessive,
>perhaps, but I guess it won't hurt.
>
>So Shuah's thing results in
>
>[    9.791367] Call Trace:
>WARNING! Modules path isn't set, but is needed to parse this symbol
>[    9.791377] ? snd_pcm_hw_params+0x3ca/0x440 snd_pcm
>WARNING! Modules path isn't set, but is needed to parse this symbol
>[    9.791383] snd_pcm_common_ioctl+0x173/0xf20 snd_pcm
>WARNING! Modules path isn't set, but is needed to parse this symbol
>[    9.791389] ? snd_ctl_ioctl+0x1c5/0x710 snd
>WARNING! Modules path isn't set, but is needed to parse this symbol
>[    9.791394] snd_pcm_ioctl+0x27/0x40 snd_pcm
>
>which looks a bit redundant, but maybe that just means people _really_ notice.

I figured it's a good balance between warning only once (which can get
lost in a longer trace) vs just exiting on error (as it prevents the
user from ignoring this issue if he doesn't care or just doesn't have
the modules).

-- 
Thanks,
Sasha
