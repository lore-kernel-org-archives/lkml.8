Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00994C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BFF206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExvPVrKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGGL1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgGGL1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:27:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F68C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:27:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t27so30685521ill.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVUqdWsTuNLDkxLHBnZzusCTDe8EzV8pEJapqN+ipHQ=;
        b=ExvPVrKc+zzmTf71n6cofGIeFau1D3ip28mvBy3ghohZ/7u5P4DzLQjE1Zb8qGcSnY
         EQ2kMJbh9sljFy5ZWEK5kgoV2BIuG5Y/IADoPNu1zD6Vlmg0TtNK5V69Zb8lQZ9UVzIu
         YcOyJSxv0hqQYoGqwKIM8YUeb5QUnSOnU6NzNxqwCXnw8oRA1+Oa8TyqZEvUiljiWKO1
         umxyRulIcz+Zhe0oJ8kyhtPaaT++bbtomYbrPmI/fbsNmOQ7x5xBYSW0Q9puKRYFO/FF
         AxrGUJ+AbicuNUCC8rUTFKs3BtsstKJerxcizWsSCwnwoWDhkZbwtblR1S52tg42DR85
         Lung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVUqdWsTuNLDkxLHBnZzusCTDe8EzV8pEJapqN+ipHQ=;
        b=TKKCwzf4QqwG94UkQHrypaHYf9TLt9qX8PifRjJvSAIqN+e1JQIcUMlwrGKeF5Xz9J
         IwrnSPXjf/Qz7DW54TBrsT19vpxMMeT7CZT1gqGdPgNOLDSvEFP8vAL2939lJlWS6xp+
         Jz3gy3TPEmq1r7Dfvnucf1BR6rFCJTLzeeuAJeaL8cZQ/4BKr+4ah7IcZA7IYKD+TZWP
         +BwvstVTfevHLxBU4pebrle7OHx1YbPUEdTkd7KxSCFuGQSTvzO10hpPrmZP2M2T4ghA
         Tv3BGsvfbulQe91b9ATaHhLIMUdlJM4NTHohihcWp109fsguqIcmbWafY7bLrsryzllY
         L0dw==
X-Gm-Message-State: AOAM530W7bgQDLH0dBs18o1tpQ7wsh4E8Lis+l0Jv42ulS92maNZx0D3
        REEOgnW/gYf3aMeBqk9LNVf8plLaCD+AQHOYGI/Ix5xr
X-Google-Smtp-Source: ABdhPJwno6zEi89UhsAhQY5E5gKnOHioVjOqUI8423vztIL4dUcYrHmelA174V9A/uNpzrmjQOK/z19kGnhigS8ibio=
X-Received: by 2002:a92:d9c4:: with SMTP id n4mr18264119ilq.280.1594121257015;
 Tue, 07 Jul 2020 04:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200611135920.240551-1-stamatis.iliass@gmail.com> <20200612092958.GD4311@linux-b0ei>
In-Reply-To: <20200612092958.GD4311@linux-b0ei>
From:   Ilias Stamatis <stamatis.iliass@gmail.com>
Date:   Tue, 7 Jul 2020 13:27:00 +0200
Message-ID: <CAAfjAQPGoTdc6Db1wAqDdf9-WRGAutFrX7ObGcZPNPexudnivQ@mail.gmail.com>
Subject: Re: [PATCH] kthread: remove incorrect comment in kthread_create_on_cpu()
To:     Petr Mladek <pmladek@suse.com>
Cc:     tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 11:30 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2020-06-11 16:59:21, Ilias Stamatis wrote:
> > Originally kthread_create_on_cpu() parked and woke up the new thread.
> > However, since commit a65d40961dc7 ("kthread/smpboot: do not park in
> > kthread_create_on_cpu()") this is no longer the case. This patch removes
> > the comment that has been left behind and is now incorrect / stale.
> >
> > Signed-off-by: Ilias Stamatis <stamatis.iliass@gmail.com>
>
> Good catch!
>
> Fixes: a65d40961dc7 ("kthread/smpboot: do not park in kthread_create_on_cpu()")
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Best Regards,
> Petr

Hi,

Thanks for the review!

Will somebody pick this up from the list for merging or should I
forward it somewhere else?

I'm new so I'm not sure exactly how the process works.

Best,
Ilias
