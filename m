Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8102FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BED02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588202552;
	bh=foHZDVH+D/wJDafjz520ZI58UfxR56P7qlEeau1QtDg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sf8S3nOdjyNYmf7Cr0VPlp3vFrvMbelzG3IfpCzhINEVuEUYoKPhjXtAoqZlqQX+V
	 /IAAqHQsMfOh+nKH6ajfaKNxC/yR6rU3eJJe7xsI+akw23dWuQ8MouKOexZlDLLkjb
	 y+mfQ0HYF4p+eHNAmn/qMEkTD/z5Qqk845vlbGGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD2XWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgD2XWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:22:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79CC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:22:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id f8so3144171lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFDZ9zGBk6/UPc7xr7AMQDOtOLrRngt/wNMKSySVpUs=;
        b=E6JvUxj8B6VKSwLWlei0aBe3ASKOzYMxs1jEzjN9VcbAEV7GQDuAG2jJXyxILBMqbT
         quRf6QGBFpujGvv3xtl7oKk7+C/ySmj/MOIfs26Zglj9y9o4Ut4ecUgmp/NYIY2LflIw
         jIvYBWkk29ImOdwQkayYdV/zQx8kSBW2CaV70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFDZ9zGBk6/UPc7xr7AMQDOtOLrRngt/wNMKSySVpUs=;
        b=GC5GRFzZC64uw8SEw4MtJiVYRuhJ7q4JC5TtbMmM5FEqlCxB+UpFYO76ij19khiMCJ
         VW2CyQOdnYl2wo9FhHLJuHpWbdsZwe1fylD/x9bOscjPY9cfbbqp2wDxhSGGQ1O3HWPh
         Ck09L/R0bh65s4hJgp2yJHz1hFhVqkLkD06hfhQxd5ZO5SSD2Kh4pzI71n1VDtEAPMLz
         s0ZXGMgo1qtz5t1u9GdUTHrS1nr8oCx/5Z0ugwD7zPAdyQ4xCud0JHIXfFFXv7hChbmO
         PiLjtgZ0GBJYVinWRROgXq0+WrWk3Pp/NabUfpoJ0TVSkTaoIYpfm3yuXy/RiViNrVbi
         RvHQ==
X-Gm-Message-State: AGi0PuZY8Xt3LYlp7L78m1UbDYCxHLSBYgx5FvVxJXFZRuaLJ9erCTHQ
        HCWCjAIeqGwFl+vSE0ndAsFnYv8rZdM=
X-Google-Smtp-Source: APiQypJd5QCA3gUYO5cVisGV4UG/XA1Ww21XqJEz1JuYy3C4a3Gtk1IR3adj0r5bYIRDpI9IyAyZrg==
X-Received: by 2002:a19:5510:: with SMTP id n16mr150447lfe.58.1588202546373;
        Wed, 29 Apr 2020 16:22:26 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v7sm3509482lfq.55.2020.04.29.16.22.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 16:22:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a21so4467941ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:22:25 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr379041ljc.16.1588202545044;
 Wed, 29 Apr 2020 16:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 16:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
Message-ID: <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 3:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you do it properly, with a helper function instead of repeating
> that fragile nasty thing, maybe it will look better to me.

Side note: if it has a special helper function for the "get lock,
repeat if it was invalid", you can do a better job than return
-EAGAIN.

In particular, you can do this

        set_thread_flag(TIF_SIGPENDING);
        return -RESTARTNOINTR;

which will actually restart the system call. So a ptrace() user (or
somebody doing a "write()" to /proc/<pid>/attr/xyz, wouldn't even see
the impossible EAGAIN error.

But that all requires that you have some locking helper routines like

    int lock_exec_creds(struct task_struct *);
    void unlock_exec_guard(struct task_struct *);

because there's no way we put that kind of super-fragile code in
several places. It would be very much one single routine with a *HUGE*
comment on it.

             Linus
