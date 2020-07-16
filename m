Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0856C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D005E206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJH2BDM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgGPXxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgGPXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:53:47 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F77C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:53:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id z17so6176016edr.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHjNZ84Odw9I00tyL0rNJk6APocttkiZI0Xw6GVe51U=;
        b=fJH2BDM6Ixum8ogIhI3oTUAlm4JvVXiLMlmveR9PrJbIIrNyy3hsxZgPKviKM4+YQU
         vBjg568mWozwniuvnzS7+RVc+0Jd05h4JQWcmc40j5oFxRSmZZPHTJ0WA+nC/pbF7+lt
         +vy3Te1DvgX4Xr1H7Hv4Py4nE4khXVlMOQUUd4rebpjFuetFSu7eDqsVAMh0IfdpwPUp
         1fwxiuksHBFBohjtIHgVptCoaISFbvcRjGEYErDBPMDcXlJX5VJ2moHZkjNCm5Bg70mj
         NlJ9wOoEvoer1eaKx9RImAsktSIETPZ0CYL7IqduNsMoJ4+VF5q7UJYys3Tix9n3r4zS
         spNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHjNZ84Odw9I00tyL0rNJk6APocttkiZI0Xw6GVe51U=;
        b=POYQr7mkDL4qUW+iJpdGqlVtQbDTJ/D6/nK9iPwMhC7UK813NFkcYttUSHtLNGUOMt
         IuPsIJExlgesFbeG2UjIgeL2RJTUETRl41Tn4zuJwnj5pzR4blxV7E4ByfOIWjaajM5f
         S2QclllbXPPOBXdHXnrt9DGgqY71zii3nRMIJOqOKx6xBbSjkPsbeKb08lvzAZbEM04I
         OhQquQmPIkP7TU18YpurAsUWv6yY+nvPmPblacX1Lm0o8NPB7d/qidVRSruZINAXs3g2
         y0hYaR9SkX62tert0f0ZOgoxBoHzOqtHg03Qsfk3d1wLvCPD4OvvKQnP4OWN7CI+ZgIj
         CaLA==
X-Gm-Message-State: AOAM531Sea86UNQ+mEiL2EbnC+4yeb8VOVIEEzSFH3bf198IPQ30SSvE
        qT0B8dfFxYUpJzbfSjYbIJNO6iwgtqReP3j8DCttlA==
X-Google-Smtp-Source: ABdhPJzJOYksqSLMgx/OMH73qQrO95Fo4PRZuMwDHNlEsde8QBxONmvSl4lHz2cQxebZnKGBfy9UpcHlCi8QgE9NkGs=
X-Received: by 2002:aa7:dd8e:: with SMTP id g14mr6950966edv.208.1594943624633;
 Thu, 16 Jul 2020 16:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fbbb605aa805c9b@google.com> <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
 <20200716083506.GA20915@dhcp22.suse.cz> <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
 <20200716135445.GN31089@dhcp22.suse.cz> <4ba9adb2-43f5-2de0-22de-f6075c1fab50@i-love.sakura.ne.jp>
 <20200716151756.GO31089@dhcp22.suse.cz>
In-Reply-To: <20200716151756.GO31089@dhcp22.suse.cz>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 16 Jul 2020 16:53:31 -0700
Message-ID: <CAHRSSEzL7E3BPnyc7WAoqo8U=ofSxaj9bKTnU-=+W2=1WManDQ@mail.gmail.com>
Subject: Re: [PATCH v2] binder: Don't use mmput() from shrinker function.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 8:18 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 17-07-20 00:12:15, Tetsuo Handa wrote:
> > syzbot is reporting that mmput() from shrinker function has a risk of
> > deadlock [1], for delayed_uprobe_add() from update_ref_ctr() calls
> > kzalloc(GFP_KERNEL) with delayed_uprobe_lock held, and
> > uprobe_clear_state() from __mmput() also holds delayed_uprobe_lock.
> >
> > Commit a1b2289cef92ef0e ("android: binder: drop lru lock in isolate
> > callback") replaced mmput() with mmput_async() in order to avoid sleeping
> > with spinlock held. But this patch replaces mmput() with mmput_async() in
> > order not to start __mmput() from shrinker context.
> >
> > [1] https://syzkaller.appspot.com/bug?id=bc9e7303f537c41b2b0cc2dfcea3fc42964c2d45
> >
> > Reported-by: syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>
> > Reported-by: syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> Reviewed-by: Michal Hocko <mhocko@suse.com>

Acked-by: Todd Kjos <tkjos@google.com>

>
> Thanks!
>
> > ---
> >  drivers/android/binder_alloc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > index 42c672f1584e..cbe6aa77d50d 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -947,7 +947,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> >               trace_binder_unmap_user_end(alloc, index);
> >       }
> >       mmap_read_unlock(mm);
> > -     mmput(mm);
> > +     mmput_async(mm);
> >
> >       trace_binder_unmap_kernel_start(alloc, index);
> >
> > --
> > 2.18.4
>
> --
> Michal Hocko
> SUSE Labs
