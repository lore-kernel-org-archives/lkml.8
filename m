Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1391FC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lYJjsqch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDGQG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:06:29 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45573 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgDGQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:06:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so4675739edl.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZSC8MNyMYJ4CcbIl5da3tSwMWoq31/28XKL6OZqNaaY=;
        b=lYJjsqchyogIG2xHJXiYDwsutn6iKu82kteMMh/iUcPx8osqcaPhaQMR0VRfmVhNWK
         NCagF590A9IHqge+RLez3WuO7uxY62A3hcYNfVsfdv+RVIwhEq7wV1V2/QfjuAh/HHNJ
         Ndiq/cU1KP/QZ40BrUjm6Tbot2afFBCYP9DNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZSC8MNyMYJ4CcbIl5da3tSwMWoq31/28XKL6OZqNaaY=;
        b=J4KNVAw8Hf0KZZNz6NYNjD8MGzc+uibzweXN4PUiA3YqFxEA0esNViJKU5vHgyk8nk
         0BQPh1DFMX2m6zsw6oYXT2GCf+DA/Ob42Yn7pZzIc1GmWj/k7tOVRvbsguC17VWkstSX
         uwFOoXr/0tyKekYnBpATFGaposRaI/VMowEVSh/fxjAffIwrFo66gxTd1Abgti9zrjT1
         oRB7/cJHcqaBySMga9SVALhk+/C4Sz+WnQwI24MzQmpKZVEnyNG+zdlaCEolRJ6HCBqU
         0G4eVlMUVDmNS3Z13z/lK64LGl9+8Zch9eaKHWuGJ3T0LnDgw0BJgCL8KpI5j9JeinkO
         eWsA==
X-Gm-Message-State: AGi0PuaEa08WF2qrmayLx+agpJuqCmonKj9y2E4kPRfzhwncpbgStlC4
        7R+8BFFeDTE5jcRpLRVQ5GX1aMySsyzu58fyb+1Wog==
X-Google-Smtp-Source: APiQypIXfOQtepXXTh7ycOqzqzJa8O502xxo9QjDYoNHsfjRyMveiS82f7idPBRjOLqUA9QCRFw1nO3c8tM2xgW4Ai4=
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr2784058ejj.213.1586275585452;
 Tue, 07 Apr 2020 09:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login> <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
 <20200406172917.GA37692@gardel-login> <a4b5828d73ff097794f63f5f9d0fd1532067941c.camel@themaw.net>
 <CAJfpegvYGB01i9eqCH-95Ynqy0P=CuxPCSAbSpBPa-TV8iXN0Q@mail.gmail.com> <20200407155329.GA39803@gardel-login>
In-Reply-To: <20200407155329.GA39803@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Apr 2020 18:06:13 +0200
Message-ID: <CAJfpegufdi7u3Wyo0YWeoPs9MQa1TePD=AHNW9S9Ey9jTuofHw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 5:53 PM Lennart Poettering <mzxreary@0pointer.de> wr=
ote:
>
> On Di, 07.04.20 15:59, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Tue, Apr 7, 2020 at 4:22 AM Ian Kent <raven@themaw.net> wrote:
> > > > Right now, when you have n mounts, and any mount changes, or one is
> > > > added or removed then we have to parse the whole mount table again,
> > > > asynchronously, processing all n entries again, every frickin
> > > > time. This means the work to process n mounts popping up at boot is
> > > > O(n=C2=B2). That sucks, it should be obvious to anyone. Now if we g=
et that
> > > > fixed, by some mount API that can send us minimal notifications abo=
ut
> > > > what happened and where, then this becomes O(n), which is totally O=
K.
> >
> > Something's not right with the above statement.  Hint: if there are
> > lots of events in quick succession, you can batch them quite easily to
> > prevent overloading the system.
> >
> > Wrote a pair of utilities to check out the capabilities of the current
> > API.   The first one just creates N mounts, optionally sleeping
> > between each.  The second one watches /proc/self/mountinfo and
> > generates individual (add/del/change) events based on POLLPRI and
> > comparing contents with previous instance.
> >
> > First use case: create 10,000 mounts, then start the watcher and
> > create 1000 mounts with a 50ms sleep between them.  Total time (user +
> > system) consumed by the watcher: 25s.  This is indeed pretty dismal,
> > and a per-mount query will help tremendously.  But it's still "just"
> > 25ms per mount, so if the mounts are far apart (which is what this
> > test is about), this won't thrash the system.  Note, how this is self
> > regulating: if the load is high, it will automatically batch more
> > requests, preventing overload.  It is also prone to lose pairs of add
> > + remove in these case (and so is the ring buffer based one from
> > David).
>
> We will batch requests too in systemd, of course, necessarily, given
> that the /p/s/mi inotify stuff is async. Thing though is that this
> means we buy lower CPU usage =E2=80=94 working around the O(n=C2=B2) issu=
e =E2=80=94 by
> introducing artifical higher latencies. We usually want to boot
> quickly, and not artificially slow.
>
> Sure one can come up with some super smart scheme how to tweak the
> artifical latencies, how to grow them, how to shrink them, depending
> on a perceived flood of events, some backing off scheme. But that's
> just polishing a turd, if all we want is proper queued change
> notification without the O(n=C2=B2) behaviour.
>
> I mean, the fix for an O(n=C2=B2) algorithm is to make it O(n) or so. By
> coalescing wake-up events you just lower the n again, probably
> linearly, but that still means we pay O(n=C2=B2), which sucks.

Obviously.  But you keep ignoring event queue overflows; it's
basically guaranteed to happen with a sizable mount storm and then you
are back to O(n^2).

Give it some testing please, as Linus is not going to take any
solution without an actual use case and testing.  When you come back
and say that fsinfo(2) works fine with systemd and a 100k mount/umount
storm, then we can have a look at the performance budget and revisit
the fine points of API design.

Thanks,
Miklos
