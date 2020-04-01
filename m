Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2318C2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4EF20578
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0v+vFxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgDACdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:33:16 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33894 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgDACdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:33:16 -0400
Received: by mail-il1-f195.google.com with SMTP id t11so21592640ils.1;
        Tue, 31 Mar 2020 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ObKcUz2lh+VxE4tN2LiRS0G1bDw6LmON+P3aqYeVSqA=;
        b=u0v+vFxt6xrzwsayAW7iyTUISSsaWOA7pTg4LodC/ctSM+2qVvbri8xnR4v2GPpEY9
         jULrMXk5jkLdoCI/WCm5k6in3HTth8ehYd89LyFRU9R/YMnbfvPVorqaLi9/TX3EBK/m
         e77NDITGYhT8cdqmE7omxBuQrUpRll+N5OnyXJZKEm6LamV6qlMI1zgIUT9Kmjl1sX0i
         7hGSNstlL0c7EIJtZayHZdapeLhDJon8YWTssBfVzjH4QnOYGIxE0BFv216OSbpGVjO5
         Xm2X6egM99LJaeGMaZmwRdAP1xOxUvBJICOPpl7SmI1N0MxFbhDiDhObntZV0GEk/n7V
         df6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ObKcUz2lh+VxE4tN2LiRS0G1bDw6LmON+P3aqYeVSqA=;
        b=IKTgL43+3Iq4LRZwDSUI5otGFw4s7CryH1m5J2V+F16rbJxGb+12yEO6lwXdJVgeEz
         AVEqQgimUrIJrvvmtvGu0gwQ8KcwUFol/SdiYApjbGee25kwD1r8kUvx/R9GpAob1PR7
         RS1pSTUUUo4CNlpzM3m4C/Ioc53csRr5OwM8EKrpKt+x1FrQvS1p/HqRMX4rqQ2gdGob
         CSOCwA45ZTnU2w3F065KjNYtIzmIvmVYKnCXvk0px+R+Y2i2UnkBtc1uy60x77VvJx9P
         lBLbD+phrnUyBzCufSpIuGwkkWO4AlGxD05rHIbIf3E78uJUcuYJ4zkCUmLibuek8A0C
         4Haw==
X-Gm-Message-State: ANhLgQ2O2lTXKprS2nGQ9FEbFcCDGg7f6tutq2Guw8uEqGEHrzbRk27m
        o75EiG0qqr1YO9X1nWwG9YMbT4c1xI0mPYNVvYX5HmykHAw=
X-Google-Smtp-Source: ADFU+vvnOrld9guaLnHaq4ZTqFm88JBnHchb1r1FDHWadRC4BBAALGIphAj67LR61+yFL2bxpiZuzDL4wX9+CkPI5cg=
X-Received: by 2002:a92:c90d:: with SMTP id t13mr19139568ilp.10.1585708395479;
 Tue, 31 Mar 2020 19:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585693146.git.vitor@massaru.org> <637c0379a76fcf4eb6cdde0de3cc727203fd942f.1585693146.git.vitor@massaru.org>
 <20200331165707.7c708646@lwn.net>
In-Reply-To: <20200331165707.7c708646@lwn.net>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Tue, 31 Mar 2020 21:33:03 -0500
Message-ID: <CABhMZUUqERRO-4EWabuesK5+ZQNzOFQmaND-tw7j4q5D8UX33g@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH 1/2] Documentation: filesystems:
 Convert sysfs-pci to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 5:57 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 31 Mar 2020 19:28:56 -0300
> Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > ---
> >  .../{sysfs-pci.txt => sysfs-pci.rst}          | 40 ++++++++++---------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> >  rename Documentation/filesystems/{sysfs-pci.txt => sysfs-pci.rst} (82%)
>
> Please supply a changelog with your patches.
>
> The conversion you have done in this file is incomplete; I suspect that
> you have not actually built the docs and seen what the results look like.
> There are literal blocks that you have not marked as such, as a minimum.
> Please actually do a docs build (after adding this file to index.rst) and
> make sure that the output is what you intended.
>
> One other thing of note...this file dates back to before the Git era, and
> while it has seen numerous tweaks since then, it's clearly outdated.  Look
> at what's actually under /sys/devices/pci* compared to what's documented.
> I will take the conversion without it, but what I would really like to see
> would be an effort to document all of the attributes that appear there
> with current kernels.

If you do go ahead and add/change content (as opposed to simply doing
the .txt -> .rst conversion), please do the conversion and the content
changes in separate patches.  That way the content changes will be
easier to review because they won't be mixed in with a lot of
mechanical .rst changes.

Bjorn
