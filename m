Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FFC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1A0206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMm4fcG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgC1MC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:02:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52692 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgC1MC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:02:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id z18so14437646wmk.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TOXUkQN2027AZH96CjlVUs+n2JwB3/4ogugbaHuDQRI=;
        b=tMm4fcG6OmC/yLdufkbKVhFa4BHp2ko5EeZc5etiSWBUXg1sjIDbfnkrXByRjo440C
         xjuiaJCEwq0fbKImyopOKdR7Rmw7xz+tZJgyxTxIRNBdwKCQotJhP0InJVI1Ez3FCE+z
         GZczKoTZTh4IPSmD+Uc1bKOaPmbfK+TpdzNm+nzg1mOUfJlXwqN8GZOYBtKgMoHvaVbi
         /0hCOuoUoG9u2SUmzxtCKEhaudVag19+XozepaVd6YMz+/DxWSPqiU5po/c9wS6KM64M
         D+FyYxr7Dv1YLRv7Ldi7hedRLqEjq0wApo2lf8rggnov1qW6UVn13xP0MQvc9qBlQ77b
         SS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TOXUkQN2027AZH96CjlVUs+n2JwB3/4ogugbaHuDQRI=;
        b=Wk8mXJrVdVUcD2B2VSMBF+ipi4mbXymiLdCZQ2FAb70BYfMAnzGzaBzsy5DyxPZCzw
         9yxmKFzlsmKKSkMxHsidzLnGCIBzqcKp0RtpOP7gA45jC2Ux1dir9ltBPTqwaY8B3svB
         0Tppt1FHDtoVOGLJjB9jhul98ll1Ynkup9V29h98Xri3Y8EW8Q59bHDHjOGBabHOtVZh
         Uxi1E+0rVUnQ60UlwyjdHNFE1jRmwCcDdn1qM8IJx5jxhDnTJ28u3BxCBc2NIbYLEQVS
         pXIs8hxBSGLUgwb+silB+w0fKB+n2vIe+bchvAg3zOGBIm325lBJ65LCcbGm70lu1NXB
         vDfw==
X-Gm-Message-State: ANhLgQ2v4xCigCgaBpNefixWRo0aGQsRl7omdf53RPuKHxzLSgVy25lT
        I/4kezon5AGihFQg3hJ7xQ==
X-Google-Smtp-Source: ADFU+vslspF6nrqP4/Qny7bMI+Wj2zR+IZxBuNtvca0SvME/5Fm3PhVf+4a77tDcfxVBkRV+7MIVvw==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr3406345wma.36.1585396946378;
        Sat, 28 Mar 2020 05:02:26 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id l12sm12439504wrt.73.2020.03.28.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:02:25 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahost.lan>
Date:   Sat, 28 Mar 2020 12:02:14 +0000 (GMT)
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr,
        boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] locking/rtmutex: Remove Comparison to bool
In-Reply-To: <87y2rkwwf5.fsf@nanos.tec.linutronix.de>
Message-ID: <alpine.LNX.2.21.1.2003281201270.20453@ninjahost.lan>
References: <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-2-jbi.octave@gmail.com> <87y2rkwwf5.fsf@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21.1 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Mar 2020, Thomas Gleixner wrote:

> Jules Irenge <jbi.octave@gmail.com> writes:
> 
> > From: Jules Irenge <jbi.octave@example.com>
> >
> > Coccinelle reports a warning inside rt_mutex_slowunlock()
> >
> > WARNING: Comparison to bool
> >
> > To fix this, the comparison to bool is removed
> > This not only fixes the issue but also removes the unnecessary comparison.
> >
> > Remove comparison to bool
> 
> So you explain 3 times in different ways that the comparison to bool is
> removed. What's the point?
> 
> Thanks,
> 
>         tglx
> 
> 
> 
Thanks for the feedback I take good note. I will improve next time.
