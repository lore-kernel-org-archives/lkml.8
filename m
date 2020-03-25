Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA0C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DB92074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585169543;
	bh=uswinrTaSWk8KJ7IEc3EprMVnttfltaTPgQ8mFU9bzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k3W/4oprbo6wVFYBsEtvf0Y2SWUdpcDYYBwuKbT8i1szK1uibBd5xL53BvTXzahx/
	 gaozA2PBw3szVessYHcj2ocpGI8UmXbblELvDCBa2F6Id2/yFUH528i5XjvTtuaM57
	 i7DQHK+4sKd7eePPW3ZfLhkzlDvhoLi7+m800/rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:52:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43210 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:52:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id n20so2986864lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Pa+6azOo7sQo71Yu5iIRHQVPNPI12P6LJ/tfFkG6qc=;
        b=DkQ69LlY50kg4Ct2XxaOH8lbPW7R6Q25M2TFwKyAymIBZfdVJCYt+BsG7mY0Apiz77
         bU4RHdWgvQng7MmfM3C7YtmdSeXoysIQk8XGVhrZSETgSXkpablGmOyDyWMREeBP1X0g
         /1W6Q6yurPD/D0aYF4vfuNYt2KaGGZXnuTyBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pa+6azOo7sQo71Yu5iIRHQVPNPI12P6LJ/tfFkG6qc=;
        b=nZVl/SeY7LqsXeOigEOtVwnk1caxBowVUwoL5excRqTiTSLL5EyugnJbjFqYe9vkBv
         mVMpu5SwMZsPBb6xrnDP+P6jUM1C+LQmPZ8GpVVmFUUqHQ9e7y59dN6Qo9nar/cs965C
         cIEIl/JcZpssgvHt9L7ube4bXbuhkc2oMDUQZuj/tTyQxe/dUGtUc1NbJ0AnCKIjJ1zI
         bK3rDUQeUjmU5x9+izwPWmblchw1rBVqsARhOKaK3Y7jj6eqvp+ouA9Yv7vNXQ4ZuHds
         B79ex8cRCckwm7ZiT1jxXrQtt1okCnZiY5feebq6Ong5ZAziKYU0xEUKr+YSDYpya27B
         4P2A==
X-Gm-Message-State: ANhLgQ3vFv9TxaOWFxInhR2Vx4E9gPrRsOOVheacONdDjxIIEcKkdOFp
        Q2J75T3TBfl6Kgurx8D8I2vY4Nl+db4=
X-Google-Smtp-Source: ADFU+vsUKq5PD8W8fpAcrIVxHumfodHBJN60cZ+lr5EHKpUUONiGq3rAOgtCgqpwEz7uG+15AVwDZw==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr3497785lfh.150.1585169538460;
        Wed, 25 Mar 2020 13:52:18 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id c22sm169273lja.86.2020.03.25.13.52.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 13:52:17 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id q5so2988075lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:52:17 -0700 (PDT)
X-Received: by 2002:a19:f015:: with SMTP id p21mr3562264lfc.10.1585169536709;
 Wed, 25 Mar 2020 13:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net> <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
 <59FDEFC1-9353-453F-84E5-F94995157B27@zytor.com>
In-Reply-To: <59FDEFC1-9353-453F-84E5-F94995157B27@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Mar 2020 13:52:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBpTqWD=cm2xDsRSCb8keL6_9VKBSE7TUrToErtO6sdQ@mail.gmail.com>
Message-ID: <CAHk-=wgBpTqWD=cm2xDsRSCb8keL6_9VKBSE7TUrToErtO6sdQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Peter Anvin <hpa@zytor.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:35 PM <hpa@zytor.com> wrote:
>
> "movl $0,%eax" is five bytes, the same length as a call. Doesn't work for a tailcall, still, although if the sequence:
>
>     jmp tailcall
>     retq
>
> ... can be generated at the tailcall site then the jmp can get patched out.

No, the problem is literally that the whole approach depends on the
compiler just generating normal code for the static calls.

And the tailcall is the only interesting case. The normal call thing
can be trivially just a single instruction (a mov like you say, but
also easily just a xor padded with prefixes).

                  Linus
