Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE747C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8692083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTDYJMah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgGaBEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgGaBEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:04:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B20C061574;
        Thu, 30 Jul 2020 17:55:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c10so3088004pjn.1;
        Thu, 30 Jul 2020 17:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8iGGRIMcGIJb/MfOVjMyzOROeLJmT2jzu/UJuU9MvU=;
        b=kTDYJMah73Fg+QPTvP5uhTBZ3ul1KmgZTaqpWq7DOJcwvAGT3c0mctPQcF7k5gMaG+
         2quOgxPsiod+KO0OK6SnFlowjse7oq+iM0WAxSs/Zqg5fz005p6RVQ0jNAa6RkaITP2O
         UzSQk3IbtESV6RWUTNxB1JjJ1yE57kfBjUNXDFowpA25NCeLYUr+dqdUf5qhlrJnO657
         5FyCR1WXvna5gCgYpbTICjgPr0tHnSJ4XPZ+T47dzebwtAgyWbPSiQBjZl7QmqOcDHBm
         xfXp5LJl7cwr+QE/z0qISIkfCdUy3smpPSd3Tt4Wu/HQkyo9MMaKC93EaLZNvYBrd7nd
         HYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8iGGRIMcGIJb/MfOVjMyzOROeLJmT2jzu/UJuU9MvU=;
        b=BbmbfoiTRq+v0SMdBHQyxil/n/Agu1x3x3Yl9luUjRen33dtz5vL+Mf3UhM+Kn8Eyu
         0jf/n1JAMBN62+YJt6G3M0Ku2mfkkv3fyuNAYbSQzm7Y30wEZPsLDZjnaFhW9DPtXHdM
         M7GvOrsoU8ray32XaVNjRIF2GEKRx3DqAmFN8Gkwm5dj/h8I3kudIpp+UfjeEgY09KOs
         M6FuWeYlluDPx08VTULHw3DoVXP0yHRmU/lDb6icw1BtiUdWhmckXSCLUb5nqFdHn2Ey
         fNqtrebF+zy3aFn+gGY8yUxOVoZd1wUnzlmCchojZhzGFao9Wdy0ZLcwT/n0MLV2/jXX
         1Jeg==
X-Gm-Message-State: AOAM531DxRs6H652truk9HOfrJFbzbzfyOX3WnWknDLnzSJo+GHspfXh
        qx+dXj2XdHjmZ+LOAXrp1mMQXWC+zlOZqv83ne4=
X-Google-Smtp-Source: ABdhPJyt0DsBYfQQqNxBjchl2sKZkhNj48U3lZhDOy5d22LJ05RdwMoIoSaoRQ27lVfBSua76BaWr+EhVXJRChcqYnw=
X-Received: by 2002:a17:902:ff16:: with SMTP id f22mr1560351plj.269.1596156915733;
 Thu, 30 Jul 2020 17:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
 <20200728195246.GA482576@google.com> <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
 <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
In-Reply-To: <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Thu, 30 Jul 2020 17:55:04 -0700
Message-ID: <CAJht_EMQvNknLFXVBJdb190jg8duD5DZ1c3HcOsUbYFOa6-5TA@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
To:     Brian Norris <briannorris@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 5:24 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Sure, I can do that:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thank you so much for your review, Brian!

> I guess x25 is basically an abandoned project, if you're coming to me for this?

Yes, it does seem to me that X.25 is unmaintained. I'm submitting
patches for it because I'm personally interested in X.25 and I want to
fix things that I find to be having issues. But it's very hard for me
to do so because it's hard to find reviewers for X.25 code. So I
really appreciate that you review this patch. Thanks!

I don't know if it is the right thing to continue submitting patches
for X.25, or we should just keep the code as is. Maybe the kernel
community can have a discussion some time to decide what to do with
it.
