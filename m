Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A6C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BF5206F7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586030439;
	bh=me7mOCtbm/nM41PQDLuZ3AV8QPPAHfZocTE3YBvBmRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KTk8ZuZGX169Skuy56hvRubPPwZVT/V5HXd+0AdIeLCCqJ68eezNt+LfMduK0mxlP
	 YMd4OccMEi39OGcg9vrM0iEcpcQ7xSjgtIYZPl5Sl5HqyVmd27YL71kk44od58Sxxq
	 AIjQ9ADL1CmuAPogDIXVnC8hqHRtmq/KF6meWSD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDDUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 16:00:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45622 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgDDUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 16:00:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so10471385ljc.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsuPBZsb8WE7VCqvhICagjys5vaL8jznepcO6gVNhuY=;
        b=O/NJbZhEcELmxr8BjYMVRxOGDrpsvhy4davP58ldZKgobV0p7JxPIcKelXaB7aNZW9
         mPcbUFn5jfyaOh/i3A4S/VxDN7Nv056gxJ7+iidO74GTBvCOtL8MrU9wKnElTGHdb3um
         EpkDy6jh4uuboALpwZV+wASIDyIisdDKaAb18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsuPBZsb8WE7VCqvhICagjys5vaL8jznepcO6gVNhuY=;
        b=PR0ksHmMfuY7n/VsLyubG68SRkCp6KdMMcv/iSTgJRWeGpxo7h1oZ1ez6dcFzGj57M
         8LeeA/ik/EvjbE7FYO8CHfeF7Fr37OgRYlL4p4mzecRqzvpb0ia/kt8aU5eS+cEL7Pa7
         PcQU84zHEYiBBCP9J9WctO0F+F44O60g3Mi45/JjNY94RAXC8bJHf6cYTQML2c7Dfac3
         YTy9gQaWtLucBZuJ8zq9+EwBourP5MRyVVgzMi9HTjFUxg981mlbzpk5C4rDanEUSRJC
         MqvxEz6CavvlxDoEQXslmjALdWQoyL0Bf23oArpjGQW1xbUh3mAog8UoJ/hY8s6LyFQS
         rQ0Q==
X-Gm-Message-State: AGi0PuY9FilP1goD1PsABt/GSs95da6Gs8I0JXhtO6Gr0MmtFbK6+ZZD
        mS7hPJ6iSoc+X66w3464ePo+jMjXgNI=
X-Google-Smtp-Source: APiQypJPEjmJLR+v/uMTiRI5GU2KPJmnxeQ2hBKAC8z99UM84MIW0zDB9FTVy821de+mAuiJlXyrWg==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr8309460lja.248.1586030426200;
        Sat, 04 Apr 2020 13:00:26 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u25sm8549757lfm.97.2020.04.04.13.00.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 13:00:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id k21so10543041ljh.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 13:00:24 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr7591094ljc.209.1586030424282;
 Sat, 04 Apr 2020 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <1437197.1585570598@warthog.procyon.org.uk>
In-Reply-To: <1437197.1585570598@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Apr 2020 13:00:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
Message-ID: <CAHk-=wgWnZCvTFDfiYAy=uMUf2F1Yy1r9ur5ARcmtqLjX8Tz4Q@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Fix key->sem vs mmap_sem issue when reading key
To:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Waiman Long <longman@redhat.com>, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 5:16 AM David Howells <dhowells@redhat.com> wrote:
>
>  security/keys/internal.h                  |  12 ++++

This isn't so much about this pull (which I have taken), as about the
fact that this code re-inforces bad behavior we already in the slub
layer, and now extends it further to kvfree.

Doing this:


   __kvzfree(const void *addr, size_t len)
  ..
                memset((void *)addr, 0, len);
                kvfree(addr);

is wrong to begin with. It's wrong because if the compiler ever knows
that kvfree is a freeing function (with something like
__attribute__((free)) - I don't think gcc is smart enough today), the
compiler might throw the memset away.

Yeah, so far we've only seen that for automatic stack clearing, but
there are very much compilers that know that alloc/free are special
(both for warning about use-after-free issues, and for "improving"
code generation by blindly removing dead writes).

We have a function for clearing sensitive information: it's called
"memclear_explicit()", and it's about forced (explicit) clearing even
if the data might look dead afterwards.

The other problem with that function is the name: "__kvzfree()" is not
a useful name for this function. We use the "__" format for internal
low-level helpers, and it generally means that it does *less* than the
full function. This does more, not less, and "__" is not following any
sane naming model.

So the name should probably be something like "kvfree_sensitive()" or
similar. Or maybe it could go even further, and talk about _why_ it's
sensitive, and call it "kvfree_cleartext()" or something like that.

Because the clearing is really not what even matters. It might choose
other patterns to overwrite things with, but it might do other things
too, like putting special barriers for data leakage (or flags to tell
return-to-user-mode to do so).

And yes, kzfree() isn't a good name either, and had that same
memset(), but at least it doesn't do the dual-underscore mistake.

Including some kzfree()/crypto people explicitly - I hope we can get
away from this incorrect and actively wrong pattern of thinking that
"sensitive data should be memset(), and then we should add a random
'z' in the name somewhere to 'document' that".

               Linus
