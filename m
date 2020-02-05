Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E134C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F342072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwSZYRQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBEUBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:01:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40373 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBEUBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:01:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so1757112pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcoXYYk6ic6vWwpbeV5QTm2mgbC4rz2LbTgr2n4s318=;
        b=EwSZYRQlSTfOd5631vBANnPzLmibK0q3Kn+nWgM4A0/+LgZzsjVIqD11PwXN9SMXeP
         qxELYJJEt62wpvS9Ve6VjxQKmtaJXGiQtoiwepoFufuFXeIRbbyVmpkVzry2f6yhKAPu
         BlRgDrxhuQeJ9e4G4OIXXhFAYsHTYrhyNtfChZhO811iPpKGo2HgO8azV7XsBgakjQ6n
         jfNWVRF3iifmAA2hXlmDJkFkRrAbrAYzVrHliosa4Jk+2/AHFHH6n4JHvoGEc2papwFT
         3hxO+khqEsEWKs+Pvc8HnLz4JxEFV72gHbxcZq8eaefVStJJ+vnA/LhX7ud1As1ptl+I
         UhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcoXYYk6ic6vWwpbeV5QTm2mgbC4rz2LbTgr2n4s318=;
        b=KcpZ8uSmsXWyTqnpFCpkUXRr4ve5q3gZi4WzS423YLTCJHtozQ1llSuOW/+xQDWUQB
         NdHqaGB2S/GZwNqVOQ9zGZITy/YVmnXp6vBLo+sBBLTKG0USM4p9h4nyZWawXm5Md56R
         ARCgTutNOf2T20YgTkVbOyKl8RACw9nqXCbrQcASBm69Fv1g/M1drWF5+sO7/FxOBVRJ
         QPc0EP3VrF88cuJE9MHBwX5pKXKqaWbV24E1S7eHPLQqeTJ7971kJjhINBqD9PcuoldC
         n/Aq2zwu2Dj+uhuhGeNnINfoMt9yYQy9ACdD54H0Xq3jsDV3DTyaBavvA6g2IuIF14Wa
         zcWg==
X-Gm-Message-State: APjAAAWy3ye44ghPS+jSmJHpKuWum2Giq3lueqglEuSPouqxJWiygn8K
        y/GNpKgPVH5BgH/k48GDi9aVey7mhd5j2FDHXR1PIA==
X-Google-Smtp-Source: APXvYqxcGalw2ODSdiROLiuyVW9TergaWetwZzyLAv99VxQSBplNp2n1t8yFtDRDTe/1HpxHT42YejcJhylyTCBf0pQ=
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr38935718pgm.159.1580932861622;
 Wed, 05 Feb 2020 12:01:01 -0800 (PST)
MIME-Version: 1.0
References: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com>
 <20200205021428.8007-1-sj38.park@gmail.com> <CABVgOSmFAZN3KRYkHVg5bb-m-UorB7+9=f9vAqW2ECABzpa9zQ@mail.gmail.com>
In-Reply-To: <CABVgOSmFAZN3KRYkHVg5bb-m-UorB7+9=f9vAqW2ECABzpa9zQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 5 Feb 2020 12:00:49 -0800
Message-ID: <CAFd5g45eys-JoaW-sgnkjwysehe4oxUL1THNifc7+v1xkgSRww@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if
 .kunitconfig is modified
To:     David Gow <davidgow@google.com>, ruscur@russell.cc
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 9:58 AM David Gow <davidgow@google.com> wrote:
>
> One thing we'd like to do with kunit_tool is to make its functionality
> a bit more independent: in particular, allowing the configuration,
> running the kernel, and parsing the results to be done independently.
>
> If that's the case, it may make sense for "kunit.py run" or similar to
> not do anything with the .config, and to relegate that to a separate
> "configuration" step, which would allow someone to modify the
> configuration themselves (e.g., using make menuconfig) and re-run the
> tests, but also allow the config to be explicitly regenerated when
> helpful.
>
> Exactly what that'd end up looking like (and to what extent we'd still
> want to support a single command that'd do both) are still up in the
> air: but I think a general "separation of concerns" like this is
> probably the right path forward for kunit_tool.

You and I have talked about splitting up kunit_tool's functionality
before. I agree with the idea.

I imagine it that we would have

- configuration
- running tests
- dmesg/TAP parsing

as separate runnable scripts. I think that would make it a lot easier
for people with various test bed setups to reuse our code in their
test harness.

Nevertheless, I think it would also be nice to have, as Ted has
previously suggested, a short easy to remember one line command that
just works; it is easily said, and much harder to do, but I think it
is at odds with the separation of functionality. I guess one solution
might just be to have these three separate tools, and then the classic
kunit.py script that combines the functionalities in a single step, or
as Ted suggested we could have some sort of default "make kunit"
command or something like that. I am not really sure what is best
here.

It doesn't address the problem of separation of functionality in
anyway, but one way we could achieve the idea of having a command that
just works, is by putting a line in MAINTAINERS file entries that have
a command that a maintainer expects a submitter to run before sending
a patch to LKML. That might at least make it possible to hack together
a single line KUnit command for every relevant MAINTAINERS entry.
(Obviously there is no reason we have to do this particular idea just
for KUnit. We could do this for other tests as well.) Russel, I think
this was your idea at LCA?

> On Tue, Feb 4, 2020 at 6:14 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > On Tue, 4 Feb 2020 16:46:06 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> >
> > > Sorry for the delay.
> > >
> > > On Mon, Jan 27, 2020 at 10:03 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > > >
> > > > On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
> > > >
> > > > > On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> > > > > >
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > >
> > > > > > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > > > > > rebuilds '.config' only if the '.config' is not a subset of the
> > > > > > '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> > > > > > the '.config' rebuild condition to addtionally check the modified times
> > > > > > of those files.
> > > > >
> > > > > The reason it only checks that .kunitconfig is a subset of .config is
> > > > > because we don't want the .kunitconfig to remove options just because
> > > > > it doesn't recognize them.
> > > > >
> > > > > It runs `make ARCH=um olddefconfig` on the .config that it generates
> > > > > from the .kunitconfig, and most of the time that means you will get a
> > > > > .config with lots of things in it that aren't in the .kunitconfig.
> > > > > Consequently, nothing should ever be deleted from the .config just
> > > > > because it was deleted in the .kunitconfig (unless, of course, you
> > > > > change a =y to a =n or # ... is not set), so I don't see what this
> > > > > change would do.
> > > > >
> > > > > Can you maybe provide an example?
> > > >
> > > > Sorry for my insufficient explanation.  I added a kunit test
> > > > (SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
> > > > from the file.  However, '.config' is not generated again due to the condition
> > > > and therefore the test still runs.
> > > >
> > > > For more detail:
> > > >
> > > >     $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
> > > >     $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
> > > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > >     $ sed -i '4d' ../kunit.out/.kunitconfig
> > > >     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
> > > >
> > > > The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
> > > > added test as expected.  Because the default kunit config contains only 3
> > > > lines, The 4th line command removes the sysctl kunit test from the
> > > > .kunitconfig.  However, the 5th line still run the test.
> > > >
> > > > This patch is for such cases.  Of course, this might make more false positives
> > > > but I believe it would not be a big problem because .config generation takes no
> > > > long time.  If I missed something, please let me know.
> > >
> > > I think I understand.
> > >
> > > It is intentional - currently - that KUnit doesn't generate a new
> > > .config with every invocation. The reason is basically to support
> > > interaction with other methods of generating .configs. Consider that
> > > you might want to use make menuconfig to turn something on. It is a
> > > pretty handy interface if you work on vastly different parts of the
> > > kernel. Or maybe you have a defconfig that you always use for some
> > > platform, I think it is easier to run
> > >
> > > make foo_config; tools/testing/kunit/kunit.py run
> > >
> > > Then having to maintain both your defconfig and a .kunitconfig which
> > > is a superset of the defconfig.
> > >
> > > Your change would make it so that you have to have a .kunitconfig for
> > > every test environment that you care about, and you could not as
> > > easily take advantage of menuconfig.
> >
> > Thank you for this kind answer.  Now I understood the intention and agree with
> > that. :)
> >
> > >
> > > I think what we do now is a bit janky, and the use cases I mentioned
> > > are not super well supported. So I am sympathetic to what you are
> > > trying to do, maybe we could have a config option for it?
> > >
> > > I think Ted and Bjorn might have opinions on this; they had some
> > > related opinions in the past.
> >
> > I'm ok with current state, but if related discussions continue and my opinion
> > is required, I will join in.
> >
> >
> > Thanks,
> > SeongJae Park
> >
> > >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20200205021428.8007-1-sj38.park%40gmail.com.
