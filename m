Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E017C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C92070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595960244;
	bh=G+jtaekjXWngzxev+plbs+4Zb4++K32wPfT729Zo3VQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IGqteyCTbEG83w8oqC9Kw51LVD5h8+9AFKxGA+HMVaBjphvF/chAUeuS8eBj7kTUF
	 yJ7so1xbEC+lq4KOj5zLx5qS0J0yCdn7p1FRSvxwNYLxl3boAJxX11d5Sxv+h1exF1
	 +XWGdgvcO0/lnfzgwx8egM9C+qnAFkNyh9A/x2Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgG1SRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgG1SRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:17:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3856FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q6so22185969ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=hdBHy5JovDcVsPtQmmE+kOG+0bUdmbxHWwkGKho10lmXbEo1G9ahGg7SX5mCD+aqlW
         7usecoUhK45RaSad6rpfDN2jFykepxltPY0kSQC9Ax1Dvd9VtqnLvGoZA2JD/scAiTF+
         RuZ2jZslihKTU8Zs6p6GmQJvi4+8tJXvgSOCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLQ0XH/RmZSu/en4EAiBtQRKchA1E8VMT6fgzWGOKMw=;
        b=R4kSZsH4vEbf72GEbpfO9eRMbzuYcyKJrFd462aoEcOnUAFCrc08+72bdlrDaE9wA4
         d9QUtG7UuEOqtvq30Lx9MDRkE4MwDwpX3X2Z3D6VfVE+iiraqHWU2xxzN1rLzG2Qk8xp
         PUH+amppMfqpP5/RPLF+6VhJT/jk+vq5S1lFqKPAVN3vHu5j3S4PZB1rFD/qKy5lWU0R
         IHUb+Ja/aDhtajhnwxUaaLiAOQ3loAJxaZX/N6tGM0QFWnpmuUrvDSl93cmWj3X9jmpl
         7MgAtArKEpuLygaCr1dpBtEkr4gPLleC6LV5Fu64t56TiFHLaazAMlOK3FmAbBCIynVp
         rgdw==
X-Gm-Message-State: AOAM531emGjAoa8SP0uySJGmZR3wEbLT6kih1puLYokqXt/bsJd6QtKO
        6t65mlZsYo/sVM52uSdUeYgAIj5+RzQ=
X-Google-Smtp-Source: ABdhPJzVG0ic5aB+LyM4WbgTEvf8QZi1q+opOU2x/TBosWPcFZ8S903pXA/0j8Qn2QQ0LawZGbVU2g==
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr7652970ljo.259.1595960240370;
        Tue, 28 Jul 2020 11:17:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 132sm3952435lfo.16.2020.07.28.11.17.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 185so11982410ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 11:17:19 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr12506329ljj.314.1595960238862;
 Tue, 28 Jul 2020 11:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7trg4ie.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jul 2020 11:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Message-ID: <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a
 multi-threaded exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 6:23 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> For exec all I care about are user space threads.  So it appears the
> freezer infrastructure adds very little.

Yeah. 99% of the freezer stuff is for just adding the magic notations
for kernel threads, and for any user space threads it seems the wrong
interface.

> Now to see if I can find another way to divert a task into a slow path
> as it wakes up, so I don't need to manually wrap all of the sleeping
> calls.  Something that plays nice with the scheduler.

The thing is, how many places really care?

Because I think there are like five of them. And they are all marked
by taking cred_guard_mutex, or the file table lock.

So it seems really excessive to then create some whole new "let's
serialize every thread", when you actually don't care about any of it,
except for a couple of very very special cases.

If you care about "thread count stable", you care about exit() and
clone().  You don't care about threads that are happily running - or
sleeping - doing their own thing.

So trying to catch those threads and freezing them really feels like
entirely the wrong interface.

             Linus
