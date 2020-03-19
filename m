Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E17C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F420789
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awMAcpFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCSSIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:08:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33175 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:08:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id x26so3389951otk.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Xu0QrQlsjdldwRC1nps46N1nU7pCt/oK3/9Wj8IKiw=;
        b=awMAcpFJeOrIdWpDHagljBb9cmXwR+Db8v8huGcj82AP2JTD75YhDnQsNzaPBAwyrs
         Fd16Z6F7NlYKo53tKs5qINZiysrcrCV+YyhpWNbqZ6M9rWNkY7oxALE/JiSq5Qg1TIM9
         W514th8N91MslC83xfX60HqJlHSzz7NL9PhT0a3pGTM1IpOkuGZIG4cmsobagKg+Rk1s
         68vFz+vHJFyxpUwPBHmNKo3u3Q8gRHKZi7KLEUbUCsIVMEjJTtFNWW869X1W8rHXMxyX
         fENIiEyHRFf5HtGQTuviBkpX72JoyG7khwSkr8ZyH6Z8aNWtTOSx3RXGhwmUnbGv7+Iw
         SgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Xu0QrQlsjdldwRC1nps46N1nU7pCt/oK3/9Wj8IKiw=;
        b=OaPGOtvSgsPdyXhJf3ee0bcqWqVRy/3/7L1qxGd1fgvsOJ6GSqCSIYb85DtYg1xPgL
         i4OrVImQL1NVLfEl8hJ1mfSZmIraILXkqK2yEnAUILNI5WUIbWeOgDxhbrfqKNosEFWw
         9+y3KicD0errOWbzGa2Exr6UV/2U9u5TBGlorrSSCHgBCR0kOR6hcrP2RWYrvJUUB7yR
         SAgtmX1nn5E7UKD1Mfh2Dxc4P3JAHieVG+rx9DDflMfDI9Xi557nVXrWb5Cwg1M+0mBa
         kZPXaOvn5pp1snvFTG26uys+Yt+6UlXyCxHV7ob7hTiSBtzmkoPLyh4NfHecwbv5oiTL
         GiEw==
X-Gm-Message-State: ANhLgQ3IkGj5t51ryJNyDZ9j5HYllKnH++NNiD3YO4zaq87h+YpADpzr
        gTWkFby2ZAOwwHhLghlbQiuYSyQ5bM6W10zbUmQrg5UI
X-Google-Smtp-Source: ADFU+vuXiZDQ0JtlnLICq8/ImvOKT2+DbBzIkng50geTAep6a7tCMxPkatqLefxRC7OrF3ZYll78Iq+luLrurCWjLpo=
X-Received: by 2002:a05:6830:150f:: with SMTP id k15mr3149803otp.251.1584641290618;
 Thu, 19 Mar 2020 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200318173845.220793-1-elver@google.com> <20200319152736.GF3199@paulmck-ThinkPad-P72>
 <20200319180245.GA17119@paulmck-ThinkPad-P72>
In-Reply-To: <20200319180245.GA17119@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 19 Mar 2020 19:07:59 +0100
Message-ID: <CANpmjNMN_-bfqinOMG9_FakPVYx_Rk7nQ=AdkW8H6sAAdjxZPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kcsan: Introduce report access_info and other_info
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Qian Cai <cai@lca.pw>, kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 at 19:02, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 19, 2020 at 08:27:36AM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 18, 2020 at 06:38:44PM +0100, Marco Elver wrote:
> > > Improve readability by introducing access_info and other_info structs,
> > > and in preparation of the following commit in this series replaces the
> > > single instance of other_info with an array of size 1.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Queued both for review and testing, and I am trying it out on one of
> > the scenarios that proved problematic earlier on.  Thank you!!!
>
> And all passed, so looking good!  ;-)

Great, thank you for confirming!

Thanks,
-- Marco

>                                                         Thanx, Paul
