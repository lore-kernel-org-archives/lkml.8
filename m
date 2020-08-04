Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70F621744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFjcXr9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHDUtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgHDUtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:49:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29334C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 13:49:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so28418916ioa.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 13:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdbBe3yRhb8UVEdZu437BXB7eaBvTiKuwEkcBB5Ach8=;
        b=lFjcXr9F4a+6cunETjp4ZXM/I9v82oAd3si1GWvBuQeX12mzbQTmu0WziwTImnxUZX
         D5FYlTosNhLxTjnxBTuvFt9IreQCsWSGZW/ZuU0o7Am1OZzI6OC+SuLZF7YUaZ60OnzX
         JIcxq5mu09QLmMwHGcBZrtkA7xMR7O8FTwnhdyNHCFWK2nuqZwothaNVoJwk1Gqknzuz
         iH8QY2MHTTsGmp+za5ED2Cp//msh+V/NPXqq9bs8NkcimZxEj7NgYNUXqZoUtTJHVmCt
         5SLr2qVrm7X3f4UWMMJF99H4Mdbk9SkX+eHzDma1G0+g8hygOADVDxbGdLvBD1hprHoo
         qskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdbBe3yRhb8UVEdZu437BXB7eaBvTiKuwEkcBB5Ach8=;
        b=C7kFVjsPKa/hTqzusCoCzaTYb3/0/94SgGc1m4y5tvg8Mfx3j8pX6MCjKdJuAohLpk
         ZnZ0IeEauh5ICnWsE8IvLWJ8yIERWaT2A8N4Dn99DVPWBSB3R5JDsr153catvGMZIhZj
         3lUOQinnVmdTzbDn2+FHHH017L5jxE1T0wjcpHfbDiVavJO1c73fbRIyOJhXrsPwnW93
         vbmrJYVHehpOBTC/4g62zeHJIX29EFap6xDNpPYvo8/s6fhChPI1fT+98YkYZ2AISDLr
         ZvaY5uf55qj4IltqV/4pNmn9nXvJBNvK9IvmmUNwMiu8b7+h/iF+4gndjZDCga6bEz6A
         uHSw==
X-Gm-Message-State: AOAM531vClDv2DOO9Ge1g6pYMlveYz4Ql9nYjtPOKMznKSFj8EkXjDmI
        kiz3UX+BxBxTZFzSpqoEpAEFU2j1GTluXaWx/j2Gqw==
X-Google-Smtp-Source: ABdhPJwXTcDhzEgVIXrgRbyS+9+17BR8iod+JrmrTu87b8AChpYWoX5iyFIWwgc6RiAq4vxYYbCqbVHuqt4FuPKbV1M=
X-Received: by 2002:a02:3843:: with SMTP id v3mr32714jae.23.1596574181355;
 Tue, 04 Aug 2020 13:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200804203155.2181099-1-lokeshgidra@google.com> <20200804204543.GA1992048@gmail.com>
In-Reply-To: <20200804204543.GA1992048@gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 4 Aug 2020 13:49:30 -0700
Message-ID: <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Calin Juravle <calin@google.com>, kernel-team@android.com,
        yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> > when get_unused_fd_flags returns error, ctx will be freed by
> > userfaultfd's release function, which is indirectly called by fput().
> > Also, if anon_inode_getfile_secure() returns an error, then
> > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> >
> > Also, the O_CLOEXEC was inadvertently added to the call to
> > get_unused_fd_flags() [1].
> >
> > Adding Al Viro's suggested-by, based on [2].
> >
> > [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> > [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> >
> > Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
>
> What branch does this patch apply to?  Neither mainline nor linux-next works.
>
On James Morris' tree (secure_uffd_v5.9 branch).

> - Eric
