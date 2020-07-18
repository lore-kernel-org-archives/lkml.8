Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE7DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D24820775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595094243;
	bh=uN52bz2TnOuj9TlKoB6pj/zQGShG9ZdyGjDoFj5YftM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2JbChZEvFT/6ru61vRqYDk0K9jQwoLlwj1GKVT8ARMiOKOBpWoooRh3XtLEkCnodt
	 ypefQQtKXrgHhoujz3LDYUpkKHBT0QfEfTpq4maO3wAaX6Dl2SpfY5T7266wRoKTA0
	 e1Yn7ZAkaEMz0toQCqQ8jLDfR9omBdVDexa0Idac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGRRmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:42:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5467C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:42:48 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b30so5428772lfj.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiY4+QiT/AY/Z/a8K8W0oYps875PzAtQx8Asj6Q1aPg=;
        b=FM+3ch1bDzhsiXNk+T+LOrHD4qkMShboABLic2xzn+DKHMi9Cgt2kWfMijpega0ALy
         JQOhddwsoTpnDE/eexxgbiNkVKH9MQ+fSTpjlS2vysSTAT+7EO9kqxZg+1gtIEYIjgfu
         Yt2hjqDc5MP/2HjiXc67Jpa/06la4Hw8kgZiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiY4+QiT/AY/Z/a8K8W0oYps875PzAtQx8Asj6Q1aPg=;
        b=DgsYhZILvLuIQzEMc2yBdi9W+jY2n0m+Sna2lJiQiUdsUg1ZHZszQhL0DmUffNLw/J
         ThpdyxaC5gQeaV49PEmL6uGxxvmbDgUCUqtq3QaiqfqDAwcurAxwe82X04bgz56p8PoW
         6rusyZkLIqiNw3b48HJyEbhOgUIFoTw7+/jblkQv1oJfrjTQhiR0TlZU6p43cw81zjOE
         WZD9ZBIcGqTwWG0P4+ly6LzVJSg9SNAX1X9hoIs3DkZkCLzyQHJ6usUZtbTzjGO0gtp8
         Ywcd/Vsj8PjU44hN9fvmKC1XbjXzXbQvcOaA7F5G+0IZgx6UaTgchSjP6YU9HI44oGxN
         8UQA==
X-Gm-Message-State: AOAM531n4I8OxVIehXk/1g/nXzrInt3zoX2osjVngucY+YBQW9hyGnhs
        hzqd8S/AT1MnpwRJ13TkfFTXpUMfCvU=
X-Google-Smtp-Source: ABdhPJzXqXMRI4SKqOB+O98Len/0QycmrwaA2/r4OzxFBXPIpN6ug2VlSDP+P6krqPICWJlG9DxtdQ==
X-Received: by 2002:a19:228a:: with SMTP id i132mr5894610lfi.178.1595094166479;
        Sat, 18 Jul 2020 10:42:46 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id h26sm2293263ljb.78.2020.07.18.10.42.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 10:42:45 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id o4so7730012lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:42:44 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr6995326lfl.152.1595094164495;
 Sat, 18 Jul 2020 10:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com> <87blkcanps.fsf@jogness.linutronix.de>
In-Reply-To: <87blkcanps.fsf@jogness.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Jul 2020 10:42:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX9Q+en5j8EmYkhxEx8H0EzHhx5WqPGui7KNiV7=ZK-w@mail.gmail.com>
Message-ID: <CAHk-=wgX9Q+en5j8EmYkhxEx8H0EzHhx5WqPGui7KNiV7=ZK-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 7:43 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> I expect this is handled correctly since the reader is not given any
> parts until a full line is ready, but I will put more focus on testing
> this to make sure.

Yeah, the patches looked fine, but I only scanned them, and just
wanted to make sure.

Over the years, we've gotten printk wrong so many times that I get a
bit paranoid. Things can look fine on the screen, but then have odd
line breaks in the logs. Or vice versa. Or work fine on some machine,
but consistently show some race on another.

And some of the more complex features are hardly ever actually used -
I'm not sure the optional message context (aka dictionary) is ever
actually used.

Yes, all the "dev_printk()" helpers fill it in with the device
information (create_syslog_header()), and you _can_ use them if you
know about them (ie

    journalctl -b _KERNEL_SUBSYSTEM=pci_bus

but I sometimes wonder how many people use all this complexity. And
how many people even know about it..)

So there are hidden things in there that can easily break *subtly* and
then take ages for people to notice, because while some are very
obvious indeed ("why is my module list message broken up into a
hundred lines?") others might be things people aren't even aware of.

Maybe a lot of system tools use those kernel dictionaries. Maybe it
would break immediately. I just sometimes wonder...

                 Linus
