Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE48C4724C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEE1206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="a0S0kA9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEECw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgEECw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:52:58 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CFFC061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 19:52:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g16so649492eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMU1wxJ+dnVELY0Vj9LZGymqmoTbYEedDYWggp3ssbI=;
        b=a0S0kA9vDqkd/KBK9Nrd68X7fBPEVuDkl2QHDHabGDslYUIWSdf15zNjU/7q3eTszU
         bTOFC95V16RH7dayICVc/notK3CG1QqAdOXhxjHLUw8WRwLnplvhZi3svQilkG58+Auv
         vPGNGzuP9lupEqTxyTxA8UAEZCEtWkGXFy+GZT98K/fINMY0NXAi/wGJ0roC3FyaMw2h
         B9caPjHrbHKokSEjJ9M1OD4aVHjXuIFOD2C61ytdvrXUjB2yabQvxYe7ZzTHlBttfTNw
         uaxtt+LoV7V2xBnpDtOg+9i3U8o4WB8ITdO/05EKegYYr6r1Inm6i+YJO8HId5Q23uka
         Louw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dMU1wxJ+dnVELY0Vj9LZGymqmoTbYEedDYWggp3ssbI=;
        b=eAnWzyTMeayT+N5dLzbcaKdnv2pjg0P6OSaF/3j1ifqWrw5NP/wgg4rZsiTS3qeLM4
         JFpCPy8SNVsFZrkDldJ018L5VcYwGLoQSFWcbfY47Ey5UeS85UpgRFTeb+uOpkaHj+/o
         hOPYe0b2eCi3xClnldFfch1sw9YLEdqQzav3ov+FrWzy+pjzYtpS2A15uy4/X9xarxkK
         tgBPP0EDjGFbVlntJH8DMRqjc8f6PQXlD8rjc/LS1z7t+y8F8Gf/rGF3ef2N0fxOHZ7L
         PJwmt3yJAKNRTMzRGt6zlCp+8Gs4+oD2BdjQqopmg5JBm01uMiFoMeap26TSdOZqhRsY
         fB+g==
X-Gm-Message-State: AGi0PubBH+bb6+5Un8xeMEsYdBrkTGqxmFGTNrpolTXMUdDc1pn2Dl9u
        vQRBzLoyBj3npXZlKK1r45R1e0smBD3TUGqFOlVLCw==
X-Google-Smtp-Source: APiQypI70HQ6rJlXhJIrNa7de/phjKZm4m0Fc8L/5us4SY1j+hfoFUkavwYutpJe6gaYdvKbrLXO5iaVP+OyDEaGPCc=
X-Received: by 2002:a50:bb25:: with SMTP id y34mr783460ede.237.1588647175976;
 Mon, 04 May 2020 19:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com> <20200505010219.GA2282345@jagdpanzerIV.localdomain>
In-Reply-To: <20200505010219.GA2282345@jagdpanzerIV.localdomain>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 22:52:20 -0400
Message-ID: <CA+CK2bASiWe=w07gsc-_fFZxPY0SSECSYh6femUCA8yugEpuRg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -3157,12 +3162,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
> >       struct kmsg_dumper *dumper;
> >       unsigned long flags;
> >
> > -     if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
> > -             return;
> > -
> >       rcu_read_lock();
> >       list_for_each_entry_rcu(dumper, &dump_list, list) {
> > -             if (dumper->max_reason && reason > dumper->max_reason)
> > +             if (reason > dumper->max_reason)
> >                       continue;
>
> Why always_kmsg_dump check moved from the dumper loop entry point to the
> dumper registration code? What if the user change always_ksmsg_dump
> dynamically via sysfs?

Hi Sergey,

I changed it to make code cleaner:  for such basic operation there are
too many conditions if we will keep it inside the kmsg_dump().
However, if being able to set always_kmsg_dump dynamically during
runtime is deemed important, I can change it back to be checked in
kmsg_dump.

Thank you,
Pasha

>
>         -ss
