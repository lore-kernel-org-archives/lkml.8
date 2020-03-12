Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756ACC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF9520663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584030312;
	bh=ddWJc/y1QKwNk/gZuKYYvjPwEwiqhkKFnnziYv4zvfk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NamAnG/mK9vCEFfJUexJbts+aGj40XaawdPJwNF8fX/EECuJqpCxZYss0jRmHECkv
	 O3r7NdC2IU2959jyZOBI/3Q20MYewu0wlYYCMLwwMQPYuk9emlYPfKjElkIMzM7udv
	 gW3tXQoP+ZCNgN9bysWxIcRvOhB/XqpvXEufbcnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgCLQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:25:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40803 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbgCLQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:25:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so5328841lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=SLSsz7RVVX6b52ACz/JyPLLkZkcdatfCUWkrNphSGRxiTdH3i/0ZPWuxLZejrvrNCB
         aFQ0QGNvMrCZqvQ81uTwGrZDythrUJ4hlHcbAsrlg/62jd40y8byXiREO1aPKzcKDQnY
         TxyLyZdVZ/bL1I3pgBX8P/qMMqbm0kUimV1sA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWmhDJUXIQr81tj3eSt5MgpUhrk7gN9oxNOVOserS9E=;
        b=QKT39uu8D1Hhr86lxXzS+RFzzMxdL1E/DT78/2cjxoCqjppvERpBES76XABXgL3NhT
         VkYiIITcZ9+aWnr7Y1GFfPjvsxudQJ/PgxrL7iiEB8freuZ/Fyla99CGD1VM4AwuwBqP
         +pUUxtXGquItLVJnGR1iF81QXGR+HLUNm/ls/IxTbqP/ofju6auC6HxetrXk7ZdrRlMF
         D+NDl3/dqy2UmHsk4wrS5IkNW8iT4A1O+zfGgvB1YOcda4KBUEr20GYH43Yl95Q3PZBO
         rLzwf5AnfENl3YflBU5tg0eh9DL0NxrBhLM94MGNnUcOKizFaETilbz/oFXJKwtcRo7T
         xi0g==
X-Gm-Message-State: ANhLgQ3wNvgxIOM8yUakiK/hx7gPHYb6WPgfdqL7lHdLCWS0hyrEB+BK
        IdT8yQ6y0kpzxB2BK13PbkD8xhQm4Uk=
X-Google-Smtp-Source: ADFU+vsSotM7Otv2JJQ+UiD9WlSFASXrnadG/Yeb05w8tL/fthy9XH2fSkuUy+lS4qRKw3zjyP1FLQ==
X-Received: by 2002:a19:3803:: with SMTP id f3mr5892302lfa.160.1584030308308;
        Thu, 12 Mar 2020 09:25:08 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h25sm6437609ljg.31.2020.03.12.09.25.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 09:25:06 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id j17so5328686lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:25:05 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5637868lfk.192.1584030305566;
 Thu, 12 Mar 2020 09:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
In-Reply-To: <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 09:24:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Message-ID: <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:08 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> The whole discussion was triggered by the introduction of a completely
> new fsinfo() call:
>
> Would you propose to have 'at_flags' and 'resolve_flags' passed in here?

Yes, I think that would be the way to go.

> > If we need linkat2() and friends, so be it. Do we?
>
> Yes, I'm going to propose something like this, as it would make the life
> much easier for Samba to have the new features available on all path
> based syscalls.

Will samba actually use them? I think we've had extensions before that
weren't worth the non-portability pain?

But yes, if we have a major package like samba use it, then by all
means let's add linkat2(). How many things are we talking about? We
have a number of system calls that do *not* take flags, but do do
pathname walking. I'm thinking things like "mkdirat()"?)

> In addition I'll propose to have a way to specify the source of
> removeat and unlinkat also by fd in addition to the the source parent fd
> and relative path, the reason are also to detect races of path
> recycling.

Would that be basically just an AT_EMPTY_PATH kind of thing? IOW,
you'd be able to remove a file by doing

   fd = open(path.., O_PATH);
   unlinkat(fd, "", AT_EMPTY_PATH);

Hmm. We have _not_ allowed filesystem changes without that last
component lookup. Of course, with our dentry model, we *can* do it,
but this smells fairly fundamental to me.

It might avoid some of the extra system calls (ie you could use
openat2() to do the path walking part, and then
unlinkat(AT_EMPTY_PATH) to remove it, and have a "fstat()" etc in
between the verify that it's the right type of file or whatever - and
you'd not need an unlinkat2() with resolve flags).

I think Al needs to ok this kind of change. Maybe you've already
discussed it with him and I just missed it.

            Linus
