Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DFEC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7416E21739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537827;
	bh=Zf7NBUAek1yLzN1x6/9lISUJiqE/o1AkQy75wlqY+I0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kw1Rj+lKctaCoRLmrrTaFBUgS/7UEG9vMDXVgeuhRjTYqpq1awS4SsC16BL0K+/22
	 p/J5mLdpuCz5Pp48GDlYTmi6H9Ci8LcZrPJ3iGmT+GhWS/bvC7FjMsCSg4CjT97Zqu
	 bDU724o28LpP3bD0IQJhuWl8MAHRG+iBZSa5hjmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgBLUDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:03:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39962 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLUDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:03:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id c23so2505043lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPPHdbNaIkwiUwi0XK7V81BmqTqsxD9Wh/eCAuOFZ7c=;
        b=edEbWD8VWSEo0ZJ6AJhYjMiocwqPWZuh1eMEPANkqs/U4/0xnwRt7xq+7HnenPiGeJ
         VFphHJXoMrc/FwJ+qGT7Ukw5K8rPi428h9mf6Q5VDFjXFC52E+csZrxYeIflstJkvyxz
         55c6XXfz4qcfrKgrhUQu/+BijxMyjycSx/JE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPPHdbNaIkwiUwi0XK7V81BmqTqsxD9Wh/eCAuOFZ7c=;
        b=WYKAS3TMw8ktB7ZldVI9NP3am0LjMD8ROXiax5fLlKflRVP69P51tpe1Nqg6kCcp5x
         13GEj8W+F4FLEtIKusOwtmK1qu85jywqAgsdvEqKnds6fCftRz9cA8QxEYqrTF9ySzdi
         5deRnSi0O5Yj3gTfRcOO0w/ZAG+/Mr2/zVaseHyMfCi/Kc9lmzeKv+Fi530gtvhg9cMc
         NK01WcEbkasSGbbp202XpJMZiTGOhLIfOtDaxbKnBMkI45KSmittbZgbZ54CCJx8CT9L
         kB/o94Wkcs3oqUN8QreOCnYl9+w8p9RKGrKD5jOG2qtt6PohpPnoveVm+OeDJrJcF1Hy
         8LHA==
X-Gm-Message-State: APjAAAXi7IcgFdb6l3DwQyWEXvI+MiNu74s+h71AnR9KIGdyQiabnRZu
        Ini2pwTDet2+bC261cieLMy1YU9m7To=
X-Google-Smtp-Source: APXvYqx2ADEwD/Xh1Y2Ww/lpQ7t9cQfjl6n3jCgyzd3/ZjXQBsZIcio8b07nTcTjdhCMQOldIcQ9ng==
X-Received: by 2002:ac2:52a5:: with SMTP id r5mr7470050lfm.19.1581537824190;
        Wed, 12 Feb 2020 12:03:44 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f16sm104445ljn.17.2020.02.12.12.03.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:03:43 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id y6so3823164lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:03:43 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr8860316ljk.201.1581537822998;
 Wed, 12 Feb 2020 12:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20200208083604.GA86051@localhost>
In-Reply-To: <20200208083604.GA86051@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 12:03:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdiabQ0dqVDJ0_5dfur7f2D5oESCjv34f4svrK3RJj=w@mail.gmail.com>
Message-ID: <CAHk-=whdiabQ0dqVDJ0_5dfur7f2D5oESCjv34f4svrK3RJj=w@mail.gmail.com>
Subject: Re: Applying pipe fix this merge window?
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 12:36 AM Josh Triplett <josh@joshtriplett.org> wrote:
>
> I've been hammering on your pipe fix patch (switching to exclusive wait
> queues) for a month or so, on several different systems, and I've run
> into no issues with it. The patch *substantially* improves parallel
> build times on large (~100 CPU) systems, both with parallel make and
> with other things that use make's pipe-based jobserver.

Hmm. I just applied the doc fix that Randy sent, and that made me
revisit this commit and the commit message.

And I realized that I find it surprising that it makes your build
times noticeably better.

Yes, I have that silly example program to show the issue in the commit
message, and yes, the exclusive directed write->read wakeups should
most definitely improve by that commit.

But the make jobserver code ends up using "poll()/pselect()" and
non-blocking reads, because of how it handles the child death signals.

Which means that none of the nice exclusive directed write->read
wakeups should even trigger in the first place, because the readers
never block, and he poll/pselect code doesn't use exclusive wakeups
(because it can't - it doesn't actually consume the data).

So I was looking at it, and going "it should actually not help GNU
jobserver at all" in the fixed jobserver case.

So humor me, Josh - can you try to figure out why your numbers changed
for this commit?

                Linus
