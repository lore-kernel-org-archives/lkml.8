Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11BC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4283120857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQFN9ZA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBPS6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 13:58:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54099 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726043AbgBPS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 13:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581879485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GozdsbK2Rv82c8TbUiRuxlIS9hdQHYifJme8rkK7//I=;
        b=CQFN9ZA1+BTT7BM/IRR+8Y9RiXTVvs0c7vxCKEnqqMp4UjsRblt+heQBBEKI/hh6DuURdd
        yKTO2CQkBX0NdhBeWPcP5S1rcUsL6rPLRSO0ydhw0Jrt+t05tDoED+ybo4sbC8Oe50wC8v
        n0XQIh7uwL5AGeHBTfoaPqwXdQYkdb8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-lEx-FuUwNM6OcTwrF6VLeA-1; Sun, 16 Feb 2020 13:58:02 -0500
X-MC-Unique: lEx-FuUwNM6OcTwrF6VLeA-1
Received: by mail-qk1-f199.google.com with SMTP id 24so10404249qka.16
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 10:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GozdsbK2Rv82c8TbUiRuxlIS9hdQHYifJme8rkK7//I=;
        b=n0RLEQ0wHn5itMKxgro5HYVfrje8XJpaXcGgySYQ/pZfpkx7I4Ee7ZgvrpcyrzGn10
         CwC326WYRCbmiKTWeTZgrOAmKYNQ5AcVbVSxf6BfoXyvcmnMX0z4ZQFOfK+uZtOuRLi+
         R4AmOQBB8VevSJhKeRr0JReQHGDGYaKrKC+9D4a0ZxXhqonzYTVjd2aZKDmFAsWTKo6h
         EEu7U0OE4fJQ6eoAkx4Lm18x5jYd+JjqEOhZGTSmhERn4RtXQSXENx9IBscpuzE1x9xN
         hzGPANDxc5UMR25jgCZ8rW+6mTfCP4U1eLIEdIkOMnp8zoZGIx7gEXRrxtse2oZhzMQb
         r/GQ==
X-Gm-Message-State: APjAAAVHkIMXi+uj/U6QgyTZqF/jc8bRM458foNIjmEe3tkmViQN310y
        h+80WXqpOAAOdkcsH68LJC50nFt+KKsTF+7qzUpq4QhWSWV32cDENAEE3pbdpxc/z954y2YzS8N
        tiJkbuMNYojs0LK6b32sPvdwi
X-Received: by 2002:a05:620a:535:: with SMTP id h21mr11853477qkh.184.1581879481715;
        Sun, 16 Feb 2020 10:58:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVldeOsogNmOOiSeErE8jCYOfPfnoQVRnjWU1KLUHG5w8IZp49jOMoylujVnQjOk6rXrQw8Q==
X-Received: by 2002:a05:620a:535:: with SMTP id h21mr11853453qkh.184.1581879481325;
        Sun, 16 Feb 2020 10:58:01 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id b12sm7565703qkl.0.2020.02.16.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 10:58:00 -0800 (PST)
Date:   Sun, 16 Feb 2020 13:57:59 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Philipp Rudo <prudo@linux.ibm.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: s390 depending on cc-options makes it difficult to configure
Message-ID: <20200216185759.GA4091960@dev.jcline.org>
References: <20191209164155.GA78160@dev.jcline.org>
 <20191210090108.GA22512@unicorn.suse.cz>
 <20191211171822.GA36366@dev.jcline.org>
 <20200210194936.511ef603@laptop2-ibm.local>
 <CAK7LNATL3Oyn=FLKm0TcB9SkJLuCOWV06a_t-FRtFiFp9Vda1g@mail.gmail.com>
 <20200214203536.GA133402@laptop.jcline.org>
 <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ9+n8eRyUVrqTNDu915VcE+uHQoewH8WzJqpOpi8rT0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 01:08:49PM +0900, Masahiro Yamada wrote:
> On Sat, Feb 15, 2020 at 5:35 AM Jeremy Cline <jcline@redhat.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 12:31:05PM +0900, Masahiro Yamada wrote:
> > > Hi.
> > >
> > > On Tue, Feb 11, 2020 at 3:49 AM Philipp Rudo <prudo@linux.ibm.com> wrote:
> > > >
> > > > Hey Jeremy,
> > > > Hey Michal,
> > > >
> > > > sorry for the late response. The mail got lost in the pre-xmas rush...
> > > >
> > > > In my opinion the problem goes beyond s390 and the commit you mentioned. So I'm
> > > > also adding Masahiro as Kconfig maintainer and author of cc-option.
> > >
> > >
> > > I did not notice the former discussion.
> > > Thanks for CC'ing me.
> > >
> > >
> > >
> > >
> > > > On Wed, 11 Dec 2019 12:18:22 -0500
> > > > Jeremy Cline <jcline@redhat.com> wrote:
> > > >
> > > > > On Tue, Dec 10, 2019 at 10:01:08AM +0100, Michal Kubecek wrote:
> > > > > > On Mon, Dec 09, 2019 at 11:41:55AM -0500, Jeremy Cline wrote:
> > > > > > > Hi folks,
> > > > > > >
> > > > > > > Commit 5474080a3a0a ("s390/Kconfig: make use of 'depends on cc-option'")
> > > > > > > makes it difficult to produce an s390 configuration for Fedora and Red
> > > > > > > Hat kernels.
> > > > > > >
> > > > > > > The issue is I have the following configurations:
> > > > > > >
> > > > > > > CONFIG_MARCH_Z13=y
> > > > > > > CONFIG_TUNE_Z14=y
> > > > > > > # CONFIG_TUNE_DEFAULT is not set
> > > > > > >
> > > > > > > When the configuration is prepared on a non-s390x host without a
> > > > > > > compiler with -march=z* it changes CONFIG_TUNE_DEFAULT to y which, as
> > > > > > > far as I can tell, leads to a kernel tuned for z13 instead of z14.
> > > > > > > Fedora and Red Hat build processes produce complete configurations from
> > > > > > > snippets on any available host in the build infrastructure which very
> > > > > > > frequently is *not* s390.
> > > > > >
> > > > > > We have exactly the same problem. Our developers need to update config
> > > > > > files for different architectures and different kernel versions on their
> > > > > > machines which are usually x86_64 but that often produces different
> > > > > > configs than the real build environment.
> > > > > >
> > > > > > This is not an issue for upstream development as one usually updates
> > > > > > configs on the same system where the build takes place but it's a big
> > > > > > problem for distribution maintainers.
> > > >
> > > > If I recall correct the goal was to avoid trouble with clang, as it does not
> > > > support all processor types with -march. But yeah, in the original
> > > > consideration we only thought about upstream development and forgot the
> > > > distros.
> > > > > > > I did a quick search and couldn't find any other examples of Kconfigs
> > > > > > > depending on march or mtune compiler flags and it seems like it'd
> > > > > > > generally problematic for people preparing configurations.
> > > >
> > > > True, but not the whole story. Power and Arm64 use cc-option to check for
> > > > -mstack-protector*, which do not exist on s390. So you have the same problem
> > > > when you prepare a config for any of them on s390. Thus simply reverting the
> > > > commit you mentioned above does not solve the problem but merely hides one
> > > > symptom. Which also means that the original problem will return over and over
> > > > again in the future.
> > > >
> > > > An other reason why I don't think it makes sens to revert the commit is that it
> > > > would make cc-option as a whole useless. What's the benefit in having cc-option
> > > > when you are not allowed to use it? Or less provocative, in which use cases is
> > > > allowed to use cc-option?
> > >
> > >
> > > You are right.
> > > Reverting the particular s390 commit is not the solution.
> > >
> > >
> > > > > > There are more issues like this. In general, since 4.17 or 4.18, the
> > > > > > resulting config depends on both architecture and compiler version.
> > > > > > Earlier, you could simply run "ARCH=... make oldconfig" (or menuconfig)
> > > > > > to update configs for all architectures and distribution versions.
> > > > > > Today, you need to use the right compiler version (results with e.g.
> > > > > > 4.8, 7.4 and 9.2 differ) and architecture.
> > > > > >
> > > > >
> > > > > Yeah, that's also troublesome. This is by no means the first problem
> > > > > related to the environment at configuration time, but it the most
> > > > > bothersome to work around (at least for Fedora kernel configuration).
> > > > >
> > > > > > At the moment, I'm working around the issue by using chroot environments
> > > > > > with target distributions (e.g. openSUSE Tumbleweed) and set of cross
> > > > > > compilers for supported architectures but it's far from perfect and even
> > > > > > this way, there are problemantic points, e.g. BPFILTER_UMH which depends
> > > > > > on gcc being able to not only compile but also link.
> > > > > >
> > > > > > IMHO the key problem is that .config mixes configuration with
> > > > > > description of build environment. I have an idea of a solution which
> > > > > > would consist of
> > > > > >
> > > > > >   - an option to extract "config" options which describe build
> > > > > >     environment (i.e. their values are determined by running some
> > > > > >     command, rather than reading from a file or asking user) into
> > > > > >     a cache file
> > > > > >   - an option telling "make *config" to use such cache file for these
> > > > > >     environment "config" options instead of running the test scripts
> > > > > >     (and probably issue an error if an environment option is missing)
> > > > > >
> > > > >
> > > > > I agree that the issue is mixing kernel configuration with build
> > > > > environment. I suppose a cache file would work, but it still sounds like
> > > > > a difficult process that is working around that fact that folks are
> > > > > coupling the configuration step with the build step.
> > > >
> > > > An other solution would be a "I know better" switch which simply disables
> > > > cc-option for that run. That would allow the use of cc-option for upstream
> > > > development and provide a simple way for distros to turn it off.
> > > >
> > > > > I would advocate that this patch be reverted and an effort made to not
> > > > > mix build environment checks into the configuration. I'm much happier
> > > > > for the build to fail because the configuration can't be satisfied by
> > > > > the environment than I am for the configuration to quietly change or for
> > > > > the tools to not allow me to make the configuration in the first place.
> > > > > Ideally the tools would warn the user if their environment won't build
> > > > > the configuration, but that's a nice-to-have.
> > > >
> > > > I too would prefer to have a warning instead of the config being silently
> > > > changed. But again, the problem goes beyond what was reported.
> > > >
> > > > @Masahiro: What do you think about it?
> > > >
> > > > Thanks
> > > > Philipp
> > > >
> > >
> > >
> > > The problem for Jeremy and Michal is,
> > > it is difficult to get a full-feature cross-compiler
> > > for every arch.
> > >
> >
> > Indeed.
> >
> > > One idea to workaround this is
> > > to use a fake script that accepts any flag,
> > > and use it as $(CC) in Kconfig.
> > >
> > > RFC patch is attached.
> > >
> > > This is not a perfect solution, of course.
> > >
> >
> > The attached patch doesn't looks like it'd work for what we need,
> 
> I thought turning all cc-options to y would work
> for what you need.
> 
> With this, you can enable
> CONFIG_MARCH_Z13=y and CONFIG_TUNE_Z14=y
> instead of CONFIG_TUNE_DEFAULT.
> 
> If this approach does not work for you,
> what is your requirement?
> 

Oof, this was an awful typo. It *would* work for what we need. Sorry for
the confusion :(.

> 
> 
> > although I wonder if it's easier to just check when cc-options is
> > defined for an environment variable or something and always return y
> > instead of calling out to $(CC) at all. Comes to the same thing, I
> > suppose.
> 
> 
> The macro definition in scripts/Kconfig.include
> takes precedence over any environment variable.
> 
> So, if you want to hack it from the environment,
> you need to change the code somehow.
> 
> The scripts/dummy-tools/ approach does not change
> anything for the use-case in upstream.
> 
> The result is the same, of course.
> 

Indeed. Since I'm not maintaining it I don't have a particularly strong
opinion about the approach. Whatever you like most works for me.

- Jeremy

