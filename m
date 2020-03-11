Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29780C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9920691
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583949616;
	bh=LkZT0BmK1tbF9N6Lr5DM7GiObqeCU2DGSZcsJF+15Yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eoB7Q3WjrD3EWz963bseTOshGodFNBpgPNCcWoGXNWb0MlZ8+LXyDdGsZMPHtWG5q
	 zi93ngRYipyHtVSh5J4L42AK7z6y5vjavahl4KwaVGHY4fL0f+QgOnv0lOD390YSYr
	 +NXvIGDG5kmgmmM/hOFGIb9Z4z3VQQPIcqYT9z6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgCKSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:00:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40760 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbgCKSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:00:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so2495103lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=ckkZBdQmXywHGIbczwxKoXJtM5bn1Q4zF8980dmDzUAerY42Vnt79h0/hrgko+maFY
         g6W5qtOcDU0FR7TReGj9YV2UAWuNcF/lAEUT03GfvSsuEW22s7MzLhczmTz71ew7VoeG
         9tipLpaaHNIEBXH+b/EPSFlrBcI9QWo4iyKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=oY856EjMQM/eWrmwtdVgu4ofzrTYkMUNpleYTFLNXwsSbTA/y4jOjy3NCbuWx9YHCo
         XofoC/uTf0jQ3F5lrvODHK11E2JZ70IE9uGUrMboq/g4zsq035a2A7+is8uSAUqfoJS5
         VR4pIXTQuhj7OQ7bYizxuvN1mDF3yETYK0GUqF78uxXcmRWpj0rdiOUlrNb20AjZxcvJ
         YzSbpw3pI51YXbomFKiQraHwo0VHjJcMwzQNlABN5Y8FqSZ+2oGfE/MTneIWpuv3+d+A
         McrJfu+0zdC7dNKRm5A9e9WC9HzfiEW+dvI2qnRRcfFjiya4P42CwhfSucd7vPX5OgMl
         Z6hg==
X-Gm-Message-State: ANhLgQ3GQzKwCVBcPxpC20ljXzE8+JeOkWZFZKyNoq/4zKvuS5STadxK
        qmHbTzxF8vp0uYhP6AcnXA/4KmWMYY4=
X-Google-Smtp-Source: ADFU+vvayonPlBe6Bwr7duUpdzmjlsgphjAebLkzPCxb8MwnSLQWD1OTg6k7LF7ULhWXAtp8PVyUJg==
X-Received: by 2002:a05:6512:1085:: with SMTP id j5mr2885555lfg.183.1583949609792;
        Wed, 11 Mar 2020 11:00:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id r2sm1911459lfn.92.2020.03.11.11.00.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id r24so3388517ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr2622296ljd.209.1583949607115;
 Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
In-Reply-To: <580352.1583825105@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:59:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
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

On Tue, Mar 10, 2020 at 12:25 AM David Howells <dhowells@redhat.com> wrote:
?
> Okay.  So what's the equivalent of AT_SYMLINK_NOFOLLOW in RESOLVE_* flag
> terms?

Nothing.

openat2() takes two sets of flags. We'll never get rid of
AT_SYMLINK_NOFOLLOW / O_NOFOLLOW, and we've added RESOLVE_NO_SYMLINKS
to the new set of flags. It's just a separate namespace.

We will _not_ be adding a RESOLVE_XYZ flag for O_NOFOLLOW or
AT_SYMLINK_NOFOLLOW. At least not visible to user space - because as
people already figured out, that just causes problems with consistency
issues.

And yes, the fact that we then have three different user-visible
namespaces (O_xyz flags for open(), AT_xyz flags for linkat(), and now
RESOLVE_xyz flags for openat2()) is sad and messy. But it's an
inherent messiness from just how the world works. We can't get rid of
it.

If we need linkat2() and friends, so be it. Do we?

Could we have a _fourth_ set of flags that are simply for internal use
that is a superset of them all? Sure. But no, it's almost certainly
not worth it. Four is not better than three.

Now, some type-safety in the kernel to make sure that we can't mix
AT_xyz with O_xyz or RESOLVE_xyz - that might be worth it. Although
judging by past experience, not enough people run sparse for it to
really be worth it.

               Linus

PS. Yeah, we also have that LOOKUP_xyz namespace, and the access mode
namespace, so we already have those internal format versions too.
