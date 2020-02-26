Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD65C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5C12084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYX8khLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgBZJLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:11:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27898 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgBZJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582708275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=LYX8khLquEaMYAmpi8dZX3a+4Tcgs9mZJYjMH41sxOF7boBZdvJzapJhBKV1BVnE/L8F8/
        ZS7/GiU4Ss5VGv1pjHMadZKd2jnrK+Fq1Qchy0tT/2t0s5RfI3MFC8/J3fBwDJT1feTUyj
        ZrDunVqgNfN4YYsXgwirggJqlOGEjGQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-oezANsZ2PLuPBrnyGO-RXA-1; Wed, 26 Feb 2020 04:11:13 -0500
X-MC-Unique: oezANsZ2PLuPBrnyGO-RXA-1
Received: by mail-qv1-f71.google.com with SMTP id p3so3078623qvt.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEqkrC4VLq8DaEUXXUlw4qM+t78tq2tEXmDFeRSdK/U=;
        b=DeKnO6ePX8iyj5TVkvlbRWbsRV6zIL2K7VI7IHwJ2CMVyWvgeMUciApzxLEzdxH7FV
         d41XmDbPyIB7bTjMXxAvQTxQLY4rI/o2Q/rbKiksviKBVJU1K/zik0TM1EknbEIv7q3j
         U3S+MbfcI094s74m1uCLxNmv2Rg+AiLVjCIWrZmqd7GmwRhLWmwZ98SKv9UfH6phMkwV
         8ZKUCFwcGnM7gawg7YHzqs9Fdtr5ACwd6etreno+g1XuVPb+OLMJ8asQI2JKQQrbiX3C
         jc7iv2p+Ojpy+LP0B4dvpF1ZDk+MlXIXDvnUNOlHWNXlyQp8UHyWR7npOYPmRmxoHsFO
         XFKg==
X-Gm-Message-State: APjAAAWgTgDO5HnuvKfx9lj6b/SXAjML8fi/ARPVVjqXY30ZnAP5ZV/D
        JX3e6YRWaHvwa/Zk/3KWS7TrQ9vXrG9YN078KeFaSbgmgcwr6Z2tuqYx9h8zSnfSSa6PxZv950t
        V8hyRw2u6kWCXccv5NdiodDdjB8PJYBRoPdEW9uzO
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423908qka.211.1582708273449;
        Wed, 26 Feb 2020 01:11:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXjPA2Pp28AoAuqRyzeCA+TX5xe5BSYiQaT9UAKY0Cw8GAaR+YwHF7q/xXePrlEyxxI8KoSd+4S3BP8Ddn7Zw=
X-Received: by 2002:a37:40d2:: with SMTP id n201mr4423885qka.211.1582708273224;
 Wed, 26 Feb 2020 01:11:13 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
In-Reply-To: <1582644535.3361.8.camel@HansenPartnership.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 26 Feb 2020 10:11:02 +0100
Message-ID: <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 4:29 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> The other thing a file descriptor does that sysfs doesn't is that it
> solves the information leak: if I'm in a mount namespace that has no
> access to certain mounts, I can't fspick them and thus I can't see the
> information.  By default, with sysfs I can.

That's true, but procfs/sysfs has to deal with various namespacing
issues anyway.  If this is just about hiding a number of entries, then
I don't think that's going to be a big deal.

The syscall API is efficient: single syscall per query instead of
several, no parsing necessary.

However, it is difficult to extend, because the ABI must be updated,
possibly libc and util-linux also, so that scripts can also consume
the new parameter.  With the sysfs approach only the kernel needs to
be updated, and possibly only the filesystem code, not even the VFS.

So I think the question comes down to:  do we need a highly efficient
way to query the superblock parameters all at once, or not?

Thanks,
Miklos

