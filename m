Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52837C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFA2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="hOLmFJuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgBJNgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:36:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42681 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbgBJNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:36:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id r5so3752037qtt.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K7xCPnfPDVaR+RixreW4kHYksD72YNNnHkzPeZTukvc=;
        b=hOLmFJuXSPhNr6hGsvNbQBjooSUc+bvOw+weuVWZ5Oj47eXtyN14KfFin8aMDfNy5e
         RmJmZt5GHnHXy+AEFUxnaznGVp5oZk9l2PloyqdMT2c0C4bsjUzjVvu58VTesYrASUPI
         +Fj9ij42AFVr/C2hVYNqaJyTni4jCPd5/cIZ5MlY/nwwREyYbBvTuOQhc1xkG0FdhoK2
         37Q5riHmSOGrjnjzkzrFnA226x/CVe15zMTB/bpjcrNZmXt+GGvqPfUtSMLeQ85hWtzv
         7oiczKj8+oUlgM2ZuXhrFPs9oI+KdQsYJqvEtPpQ2fnG9hMKOtBWq6w6H8oypBKCJuMv
         xYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7xCPnfPDVaR+RixreW4kHYksD72YNNnHkzPeZTukvc=;
        b=WMPCJfOj9mMDdxVrsO1VVVlTnaQp/FTmuY613mLYg0OnyGIErn3Jo8tLeu1wUbf88w
         PGfX9dqJtqpHUjJYpB1HYQXB/Naa5BS3VHYsTvsY9fCg3jMdJeufnRHWSOylLNZREhJj
         rgugaqj6CJl3ByPlsJnIVgY80I9vNMfKYsb0VtfyaKJA0pQD4NJXukX4inwugUeARTSJ
         1PfpBvpJKz3r9q2nqTBF/qArjyT8+p71P/oU2tYUqhSsQEhGPwCMOBXsSUdTFa6b04/v
         HA7Kgpo/0aJBzg4UgWz60/zxzxZCPo9ZC5Vv28d8OHh/fr0YYl6d62ftaSreK3D/dFCB
         +h4A==
X-Gm-Message-State: APjAAAVxqcpvSo+FnW4Ug/doO4Mi+XPoK5Nz78H9Z9/vFZGJSGJZotB1
        Tmbf721+vfpZoCTWFlJK8yM15g==
X-Google-Smtp-Source: APXvYqzfCrSW05EQXUwLqWEr2tZP7aRcMoWF/NyH7uQ5NOu69GP0VRROWubYpavskQBcxywAN8selw==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr10090991qtj.106.1581341771026;
        Mon, 10 Feb 2020 05:36:11 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 205sm144034qkd.61.2020.02.10.05.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 05:36:10 -0800 (PST)
Message-ID: <1581341769.7365.25.camel@lca.pw>
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, ira.weiny@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Date:   Mon, 10 Feb 2020 08:36:09 -0500
In-Reply-To: <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
References: <CANpmjNNaHAnKCMLb+Njs3AhEoJT9O6-Yh63fcNcVTjBbNQiEPg@mail.gmail.com>
         <26B88005-28E6-4A09-B3A7-DC982DABE679@lca.pw>
         <CANpmjNMzF-T=CzMqoJh-5zrsro8Ky7Q85tnX_HwWhsLCa0DsHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-10 at 13:58 +0100, Marco Elver wrote:
> On Mon, 10 Feb 2020 at 13:16, Qian Cai <cai@lca.pw> wrote:
> > 
> > 
> > 
> > > On Feb 10, 2020, at 2:48 AM, Marco Elver <elver@google.com> wrote:
> > > 
> > > Here is an alternative:
> > > 
> > > Let's say KCSAN gives you this:
> > >   /* ... Assert that the bits set in mask are not written
> > > concurrently; they may still be read concurrently.
> > >     The access that immediately follows is assumed to access those
> > > bits and safe w.r.t. data races.
> > > 
> > >     For example, this may be used when certain bits of @flags may
> > > only be modified when holding the appropriate lock,
> > >     but other bits may still be modified locklessly.
> > >   ...
> > >  */
> > >   #define ASSERT_EXCLUSIVE_BITS(flags, mask)   ....
> > > 
> > > Then we can write page_zonenum as follows:
> > > 
> > > static inline enum zone_type page_zonenum(const struct page *page)
> > > {
> > > +       ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> > >        return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> > > }
> > > 
> > > This will accomplish the following:
> > > 1. The current code is not touched, and we do not have to verify that
> > > the change is correct without KCSAN.
> > > 2. We're not introducing a bunch of special macros to read bits in various ways.
> > > 3. KCSAN will assume that the access is safe, and no data race report
> > > is generated.
> > > 4. If somebody modifies ZONES bits concurrently, KCSAN will tell you
> > > about the race.
> > > 5. We're documenting the code.
> > > 
> > > Anything I missed?
> > 
> > I don’t know. Having to write the same line twice does not feel me any better than data_race() with commenting occasionally.
> 
> Point 4 above: While data_race() will ignore cause KCSAN to not report
> the data race, now you might be missing a real bug: if somebody
> concurrently modifies the bits accessed, you want to know about it!
> Either way, it's up to you to add the ASSERT_EXCLUSIVE_BITS, but just
> remember that if you decide to silence it with data_race(), you need
> to be sure there are no concurrent writers to those bits.

Right, in this case, there is no concurrent writers to those bits, so I'll add a
comment should be sufficient. However, I'll keep ASSERT_EXCLUSIVE_BITS() in mind
for other places.

> 
> There is no way to automatically infer all over the kernel which bits
> we care about, and the most reliable is to be explicit about it. I
> don't see a problem with it per se.
> 
> Thanks,
> -- Marco
