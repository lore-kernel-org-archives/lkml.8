Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCKQYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:24:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so3062619ljo.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:24:41 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id g16sm3548838lfd.7.2020.03.11.09.24.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:24:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r24so3046030ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
In-Reply-To: <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Mar 2020 09:24:22 -0700
Message-ID: <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
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

On Wed, Mar 11, 2020 at 9:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's commit e423fb6929d4 ("driver code: clarify and fix platform
> device DMA mask allocation") in my tree. I've not pushed it out yet (I
> have a few pending pull requests), but it should be out shortly.

Actually, looking at other emails in my mailbox I see that Christoph
send a patch with a sign-off, and there's a reviewed-by too, so since
I haven't pushed mine out yet, I'll edit that up and give credit to
Christoph properly, and add the reviewed-by.

So it will have a different commit ID, updated message, and be a mix
of my patch and Christoph's.

             Linus

