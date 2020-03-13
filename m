Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91416C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592912074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG0PGXBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCMXQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:16:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43737 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:16:34 -0400
Received: by mail-il1-f193.google.com with SMTP id d14so10181022ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCwtT5ys+KXfR/7uONUa0iE5JcoqG50bF3Lvb9+GFSw=;
        b=kG0PGXBdvJXeekPZGzliI9XRc2vek0lF9e0c9VFr7XFfx38CfsDeYcRBeoE6Q36rUR
         uJCbkVTB3W6K/SFilJrmBs2+3Z4DQ8O+rpIW2F/Ppid7wIYpvydV7QAb9qlOfPvGlSRt
         zimv0y2195d6CoQJalkk9DrfwKFXdq7VrLf12yMBO7kC3y77jcx2aEvArUxdNJb18pIF
         Jj5vgb6wXRo3/+jsMs5aEkhvhL2+/NugD4gMw6nmwGKkmb75n2oHlbBBrC1kv8M5SjBB
         5HSImzRIZHcVUnAIb2O6LI7toPNs00q7wN4EgB6ZL7eoJI29agk6jJZ/TkOWMXinBDyF
         Hdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCwtT5ys+KXfR/7uONUa0iE5JcoqG50bF3Lvb9+GFSw=;
        b=jvRljFR1ncU2qlc00FqaUNIIpzdmA5cI2jvVSthODf6n4trTGGqIk+3H0vKjQP4SlB
         Qrp4wqy8AO0WS7Hmkci32G10Ng5Sk8edQ5ov75eWoPBqrZpRm/a6dEsVNdaFKsjQo9AP
         Fzz7ylBFv+msmAf3ly4wtGqKDujwKEXUJN+qAEn2PcHTJPXUmkj+Gyki7TUOnLJdENrw
         P54ULtW6uwbAtTpolIfIYREo/F5iTIp5XQ9t7i9Wb4ttSch9YGLLl+uYwgLabVDH7F5K
         b6tfdPDjeXAfKhrW9aoqMeG1ZIQ/PBKZ7lzl3duFzaZ9pZAEaCCDmQsyDA5xF8rCk19H
         iatA==
X-Gm-Message-State: ANhLgQ3CYBuH05bs0r4jaOds5XADYc9Gp+uB0MsokHgPWrc+Ck77w4Ku
        N00h6YnMG0DJTT7IgZk3Ni5E/nzimMdBnnP19ZnoHw==
X-Google-Smtp-Source: ADFU+vt40lziG3DKWcTz170Rnx1BN/ZKX5LDvpuy0FQIDh7YqxE3tlAXf+/NESWYuerEg4Kt5qsQYZPZ8haa/q4jdys=
X-Received: by 2002:a92:83ca:: with SMTP id p71mr15146664ilk.278.1584141393127;
 Fri, 13 Mar 2020 16:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200313184909.4560-1-hqjagain@gmail.com> <20200313184909.4560-3-hqjagain@gmail.com>
 <20200313191212.GN22433@bombadil.infradead.org>
In-Reply-To: <20200313191212.GN22433@bombadil.infradead.org>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Sat, 14 Mar 2020 07:16:22 +0800
Message-ID: <CAJRQjofwvxUaxg60jWUsKRhK+8pcpsGRUXmOPmdSVPi1Q8bNkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] radix-tree: fix a typo
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 3:12 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Mar 14, 2020 at 02:49:09AM +0800, Qiujun Huang wrote:
> > "iff" -> "if"
>
> > - *   This function can be called under rcu_read_lock iff the slot is not
> > + *   This function can be called under rcu_read_lock if the slot is not
>
> That's not a typo, it's a mathematician's shorthand for "if and only if".
> I'm not excited about fixing problems in the radix tree code; better to
> focus efforts on migrating users to the xarray.

I get that, thanks.

>
> http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-conv
> is an out of date effort to do every user.
