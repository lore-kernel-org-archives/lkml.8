Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C83AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435112076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068086;
	bh=tuuaU1o5XE5JrAxv/4vS4uyCn9VxF9lZSXPfHZDVrPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xQWVHW7ITSib+4E8wnefyQa8ihEKwEFk+cs2LLrCsl1hmGxJXM1XRtUgZJjk1kkAV
	 6ooYXlBCFMWs4tOMeScO+G+Faof2BEZggYNKQCA7iaA0sNdMgQ8EptpMyJaOAMt3FA
	 oBUMaTYWoBtTJDnXRZyCBHUINKvQ3cGqnQ0tci/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCXQlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:41:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40949 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:41:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id w26so15126670edu.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XEAcgrtzlQ0nzsuAIOz6lRZnZyzpLkzKdjSUsUmbaiY=;
        b=DyaeVbt/mnGOvxpYTVSUTvxDPVQYVS3x1eaUPvsh7Rnx3FOM/j8k6No0xzupqKHlBl
         grkrG08s2C8Y2S6RpApRxXhiSNAT115kCoNJQmXFlNcT27zq7jafr0hzEJ1L4puKWJWF
         n5mHXzOpLZGae3EMG6VJK7HG0w8XHQ66cfXo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XEAcgrtzlQ0nzsuAIOz6lRZnZyzpLkzKdjSUsUmbaiY=;
        b=MMsdo1H8SJINLzkjDiZ8A0lrD3E6Gs7yUrGy+pxKqSa6qXnpTLWGkac6QiIo8tvjYI
         Nf8Hz2TVrxi93c6VMAc4opt9BhL8TWgL+BnjTapcwr3CeZ4MrykZ27M1odRSG1Flrrxc
         ij0f9Cxw9+OVwo7EcGFxyfpimM0qj/8hsOKZ/CKUQsVpcLW3a4mEga6uMIqkeUMjggZe
         D/2F09A1RNCfJq+NTDJpBS0kBSa0VHrdeW4ekQzQYdrfWZUok87QBzNwAMbhytnameJ0
         FFsOd28FlIJHYBg96F9uzUs3xsVFJ/vpmZlRQzUdWzEDZooq7WwvZsxoas/oZK5XeD4f
         /CUg==
X-Gm-Message-State: ANhLgQ0O5UG1VXq2U89r+Y4w3R/6LJ7WSRj61VABKg7FdZQQoyMijapO
        y8GD6EfWNs6KOrhZMY86t/0BpUFNQVo=
X-Google-Smtp-Source: ADFU+vv3VjHxlQOAr5fL8O8m2cvtardGhCI2ub8u0ASJfzBqA92/e1KhAPqG/9BXRvB6R9qj9LhaPg==
X-Received: by 2002:a50:f383:: with SMTP id g3mr4367772edm.316.1585068082741;
        Tue, 24 Mar 2020 09:41:22 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id t13sm1399435edw.49.2020.03.24.09.41.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:41:22 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id i24so21504844eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:41:22 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr17538229ljp.241.1585067617805;
 Tue, 24 Mar 2020 09:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiumU4QxAkT+GqhBt5f-iUsoLNC0sqVfRKp0xypA6aNYg@mail.gmail.com>
 <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
In-Reply-To: <86D80EA7-9087-4042-8119-12DD5FCEAA87@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 09:33:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
Message-ID: <CAHk-=wim-2aaFi_GNs5KmX4ykkgQjnRo5D4B9ZK+1Oz=kpp_2A@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 9:22 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I haven=E2=80=99t checked if static calls currently support return values=
, but
> the conditional case only makes sense for functions that return void.
>
> Aside from that, it might be nice for passing NULL in to warn or bug
> when the NULL pointer is stored instead of silently NOPping out the
> call in cases where having a real implementation isn=E2=80=99t optional.

Both good points. I take back my question.

And it aside from warning about passing in NULL then it doesn't work,
I wonder if we could warn - at build time - when then using the COND
version with a function that doesn't return void?

Of course, one alternative is to just say "instead of using NOP, use
'xorl %eax,%eax'", and then we'd have the rule that a NULL conditional
function returns zero (or NULL).

I _think_ a "xorl %eax,%eax ; retq" is just three bytes and would fit
in the tailcall slot too.

                Linus
