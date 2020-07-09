Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B67207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyLQq+5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgGIJBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:01:43 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5FC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 02:01:43 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so1394364ili.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55x0UBIPkk2Krfx/KXzHrVaxKqeYZGh5rVc+isvPSjw=;
        b=UyLQq+5Zcvypue6+lOGoyOhePqCq/gCp2ZErd7RoeDuVOS95ZAqcftovuOcrSr/K+a
         3vYLElrqp6O/jDNnk+q+ULcdqHsryivU4lMXiMWwAHN6mgiXK8yL0R1wMOmB7ofTvn3k
         qF0C9ydQZqjToD7Gt3BAEpppprHu0kqXTvepj/BQAQlAJnywrsGyZUahpWSfVhuJ6PHa
         wiegYy6r2MynMfaLhy0Ea9KENHP9qwuqrKcqHHDFB7WWhtoEb5gP+Ti5hDf42ViH1WaT
         D6wJqIrHkywfxvtbSK7GNH5ISxwQKoM9+dP87tHzsDnFcqNuqShrUqqlbaPQVWfGlvgG
         db+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55x0UBIPkk2Krfx/KXzHrVaxKqeYZGh5rVc+isvPSjw=;
        b=qYqqMyuysg0ulOtGPG74oJi9iuXNdtELnscXFWSFfIELpfoD8oZD6fhvwBIcgxazHN
         kBTlarW8+2sQ87zmal8eJOiPe32T6rkjPR0jNl5leY3+2ex9NaSDHlRi68L0+mcZYdCS
         amefrxTv7aFAvGm978ZQuPue3GVsy/SWECxOi99SjEMOXrvQGjhbcjOIHaWPv/2tSk7l
         xxPERRFxxEgzRSWuD3ymeu41ApnIFdBDgkJ9wfF2oxV6k7gY62RWo94JdissS9OsHuaX
         /merI7oAFeP60Im5pgXoR5SCRw2EQpz/71WmkEjnnLct7CCgbyf7zUr6vGTszsx2/6bY
         Hcow==
X-Gm-Message-State: AOAM530gjrapCRY+ekci6YOgJogzZoaMpQnn+adiVESmW92yaQmFGtOP
        jPOd11i1GTHu9gEDADdHSrA/npAexqz9/tnpz70=
X-Google-Smtp-Source: ABdhPJz6lyL1M32mjf3JxgiI/8RtiIq0VAeksFU6EQslv8TA2NBsE8hOamkfocpra4lgbUe+eVHGSGkkJYbAUnpueL4=
X-Received: by 2002:a92:404e:: with SMTP id n75mr5224682ila.203.1594285302929;
 Thu, 09 Jul 2020 02:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200709062603.18480-1-mhocko@kernel.org> <20200709062603.18480-2-mhocko@kernel.org>
 <CALOAHbAezHHN58cn0unLNbOjHJyYW=zhzQxpQD8_rD4O7qmYRQ@mail.gmail.com> <20200709081813.GD19160@dhcp22.suse.cz>
In-Reply-To: <20200709081813.GD19160@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 9 Jul 2020 17:01:06 +0800
Message-ID: <CALOAHbDZLM4bfGi7EQDzE6FabBinnZJ7yF+uZADUgx2S_pfg1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc, mm: clarify /proc/<pid>/oom_score value range
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 4:18 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 09-07-20 15:41:11, Yafang Shao wrote:
> > On Thu, Jul 9, 2020 at 2:26 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > From: Michal Hocko <mhocko@suse.com>
> > >
> > > The exported value includes oom_score_adj so the range is no [0, 1000]
> > > as described in the previous section but rather [0, 2000]. Mention that
> > > fact explicitly.
> > >
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  Documentation/filesystems/proc.rst | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index 8e3b5dffcfa8..78a0dec323a3 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -1673,6 +1673,9 @@ requires CAP_SYS_RESOURCE.
> > >  3.2 /proc/<pid>/oom_score - Display current oom-killer score
> > >  -------------------------------------------------------------
> > >
> > > +Please note that the exported value includes oom_score_adj so it is effectively
> > > +in range [0,2000].
> > > +
> >
> > [0, 2000] may be not a proper range, see my reply in another thread.[1]
> > As this value hasn't been documented before and nobody notices that, I
> > think there might be no user really care about it before.
> > So we should discuss the proper range if we really think the user will
> > care about this value.
>
> Even if we decide the range should change, I do not really assume this
> will happen, it is good to have the existing behavior clarified.
>

But the existing behavior is not defined in the kernel documentation
before, so I don't think that the user has a clear understanding of
the existing behavior.
The way to use the result of proc_oom_score is to compare which
processes will be killed first by the OOM killer, IOW, the user should
always use it to compare different processes. For example,

if proc_oom_score(process_a) > proc_oom_score(process_b)
then
     process_a will be killed before process_b
fi

And then  the user will "Use it together with
/proc/<pid>/oom_score_adj to tune which
 process should be killed in an out-of-memory situation."

That means what the user really cares about is the relative value, and
they will not care about the range or the absolute value.

-- 
Thanks
Yafang
