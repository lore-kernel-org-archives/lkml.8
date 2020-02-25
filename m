Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A174DC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7067121744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7mnFD0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgBYKkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:40:17 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33893 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgBYKkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:40:17 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so9418337lfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 02:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lB/ixEiBalyhvhRiB5xSxt+Xn0mrFFaoIJOp9ZDTEVw=;
        b=U7mnFD0eB+14p5WXU8eODfJJrt//+UySWxh8iW6iKBny2kTkaFgkEdVhHYUkXpRAUA
         7g7Mmd2YzBV+3I5oYA7FDrKM3VpchtBzkta7WmR6zZxPW/G0ydgkd1NqescWG7rFbIgk
         bPIrzs50xbCoNfa9nFT/+p4zpbKLgAk7XAcbSuwi3cW0spcv/TYjbaLsMnI1UM4x8CXJ
         Y4Anr+HhIjaJ+WLwg5MbE8JW5ERuVOBwkJXcLZfFBkOXIoKXlPtFC55LSPqUrAnqyWX6
         B/c+gYEDdP2sUseoxBmcjNri2hGBRzywJd6uONo9ZRJi0f6BZ3gLMXMbzw5mi7LXdwC6
         R/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lB/ixEiBalyhvhRiB5xSxt+Xn0mrFFaoIJOp9ZDTEVw=;
        b=qadEF1iM3OkIkFMPnrDaT8oZvIeqXiz2ZPC7pWFQPzUKWdyDM2rkosLq2+MWesTLXF
         ZnHd6JL0CoQ/S9DDDVx0vBykl4dSC4ii8rXbyycs4K8ZfIDe95xix4C2LyK9iEp3j9JC
         bNddNvitxxorzBuPYQZ3gxbVpaiWwaYXIgRKz7NxaVbTMpBldhVWCACi8/2vaKXcyOJA
         5MXwL/SJBJFKnqzuzhutCuvlfSCRfgVxkYW0vBqGJsNIeEzAAkSzR564mEwQfBxOxHo0
         ihrEwybaQ2mRXD2Wg1NrEPVZKQ+KakGxN0DjxFZEDxuNA2c1FZA7VW4IlsCJrP+ZmZxr
         2JRg==
X-Gm-Message-State: APjAAAX1tfXHW17xsrFCylb9fR+wH/rAgq3dCw9OXyh7M3vsSk99dobq
        T6P6258TKgbJvveVoBGZhRYdAvqqYFJdrX50Oxg=
X-Google-Smtp-Source: APXvYqyk/IFNidAB1quALylWpIE3a/t1bvpbndPuBZnjoxy39NP9ssSpKbGX5hPEkyRTtFbOI5O8eKLBMfSiip8LJqE=
X-Received: by 2002:ac2:52a2:: with SMTP id r2mr29634067lfm.33.1582627213967;
 Tue, 25 Feb 2020 02:40:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
 <20200225073446.GA618392@ziqianlu-desktop.localdomain>
In-Reply-To: <20200225073446.GA618392@ziqianlu-desktop.localdomain>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 25 Feb 2020 18:40:02 +0800
Message-ID: <CAERHkrtraNqWj+RZnUFBaR8Cxk_cprQnzyKEgZ=6K+1mb1Jifw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 3:34 PM Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 01:32:35PM +0800, Aubrey Li wrote:
> > Aaron - did you test this before? In other words, if you reset repo to your
> > last commit:
>
> I did this test only recently when I started to think if I can use
> coresched to boost main workload's performance in a colocated
> environment.
>
> >
> > - 5bd3c80 sched/fair : Wake up forced idle siblings if needed
> >
> > Does the problem remain? Just want to check if this is a regression
> >  introduced by the subsequent patchset.
>
> The problem isn't there with commit 5bd3c80 as the head, so yes, it
> looks like indeed a regression introduced by subsequent patchset.
>
> P.S. I will need to take a closer look if each cgA's task is running
> on a different core later but the cpu usage of cgA is back to 800% with
> commit 5bd3c80.

Hmm..., I went through the subsequent patches, and I think this one

- 4041eeb8f3 sched/fair: don't migrate task if cookie not match

is probably the major cause, can you please revert this one to see
if the problem is gone?

From what I can tell, if 16 threads in cgB occupied 8 cores, this
patch prevents any thread in cgA from migrating when load balance
is triggered, and yes, cpu.shares is ignored at this point.

Thanks,
-Aubrey
