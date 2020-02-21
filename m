Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8288C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E720578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xk3mc9Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBUUId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:08:33 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:53679 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgBUUId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:08:33 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 93b9ca7c
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Feb 2020 20:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=lPA79OPzAueReIxPc+KvHNCdJZk=; b=Xk3mc9
        Bl1y6EiHTmlcH2AWEN3EmfffveEopaquxmDqHqc+vS/PlaL6/b9PSFV4pTv78IbS
        Ao8h3qoT+1Ft+DzQLvXAwW0infmEgDHURwuJaULxIAUocQ6VuJvN/rwalmboNy1q
        Kwz6ij331alv/FLJEgXrVLXqgITUHjKcfP7q5KnKnhrsRypfz3ByJw8ffU0MXhJ/
        Gm4IgGsm1YVjC7Xam7c1l95FA1Wjeo7ojV3yCJaI4EYt6P4ScAHJKLMNWS7hVuyC
        32FfvMXia5UsluIuSEUN4KJrbPJfprWp8SPTc274iOqMA4a+1XJSGvOtWnXBXMV+
        y99ZsxOCpOt49JBQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb45fd21 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Feb 2020 20:05:28 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id r137so2815888oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:08:31 -0800 (PST)
X-Gm-Message-State: APjAAAU9VhhfvvrnO2CgnYR2yMS18jbSE4RtYmDuQFBS/PYVOp/WLxuQ
        5pLyccrl1jj6Rvje5UbrLqCSajguDHXCMwvkM3g=
X-Google-Smtp-Source: APXvYqyykB910DiKmkSnVzKinV3u9XqkPi1mdIoQ5GBOUzFp2D2UENUNdB771OeuX/tV2cyHylCfoG3K3iJrUQB2a30=
X-Received: by 2002:aca:815:: with SMTP id 21mr3542855oii.52.1582315710678;
 Fri, 21 Feb 2020 12:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20200216161836.1976-1-Jason@zx2c4.com> <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com> <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
In-Reply-To: <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Feb 2020 21:08:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com>
Message-ID: <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com>
Subject: Re: [PATCH] random: always use batched entropy for get_random_u{32,64}
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:29 PM Tony Luck <tony.luck@gmail.com> wrote:
>
> Also ... what's the deal with a spin_lock on a per-cpu structure?
>
>         batch = raw_cpu_ptr(&batched_entropy_u64);
>         spin_lock_irqsave(&batch->batch_lock, flags);
>         if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
>                 extract_crng((u8 *)batch->entropy_u64);
>                 batch->position = 0;
>         }
>         ret = batch->entropy_u64[batch->position++];
>         spin_unlock_irqrestore(&batch->batch_lock, flags);
>
> Could we just disable interrupts and pre-emption around the entropy extraction?

Probably, yes... We can address this in a separate patch.
