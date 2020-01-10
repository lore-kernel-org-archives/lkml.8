Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C1C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6DF20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 05:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578632605;
	bh=I/5NguRiVD798gEM9xuQgx1/Q9SGP14gIYHh30D1IHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W4udIfY+qQbb2cOnBxF4DPx1gPk3HfjgYAZ4Lp8qzPPWQ27eXpcmGyIoXWBrUIZ8+
	 xQ3m4y7INYc52uPErf0wBZGv7JUbrSDT3k9Jbhwztl3gmDlnh92wH+CFVGQcqxbvee
	 ZwmVzum+prSkwED8Cs8OV3zQwd9zHRQBZaGLz3S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgAJFDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 00:03:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43435 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgAJFDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:03:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so728670ljm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 21:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/GI7mSLrO7+AWyztv1F/7+LjmBRdi9pxniW8srHraM=;
        b=WJnSkgb5IoN+QFM9zDo/+1LUciNYCKC1uNr4+jda+SHQ4Al4kAzM40Ki7rykrkdSQb
         LRo6BkP+xKhXKun/nrSizTl2SLNY7SO9HFhXKlKAOnq3AXpHt/oUN004/3so/HMeBcSV
         czfR5SnYRegkSqQWTz+TDMXgEHM9RAu7JIN+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/GI7mSLrO7+AWyztv1F/7+LjmBRdi9pxniW8srHraM=;
        b=hI8FnIRKmJm3rqK768Dj6A3XkPE+m9TBvQWKfePuqDYiWJ+p1h7/IFjYgWHvAbzEOI
         V7OR0x7Z8vsgHeQVlnCnxKTbKs2gz2o++o6eowQqUtkXLxkFwsz75nx/LShMliDSSjn5
         OwtX+w0DIP8kTNXCHv8FenplmHWIinZRt2E/dPZfcvVr+dN1vNyb/f3YUZbdoWV4K8Mv
         VOfKZocW4uDgeR1w6vbnaOhzuFujAtwHxoLfB+TzwTutpFwJ705oDfdJcEj+cb7+5o+y
         4n9CTIsECD/s0v4uJcqQP71QWTkuEInRYhGXSF4JmU+OC2ubV2frANJpuwxdGkumDVVf
         8lyw==
X-Gm-Message-State: APjAAAVrCso2VgnbS5juacXQvbaYuJUd/zMJy/UkjLIY7N0DQmUu8kVB
        2wzU4Xr24jViUn2obfRLaHNJ3uPQlgU=
X-Google-Smtp-Source: APXvYqy9AVf42Q72kx94fgp9uiavpErfWaak8pi/Ex57jp9sWEdN+XY+G6Kfj+uGqZWQCTF9C4/sTg==
X-Received: by 2002:a2e:8152:: with SMTP id t18mr1165242ljg.255.1578632600358;
        Thu, 09 Jan 2020 21:03:20 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k1sm340021lji.43.2020.01.09.21.03.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 21:03:18 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id v201so457974lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 21:03:17 -0800 (PST)
X-Received: by 2002:a05:6512:1dd:: with SMTP id f29mr961529lfp.106.1578632597317;
 Thu, 09 Jan 2020 21:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20200101005446.GH4203@ZenIV.linux.org.uk> <20200101030815.GA17593@ZenIV.linux.org.uk>
 <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com> <20200101234009.GB8904@ZenIV.linux.org.uk>
 <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com> <20200103014901.GC8904@ZenIV.linux.org.uk>
 <20200108031314.GE8904@ZenIV.linux.org.uk> <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com>
 <20200108213444.GF8904@ZenIV.linux.org.uk> <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
 <20200110041523.GK8904@ZenIV.linux.org.uk>
In-Reply-To: <20200110041523.GK8904@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 21:03:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiF6en6WD7JdYAUxHnzeTgs3P08ysDQPv4504hQ2qUcmA@mail.gmail.com>
Message-ID: <CAHk-=wiF6en6WD7JdYAUxHnzeTgs3P08ysDQPv4504hQ2qUcmA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 8:15 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Hmm. If that's the case, maybe they should be marked implicitly as
> > O_PATH when opened?
>
> I thought you wanted O_PATH as starting point to have mounts traversed?
> Confused...

No, I'm confused.  I meant "non-O_PATH", just got the rules reversed in my mind.

So cwd/root would always act as it non-O_PATH, and only using an
actual fd would look at the O_PATH flag, and if it was set would walk
the mountpoints.

> <grabs Bach> Right, he simply transcribes v7 iget().
>
> So I suspect that you are right - your variant of iget was pretty much
> one-to-one implementation of Bach's description of v7 iget.

Ok, that makes sense. My copy of Bach literally had the system call
list "marked off" when I implemented them back when.

I may still have that paperbook copy somewhere. I don't _think_ I'd
have thrown it out, it has sentimental value.

> > I think that in a perfect world, the O_PATH'ness of '42' would be the
> > deciding factor. Wouldn't those be the best and most consistent
> > semantics?
> >
> > And then 'cwd'/'root' always have the O_PATH behavior.
>
> See above - unless I'm misparsing you, you wanted mount traversals in the
> starting point if it's ...at() with O_PATH fd.

.. and see above, it was just my confusion about the sense of O_PATH.

> For cwd and root the situation is opposite - we do NOT traverse mounts
> for those.  And that's really too late to change.

Oh, absolutely.

[ snip some more about your automount digging. Looks about right, but
I'm not going to make a peep after getting O_PATH reversed ;) ]

            Linus
