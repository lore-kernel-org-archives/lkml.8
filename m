Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B0BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6160220748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m3IgsGGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCaFLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:11:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43336 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgCaFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:11:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id bd14so23553205edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 22:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=181xT05kF3H0VD4f8J7xShi9xZwvoRHrcpvFBQLeEIA=;
        b=m3IgsGGZrBgakxVw5if3yzczNN+msQw/g4O9F81ImNkKRl6IR0dPN9pgwGDudyXoFD
         wIWE3Xb4wifN6VLA2/4V2jQdkh5DWnfWy9gEgEbaIM2wokowxXNZoF3v4dB085lzm0sT
         cxBvjCc7bpBAb5dgoCxTIjslzsJDa+Q/lTfFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=181xT05kF3H0VD4f8J7xShi9xZwvoRHrcpvFBQLeEIA=;
        b=Ja+x7ucTZ1jnX8jFDVn9a9hCkHJ9k5RLYs8+Yamx3iaTHVzAAurAbFdutVkOnEyUd9
         Zc0NJkDc+hrFoRjvOmRobklseZSe9TmSKAI24cvS0OK65uLbJQF8xwD5on2CJFspX3Rm
         qidaXhBxvwTPgqglrEXq6aq1GxVU58LsRx4xniAoFPUsK2OSpbwxWIFdnd9G3AdUUNpR
         vrIY+qDbCTMz8//FxHS+Utbt2RmYZuFXpvClJsuOItH/hY+iu+QqUqHCXJ1yMm00GlSt
         xGDPiTPXBNWgZt66gvWkgV3yP9cmccfnwe0nHvaPpvyWhLxadB+g6mC3Jx8nN1S7Qikd
         Zdnw==
X-Gm-Message-State: ANhLgQ3IxUTZvh80D56USN24L29gxd+S6ezsCMUIhDjOpsXlx6aGDAyQ
        TvIOqU8gLUW2QaUKPZ4pk7/mQcHauDtYBnR9DoFJ6g==
X-Google-Smtp-Source: ADFU+vujD3XRyzE2A6P8XAJLarFPpIUeWPjGW5jTzW/mvrFUEb88BGcaM3HywgE+474EUtqBVDyCkVg3I0Aj9RVfp1g=
X-Received: by 2002:a17:906:9ca:: with SMTP id r10mr13543753eje.151.1585631482578;
 Mon, 30 Mar 2020 22:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
In-Reply-To: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 31 Mar 2020 07:11:11 +0200
Message-ID: <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:

> Fwiw, putting down my kernel hat and speaking as someone who maintains
> two container runtimes and various other low-level bits and pieces in
> userspace who'd make heavy use of this stuff I would prefer the fd-based
> fsinfo() approach especially in the light of across namespace
> operations, querying all properties of a mount atomically all-at-once,

fsinfo(2) doesn't meet the atomically all-at-once requirement.  Sure,
it's possible to check the various change counters before and after a
batch of calls to check that the result is consistent.  Still, that's
not an atomic all-at-once query, if you'd really require that, than
fsinfo(2) as it currently stands would be inadequate.

> and safe delegation through fds. Another heavy user of this would be
> systemd (Cced Lennart who I've discussed this with) which would prefer
> the fd-based approach as well. I think pulling this into a filesystem
> and making userspace parse around in a filesystem tree to query mount
> information is the wrong approach and will get messy pretty quickly
> especially in the face of mount and user namespace interactions and
> various other pitfalls.

Have you actually looked at my proposed patch?   Do you have concrete
issues or just vague bad feelings?

Thanks,
Miklos
