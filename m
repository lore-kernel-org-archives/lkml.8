Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8402177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UGHJuDCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgHGJxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:53:43 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:49747 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgHGJxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:53:42 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4bafd5ba
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Aug 2020 09:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=rOyEY/+Hbg8ncbUAsQqEvB5BAb8=; b=UGHJuD
        ChmePyiBSADcTZ8DcK1YgUJeN4/BT0jJhsG41V7FLe2Pf1mtysZ2KJZMQ6bKt/Gb
        DRwDZhlT4c0egHGL8Amv+8CsGTeCL9lh9t7jRMN2OjIOMjNscwOiR37rqRO5lg84
        +dLn8AUaRFA+q301nQl4RTcr412j++exQ2aHwmjLXxmaM2sW5PpTXsQEB5VMJvEN
        b10C+uZbvYQEReVs0hhDaJhpx6gnmOhKbJTbTgSXIQwQ+sWXWTNHWwUtOuJFZ4ae
        90DWVR2+DKWcc4V1ALq69bl+AjnhzAXfdDcNt1Yv/KLCQB+lQ151nmSzrdmLnDtR
        PB2VpkYFGnTZTuGw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2bbbea13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 7 Aug 2020 09:28:57 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id k23so1288836iom.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM533RfX/tHhvp9FNqzPv7m1ckioXC75Pj4NfZ0QnrehkND47Hh7mU
        yvKczAdHkLhi/NBD5//0YiUklE95d/s2/V9D/M0=
X-Google-Smtp-Source: ABdhPJwf6B6JQdH32dnncU/NBaHX1zW6emWOC5yL1lWg2kVq/3V+sMtc4v7V8InsYUHGu8BjHGH8uHEikdN6MjV2wHI=
X-Received: by 2002:a6b:b211:: with SMTP id b17mr3641993iof.29.1596794019689;
 Fri, 07 Aug 2020 02:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200803190354.GA1293087@gmail.com> <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com> <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com> <20200806192333.GB24304@suse.de>
In-Reply-To: <20200806192333.GB24304@suse.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 7 Aug 2020 11:53:27 +0200
X-Gmail-Original-Message-ID: <CAHmME9qYEzRp85ig5R5HKVbEkoSVjRF-1UY4tbnBBjxZW0Ppvg@mail.gmail.com>
Message-ID: <CAHmME9qYEzRp85ig5R5HKVbEkoSVjRF-1UY4tbnBBjxZW0Ppvg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joerg,

On Thu, Aug 6, 2020 at 9:23 PM Joerg Roedel <jroedel@suse.de> wrote:
> Jason, can you share more details about the test setup which triggers
> this? Like the .config and the machine setup, ideally a qemu
> command-line, and how to reproduce it on that setup.

make -C tools/testing/selftests/wireguard/qemu -j$(nproc)

I can also confirm that the patch you sent to the list fixes the issue.

Jason
