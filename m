Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2924206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586450563;
	bh=meWujr9R/wliQxy0yMxtlYh6kayDM2IEDZoCxU5/1h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NyHXd80aEXFCGipuzB5VsRa2LaVzU/7DMhhcAVx4Qc28hUuUFWclXZ5L8jKAk4pDH
	 JyCzVa8l201TpXP9Aiwwsm5udoaUvXExn0nEwJdy6JQ2JhINZ9H/PzWOLkUjRbfs7K
	 451w7+0jTdIu9TPiqrG6tgI4WGlz1PaLyKJVXdQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDIQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:42:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37455 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgDIQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:42:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so378198ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOBvJudjKhEH/nw8efrp6OPdZhccp/DwAqikzCITmjM=;
        b=g/c2K9h6KURBS6W9N4fbTAdz4lPq7rQgnK1C1AMox8Dk13rYHm8TVDSEdtCaELIaHj
         K5A2prQAM+bjd/a8DAF34WRkus40YIkGPK8sdNA/kv8cga5k3qqNZZiWe7sIdkB/l/5H
         D3vBdaHbcUxw2MOc7soiyHBjtXUcgvWeObgK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOBvJudjKhEH/nw8efrp6OPdZhccp/DwAqikzCITmjM=;
        b=hS+xfh3hpuzW4um9OXTJaPUSDTC9AMhfnBFIU9OzCSBi/dbaeOzKINfQUJAGm9Ks3O
         mJZQ3ME50FUnCFXU73KFgXiZH/c8sdjmmvV6umH2mDPJ2x8Iod3UP6425/4DbARtjgSk
         sqbdNDi28CvqoDpUMiQ22SvfYCdt2PeGMVBibs+EPV744ubdN/Ys1eaiMKMw8xRvR9OL
         1sPUtsa4Ol0nnYCXJ/1oocv+peT2WjrIOhMxg334IWOHYkU6EQP3Yg89622LhAtxvZXw
         2F0FuV+5oFz4ErkDf80LflkM0Qal59uz3xonT02fgTOjl5Bezc+WeUSHZK1IOAoGsuAd
         sU7w==
X-Gm-Message-State: AGi0PuZhse1QaBVJfSsugGNHmsjGJfhdR5mZgJu/BFEtWeXKGHmuafnS
        rPBuJ2FL+Kt8jlM8J91tKmEZPxu65Fs=
X-Google-Smtp-Source: APiQypKCptzIMgAnnrp16JM4e9et/LUrZJ7+6BRR3WLkyzzqBUiySSkgmHAL3Px1UIOhzFEGL0Cj5Q==
X-Received: by 2002:a2e:a308:: with SMTP id l8mr406796lje.282.1586450557822;
        Thu, 09 Apr 2020 09:42:37 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e16sm3837616ljh.18.2020.04.09.09.42.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 09:42:36 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id x23so157943lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 09:42:36 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr99713lfk.192.1586450556113;
 Thu, 09 Apr 2020 09:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408014010.80428-2-peterx@redhat.com>
 <20200409070253.GB18386@dhcp22.suse.cz>
In-Reply-To: <20200409070253.GB18386@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 09:42:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
Message-ID: <CAHk-=whwRqkwdaJQf4g0-Evd6RmXR3dkkKyfnPjbnkeia=b1ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal signal
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> This patch however doesn't go all the way to revert it because 0 return
> value is impossible.

I'm not convinced it's impossible. And if it is, then the current code
is harmless.

Now, I do agree that we probably should go through and clarify the
whole range of different get_user_pages() cases of returning zero (or
not doing so), but right now it's so confusing that I'd prefer to keep
that (possibly unnecessary) belt-and-suspenders check for zero in
there.

If/when somebody actually does a real audit and the result is "these
functions cannot return zero" and it's documented, then we can remove
those checks.

Ok?

              Linus
