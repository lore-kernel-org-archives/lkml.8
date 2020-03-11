Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36629 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgCKP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:58:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so2943931ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:58:16 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h24sm13849546ljc.36.2020.03.11.08.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 08:58:13 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j15so2178624lfk.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <19498990-fb97-b739-cd19-6a6415ba88a2@gmx.com>
In-Reply-To: <19498990-fb97-b739-cd19-6a6415ba88a2@gmx.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Mar 2020 08:57:56 -0700
Message-ID: <CAHk-=widmu42C4eTQ9uDM+njZE1s5ARmx7E+1SHH1XznTFOwyg@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 11, 2020 at 8:53 AM Artem S. Tashkinov <aros@gmx.com> wrote:
>
> I'm not sure I can call or do anything because the system is dead and
> I'm looking at the kernel panic message. The console is dead. The root
> file system is not yet mounted. Initrd can't be loaded either. I have no
> COM port/console. I have no debugging abilities whatsoever. I can only
> compile kernels and try running them.

Christoph just wanted you to use the image you booted with - you can
do it while using a working and entirely unrealted kernel.

But I think Christoph's second email was right on the money: the
platform device code used to (accidentally) always use that special
kmalloc()'ed memory, and the "always use kfree() to release" then
happened to work.

But with the change, platform devices use that allocations inside the
platform device itself, and the kfree() now does bad things and
corrupts the kmalloc lists.

So that finally makes sense of why that commit would cause odd
problems for you. I'm actually surprised it didn't cause problems for
others, but it's an error path, and presumably it normally never
triggers.

                Linus

              Linus

