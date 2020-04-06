Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A9FC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ACE206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W3pq5Mo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDFJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:22:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43352 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgDFJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:22:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id bd14so18314625edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ICZidZS836uKk3f5MYlrKnxf/d24delcy3nSKE9ogi4=;
        b=W3pq5Mo7uZpLVGOq5GAIDI/ai7fUH4IIThQ1nwRczafHnhltyPbRBYi4qNanWLvp69
         +904YhfbA4VWq0KvmJHQkjtbf5BXIa7CMoQ1Fr67ulXZcagefy/tt06DHI28sQAl1Z4o
         hoDv8pLs5dD5DoPrxG3VeoDU6ANvHB8Mx51a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ICZidZS836uKk3f5MYlrKnxf/d24delcy3nSKE9ogi4=;
        b=gSGaQPSSNdtSevL5xfHgg0b7Bx21mx2M4xTZ8ip2LE8M6kqey4JrM3LbLmFgNPnsld
         GiZHvsvjfFkv3ccOcHIshnu5tamPYB6AlGyuUtd6q0rzpN/XdvpLJVPRTktm2GsKWfWO
         SImSkOwPRU6HJhz6NmT5rhCln65K7I8L0CN4iP580JlO8oO2Tn0qbjqksPNvsYhAG7QV
         GlNiaraHu7UdZSlPko9KhkmACVcWDIxtH8p/KAC8rJ5Or+ykJZTr7aSFL31cafMY3nGC
         Kacn+ajdkc7JWKEMj3jcUnPPc25aPg/W6zV5dhqzkyam5K4ZA/TW5bN0c+9hBU9zlmYn
         ndlA==
X-Gm-Message-State: AGi0PuYHB8wsby69dEPdqhMhc4rtUDBUXt2PvGtbYEnal5Vwb+W7iyul
        DRO6wyTNl5OlJermrEnafs4mOF00mB1R16L+cNfjDg==
X-Google-Smtp-Source: APiQypKhY01mdGI1/JQgHY2uIzhyGBPdhVdoEMLb6wrymVsJFgMONWTk9QGbDBPrwg//+L4NEZ3xqyN3Wn1J9Hi6NTs=
X-Received: by 2002:a17:906:b351:: with SMTP id cd17mr20431593ejb.351.1586164962711;
 Mon, 06 Apr 2020 02:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login>
In-Reply-To: <20200403150143.GA34800@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 6 Apr 2020 11:22:31 +0200
Message-ID: <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
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

On Fri, Apr 3, 2020 at 5:01 PM Lennart Poettering <mzxreary@0pointer.de> wr=
ote:
>
> On Fr, 03.04.20 13:48, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > > > Does that make any sense?
> > >
> > > When all mounts in the init mount namespace are unmounted and all
> > > remaining processes killed we switch root back to the initrd, so that
> > > even the root fs can be unmounted, and then we disassemble any backin=
g
> > > complex storage if there is, i.e. lvm, luks, raid, =E2=80=A6
> >
> > I think it could be done the other way round, much simpler:
> >
> >  - switch back to initrd
> >  - umount root, keeping the tree intact (UMOUNT_DETACHED)
> >  - kill all remaining processes, wait for all to exit
>
> Nah. What I wrote above is drastically simplified. It's IRL more
> complex. Specific services need to be killed between certain mounts
> are unmounted, since they are a backend for another mount. NFS, or
> FUSE or stuff like that usually has some processes backing them
> around, and we need to stop the mounts they provide before these
> services, and then the mounts these services reside on after that, and
> so on. It's a complex dependency tree of stuff that needs to be done
> in order, so that we can deal with arbitrarily nested mounts, storage
> subsystems, and backing services.

That still doesn't explain why you need to keep track of all mounts in
the system.

If you are aware of the dependency, then you need to keep track of
that particular mount. If not, then why?

What I'm starting to see is that there's a fundamental conflict
between how systemd people want to deal with new mounts and how some
other people want to use mounts (i.e. tens of thousands of mounts in
an automount map).

I'm really curious how much the mount notification ring + per mount
query (any implementation) can help that use case.

> Anyway, this all works fine in systemd, the dependency logic is
> there. We want a more efficient way to watch mounts, that's
> all. Subscribing and constantly reparsing /proc/self/mountinfo is
> awful, that's all.

I'm not sure that is all.   To handle storms of tens of thousands of
mounts, my guess is that the fundamental way of dealing with these
changes will need to be updated in systemd.

Thanks,
Miklos
