Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA4C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744AA2495B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588355986;
	bh=pyqhQKoYXwVfX+x7HpoU2IBqIU8KOdRj95oXbSY4tVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mKdtq8WDuW79WmesKak8nLwxJcJRN1d3PkKHUmWCD8mbhRk6SY7dzlWrRYvVliMas
	 4VaPb8OqihBJd5Kixt7vQKLUIF/eAcSzfZyhM4hP7xlBG+zJMUtep5oyaUw20OvClo
	 3yE0396HTsTHBUWxdlkv2t4Vdc+2qICJTUh+3viw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgEAR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729918AbgEAR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:59:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F012C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:59:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d25so4449116lfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXn4r+MPXVyQgD4o3lQqxkPpG/DsRtiXml/AiVaSQ7U=;
        b=WDGjF9aBE/SCwrRF0wdMLKxLM+QBOED6GjGnh6yXS7IP9HNxSxs21YXx3b3eIWkRI+
         /iNXc1c8XqN+ZOv5RPZgMGtVWgGn1/M1GJiDFUpCwhOvhhQ2k3vHVaVXg71Yqenb+sMH
         3GKDp4UGgBZCrrhROjcIpyZllnUqK4vi18uQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXn4r+MPXVyQgD4o3lQqxkPpG/DsRtiXml/AiVaSQ7U=;
        b=T/vKkHty8P5GhrfIrqJUhsktg+HkM1/nQqUipJjCr0HGOFj6+4WvRPhq//o0eu2aXN
         ilTGmOsmBUECAPk6+3yX4fkzpX2tjo3dqN+0/zdFHlsG1i2ChhcqFzThtNfP+1nyZJHH
         xrHaIntTtIvpDlxGX3Zs0zkgFve4Y81P7d0NVRnC2JtFZkHlmMpD9QkNQwiR11vU12d4
         h5tubwOcgK18+0b3T+AUrma+qOebQ5b3luQSLBrS9kN8ABno0gOir3eBI0vH4cbCStBm
         Y3UkS1Y8qzi2CjaewIWYyKI8Q75y+09ijrxv4E9misn3YPxQyntTTeiCSRN59RZLyaJy
         FdOA==
X-Gm-Message-State: AGi0PuZVMjZ4HOP0WkFHNnFn0rcaBL2Qt9IpyoC/ZbVgLZ8ZzI0Hn8Bk
        e7eYRGkR/6DkjuXkomCejLxsFx61Vgc=
X-Google-Smtp-Source: APiQypKThfpBS2sbPLWsfM+Yc/uEbEK6lPvgpH1IFt6z68A+iRHt/Ra/EPG4M8kw4ZrcqP2j4tmcHg==
X-Received: by 2002:a19:4843:: with SMTP id v64mr3219345lfa.155.1588355981488;
        Fri, 01 May 2020 10:59:41 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id n14sm2657265lfe.31.2020.05.01.10.59.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 10:59:40 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id e25so3339748ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:59:40 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr2962897ljg.204.1588355980014;
 Fri, 01 May 2020 10:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
In-Reply-To: <1588348912-24781-1-git-send-email-bfields@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 May 2020 10:59:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
Message-ID: <CAHk-=wiGhZ_5xCRyUN+yMFdneKMQ-S8fBvdBp8o-JWPV4v+nVw@mail.gmail.com>
Subject: Re: [PATCH 0/4] allow multiple kthreadd's
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 9:02 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> Anyway, does this multiple kthreadd approach look reasonable?

I don't see anything that looks alarming.

My main reaction was that I don't like the "kthreadd" name, but that's
because for some reason I always read it as "kthre add". That may be
just me. It normally doesn't bother me (this code doesn't get all that
much work on it, it's been very stable), but it was very obvious when
reading your patches.

In fact, I liked _your_ naming better, to the point where I was going
"'kthread_group' is a much better name than 'kthreadd', and that
'kthreadd()' function would read better as 'kthread_group_run()' or
something".

But that may just be a personal quirk of mine, and isn't a big deal.
On the whole the patches looked all sane to me.

> (If so, who should handle the patches?)

We have had _very_ little work in this area, probably because most of
the kthread work has been subsumed by workqueues.

Which kind of makes me want to point a finger at Tejun. But it's been
mostly PeterZ touching this file lately..

                Linus
