Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E9F22D06
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H+qsmC3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgHER1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgHER0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:26:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97508C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:26:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so47241840eje.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfhfFAEDblzsRQWrMzcI0diRWe/CNXK92mcngQaYd7Q=;
        b=H+qsmC3Z3MgedQ/Jm+u3qVYeVXWyqQH33iCIHKK2tbGxBQbr38frgchQxuf3EzgvmP
         MNh03Ji3AV40eKkq2AvkoWr7v+NFfyOdrJJ5S474gQ999/lCCin015tia0j+ezaTWqZV
         /DOijvZvYoY+sBt3AM+Ygy+/Povj5zubYWXtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfhfFAEDblzsRQWrMzcI0diRWe/CNXK92mcngQaYd7Q=;
        b=eHOiryEx28VwhKRWw8GnVkb5G5acKl2w2CydCwy4RAaJ6yB/pvlp6rE8k3bmS0xC2/
         kMek9QOzfm4HqBY59jxmUt2k3cgA1wBv0vs/h2D0Et5E4bUq4RPzRNCfe6ABzSyqqcwt
         0/gU7pe+a2WngWcQDGvmsODGzMJxifz7psQAG9PWHCJ2+0jp1xlaoDZ059MICdHTLchL
         5uXRVJxRZUb/C5QU2/PYbK6Vo+MmAKw+0VsEZSmWT5reUKJ5xF6LbkuYiXEba9erU25Q
         guJAOdbKGbTZgNpO9KMAl8LeGrmN28W3vzm/55EKL6czc0kCj7cwrTly6SAeVvXe6PRm
         jXXw==
X-Gm-Message-State: AOAM5313p1vPOQfywfr1vWDOj1y2roEBFpodiC3mhrIar5IOfOOm4tnd
        zZ1kbFyhKYICAjtj6mkv+XHWCcNFFlZMFxwF06rKVA==
X-Google-Smtp-Source: ABdhPJzdEHOuUAQwwJud++YQFGRBiDh0v606aODVa0hZTrCfoTE6lVJhbEjcB37S7JrGgIPTV8fOte9EbRFoUEgvB4o=
X-Received: by 2002:a17:906:4c46:: with SMTP id d6mr379886ejw.14.1596648377290;
 Wed, 05 Aug 2020 10:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
 <20200804135641.GE32719@miu.piliscsaba.redhat.com> <2320582.1596643618@warthog.procyon.org.uk>
In-Reply-To: <2320582.1596643618@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Aug 2020 19:26:06 +0200
Message-ID: <CAJfpegvpjjk3JNgTfY1yOGToPLF1mXG5+UkUZqVOGDkvzEr5HQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Shoun't we just make sure that the likelyhood of overruns is low
>
> That's not necessarily easy.  To avoid overruns you need a bigger buffer.  The
> buffer is preallocated from unswappable kernel space.  Yes, you can increase
> the size of the buffer, but it eats out of your pipe bufferage limit.
>
> Further, it's a *general* notifications queue, not just for a specific
> purpose, but that means it might get connected to multiple sources, and doing
> something like tearing down a container might generate enough notifications to
> overrun the queue.
>
> > and if it happens, just reinitialize everthing from scratch (shouldn't be
> > *that* expensive).
>
> If you then spend time reinitialising everything, you're increasing the
> likelihood of racing with further events.  Further, there multiple expenses:
> firstly, you have to tear down and discard all the data that you've spent time
> setting up; secondly, it takes time doing all this; thirdly, it takes cpu
> cycles away from applications.
>
> The reason I put the event counters in there and made it so that fsinfo()
> could read all the mounts in a subtree and their event counters in one go is
> to make it faster for the user to find out what changed in the event that a
> notification is lost.

That's just overdesigning it, IMO.

If the protocol is extensible (as you state) then the counters can be
added as needed.  And unless the above CPU cycle wastage is actually
observed in practice, the whole thing is unnecessary.

Thanks,
Miklos
