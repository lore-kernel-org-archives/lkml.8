Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A2C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3E2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581533578;
	bh=s0rQQJgReY1pvJWTDvRS2Q9eLU7aX05/Am/N2h5REPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HQvo060JsWcgHT4qCtlgj/oOHtXP8GL0HHdv9DGbPfwxQrPrZmzCmcHZZ26kpBLTL
	 a4PBxjqu05N/xJYIRLKwg6/5/W/lMA1C/5i7xGBN9etWKS8Qfv9pvWVreZFVjkUy+h
	 n7bnt/yzmgKg1okiY7M/JYlhjNKKuBLNm0NeaMmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgBLSw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:52:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34433 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgBLSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:52:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id r18so3666477edl.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=E/vN3AE3iyzGDOzjrhIyYOh5wyK5H3COrkDAy4Yb/0fuIwlyf50yEW7S/x5cDf9tHW
         zWbCuDLoLaAGtRSBjikTyE8yY06byotE/cGEhEbxOklsxfNCa9G0PsCjeYAs62WP1DSa
         M2BG1IabKnVo1IvqnOENDDauUUlMg+SJyMK4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S2w7jKfhj8nqr2BEN6cbFr7nckGF3MBI5pTAOk2Bgk=;
        b=Rt9/Z7eOPTOvdlvBe/PjHygA8sJUPc4WNpDYFTtGPxzeQDwWttytHnA8swd6k2ViEb
         gndde7M2BPAw+dvhKH0AcTyFgnXIwPOvpBhXgU4GO/gLPSauGAYccSJS5GC6QV7xNk/V
         JIfaprEymSe1c+GR2vG7He45CGQKFtRjtIx+wbtu1ONbkBdbtzm8RIaY8fL9QcIdCMK0
         bB7z2csZbAsBAkp50cSziNcHNeePa91WG+THTc9qTtKCwMsjHbuAtn2D0sZ2KngeGnbI
         I7Jvg6BFPJuQfB9VWw5c1YnXclPrmPWDZd4AY1WQBy00SCBayQLV1SW2Z6U9InOsPq9y
         OumQ==
X-Gm-Message-State: APjAAAW3NBqzo5AzDluzWigSMMlcL/SRVfh3fI1qDLY4IEffET7adhIS
        /HM6ial7qdHF4zz4lo/wI176dSMVMis=
X-Google-Smtp-Source: APXvYqz2YYUPTwgrL9FiB75EowOgglMyMdYnMoj9hKxXoKpr6z5+0gfGO0YfuP44up4EeSPTrhjCTQ==
X-Received: by 2002:a05:6402:b59:: with SMTP id bx25mr12417752edb.5.1581533574078;
        Wed, 12 Feb 2020 10:52:54 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id dd20sm101018ejb.59.2020.02.12.10.52.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 10:52:53 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id p23so3645205edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 10:52:53 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr8440902ljj.241.1581533122702;
 Wed, 12 Feb 2020 10:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6> <87tv3vkg1a.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv3vkg1a.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 10:45:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Message-ID: <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:01 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Fundamentally proc_flush_task is an optimization.  Just getting rid of
> dentries earlier.  At least at one point it was an important
> optimization because the old process dentries would just sit around
> doing nothing for anyone.

I'm pretty sure it's still important. It's very easy to generate a
_ton_ of dentries with /proc.

> I wonder if instead of invalidating specific dentries we could instead
> fire wake up a shrinker and point it at one or more instances of proc.

It shouldn't be the dentries themselves that are a freeing problem.
They're being RCU-free'd anyway because of lookup. It's the
proc_mounts list that is the problem, isn't it?

So it's just fs_info that needs to be rcu-delayed because it contains
that list. Or is there something else?

               Linus
