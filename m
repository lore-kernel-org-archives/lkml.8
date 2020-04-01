Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28501C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F22078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p5QzZMqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgDAPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:34:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38249 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgDAPeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:34:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id e5so418842edq.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PknMOjO0aVK6+Mbr46jA4uNoXU0DCDMitbN9TCuKpYU=;
        b=p5QzZMqB/vMQwg0fm6pTCPUxV1A84gb+EbDz8bFwLIYFbNP9FnvyYhjSFYadmD92gb
         mRFyGUNcatWLbDeKB3pVtLlqOSoBYBt/rdV98tORxMQw0g+6QIHkhXIzbYrVkopEy81C
         VW95LobYq1gT/TNOY+qN/8qCYjeVcjpE8eBU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PknMOjO0aVK6+Mbr46jA4uNoXU0DCDMitbN9TCuKpYU=;
        b=jGA3ntjSoGBPatn5BIvDY98E13whLWZQTpH+k5af2ySqwGAuuBDlz32nH5/gV5i4OQ
         c8dL8qxBQR+isxef7wt9HL5wAhnM8kCGDHB8mPVoPo3hQGjqwGdU7uv8OgNP6tFyO4RU
         OR3xdkb7nVQ42Z4bXqHf8nIamUMq27X4WkKKgrrcqS7xyX/59i5FE4O0iNfohI0lu/qX
         c+eZbenzMwYzFg2pMhXCA96O0RlW19BrfyWOvOM8sWk5AxRcW0qkTzWOf4XVbendiTZx
         g1YK9drN9Soj61fYmoDjnT+8ALv0Ni52YNyPx8fAesCQsx56Z0iwdFgoPU/fYCJzWl4I
         s/qg==
X-Gm-Message-State: ANhLgQ1jmN5GaAor9MgiGAtGUwwjT8aSVS+I7HQvxyY6afS/YG89YkKb
        L3s96z1KEvTMWvqaRJZ89LjoGdEQmcoM0HamqslT5Q==
X-Google-Smtp-Source: ADFU+vs4NvhCMrvCrJhNiFJktWHH/mqCFDfkFAflywuZUDLeQconO4+bbarWMrnDJQm+JW/SHBg/UTtmPThSySe23DY=
X-Received: by 2002:a05:6402:44e:: with SMTP id p14mr21764199edw.356.1585755249047;
 Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
In-Reply-To: <20200401144109.GA29945@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 17:33:57 +0200
Message-ID: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:41 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Di, 31.03.20 22:52, David Howells (dhowells@redhat.com) wrote:
>
> > Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >
> > > querying all properties of a mount atomically all-at-once,
> >
> > I don't actually offer that, per se.
> >
> > Having an atomic all-at-once query for a single mount is actually quite a
> > burden on the system.  There's potentially a lot of state involved, much of
> > which you don't necessarily need.
>
> Hmm, do it like with statx() and specify a mask for the fields userspace
> wants? Then it would be as lightweight as it possibly could be?

Yes, however binary structures mixed with variable length fields are
not going to be pretty.

Again, if we want something even halfway sane for a syscall interface,
go with a string key/value vector.

If that's really needed.  I've still not heard a convincing argument
in favor of a syscall.

Thanks,
Miklos
