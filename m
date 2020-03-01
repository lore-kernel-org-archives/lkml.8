Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E975C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D509120880
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="A9FM8HH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgCAOhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 09:37:10 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39678 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 09:37:10 -0500
Received: by mail-pl1-f174.google.com with SMTP id g6so3143374plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 06:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=MT8m5WxhVAoLR+Wqbebd8/i32Xvn2qbRw1p7UnjqdyI=;
        b=A9FM8HH2Cc9gf4xyEvyhvDqWd6l0Sxv+umWhApKrfhUCvpqlnXJJQLNpequ1+KSOg+
         Ubqrhzue5SniVoZjuXjrPRM2u1SLlF9ntK6envGE3H+i5RM7hQ1OQdsIXRHosRb9gajk
         5+PWHJBWHkqbbWfS2ijqVxA2t04gplycn2HVSLIh3lSbeCa/zRMlUBT7lThWYvkTlZei
         6urFZxH4o9y6myxQaiURhPAwHQFoR903r7JcJeios5EFPsSRLbVcIhMcbXdVKvRzoDrV
         kgK/EN6k/blfhsjers+p+Od+6qNSnzki93bAGtaeBtk363en1Z0g0/UgY2A82O87l3Du
         nUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=MT8m5WxhVAoLR+Wqbebd8/i32Xvn2qbRw1p7UnjqdyI=;
        b=hRmaCkzLMCAeohq0T/aB12JnFBdhJOKhRidADNXimN1fnwbAcvHNRjZsAUnO0xxbR+
         FDLffgqXLOf4gcRKEWWxtm8MBZ1JC/TXEFqj2D4ySYDM/j+BhiFZ9tz+VRUm+230dIbe
         61zxjVHRzPKA+/d1P98RKiF1EF36rtnoWlA6hQuTIdLqNfPD1xtw5g5Yf3RKv+TLuSI0
         /tMrRIlTuq9WXeKHIC8rKJAnFaDmVoj0kfVmIXQjy7K1jZeYxUNYVukjCy60MXf9AGIJ
         tHTx/Vtaeo+YiojOF5wwjhCqwIqs+fC39d2Igkh0m/DLWJCmcx06POI77tYaNJsAWKeL
         +2UQ==
X-Gm-Message-State: APjAAAWn8BB6hALAK7wBZl/HQiAS4sNmFkOA/sLtmAxlZQMTO4NKCWNh
        WYyPlb4N2o+ZxXDqXM1xjIQ/aA==
X-Google-Smtp-Source: APXvYqwfPcHFXEABWhQxUEZYtS7Yh8kYyd5MhP5XXwpDSqASqZ3PaZz4T7RGFhCpcCA63xfy1MRY/w==
X-Received: by 2002:a17:902:504:: with SMTP id 4mr12387749plf.276.1583073428012;
        Sun, 01 Mar 2020 06:37:08 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:c4b0:4a97:f98c:7f8c? ([2601:646:c200:1ef2:c4b0:4a97:f98c:7f8c])
        by smtp.gmail.com with ESMTPSA id f19sm10354660pgf.33.2020.03.01.06.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 06:37:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Sun, 1 Mar 2020 06:37:04 -0800
Message-Id: <AED99B11-8739-450F-932C-EF38C20D44CA@amacapital.net>
References: <87imjofkhx.fsf@nanos.tec.linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <87imjofkhx.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2020, at 2:16 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFSteven Rostedt <rostedt@goodmis.org> writes:
>=20
>> On Sat, 29 Feb 2020 11:25:24 -0800
>> Andy Lutomirski <luto@amacapital.net> wrote:
>>=20
>>>> While the tracer itself seems to handle this correctly, what about
>>>> things like BPF programs which can be attached to tracepoints and
>>>> function trace entries? =20
>>>=20
>>> I think that everything using the tracing code, including BPF, should
>>> either do its own rcuidle stuff or explicitly not execute if we=E2=80=99=
re
>>> not in CONTEXT_KERNEL.  That is, we probably need to patch BPF.
>>=20
>> That's basically the route we are taking.
>=20
> Ok, but for the time being anything before/after CONTEXT_KERNEL is unsafe
> except trace_hardirq_off/on() as those trace functions do not allow to
> attach anything AFAICT.

Can you point to whatever makes those particular functions special?  I faile=
d to follow the macro maze.

>=20
> Thanks,
>=20
>        tglx
