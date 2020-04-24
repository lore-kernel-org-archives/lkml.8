Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA757C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA732168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="D1hEvZmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDXVv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:51:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E07C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:51:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so8489952edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQNey5J4m05taFWia4GD1NrRrq+YSdJb5hG7zAcllAA=;
        b=D1hEvZmEJ/MQA6Qze+6lehHqnQctIkcGh44n20m+tUpuRwndmDJ7PmZ9GbIzK+QO+X
         OH+W44KItPKhT5yezZvJwxSqBNhW4TQ1eIWrrLt58meBviIJ38g91QOdkrkMTVEkOUr/
         J4pcY2AkURqqGi3kYaHwuqyxoOZFA5I/iCeaCHUYcK8wNBQ/idjUBrfRyhocOq5hFgp+
         Nzk1m167MLSQRaax7FX5LvHk3BpWVWLLadAaUuD0XDIlBW73c7J9z1ldALeKmoeZQO26
         XG0Onofzngx5u60znXIsm7PWr7O3rmwi9nICCcr9FV81TKHL1VdcNG1v940lgu4I98mh
         gNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQNey5J4m05taFWia4GD1NrRrq+YSdJb5hG7zAcllAA=;
        b=lssWr0lUgyWwlQMVD4+l/npTP0Kk4afFYLocJQK6ZWKDpejOteLWPZfYuTOsjML6lO
         4cxhxkuUWMrc16HgHuLIbQweN/HNHNDzvtLUh/ZOA3yriVvErk9MvcAOIoKLGk9dL/bg
         I8T8de6I0JGQmdq3VbeqAT9fMXMb1kOnAVvPZ0rSV7fUfsBegElldff0QW8vMnPjwKPV
         X52fry+HmXv+uq1WYnf9fHitC7A7NdSHYd7MS3t8vGIAWQttGSiARrTIvatpUddJqTEY
         6NTJL5n8y6Hf0ZL04x6c9+dZh+C56nVaFq4WDY0u55WLQNu0vY4uShxohxU1ozbTkGtR
         ddNA==
X-Gm-Message-State: AGi0PuZSCc9B1wjZMGLrdavGdQbBeUkeKwgdn4TMXSZvV4Hdss0yjCDi
        eTWh1Zc4sIh3OnkO8lE20B9nefVPK7K92MUIpjux
X-Google-Smtp-Source: APiQypLRHoOQqlS+eTiXjiKNm2Vnp4dQTSNZByKUDEO/mfLCT00jY8KrZIOPwayS/VFghWwtEWH+81952BYl3oY4skI=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr8787931edj.196.1587765114174;
 Fri, 24 Apr 2020 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
In-Reply-To: <CACT4Y+YTi4JCFRqOB9rgA22S+6xxTo87X41hj6Tdfro8K3ef7g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Apr 2020 17:51:42 -0400
Message-ID: <CAHC9VhQs6eJpX4oMrhBiDap-HhEsBBgmYWEou=ZH60YiA__T7w@mail.gmail.com>
Subject: Re: selinux_netlink_send changes program behavior
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 4:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> Hi SELinux maintainers,
>
> We've hit a case where a developer wasn't able to reproduce a kernel
> bug, it turned out to be a difference in behavior between SELinux and
> non-SELinux kernels.
> Condensed version: a program does sendmmsg on netlink socket with 2
> mmsghdr's, first is completely empty/zeros, second contains some
> actual payload. Without SELinux the first mmsghdr is treated as no-op
> and the kernel processes the second one (triggers bug). However the
> SELinux hook does:
>
> static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
> {
>     if (skb->len < NLMSG_HDRLEN) {
>         err = -EINVAL;
>         goto out;
>     }
>
> and fails processing on the first empty mmsghdr (does not happen
> without SELinux).
>
> Is this difference in behavior intentional/acceptable/should be fixed?

From a practical perspective, SELinux is always going to need to do a
length check as it needs to peek into the netlink message header for
the message type so it can map that to the associated SELinux
permissions.  So in that sense, the behavior is intentional and
desired; however from a bug-for-bug compatibility perspective ... not
so much.

Ultimately, my it's-Friday-and-it's-been-a-long-week-ending-in-a-long-day
thought is that this was a buggy operation to begin with and the bug
was just caught in different parts of the kernel, depending on how it
was configured.  It may not be ideal, but I can think of worse things
(and arguably SELinux is doing the Right Thing).

-- 
paul moore
www.paul-moore.com
