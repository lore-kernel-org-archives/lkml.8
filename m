Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DCCC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4FF20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aB2mqO0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgBJM6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:58:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43424 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgBJM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:58:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so9050251oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zh7WaU7ewGekRG7I1HMZ6lekH2DZziRDqSPnvPUVHsM=;
        b=aB2mqO0I1BE2YVL9HktuWHitoKBpyzRZp78dTOhF8GymM4iLL/UTUr12XfLXer7+2Q
         tJBqlfHLPj4M8LChNh8/vNK2luTKqHWGkEHCBkyQg8aQD5o6SADs1g9OBN/dowF3Illb
         eB9WOCXOto4ZifIPH9uojL6ipxlAdUogy56n9NMOb6GwM7gCdasNUNswGwkxiMh7i8LV
         7JmEyLwoy7olS9Ue2hSHhkVwWSEmkaH/OTBwbBr0bBIQpwr5IpPz4tEFcGL9bfSIgGwN
         Al9t+58bAsnLAuigp+kJtMYgS46qixPPoI3ejMsWNjuEYCiLgRp50wwHWxJLU/qRqE/i
         7ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zh7WaU7ewGekRG7I1HMZ6lekH2DZziRDqSPnvPUVHsM=;
        b=tJ6z+jMuj17N72V2zPO/dXztw5Cu1d/Z3TUxXoLVzxuKwvRPz6ixASfuW5fjZtfynJ
         0aKWnThMshLPa04He8f/sV6s+zjtUNZSmiZ5MAfGhyasNXo2BIVlK0+b+PQpceZ5xDbv
         czqU9wJzm47ZaPQdRmIWidNLAQrQrhwKZd9c92JnCfbhLTGSjVLRScHTHRmyacla4L+J
         e/bmgye/5ltHvvLAYIu/H0WMu+JhWLEIBQlf6SWhsQkUP5OB+uq4Jncr5hTJI2kJWMhc
         xLImWIVxgcggKyoCtDn7tEm01l9uc72OIDxg0us/cREKZDjSvFwwRTbVAe4ckVwxofc1
         BjfQ==
X-Gm-Message-State: APjAAAW4PzE87R6DFuW4vpo96xLatSBpYwiDdsU0ap6lQ5tuYp1XvAAc
        1Wo8y0mYlGJVeqv3qgrXii2FPWHf77FyjjzXg9nYlg==
X-Google-Smtp-Source: APXvYqyLVKEJkzbvqewcQ1Cwp/1kseXffAz8pZi+JP4f+koptcUYrs6fKS19tYLFdKppaHVYVOsespyyJSiphNJMBzk=
X-Received: by 2002:aca:2112:: with SMTP id 18mr684589oiz.155.1581339494032;
 Mon, 10 Feb 2020 04:58:14 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
 <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw>
In-Reply-To: <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Feb 2020 13:58:02 +0100
Message-ID: <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 13:16, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wrote:
> >
> > Here is an alternative:
> >
> > Let's say KCSAN gives you this:
> >   /* ... Assert that the bits set in mask are not written
> > concurrently; they may still be read concurrently.
> >     The access that immediately follows is assumed to access those
> > bits and safe w.r.t. data races.
> >
> >     For example, this may be used when certain bits of @flags may
> > only be modified when holding the appropriate lock,
> >     but other bits may still be modified locklessly.
> >   ...
> >  */
> >   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> >
> > Then we can write page_zonenum as follows:
> >
> > static inline enum zone_type page_zonenum(const struct page *page)
> > {
> > +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT)=
;
> >        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > }
> >
> > This will accomplish the following:
> > 1. The current code is not touched, and we do not have to verify that
> > the change is correct without KCSAN.
> > 2. We're not introducing a bunch of special macros to read bits in vari=
ous ways.
> > 3. KCSAN will assume that the access is safe, and no data race report
> > is generated.
> > 4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
> > about the race.
> > 5. We're documenting the code.
> >
> > Anything I missed?
>
> I don=E2=80=99t know. Having to write the same line twice does not feel m=
e any better than data_race() with commenting occasionally.

Point 4 above: While data_race() will ignore cause KCSAN to not report
the data race, now you might be missing a real bug: if somebody
concurrently modifies the bits accessed, you want to know about it!
Either way, it's up to you to add the ASSERT_EXCLUSIVE_BITS, but just
remember that if you decide to silence it with data_race(), you need
to be sure there are no concurrent writers to those bits.

There is no way to automatically infer all over the kernel which bits
we care about, and the most reliable is to be explicit about it. I
don't see a problem with it per se.

Thanks,
-- Marco
