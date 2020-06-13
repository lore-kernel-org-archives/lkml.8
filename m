Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B562074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592066877;
	bh=A1XiBk3dO6eyPQJtzbqZsLSY5jHXTX474/0GfA1bqbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lecrz9xBtbaxsIWKn7PVXI2VFP5qHDvSR4va5JjciXlfcE7z6s3LlsCugzb/yvu1I
	 0AHmjmFDKjy01qT8RQiQJzIV+tCyY1iAPKBqbILS7ohxg3Q8zMqnyWc+ZmxVWxCpNi
	 7Xk9ouGnXuGTkv44R6N83e59DAbZLPOE0XFDnE2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFMQrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:47:53 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB794C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so7146165lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncEwZ2YTb3mVdV4EuBbju4CI9gD1hCf0cAsyxu6rkFs=;
        b=WxQOOQExCmoR+tWyWgfXfgTncQypYk9W5MJCAxdFj3dqLPSTkGWlfMMwGUljAXEl5R
         DcdA9O4BYJiyYRfD230dt30F3t+DJyMR6NcHFmsBmpFKMj8GebV/5NgxzNY4KxeMK4CZ
         y2p86lQyIBCmazacaBh+U1MDbQQBNmr34MoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncEwZ2YTb3mVdV4EuBbju4CI9gD1hCf0cAsyxu6rkFs=;
        b=SPV1FSmiPZTVm8Eajweq55Wh48vtXgibVPSlDjoKEtANBhISenXmL+FKsE5PMixlCb
         IBOsRQtN/JUXsJ7aX6ii/J1VVqWwkgmhv/VIQWIvC4cMX1ATXVIj2PyMytD+tbgB07Nk
         oDYeZZ/HIDSW786AEaWys8FHg4f4SNGRgDhHSkSRY4pA9wUNrvTTky/OQJ0+XPsHeth/
         +9ktodqntx9vWUvYRldI6yg4GlUso/diYcRk4t0ityNSCdLWdIqDIWgdPiH702kBrs30
         wo3R6RhRafdfuQUnJsx8mcEl6Qpt4J/3XuBWSf8ldXgLZ/OSEkTjiToDxYWaj875xgrI
         IPVA==
X-Gm-Message-State: AOAM531RAheVLkya2ZzbsDbd31OxUoBoB75TbYcYqaiBmHpJCbfbNZ2m
        xYE+/c1b25ckTrOmikYEuPjysZGoDuo=
X-Google-Smtp-Source: ABdhPJyKi3PALMqFUNhb/A0qpqPHDk20bnvhxSVzPHDInsVe7gm4hEdxB4ggrH7Imus4mCNxHHiqgg==
X-Received: by 2002:a05:6512:2ed:: with SMTP id m13mr9517614lfq.43.1592066868283;
        Sat, 13 Jun 2020 09:47:48 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id y1sm2718126ljc.88.2020.06.13.09.47.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 09:47:47 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 9so14497685ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:46 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr10011919ljn.285.1592066866523;
 Sat, 13 Jun 2020 09:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 09:47:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
Message-ID: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 6:05 AM David Howells <dhowells@redhat.com> wrote:
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

I'd want to see more concrete use cases, but I'd also like to see that
this keyring thing gets used and doesn't find any show-stoppers when
it does.

If we have multiple uses, and one of them notices some problem that
requires any ABI changes, but the other one has already started using
it, we'll have more problems.

          Linus
