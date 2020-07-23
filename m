Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C37C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFCD207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595534630;
	bh=Oijk5L+YN0LHVys10jodEi1dXnLY5P69z5y0Xm2tfeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rmA5m6vgBd+pEwz/PD3xWui5fNRIs6qG3oIW+8sVKf6p0Z6A33rUylG0jF7ifln2Y
	 Gsl5HE6+hfLMIWIZ5DKZVfRQ4CD+/5Mv66gaIadVI63xojnz+7K7Wt+gE1NtFYC6WM
	 vNhHRvB2yVBT34jB8My4N4jxU/EFs3MKAVtsCAS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgGWUDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:03:48 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC90C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:03:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y18so3942592lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vKnE7X4C3wzlK1JmSQfpytc1qItyht9kBX7kY+JZA0=;
        b=ZLwjkmddpJA5gf+HFdEmyLuDA7FQoYg9/jBFMulzEGqemvdcyzVhn6a4S43qPXhK+B
         t2+creQzWutMv4/M6OVkN7gpfUThbgXramMeuQkhE1v8KmypWYrR+tQpapZoe2l990bU
         NljuVBzFgz0gYAF8I3r9xVn5s65q9Y70lC2JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vKnE7X4C3wzlK1JmSQfpytc1qItyht9kBX7kY+JZA0=;
        b=uCsCp0C+08wnrpkuMQSSNGngs22gTTn34dWH5rzw6Qv5hqSfUN6IHiOzWUvaAn4pYI
         p1azUHoy3EV1OtkcJDqSbYKsX4+RLPvP3ZhplF5XtyF/UhH3Gyb4HQZAwgd5/Yh4/c3o
         /ZAilJj7BekQigcmPIrTWkYJ3XU+Ewe3VrqZ5lqqU5TNVhhUWfLvkcYTXQWVK8sKAVIr
         uWRdshG9sG30C3NPT6Ea2uVnlCV5AN3F03YRJS2/PWvqsfUCGlcbGz0FLOKdXFylgew3
         vjNQfUnx4l0L0qTZQjNBJAq9gGeSRXykm/5VaUFDAuQ4xEIgFc8hYy8m3kgD47Ikt3lp
         vtuA==
X-Gm-Message-State: AOAM532AgS0hxgZVz4uvhKUVNPf/wnzdh1gSgX9jlo4VvPnCrhtIJ7YD
        GFZsP8gba3f/hSHIMXTxWiWwvo/VtVk=
X-Google-Smtp-Source: ABdhPJwkBLIb9DUzj9zH4owKecK+7XaerCL/squTz/urd6msrQqdceoVFsdrTxOurI63W3VT+cOPOQ==
X-Received: by 2002:a05:6512:4cc:: with SMTP id w12mr1860331lfq.99.1595534626220;
        Thu, 23 Jul 2020 13:03:46 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i11sm3273420lfl.31.2020.07.23.13.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 13:03:45 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y18so3942526lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:03:44 -0700 (PDT)
X-Received: by 2002:ac2:521a:: with SMTP id a26mr3026142lfl.192.1595534624105;
 Thu, 23 Jul 2020 13:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 13:03:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
Message-ID: <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:32 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So here's a v2, now as a "real" commit with a commit message and everything.

Oh, except it's broken.

Switching from the "am I still on the list" logic to the
"WQ_FLAG_WOKEN is set if woken" logic was all well and good, but I
missed the case where we did that trylock_page_bit_common().

It used to just not add the thing to the list if it would get the page
bit, and then the rest of the waiting logic looked at that and was
happy.

But now if it needs to actually fake that WQ_FLAG_WOKEN flag.

So that patch needs to do something like this:

        if (!trylock_page_bit_common(page, bit_nr, behavior))
                __add_wait_queue_entry_tail(q, wait);
        else
                wait->flags |= WQ_FLAG_WOKEN;

in there. Or maybe have that bit set originally, and clear it when we
add to the wait queue.

I'll send a new version after I actually test it.

                Linus
