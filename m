Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DE120719
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eoVrCN0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHCLRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:17:19 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B11C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:17:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l23so13215620edv.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=eoVrCN0PZZ1JS+F3fakDr2Ij8wISyKSGPN0lWQaGRrdbv1WtI1HXeY2zQorKnB7Bi0
         VRrysLvCQG2nw4yx00kjhBBvbRQCdLC+pMBHaFd4x+oUq5/iuV61KNUXUtmKl/01yaYQ
         K72k3pKjdfjjKvewHfPgkAHJIvr563YyPdSN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phUao9tXf/t4b/68S+2rq16ySbBLGNbfI2sRyl9fmdU=;
        b=gC9h4Dn40DHYR/zMyteQ7m6vpBieqbD37/P7VI8oK2YIEnD+MqjXM1uv7Pox/WZNhl
         emcaNH32jPQWWVqK1WKX48NauJCIoBFcwk8xTOxatYana9+Kb8kXMKu3QqQTK6nmnH7G
         JKeue2JP0Y8c7ZZMa3Nia2ClULGKK/8z4D/ZZeuNyWpT4R/bKKSgi+PHKIvB3BpaTjNl
         Tl02TM3AddjH2Uo0rfL+jyM6zXEefRf9tP3E/c7Mg9V1FyorEaLQ8Tp4Mu1FSuoOSiuD
         cU0kq4n3+c/k9QqB47nc23fwRpNcWX2x/VDLwj2qr2cFb4Zi7Jz4srKKI4r4WP/Zgkcj
         Rmug==
X-Gm-Message-State: AOAM533j+Guaujvb4h76FEjQgWEBLEKfsXG2ZJ4va4Zl8PfRG4ys446E
        CuYA2N24Aj6OK31ul2qupanIycrQorLlkeFE+6AzbA==
X-Google-Smtp-Source: ABdhPJzYkpExpfofwOysvG0SUfDHJUUcNoJnQSIchQHGMGBM9qKDjKahkgN9Xb26C1GwbhowgmIILXMGk8ZjU9gsAgI=
X-Received: by 2002:a05:6402:13d4:: with SMTP id a20mr303427edx.161.1596453438170;
 Mon, 03 Aug 2020 04:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <1293241.1595501326@warthog.procyon.org.uk> <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
 <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <2003787.1595585999@warthog.procyon.org.uk> <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
 <2023286.1595590563@warthog.procyon.org.uk> <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
 <1283475.1596449889@warthog.procyon.org.uk>
In-Reply-To: <1283475.1596449889@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 3 Aug 2020 13:17:06 +0200
Message-ID: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute
 change notifications [ver #5]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 12:18 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > fsinfo() then allows you to retrieve them by path or by mount ID.
> >
> > Shouldn't the notification interface provide the unique ID?
>
> Hmmm...  If I'm going to do that, I have to put the fsinfo-core branch first
> otherwise you can't actually retrieve the unique ID - and thus won't be able
> to make sense of the notification record.  Such a rearrangement might make
> sense anyway since Ian and Karel have been primarily concentrating on fsinfo
> and only more recently started adding notification support.

OTOH mount notification is way smaller and IMO a more mature
interface.  So just picking the unique ID patch into this set might
make sense.

Thanks,
Miklos
