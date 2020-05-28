Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AC1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA59E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgE1JJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:09:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgE1JJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:09:31 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MtOSu-1ijdkF2kLG-00uuAT for <linux-kernel@vger.kernel.org>; Thu, 28 May
 2020 11:09:29 +0200
Received: by mail-qt1-f173.google.com with SMTP id x12so21599939qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:09:29 -0700 (PDT)
X-Gm-Message-State: AOAM532Xg3rDvgIZqZUyKc3dY1mzJjgwkiRMiMMlLTIo2osB+IiNeRKa
        7JIwQHLR0PQedO3p5yP3giD5drsLQlth1yLjAfs=
X-Google-Smtp-Source: ABdhPJw0lPr/TwhrVNC3iy5YtxH6Hjy8bzmX2rAe1KGmP7eYz/oL6ngiwKPu38ETWEqiMphjY7bZ3Eseev3rSciH8pY=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr2005129qtr.7.1590656968528;
 Thu, 28 May 2020 02:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134254.854672-1-arnd@arndb.de> <CAKb7Uvhh2JKck524D9S14uNSLykFj+U48AgR+sd2uwchsH_wEQ@mail.gmail.com>
 <CAK8P3a3kRP6Sg-An5szsN=4Pv1OsG+-YQYa1wgxJCi1c+uedPw@mail.gmail.com> <CAPM=9tw_D0edbF38iFSrecDM8gnK4wNCDGiL2JV86tSUAmSk6g@mail.gmail.com>
In-Reply-To: <CAPM=9tw_D0edbF38iFSrecDM8gnK4wNCDGiL2JV86tSUAmSk6g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 11:09:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wuK9hHWCypF0HEzWY_iSn1SQJ22j26ykXYeVYYqKpCg@mail.gmail.com>
Message-ID: <CAK8P3a3wuK9hHWCypF0HEzWY_iSn1SQJ22j26ykXYeVYYqKpCg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] nouveau: add fbdev dependency
To:     Dave Airlie <airlied@gmail.com>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ag7tWZZGrf8qgFOmQ/JWr29482tiFOhy0jXtY8MpDpHMO0OAsdl
 W2jTnd/V8BlWN5OxRZNzU3OQVGDBIPvTV3KUW2uKdCpxch2vJKGl7bxsM+pLWGKpyDzcVSu
 tmTQHfdwBFRpOBWBtrgdpacIBQOXk6RMto0cl4UKtNa3mIwQ184PyYynJAwj0tycSVmT398
 H4oFwpZXjArzNvdAKImzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+hFDovOWR/M=:Ccg/DiwmystHzkU0yrb1Cg
 +F2qiWIYdWEOMdnBGuLfuUewPot7BfYYtrvZ4kJnjQsIP4vsVVrjj1JZwmYwJ9/okoZtlkR5t
 tfirI43d9Viq7JSqczfe+yMv5sWXbvVXw6vGyPEOfYxEjB8w0a1Gb3m37wtaGQOYDjGKKxT+d
 +Rpe3TkQXfRsxNUSf82E5wE5X7yyaKU/NXeOYV92TKc/kGp/04yZdgVPgbKccHrQUyx3iNFJE
 74J3gzqn6iyXwBQL2udnIlXeTO6ANKVEyEhX2ZKidejEeSlFxo0+1VsWm9uJPOYXLs0TABoDL
 xEuP/3SavNhJUlzxkwUyTkkEFaSMrFW1AsDmHUUtNk3CFZWeMbHFkvYv9VqmgXGxIKSZQGV68
 +wCmhPR6ByuUvEp0FLN2P7AXWbI3mI1Rx+EmnBllnWNTMuUyYQv8jjOGAZbW5jAa9hVpiw12O
 xgjnIj7Q49huhwm28JKp0/HHnOtAEjF1TBAfu6l8Vj5LYNhClR6+zW5JQhqW41uy9GYgOB08m
 p22i6V2m+XYaZl3sMC3VTIlByzufEDKAW0BoUgS8z959G9lHfKkQwd/IQ27D43xVEeTkvXmmH
 N9fd3xXN4dwuOHCzlnj4VAPACtODq3EWJkFX4LzYxpVdj+p6mm7lm7yjZUrVx3/PasssWZ1Bj
 jkykV2K8oNO5RiUYYva1yg0ia/vilaz7zJO7cWxG/n9wTCmOPalDMReFqRZ6JMWFghCe5DE8O
 XC8Rp4xsaTl/+syI8Ga2JfX10EQhB1WAf2soby1gfqJKjN9NYhxSHXYCtvLFXblyQWFi3x9k1
 RhI3UFNEGkgJrwtPbiKzEczusldO8x3VXxXYOgzUnoc5fAKYdg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 7:37 AM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 28 May 2020 at 00:36, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, May 27, 2020 at 4:05 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > >
> > > Isn't this already fixed by
> > >
> > > https://cgit.freedesktop.org/drm/drm/commit/?id=7dbbdd37f2ae7dd4175ba3f86f4335c463b18403
> >
> > Ok, I see that fixes the link error, but I when I created my fix, that did
> > not seem like the correct solution because it reverts part of the original
> > patch without reverting the rest of it. Unfortunately there was no
> > changelog text in the first patch to explain why this is safe.
>
> No it doesn't, I think you missed the pci in API name.
>
> The initial behaviour doesn't use the pci version of the API, the
> replacement did, and the fix used the drm wrapper around the pci one.
>
> So this patch isn't necessary now that I've fixed it the other way,

Ok, got it, thanks for explaining!

       Arnd
