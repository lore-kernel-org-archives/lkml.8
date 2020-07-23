Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A9220709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGzWAHNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgGWOML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGWOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:12:10 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE6CC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:12:10 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id w1so1135340ooj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYds3Nco1psIbFhxscSbi5hgJh8BjumXm2M9T6KAWQM=;
        b=AGzWAHNpaimo3sPQx/8NtCk0U0hKvSJMPiU2ONe6dgO+wiQunz4CKjUA//5cAVVjYG
         jJlwmT4WVOzgrxS+HuHVU0IIFXDnkHlLzBNaxMmYTr02HD+ajOcF2Qpsn6kzGo7M9dwN
         6+PcwiZNcNzSV9fJD/r/mCwR5ERf17J+87FW12kyg6NbhHkxI262lrPlBTCStTUKfy+M
         AJD9XbqxHZj92W2AH3So2qmRGoixRa/dg0OSMdI6nEcZczUZhG1sK55WPTVLTMTbbJvw
         +mITnPUnog5V/8e+DZIWDsKN30AK6BcH2zjfF9EDRzDe02GA5zpGhhzyG0tYINwkQAk6
         TLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYds3Nco1psIbFhxscSbi5hgJh8BjumXm2M9T6KAWQM=;
        b=YnkH+Xg8jfvW391qiOjY9y0qSYyTGqWKcRa0RrNtYQA5L/sv5qmKGncOO3KoGhBofn
         /ZCHmFhgKIyO6FLsiVChvAWUkJEpqLQzdxYLxVH90raoOwZjw97a0dAZ80ZRT1DNSzRa
         E3N6PDgK7W7NJRd8ixilLKMblanxI4R71p+sEmk+OtUZn1FTrsJZG2cFQseTvaedVkiz
         I4Psdi6Ljdt5aApJWCC8GsnizJGf0E3E1hJ/j1I16Yj1ESmrUb7R70fSlKkvraN/W0mQ
         yfu1QVPDQVD+d2fh4YOqDqTJ6oM2Bl6NFZAHYLQjvkMK6NbPB5Mqh8nURTnvCakH48OV
         4CnQ==
X-Gm-Message-State: AOAM533GuR1uF8HLxTAdJ+FiEcX7WFVEiiXNeBmCkZxEHA5U0OipEQJj
        SYKp0F2YbvuuIxAinG41B1b6v89MBtHcxwOd8aY=
X-Google-Smtp-Source: ABdhPJx/eCa/cCkHFK4V7yMOs9HWmf3XPR+0/9I8VV7VAy+217aZBKqr8yOOSwln4XDNgOaFCk739p6JLnOpwvfQOu4=
X-Received: by 2002:a4a:d4d9:: with SMTP id r25mr4653363oos.51.1595513530264;
 Thu, 23 Jul 2020 07:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <1595480041-10597-1-git-send-email-qianjun.kernel@gmail.com> <87d04mxs9t.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d04mxs9t.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Thu, 23 Jul 2020 22:11:59 +0800
Message-ID: <CAKc596LwF3UNrasZcm46wQX8JSEht4oxx+sDqRKfSkM3Ld0Fjw@mail.gmail.com>
Subject: Re: [PATCH V3] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 9:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> qianjun.kernel@gmail.com writes:
> > From: jun qian <qianjun.kernel@gmail.com>
> > +             /*
> > +              * the softirq's action has been running for too much time
> > +              * so it may need to wakeup the ksoftirqd
> > +              */
> > +             if (need_resched() && ktime_get() > end)
> > +                     break;
>
> As per my reply on V2 this is leaking non handled pending bits. If you
> do a V4, can you please use sched_clock() instead of ktime_get()?
>
The reason why the non handled pending bits leaked is
set_softirq_pending(0) called in the start, if the
loop is broken, the not handled bit will leak. This is my
understanding, I am not sure if it is correct or not.
Looking forward to your reply.

Thank you so much.

> Thanks,
>
>         tglx
