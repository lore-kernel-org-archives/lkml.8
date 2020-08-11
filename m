Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C354C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 727BB204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q1ksszNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgHKOgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgHKOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:36:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08834C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:36:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so9248047edk.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqdx28YA3pNP6REzIkc0gA+th2RV2sA+pXLZKVTobEc=;
        b=Q1ksszNnkE3uXErudLxD5Slds/9xC2LepwVHl/yg53pTvHQKvRVeVoUg19cu3r8O/d
         2j5OwMLDoAG2lTQ7vwNNjuRby0rp1tOy3R428/P7KvCr+CqmNv4b9Nxng7AZH6DqOvtU
         tf6V8M7ABdiI9pdl+NAAhtTZ4ax+VPsqyGlKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqdx28YA3pNP6REzIkc0gA+th2RV2sA+pXLZKVTobEc=;
        b=qEADhPDgQRjmRHMQAnAPwFEox6J2+pzFlP6q0Wtp0WVprcFU0xzVercBFd1eAfLFri
         u/t9+boE+eQUhPaSN4gmSDzPIv1aQgzMN7Z1Gb+OkHr1FNnlX/u//t18cMhWdZzD/mzH
         bUFPqdpryaGhSOk7ayZvT0CjNU45MYHTvGV9k7bceSkdM1s09WQiAmj6zjVbGAL90Udx
         3Ubv3oLEOI2kqXhD8HlJp23VtxoUlsnFrrq15CVsJGQb5zSNmsymJqpWV8A1f5837/1g
         4b5ieF+1s3HkVM2FqMn647xyiz0f+AFhLRDSqFM7FT1LrH3t9D4kV0i2STeZWHRwSDyM
         2ysw==
X-Gm-Message-State: AOAM53325pu8nh8XsR9PlGXID4HD1BI7aRPVEGDIYdc1UFfBIV4c2Y03
        5x/4REZIm8ZrBqgMhwFS/MULj3zc97U7Ejx4gpCwiw==
X-Google-Smtp-Source: ABdhPJxfnGcG5XR0N3VewKejZMDihZQ7PMSWe3JlRhAnp2pRLAKcLCy/qRsSkNN9jcnRpbbl6pgbPRQzUP2hwNpB62Q=
X-Received: by 2002:aa7:d688:: with SMTP id d8mr26760651edr.168.1597156603660;
 Tue, 11 Aug 2020 07:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <20200811140833.GH1236603@ZenIV.linux.org.uk>
 <CAJfpegsNj55pTXe97qE_i-=zFwca1=2W_NqFdn=rHqc_AJjr8Q@mail.gmail.com> <20200811143107.GI1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811143107.GI1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 16:36:32 +0200
Message-ID: <CAJfpegvAVOYg03q7n24d6faX33rd16WWi5+LLDdfwj_gRYaJLQ@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 4:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 04:22:19PM +0200, Miklos Szeredi wrote:
> > On Tue, Aug 11, 2020 at 4:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 03:54:19PM +0200, Miklos Szeredi wrote:
> > > > On Wed, Aug 05, 2020 at 10:24:23AM +0200, Miklos Szeredi wrote:
> > > > > On Tue, Aug 4, 2020 at 4:36 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > > I think we already lost that with the xattr API, that should have been
> > > > > > done in a way that fits this philosophy.  But given that we  have "/"
> > > > > > as the only special purpose char in filenames, and even repetitions
> > > > > > are allowed, it's hard to think of a good way to do that.  Pity.
> > > > >
> > > > > One way this could be solved is to allow opting into an alternative
> > > > > path resolution mode.
> > > > >
> > > > > E.g.
> > > > >   openat(AT_FDCWD, "foo/bar//mnt/info", O_RDONLY | O_ALT);
> > > >
> > > > Proof of concept patch and test program below.
> > > >
> > > > Opted for triple slash in the hope that just maybe we could add a global
> > > > /proc/sys/fs/resolve_alt knob to optionally turn on alternative (non-POSIX) path
> > > > resolution without breaking too many things.  Will try that later...
> > > >
> > > > Comments?
> > >
> > > Hell, NO.  This is unspeakably tasteless.  And full of lovely corner cases wrt
> > > symlink bodies, etc.
> >
> > It's disabled inside symlink body resolution.
> >
> > Rules are simple:
> >
> >  - strip off trailing part after first instance of ///
> >  - perform path lookup as normal
> >  - resolve meta path after /// on result of normal lookup
>
> ... and interpolation of relative symlink body into the pathname does change
> behaviour now, *including* the cases when said symlink body does not contain
> that triple-X^Hslash garbage.  Wonderful...

Can you please explain?

Thanks,
Miklos
