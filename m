Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF1DC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14477206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iNgHSCbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBQHju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:39:50 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:44941 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgBQHju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:39:50 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id db3c7991;
        Mon, 17 Feb 2020 07:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5qFoYGABoqiUw27DDar5aMuqQ9k=; b=iNgHSC
        bW+WUc4LtYyc9vK9HkrE99PNnHzmB04Dq8L+aqbpbkN2JphcTIvhS5OUlMta47Rz
        M+ASa4Qyug6D/xvcf3JnDDiGp+dijBBkfZwyLBKhI7DqWzJxzSIMHA1TwMAoZBlg
        pl0CgD+0h9iQDB0OTPu7XFC9A5AMoQnCKFlkFKG4PBOURxWLUr13eWVoRcoXh06z
        zTRuednI0mNuTyLSi2EZMZy9wNithBzJ+nlqeodxMajxY1r3eEVksZgx+CPVoNvQ
        L709DNy5/cIs+48oSYBI6u2Hjg8yzmNpHHH0lGYWNP++MhHjWsQGbSlV1nSxugcy
        5ZG8O4GLB0Nx6Azw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c393d1c5 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 17 Feb 2020 07:37:19 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id c16so15842987oic.3;
        Sun, 16 Feb 2020 23:39:47 -0800 (PST)
X-Gm-Message-State: APjAAAVdh5Ro/P4TRMJV1SIXrL++1tvTeKhpUmKq/O9lXFLYQfG0mKTn
        FZIaqG5TtbMwMSiePfNzKmIiu5Odk3GqIWhXGkQ=
X-Google-Smtp-Source: APXvYqxLgJtUBmhY1BDRIeQurZQnFngB1coYo+s31QSe1Eer5HNMVsPo+veYVDCGNWwalrM49oKMi//xq4G0/vBuVLI=
X-Received: by 2002:aca:815:: with SMTP id 21mr9444281oii.52.1581925186693;
 Sun, 16 Feb 2020 23:39:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:dd10:0:0:0:0:0 with HTTP; Sun, 16 Feb 2020 23:39:45
 -0800 (PST)
In-Reply-To: <20200217032458.kwatitz3pvxeb25w@gondor.apana.org.au>
References: <20200206163844.GA432041@zx2c4.com> <20200217032458.kwatitz3pvxeb25w@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Feb 2020 08:39:45 +0100
X-Gmail-Original-Message-ID: <CAHmME9q+YYia0H3upW7ikwSii_XegNNSBkVxP-1mxaHyEVmBxA@mail.gmail.com>
Message-ID: <CAHmME9q+YYia0H3upW7ikwSii_XegNNSBkVxP-1mxaHyEVmBxA@mail.gmail.com>
Subject: Re: [PATCH v3] skbuff: fix a data race in skb_queue_len()
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     eric.dumazet@gmail.com, cai@lca.pw, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Hi Eric,
>>
>> On Tue, Feb 04, 2020 at 01:40:29PM -0500, Qian Cai wrote:
>>> -     list->qlen--;
>>> +     WRITE_ONCE(list->qlen, list->qlen - 1);
>>
>> Sorry I'm a bit late to the party here, but this immediately jumped out.
>> This generates worse code with a bigger race in some sense:
>>
>> list->qlen-- is:
>>
>>   0:   83 6f 10 01             subl   $0x1,0x10(%rdi)
>>
>> whereas WRITE_ONCE(list->qlen, list->qlen - 1) is:
>>
>>   0:   8b 47 10                mov    0x10(%rdi),%eax
>>   3:   83 e8 01                sub    $0x1,%eax
>>   6:   89 47 10                mov    %eax,0x10(%rdi)
>>
>> Are you sure that's what we want?
>
> Fixing these KCSAN warnings is actively making the kernel worse.
>
> Why are we still doing this?
>
Not necessarily a big fan of this either, but just for the record here
in case it helps, while you might complain about instruction size
blowing up a bit, cycle-wise these wind up being about the same
anyway. On x86, one instruction != one cycle.
