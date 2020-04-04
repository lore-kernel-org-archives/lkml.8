Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C75C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D02206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 21:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586034808;
	bh=3g0H/QTlacQZtGXY2JZE6CQauQOGtqwLYZyjVORgHGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qG+n1GKamu9PAHGaWk7xeTi88x8StnUp4hWr6EbnFSrf8CN0bsJO45AT4BKxdNEKY
	 1UIwBcwoW5VUn7EyGa+d0Zjp0rJcNswZilqyqpMOCuUzaBMEjCUFBYyXxwPT3sY/89
	 kjvoQTVO+z6kGtTFIElqs/3J56b8ZZTCLzqHkUd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDDVN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 17:13:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45684 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDDVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 17:13:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so7310355lfe.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 14:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whlD+FJJxUSsYgQJmOoyKhMr6jBMYuvqobVL83EC0Y8=;
        b=WRre38NwVB2LmEnC98i41YGU/UMX2qymyekgtMqnchU1KqX89ceYbyw3xRKr1XhGy4
         6HgJuVbiSVOqVXwon/QrA0T4sEgUgGPNmPqffIx0/mv+mHKaU0PjbaaEewmpvuro9DfU
         JDnC7tAkfLyumK5mtIm39aTZYSgWEHmXopyGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whlD+FJJxUSsYgQJmOoyKhMr6jBMYuvqobVL83EC0Y8=;
        b=bXVXw/5lqs8ZS6w9ukwpDCK7eQdnKPji7TCq2YLeLkbXMGxJ9YdAjgQP/VMaA3XpJG
         YXcysw972SIw1TA3qxSAll0gx/kRIo1VdLM3lLKMMPiZLWV4SzQl6aquadQElsK9wpCk
         /gF8YFaUG5ghZct5Dl8PSfOcKk1Ni0NbsR0EWKw7CQpIQENIOP9PNwYee0ofzpGZSJkz
         8Pl8Z83gyRI6WtbdfgY0ogEwtgTGIkHC0kvm1bSmFfLkkvMogFsqV6Of5L774tq/sWP8
         i8527JN1S8ZjFJgKY6rLLn6n8sREvJ9b1L1OUZpmvdgZb+wGxLIWMJ5MFcQP9BA39DHb
         SyCQ==
X-Gm-Message-State: AGi0PuYOENCf0sCzfGr2aWpWLKHszAbSaqr8YcAqOyZNnRKjnw77ePli
        kDruKaeYrOIveakxoupfr8zMXfqO+DM=
X-Google-Smtp-Source: APiQypLe/RJKVlC+rcRh8JxJ21dS+v+9+y+l/wmJCtmRmKBAi0tZNBeeBUF1Y2h3ubQ9nGh6kxlmMQ==
X-Received: by 2002:a19:c607:: with SMTP id w7mr8561315lff.32.1586034801995;
        Sat, 04 Apr 2020 14:13:21 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q9sm8898159ljm.9.2020.04.04.14.13.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2020 14:13:20 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id p10so10639612ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 14:13:20 -0700 (PDT)
X-Received: by 2002:a2e:9b8e:: with SMTP id z14mr8233548lji.150.1586034799883;
 Sat, 04 Apr 2020 14:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <1445647.1585576702@warthog.procyon.org.uk> <1449543.1585579014@warthog.procyon.org.uk>
In-Reply-To: <1449543.1585579014@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Apr 2020 14:13:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
Message-ID: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
Subject: Re: [GIT PULL] Mount and superblock notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>, jlayton@redhat.com,
        Ian Kent <raven@themaw.net>, andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 7:37 AM David Howells <dhowells@redhat.com> wrote:
>
> If you could consider pulling this - or would you prefer it to go through
> Al?  It adds a couple of VFS-related event sources for the general
> notification mechanism:

<y issue with these remains the same it was last time, so I'll just
quote what I said back then:

 "So I no longer hate the implementation, but I do want to see the
  actual user space users come out of the woodwork and try this out for
  their use cases.

  I'd hate to see a new event queue interface that people then can't
  really use due to it not fulfilling their needs, or can't use for some
  other reason."

I want to see somebody step up enough to say "yes, I actually use
this, and have the patches for the user space side, and it helps my
load by 3000%, and here are the numbers, and the event overflow case
isn't an issue because Y"

Or whatever. It doesn't have to be performance, but the separate
discussion I've seen has been about that being the reason for it.

I just don't want it to be a _hypothetical_ reason. I want it to be a
tested reason where people said "yeah, this is easy to use and
actually fixes the problems".

Because if what happens is that when the events overflow, and maybe
people fall back on the old model (or whatever) then that probably
just means that you do better up until a point where you start doing
_worse_ than we used to.

Or people find out that they needed more information anyway, and the
event model doesn't work when you restart your special server because
you've lost the original state. Or any other number of "cool feature,
but I can't really use it".

IOW, I really want to know that yes, the design is what people will
then use and it actually fixes real-world issues.

And it needs to be interesting and pressing enough that those people
actually at least do a working prototype on top of a patch-set that
hasn't made it into the kernel yet.

Now, I realize that other projects won't _upstream_ their support
before the kernel has the infrastructure, so I'm not looking for
_that_ kind of "yeah, look, project XYZ already does this and Red Hat
ships it". No, I'm looking for those outside developers who say more
than "this is a pet peeve of mine with the existing interface". I want
to see some actual use - even if it's just in a development
environment - that shows that it's (a) sufficient and (b) actually
fixes problems.

             Linus
