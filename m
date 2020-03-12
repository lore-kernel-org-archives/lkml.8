Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48685C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267912071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036600;
	bh=gqepVeIwCF0UnQcCLUhwVj6VtQvoDpMlDk1gq0Zm52Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XJ86qOjArTy7ldJu5srNaGqeHDevwLT3UInZTEBOMbc3DXjX/tqkwxHoJhlfJTzRi
	 xAjPbyjdl2vjEzONlmqBm19weIBjJOFqbW7pHcqRBoSG8lHl5rCm0W7AicQmEnxAR+
	 3KNQv1r2oKrHXTnaJAVyGft061OGQR+uqx3odVXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCLSJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:09:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38261 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCLSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:09:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so7568865ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=MXoIPfUgy938dwO+4Ke7cFDpDrSyBbOMidOjN6VWqwOeAMyfFqF2Y4Ay/rwdS0BizU
         Kppg6HhZcnXQd15+19gbWj60YmAsYBKe5dgNHxhDdmce+HxBvnO/FxXNECxZgBF0nuD7
         +Ow57KwOsRb33vqxZnMj9GjOtkrhmMbMIdqZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=db4ZIlsBdHUUf5lnTw2Ds29c9aCQiVmuU5p3MPcwk5Nl8lesFTwslebfZzmC93IqAm
         UsTdLmqstxHdosDgHDMvtWL7i5zCaUlxEOF8DwMye2p5RdkmMq1/q0Ap1mOIye5rPwu8
         08uoUMhlXhl4+vlUmS6UY0Q493XuTW2ekCrjEyZD9b+kGMnUIcP7XMPJN56ocS0Qsk7E
         y6PSymOjkQWK/XCAh1Rgma9wJRxSiDnBcMYPTRyUqJxQw/B1nslZgBlEFiaI2xRhuI7R
         R5FxDVQUENU3ak4RnZJs6bqsRN6iPSkvom6ETUxsEkFgaTwVEVMqS+GUIZy0PoWJryfD
         UQ/w==
X-Gm-Message-State: ANhLgQ2G4lr2mz24IzwvY8LVThpxtSFJvS6P5OWBIPKdnapy831y+l6c
        erfDE+SiwBvJdL0r1eze0Nm99bDQ5rw=
X-Google-Smtp-Source: ADFU+vtYw9/jiczV963ZRut0G0JBErS2vQ+3kei5z2EzxsSlq7u4os3x1TtkuI5/43AvvqZI2YN8+g==
X-Received: by 2002:a05:651c:326:: with SMTP id b6mr6109405ljp.289.1584036594899;
        Thu, 12 Mar 2020 11:09:54 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id f10sm14304353ljn.44.2020.03.12.11.09.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:09:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id u12so7577402ljo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:09:51 -0700 (PDT)
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr5976976ljn.201.1584036591344;
 Thu, 12 Mar 2020 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org> <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <1147628.1584032201@warthog.procyon.org.uk>
In-Reply-To: <1147628.1584032201@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 11:09:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
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

On Thu, Mar 12, 2020 at 9:56 AM David Howells <dhowells@redhat.com> wrote:
>
> Any thoughts on which set of flags should override the other?

Do we need to care? I don't think we actually have conflicts, because
the semantics aren't the same, and they are about independent issues.

>                  If we're making
> RESOLVE_* flags the new definitive interface, then I feel they should probably
> override the AT_* flags where there's a conflict, ie. RESOLVE_NO_SYMLINKS
> should override AT_SYMLINK_FOLLOW for example.

That's just for a linkat2() system call? I think the natural semantic
is the one that falls out directly: RESOLVE_NO_SYMLINKS will cause it
to fail with -ELOOP if it is a symlink.

NOTE! This isn't really a "conflict". It's actually two different and
independent things:

 - without AT_SYMLINK_FOLLOW, a linkat() simply won't even try to
follow the symlink, and will link to the symlink itself instead.

 - RESOLVE_NO_SYMLINKS says "never follow symlinks".

Note how one does *NOT* override the other, quite the reverse. They
are about different things. One is about the _behavior_ when the last
component is a symlink, and the other is about permission to follow
any symlinks.

So all combinations make sense:

 - no AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not

   This is obviously our historical link() behavior.

 - no AT_SYMLINK_FOLLOW, yes RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not, but if there's a symlink in the
middle, return -ELOOP

   Note how this case doesn't follow the last one, so
RESOLVE_NO_SYMLINKS isn't an issue for the last component, but _is_ an
issue for the components in the middle.

 - AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the target,
following the symlink if it exists

   This is obviously the historical AT_SYMLINK_FOLLOW behavior

 - AT_SYMLINK_FOLLOW | RESOLVE_NO_SYMLINKS: just link to the target,
return -ELOOP if it's a symlink (of if there's a symlink on the way).

   This is the natural behavior for "refuse to follow any symlinks anywhere".

note how they are all completely sane versions, and in no case does
one flag really override the other.

If anything, we actually miss a third flag: the "don't allow linking
to a final symlink at all" (but allow intermediate symlinks). We've
never had that behavior, although I think POSIX makes that case
undefined (ie you're not guaranteed to be able to link to a symlink in
the first place in POSIX).

I guess that third case could be emulated with open(O_PATH) + fstat to
check it's not a symlink + linkat(fd,AT_EMPTY_PATH) if it turns
somebody would want something like that (and we decided that
AT_EMPTY_PATH is ok for linkat()).

I doubt anybody cares.

                 Linus
