Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FD520768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="srxxOCIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgF3Uar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgF3Uaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:30:46 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:30:45 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h39so10749803ybj.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hbndbL/42Lj3+0S0TLvtcAj80v30sW3yhJRu17Ph6zg=;
        b=srxxOCIJovcrNRpTPb+vPoi7ULhN9VgUvdErE5TP3DfGhwyIFPB5X6g/ztxdOGr8Us
         cpjIkRDzkeH2jZw3D/wftckIEerLd5rUdvtUl/8LL7o4CvGcZbSKsdi+WaWM/qnxhKCd
         boIWgG2TNdAWNBWCHz2xUim+xon2BGB9X2PErs/zMBI/HKpUPXRX84z8HRxjpZoFyw7A
         GRglbCa0bCmzMh4akDcfXLnK7oVF8/P6yxO8QApOOeMLhhaF9eUr5Q3XjeEze4ATPnqG
         ikdD5qaYLJKTBX9M7QaAARpIER+Zh5xgTueSnTdX8NYLpWJN3CQq0kE8IPbrNVGNSHgn
         da3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hbndbL/42Lj3+0S0TLvtcAj80v30sW3yhJRu17Ph6zg=;
        b=pKRJbVB8KGQmUdVOsCqIxszytcr32SK3Z94buzdpQfFzoPQZQ6f7MvmjFQyndBCLcB
         Yp6bgfe2yZ+AIcbHHrwAOMMbWOETGda4UYQ8k01o0xMETsX2ZJol3+eR34BC7iN2WRza
         gBpayW5R9WvGmamXOJEmjSknujY9oN+/V+Gofy3X0jWt8gpgYRvp/pqDy+B7iUY9+dH2
         szQQTwQGyBq0IrxG/0xBHZQ9GWERDijdHzsr1vzuKt1FjF6784N1gQYcvu4T/cx354nV
         wdryjUPRVHh6N8Sfy9hwu2LkVzoniSfQqZm7RxE2iw+Jb62KbpdInfrmRoiDl0ZUmzIC
         vL/Q==
X-Gm-Message-State: AOAM530Zq5ZGC56jYlcFm0GA/gBRaidtE33g/9VhWXJ97682y5FK3NCQ
        8mY4BIHweVE+woIovLsR30mCAGGDEW1skOfgcayY1Q==
X-Google-Smtp-Source: ABdhPJxNvCwjAE5cOI2IQkuy3+eSCuJzg/Oj6+537Ld+qP6KKGMKhW1Nd2SL7YrZZVP+Kg19OaW36nzhlXVEm+D0/5s=
X-Received: by 2002:a25:81c2:: with SMTP id n2mr14190731ybm.520.1593549044541;
 Tue, 30 Jun 2020 13:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <1132973300.15954.1593459836756.JavaMail.zimbra@efficios.com>
 <CANn89iJ4nh6VRsMt_rh_YwC-pn=hBqsP-LD9ykeRTnDC-P5iog@mail.gmail.com>
 <CAHk-=wh=CEzD+xevqpJnOJ9w72=bEMjDNmKdovoR5GnESJBdqA@mail.gmail.com> <20200630.132112.1161418939084868350.davem@davemloft.net>
In-Reply-To: <20200630.132112.1161418939084868350.davem@davemloft.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 Jun 2020 13:30:33 -0700
Message-ID: <CANn89iKUUJsEfwp2L0pwKdCP3Rx-o=6uM+1bUhT5Cc2p0p7XqA@mail.gmail.com>
Subject: Re: [regression] TCP_MD5SIG on established sockets
To:     David Miller <davem@davemloft.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Jonathan Rajotte-Julien <joraj@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 1:21 PM David Miller <davem@davemloft.net> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 30 Jun 2020 12:43:21 -0700
>
> > If you're not willing to do the work to fix it, I will revert that
> > commit.
>
> Please let me handle this situation instead of making threats, this
> just got reported.
>
> Thank you.
>

Also keep in mind the commit fixed a security issue, since we were
sending on the wire
garbage bytes from the kernel.

We can not simply revert it and hope for the best.

I find quite alarming vendors still use TCP MD5 "for security
reasons", but none of them have contributed to it in linux kernel
since 2018
(Time of the 'buggy patch')
