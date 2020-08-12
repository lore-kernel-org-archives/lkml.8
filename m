Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AB020781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262257;
	bh=zANYippBEM8vlz4ACqIlFjW9XcLrdF4n06DKDTjMecs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=InvpCv4wcU0Rfbf7qrOM4EzlP0KpKnyVHMpZ39HjQ9L+urtI3naSLtGT0nYRdhu2I
	 LREC2P54waY4WroG+ARH3FamOmOK3kPIxpp01EPh2P0rtibtOvJ9T+ITtB4BNLVrYG
	 ERT7bKqd0qKu4AJbWXpOUvRJVvU2I5kbLJsqvU/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHLT5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgHLT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:57:35 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B96C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:57:35 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a14so2451633edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=U1hdSpOUSLOjOrO72XqzG+q96d1pIF0cv/aZqt7kBp+fkvgL9591I+FRTAk0LrnIxR
         8JT4UZPZRO/zc5YAudhwHewQ4vDe1rgRhtOdIJf44K3wQIjkVGrwuKfqWiz5aOBB7xzw
         NmuJO1e6+UoXEurWxTmy0lrzQtpRHAgwv0Dgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0LPNTEWbU2mq6BgRpzsioeNr4RPYOF2TnDOgMD6NIs=;
        b=sh5UjN0GDwTb8/pXp4+F31ymL1JhnvP3MXBNsyIzI9xubkybu2GrlPyLrwCdVddPYr
         8e1KCj3no1IRZ4jA52kq3RH0peIr+6yKp85lPpfgZd0rGqWHYdkh+GGp0icJe2c8gSst
         7hrYUVlrXPkeDEGe4aqF/hoi23Fqoh/ChkPA96qGrwvDO9g1kWc9D5bgWZEaJHOeVGaa
         ebT9Km37ujHININtv2nG7F1HoGjubus7Jb9fSapy/sXuW4reOz/El5JRrPDNCbVewY8k
         Z14CKn9lMPC7Ypgxfdvc0U+Wt8GzVyc7HheTCiSb6HXRJL6+dWzCycw/xwYG3A4FfAUc
         8WiQ==
X-Gm-Message-State: AOAM532t0gVoboNqrZETYBXWgZtHrxDvIwey14D0tIWNqPpeKvwTr6b/
        FGnsj6/cEYxPthCsiMXb269ByUmmNK8=
X-Google-Smtp-Source: ABdhPJx8lVjJ3f9S5jZzIEOQQrF6PunDC5irRIZ7TinyUPoA4eAYp0DTjT5ky/jgPQXtXCJD+Mk8Yg==
X-Received: by 2002:a50:d697:: with SMTP id r23mr1505001edi.223.1597262253941;
        Wed, 12 Aug 2020 12:57:33 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id op15sm2221666ejb.42.2020.08.12.12.57.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 12:57:33 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id r4so3156970wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:57:33 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr500353lfp.10.1597261845653;
 Wed, 12 Aug 2020 12:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
In-Reply-To: <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Aug 2020 12:50:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Message-ID: <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:34 PM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> The point of this is to give us the ability to monitor mounts from
> userspace.

We haven't had that before, I don't see why it's suddenly such a big deal.

The notification side I understand. Polling /proc files is not the answer.

But the whole "let's design this crazy subsystem for it" seems way
overkill. I don't see anybody caring that deeply.

It really smells like "do it because we can, not because we must".

Who the hell cares about monitoring mounts at a kHz frequencies? If
this is for MIS use, you want a nice GUI and not wasting CPU time
polling.

I'm starting to ignore the pull requests from David Howells, because
by now they have had the same pattern for a couple of years now:
esoteric new interfaces that seem overdesigned for corner-cases that
I'm not seeing people clamoring for.

I need (a) proof this is actualyl something real users care about and
(b) way more open discussion and implementation from multiple parties.

Because right now it looks like a small in-cabal of a couple of people
who have wild ideas but I'm not seeing the wider use of it.

Convince me otherwise. AGAIN. This is the exact same issue I had with
the notification queues that I really wanted actual use-cases for, and
feedback from actual outside users.

I really think this is engineering for its own sake, rather than
responding to actual user concerns.

               Linus
