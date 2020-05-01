Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6014C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC52B2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588357860;
	bh=7DvSEjnl3CgZUbOmeadiRe558M25bB0PbFh/u8NunW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=atlzEXnfWrKqfoff9Mb/if0LxJB/Chisym6aY4Qa7kGF9l11iV7g5yNEAARQPZSuJ
	 BgeZLMYK+tl6Wn4cLLS3emHl9QVSvr68E5osGMBO7KX+4YgabLYxVK5BIOtwb0FQ2+
	 ttMf6o1m9CRzVarx3hXwn1PDUCWIZo3Ligx44Utw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEASa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729182AbgEASa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:30:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38094C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:30:58 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d25so4515579lfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3/eq4U4mb3aT65X9LT4kh52VMeKsD/VdbN6I08Rkuk=;
        b=LJlZaEg8IFjmSO6QYRnwiO26xGWcL4y2lrFsC/rMf4cK0+zQg/3tTA/nV3AFpw54kf
         oCo9Q24bJ5Mbhk/bCAPWNE+2RisaAi0QY/khLrM+su9grRTjly+zNpD//Vlk/0yob4fE
         MrrXuIYbOt+S2+zWY3QB80+bUS/u0x9LACdKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3/eq4U4mb3aT65X9LT4kh52VMeKsD/VdbN6I08Rkuk=;
        b=DG45CXtnwBh/EyIfHtOKCOSgimuxrB80ss9rWbuTyE7IIYGSg0DC7y+rU5j0GjO6gn
         oDr/V/ON29M+y2FizaUQ+cT8RWg8JPgmAcdFNz16vpsCKm8VuCtRjHGBwZ1REU/iDfkJ
         o1XluDYxZawOqLMfBCh/8SpwzjscKnr+P+0XfYWAGnMsZpBtlLitBL6HnOJxsH5MK0E+
         fNTSosJrwWlS82j38nbyz7Yt+YmIBUYD3TNb22Z7+31gYqIxh3kHQpps7RqcKgAqbqBI
         wKq6y//TzhjQgvQdk3mBYt8Xr7gWn6/wllLgtuYOLlvow68bX00HBlyDEUwP71fIN1cD
         oLmw==
X-Gm-Message-State: AGi0PuZzNBgq90M3AQ5kWnkDAYRwCRMdvGiaSORMaPOSyl8vOJSamBb4
        ZnO8iKZnBe4KiPaCNGkEG34joYyT1BQ=
X-Google-Smtp-Source: APiQypISlF+ZmfQoHzJcum9FsZSGYo5aazWRovllu89c69LB4RN2w7FzM6CSe09x/sp7wvMDYNOKHQ==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr3366966lfc.60.1588357856059;
        Fri, 01 May 2020 11:30:56 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id h24sm2826297lji.99.2020.05.01.11.30.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:30:55 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f11so3454301ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:30:54 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr3284912ljj.265.1588357854595;
 Fri, 01 May 2020 11:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
 <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com> <20200501182154.GG5462@mtj.thefacebook.com>
In-Reply-To: <20200501182154.GG5462@mtj.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 May 2020 11:30:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
Message-ID: <CAHk-=wgB=PDdMX=uwsSrcERgSyyNW83Hj=WTWWjKp9dyriEzVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
To:     Tejun Heo <tj@kernel.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Shaohua Li <shli@fb.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 11:22 AM Tejun Heo <tj@kernel.org> wrote:
>
> Looks fine to me too. I don't quite understand the usecase tho. It looks
> like all it's being used for is to tag some kthreads as belonging to the
> same group. Can't that be done with kthread_data()?

I _think_ Bruce wants the signal handling unification too, because
nfsd wants to react to being shut down with signals.

But you're right, more explanation of why nfsd wants/needs a separate
grouping is a good idea.

                    Linus
