Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B0C0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D8F20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kvfshzNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgCQAHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:07:10 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40890 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732932AbgCQAHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:07:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id m25so3842781vsa.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ntKJKBz3QZaW3upO5B77khaQdlJEtk26+mdI0qKPpo=;
        b=kvfshzNlH4GhDvSk8suwxv4rlbjov+ouHN1bXNvo95mWddKa0+ZXU5p0pE7LcZYAtx
         APOIogl/EVUTjvKtNAnnqgOiQkejh6bPINWYeNJOxzGqyE5hBBmXW4sRVFeitovagUDP
         r2O8J+vfLmAudOUh4T7Q9Kpg8ykyjwsrcshUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ntKJKBz3QZaW3upO5B77khaQdlJEtk26+mdI0qKPpo=;
        b=bAHepv/NPu373h7bCCqPbh8sILUbgX2EjLEmRC72QsGXNaF86ijP9ntemyc4anED0p
         vXMxyqMYzDPZkms8WSSlQzmuzD9qcmmJcZ/tQO2b+f753sM5fPn5yaSVxvmvxe1WQeQm
         E9mDpqhwJCYnYRNyXQTZmvcQRybev1oEIKWJuxESWJCDoXF+nNKiZEC7MMnn+Z22LKrd
         mq/JcPZ5Wpv3WC73yWh9aowV4oQAicv4ARmoJM0ynNF0R1kMTYfjrJwSPCIdMYc9+Qh+
         +73Tkc6Lco7txw70j5TNinRHoApXpjGjnP6DrtNTwFoxGH3bP9WCHjGH01BhMPubh+Lm
         MEAA==
X-Gm-Message-State: ANhLgQ0whlXZqAao0kNgooAVrHN+cIqolKtLjYN2eHTJHEmgtfQ8NNeY
        w9TgX7egCP5FLnkT1f9dK0js51owrxc=
X-Google-Smtp-Source: ADFU+vuuAzM04Z5dEciC4PJVIRpk5bwGAzxTGK6xi4489ToxIaEB+q46oRt3zW6zhJgN+9lJNJVgmg==
X-Received: by 2002:a67:fa14:: with SMTP id i20mr1719377vsq.196.1584403628219;
        Mon, 16 Mar 2020 17:07:08 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id r193sm580727vke.19.2020.03.16.17.07.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 17:07:07 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id i7so7009894uap.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 17:07:06 -0700 (PDT)
X-Received: by 2002:ab0:2e91:: with SMTP id f17mr1804155uaa.22.1584403626259;
 Mon, 16 Mar 2020 17:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200316143916.195608-1-dima@arista.com> <20200316143916.195608-48-dima@arista.com>
In-Reply-To: <20200316143916.195608-48-dima@arista.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Mar 2020 17:06:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Ourc0gbVnq_eQqyxDn05uV3NT2raEAKSohrN5qrwgQ@mail.gmail.com>
Message-ID: <CAD=FV=X4Ourc0gbVnq_eQqyxDn05uV3NT2raEAKSohrN5qrwgQ@mail.gmail.com>
Subject: Re: [PATCHv2 47/50] kdb: Don't play with console_loglevel
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 16, 2020 at 7:43 AM Dmitry Safonov <dima@arista.com> wrote:
>
> Print the stack trace with KERN_EMERG - it should be always visible.
>
> Playing with console_loglevel is a bad idea as there may be more
> messages printed than wanted. Also the stack trace might be not printed
> at all if printk() was deferred and console_loglevel was raised back
> before the trace got flushed.
>
> Unfortunately, after rebasing on commit 2277b492582d ("kdb: Fix stack
> crawling on 'running' CPUs that aren't the master"), kdb_show_stack()
> uses now kdb_dump_stack_on_cpu(), which for now won't be converted as it
> uses dump_stack() instead of show_stack().
>
> Convert for now the branch that uses show_stack() and remove
> console_loglevel exercise from that case.
>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  kernel/debug/kdb/kdb_bt.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Presuming that the rest of this series is deemed acceptable by those
in charge, this patch looks fine to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
