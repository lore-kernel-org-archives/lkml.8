Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40BDC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B269620714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="re/SlJNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgDATe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:34:59 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:38053 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732148AbgDATe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:34:59 -0400
Received: by mail-lf1-f41.google.com with SMTP id c5so720527lfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4k3vO/gmHNH9BUyuJdIiMLOYo/c54ufu3YUkaQPTZh0=;
        b=re/SlJNSwxj4p7FegGdRYaiRGHLXkQdVNLPVVld1YPr2vq1CxKdQn3AovLURrdbajn
         3Xo6b8vWorZ6qc+3hhX90ygDdQ95BBHcEpgZnx2YMbAbz5zp0UO5tDrBC09IV0Rz0AQZ
         mHZhB0f7sc10ksckpD7nlQp53AvGIdEHvhacVwZjkNxIQMn72xmomeUMQrrZtpmwlLob
         chVEzDTJ1uY9xDFRk4n3MOdVtR/MREJq1jjenkZl2XQfjkavvMyNIv34TYyipOR+TWl8
         EoevKS+PUTr6mOau0aAQqzcNLxYILGS/uuB+QHlBCvZiTRGPfgIPLXxw3wufoeWYLpT1
         SKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4k3vO/gmHNH9BUyuJdIiMLOYo/c54ufu3YUkaQPTZh0=;
        b=JLjQiLMz7rz3VpP+sxmcNvHIplpjNQVLTI7W1fJtYNMJ9VdaznFTeGVsNoLaqYfH99
         ScuFljbJio2U4AACvAxzAYBrCkr0zL7q7TrXazmvsov4YJX76tAgkQ4CpXFJV1aGXElN
         fCcm0dd9QeJ1KNHddbNn6R98gsZahZFrTfZrC/HgjMIHiuWUW0CT1NZDsai+DfC48TQ0
         w+qM3r/+d/GO4zjRrWbJBer670sxZ8LEVxZfUl8UeU8eHBDdnihJfm3adZejVz9CJBzD
         gAPPQGiJ3BaD2cgH3ozAysBt5Nu4QTr6EpxFt5wiVeemfSR48n9NG1hosC0BWO0zrJ/x
         LnOg==
X-Gm-Message-State: AGi0PuaSEdpWOEK2xp+1PtSDTTzeW0YI7n90oncXDgMFHmi8td4UVjg9
        3blN3iC5bAALzpYChvtG5Sk++1tVV8eBjEhfX27dpb6X
X-Google-Smtp-Source: APiQypJ8XJQCJ4boN+oW9h87APr/SKiu3bMdgxZnNdJDZgjwA8jABTpUka1Eb6Qy0WwSq0am9RhCXWirrwmjQrFSe14=
X-Received: by 2002:a19:6e47:: with SMTP id q7mr12252555lfk.164.1585769696172;
 Wed, 01 Apr 2020 12:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 1 Apr 2020 21:34:29 +0200
Message-ID: <CAG48ez3iiN6Y77F_7Rdba6_obhAMaTQ+M0YfGMV2Fk762-5PZg@mail.gmail.com>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 12:30 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
> printk_deferred(), similarly to printk_safe/printk_nmi,
> does not immediately attempt to print a new message on
> the consoles, avoiding calls into non-reentrant kernel
> paths, e.g. scheduler or timekeeping, which potentially
> can deadlock the system. Those printk() flavors, instead,
> rely on per-CPU flush irq_work to print messages from
> safer contexts. For same reasons (recursive scheduler or
> timekeeping calls) printk() uses per-CPU irq_work in
> order to wake up user space syslog/kmsg readers.
>
> However, only printk_safe/printk_nmi do make sure that
> per-CPU areas have been initialised and that it's safe
> to modify per-CPU irq_work. This means that, for instance,
> should printk_deferred() be invoked "too early", that
> is before per-CPU areas are initialised, printk_deferred()
> will perform illegal per-CPU access.
>
> Lech Perczak [0] reports that after commit 1b710b1b10ef
> ("char/random: silence a lockdep splat with printk()")
> user-space syslog/kmsg readers are not able to read new
> kernel messages. The reason is printk_deferred() being
> called too early (as was pointed out by Petr and John).
>
> Fix printk_deferred() and do not queue per-CPU irq_work
> before per-CPU areas are initialized.

I ran into the same issue during some development work, and Sergey
directed me to this patch. It fixes the problem for me. Thanks!

Tested-by: Jann Horn <jannh@google.com>
