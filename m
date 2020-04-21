Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C5C20724
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYpAdqtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDUUgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:36:21 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA33C0610D5;
        Tue, 21 Apr 2020 13:36:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so11241481edy.9;
        Tue, 21 Apr 2020 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cq4xp3yqaFWuVE7YUa9jI1S3bx7YhIAC44OnIS8bLMg=;
        b=TYpAdqtY+WYHur0QZHOYxX1lb3l5xjdZUPT30oVoxED9kbgpO9Mey3zEe3QgrLiRhs
         nQVwGaHX885ABAEy59Oy4nVmufv/km/Jl0VCaTj0OoJOLoLQp7Y+8W48hReDfyJjROeu
         C4EBin0sH5LTLq8lDREl2XY7vZ271PeB5caL+bYMgGrcca4VJLgGI61HO/qBdsnyaYqJ
         kSi7+3gx88O+UItOUGXnaQ8069KC4osA0V0/CgDUuPadUyXkjH9laY0r/+21IKc4g+Od
         VlAhOQfc7dw1JrCgIFOs6uClnBG6NRKPFJ13hE/xx8inm7zlNO/YtSJzRPQmTbARSblM
         fIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cq4xp3yqaFWuVE7YUa9jI1S3bx7YhIAC44OnIS8bLMg=;
        b=t5vy+pTWUOeTi/lSz1dV/PH6CZiBQn+Y08gCpaL9hAQ66vChoTuO9K9OhPbE1C9u6j
         gs4IQfpLAKLDHCcZlWVjMKXqe2Q9ihWLrVJlWr8T8qIZfC0i8hQPq+lkWXB7QIbn1nah
         +sZr34HMHESPSkQ1E+HHv/4vTLAs4R5X7uVCP5zKy0CO2Zla+26LMGfOLhLF47z1g3Qx
         8nQNd6L0sXPQHUSLrxdLeifcIOmPZKZnPxDcLI2Ww0xxvstK4iLaknJzvvUjRuw1Vuec
         QjADqit3rYfkk0T1Wf+C92BmNvLXFlaouhAuJBaiyOEKNpvsYN4yglvHJ1NriPJVyfb5
         j4eg==
X-Gm-Message-State: AGi0PubHpdTzbrKTIEQkCwL1tWukxuYeDkqHcOAVtZvr922z2k7boDPn
        b6H6+nPOUcxk/VkEYS3II8lQR5rAKOR1WlwVeG0=
X-Google-Smtp-Source: APiQypIn1hspAlk6ZrcuJ4HihtEE8LTEvJaVMPywTNTlikTbpFH9mMowmZrHsLXUAOZvStsR9pH2IheX7L1jaXrQLVs=
X-Received: by 2002:a05:6402:1b91:: with SMTP id cc17mr11556572edb.46.1587501379927;
 Tue, 21 Apr 2020 13:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200420231427.63894-1-zenczykowski@gmail.com> <20200421102719.06bdfe02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200421102719.06bdfe02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Tue, 21 Apr 2020 13:36:08 -0700
Message-ID: <CAHo-Oow5HZAYNT6UZsCvzAG89R4KkERYCaoTzwefXerN3+UZ9A@mail.gmail.com>
Subject: Re: [PATCH] [RFC] net: bpf: make __bpf_skb_max_len(skb) an
 skb-independent constant
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This function is used from:
> >   bpf_skb_adjust_room
> >   __bpf_skb_change_tail
> >   __bpf_skb_change_head
> >
> > but in the case of forwarding we're likely calling these functions
> > during receive processing on ingress and bpf_redirect()'ing at
> > a later point in time to egress on another interface, thus these
> > mtu checks are for the wrong device.
>
> Interesting. Without redirecting there should also be no reason
> to do this check at ingress, right? So at ingress it's either
> incorrect or unnecessary?

Well, I guess there's technically a chance that you'd want to mutate
the packet somehow during ingress pre-receive processing (without
redirecting)...
But yeah, I can't really think of a case where that would be
increasing the size of the packet.

Usually you'd be decapsulating at ingress and encapsulating at egress,
or doing ingress rewrite & redirect to egress...

(Also, note that relying on a sequence where at ingress you first call
bpf_redirect(ifindex, EGRESS); then change the packet size, and then
return TC_ACT_REDIRECT; thus being able to use the redirect ifindex
for mtu checks in the packet mutation functions is potentially buggy,
since there's no guarantee you won't call bpf_redirect again to change
the ifinidex, or even return from the bpf program without returning
TC_ACT_REDIRECT --- so while that could be *more* correct, it would
still have holes...)
