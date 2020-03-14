Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F38C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A978B20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584240559;
	bh=fKa0Mj8D7EWiXfNH1vC9ZFdeWq+GvZo2dX8M3sXOIWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ss4tvG3uaJIdFVP7v3ZK34Ji7+RAHM+TvqrUg229hb6nsB2FMm3Scz0E8HAtsRc2k
	 WIjBzKCxjx+4z07FSwZgsw/w1itggAHp/AafP3H7hqo0klbgMFc2m7ieiFhVvFJIf/
	 Z9VnO93elyXCUuEk8mSn1v9PoTMAxhEp/Nhw7Blk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCOCtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:49:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40612 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:49:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so14785308ljj.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNAFSM2e1+znwd/oK9GqPEFWnZPCXJOYSC3o4R7VRNY=;
        b=XmKJHhBn38vYPYW5Qw9NYbOmHlLhlGbMUnho47mHIiguKzuelMDN6CDf+xfm0al7z0
         mhcACnrAah8QVEpIZpnR9mCR0ilV+pTCciPD61XwhA2JptKErlcb+6K96hJ8XT5oymeB
         WnZpWU1cbZc0qURpjpCma+Gj+Ll56cjVy3Bmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNAFSM2e1+znwd/oK9GqPEFWnZPCXJOYSC3o4R7VRNY=;
        b=lVexekRwaIg8W3QqoAtOZv/cvZkbHrVsIgYKbZzN1HD3w7ICnZ6QTojYqbTN4QPYHd
         aBb0O7d22VHJevxru4Cc6RbnNmT1FpJmLA36h3wLTVNPiKtkUIKW8fZ5MbUOVYffNpa+
         W8gWVTruVtCmEOpiM4x4APeXPHquOJrYTvYWz9kjxliJnK8mxjFRry7lxRl3qcfYglK7
         gY6Pi/7VmECyILdYyYxoZyqsopmK7/3T+8gG3mx40zT+yJIHH5CKfRpP+IU2EOGikh8b
         w4JMUgV/1KsFx7+fvo9xXVDg6yeI3LyA/fRf//cCzWWOzj6kSF5jyLkKwYPYIDIvnUz5
         StUQ==
X-Gm-Message-State: ANhLgQ0w5x8fI0MLoCMhEWC9ys9eFQcSsM9BD3vbABxSWMdRpWC97Wgq
        IzkYNsYtsctqGizJtnJ9MeiuNJ0JHLg=
X-Google-Smtp-Source: ADFU+vsDariyxD3KYgVI0S/8ZaHdPvu0tDalrmUkEuDejy3P0lVXJJ9Rd0/9rAbtq6m/0oWHU/UbUg==
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr11623730lfe.178.1584201502855;
        Sat, 14 Mar 2020 08:58:22 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id g25sm31198182ljn.107.2020.03.14.08.58.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 08:58:21 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f13so13912897ljp.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 08:58:21 -0700 (PDT)
X-Received: by 2002:a2e:6819:: with SMTP id c25mr11582038lja.16.1584201500891;
 Sat, 14 Mar 2020 08:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
 <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
 <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name> <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name> <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org> <877dznu0pk.fsf@notabene.neil.brown.name>
In-Reply-To: <877dznu0pk.fsf@notabene.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Mar 2020 08:58:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
Message-ID: <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 7:31 PM NeilBrown <neilb@suse.de> wrote:
>
> The idea of list_del_init_release() and list_empty_acquire() is growing
> on me though.  See below.

This does look like a promising approach.

However:

> +       if (waiter->fl_blocker == NULL &&
> +           list_empty(&waiter->fl_blocked_requests) &&
> +           list_empty_acquire(&waiter->fl_blocked_member))
> +               return status;

This does not seem sensible to me.

The thing is, the whole point about "acquire" semantics is that it
should happen _first_ - because a load-with-acquire only orders things
_after_ it.

So testing some other non-locked state before testing the load-acquire
state makes little sense: it means that the other tests you do are
fundamentally unordered and nonsensical in an unlocked model.

So _if_ those other tests matter (do they?), then they should be after
the acquire test (because they test things that on the writer side are
set before the "store-release"). Otherwise you're testing random
state.

And if they don't matter, then they shouldn't exist at all.

IOW, if you depend on ordering, then the _only_ ordering that exists is:

 - writer side: writes done _before_ the smp_store_release() are visible

 - to the reader side done _after_ the smp_load_acquire()

and absolutely no other ordering exists or makes sense to test for.

That limited ordering guarantee is why a store-release -> load-acquire
is fundamentally cheaper than any other serialization.

So the optimistic "I don't need to do anything" case should start ouf with

        if (list_empty_acquire(&waiter->fl_blocked_member)) {

and go from there. Does it actually need to do anything else at all?
But if it does need to check the other fields, they should be checked
after that acquire.

Also, it worries me that the comment talks about "if fl_blocker is
NULL". But it realy now is that fl_blocked_member list being empty
that is the real serialization test, adn that's the one that the
comment should primarily talk about.

                Linus
