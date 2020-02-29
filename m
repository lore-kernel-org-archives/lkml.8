Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD998C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8498F24672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xKU/JUdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgB2TZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 14:25:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42859 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgB2TZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 14:25:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id 15so3474888pfo.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 11:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=PyYfDnf43WH5ivv/PcQ/dGCHo4V7xLTHAot5fxh8eiw=;
        b=xKU/JUdVDgwA4QnwQf1+8vZcO1v8+rflnjGCKeibtWun3w/QXfckwhlMY1IW30AkXH
         MP3257WrLvupHHyoHYYJZM/t2avx9oTfefLaz5VLop9k4dX4Fr9QJDJogQQeQVrYLeCa
         YwW4ESxgUMSv9RC5tTkZC/IYfwWwkC7/VuRWqfWXtWEK5nktC1Uup20GsI7akBUZIMv3
         iZ+FHsZxAEwW3ctmw87Eqlirk3yJY8jV6rxLK0aUwf0E78h1e08X9a6DLYsjdOyawIsZ
         UN8RDklBLxXuaadYKYJH5RJEoC8eC63XBZhXYkLYHIE7Kmgr7NivTNs1uqF+rCoB0Qgc
         rZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=PyYfDnf43WH5ivv/PcQ/dGCHo4V7xLTHAot5fxh8eiw=;
        b=LTj+WR4JqjTWT30RiSUp2OSijY4UM79/dxOHvxQS123Xrdap9a0m6Jlwo3YqTY1G69
         zPLkNYaiBQYhrjxO67i9VmeRABdH/xzyG+JT45HtbHfLJzDXAJIY+A6J18HcODuDWm6c
         0OKPRVeDZ4bmi63tpysyy8YJBdeeW/zv4UeYtM8RcE9OXV9K7nIp+PbPIyTE347gW1t9
         9ydf45qQm0kvqZ7yQ27Ym/qed6JOU8E40fzfrgo5ZPlYesoce1Pytq1Tw5CvbeEisJtV
         ykBEiroWrtTjEVHOE5t9S6gqv4tuv+galkkI9OpC7HJ6Yi6eQWxjTjozdG6BlqMUjzqD
         L2EA==
X-Gm-Message-State: APjAAAXM/NIcVRXabZ3btMALoYjIbLUDRhyupeLqq+Z0ocrbPfMbc2jw
        JuZZAb0JT5gMIbfMbekJeYOsotq070s=
X-Google-Smtp-Source: APXvYqyD8sg1LuyWPPu46AJm6SkJrIrDyAPtC9IqNdiQFFLBpGl/YOi94GDlTQpW1x9GNpO6FeFGZQ==
X-Received: by 2002:a63:1051:: with SMTP id 17mr10480124pgq.291.1583004326792;
        Sat, 29 Feb 2020 11:25:26 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:a821:5843:fca0:b0a5? ([2601:646:c200:1ef2:a821:5843:fca0:b0a5])
        by smtp.gmail.com with ESMTPSA id u7sm15221299pfh.128.2020.02.29.11.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 11:25:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to C-code
Date:   Sat, 29 Feb 2020 11:25:24 -0800
Message-Id: <4EFF3B04-2C8A-4D63-BB63-B5804EBFFE2F@amacapital.net>
References: <87lfolfo79.fsf@nanos.tec.linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <87lfolfo79.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 29, 2020, at 6:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFThomas Gleixner <tglx@linutronix.de> writes:
>> Andy Lutomirski <luto@amacapital.net> writes:
>>>>> On Feb 26, 2020, at 12:17 AM, Peter Zijlstra <peterz@infradead.org> wr=
ote:
>>>>> =EF=BB=BFOn Tue, Feb 25, 2020 at 09:43:46PM -0800, Andy Lutomirski wro=
te:
>>>>>> Your earlier patches suggest quite strongly that tracing isn't safe
>>>>>> until enter_from_user_mode().  But trace_hardirqs_off() calls
>>>>>> trace_irq_disable_rcuidle(), which looks [0] like a tracepoint.
>>>>>>=20
>>>>>> Did you perhaps mean to do this *after* enter_from_user_mode()?
>>>>>=20
>>>>> aside from the fact that enter_from_user_mode() itself also has a
>>>>> tracepoint, the crucial detail is that we must not trace/kprobe the
>>>>> function calling this.
>>>>>=20
>>>>> Specifically for #PF, because we need read_cr2() before this. See late=
r
>>>>> patches.
>>>=20
>>> Indeed. I=E2=80=99m fine with this patch, but I still don=E2=80=99t unde=
rstand what
>>> the changelog is about.
>>=20
>> Yeah, the changelog is not really helpful. Let me fix that.
>>=20
>>> And I=E2=80=99m still rather baffled by most of the notrace annotations i=
n the
>>> series.
>>=20
>> As discussed on IRC, this might be too broad, but then I rather have the
>> actual C-entry points neither traceable nor probable in general and
>> relax this by calling functions which can be traced and probed.
>>=20
>> My rationale for this decision was that enter_from_user_mode() is marked
>> notrace/noprobe as well, so I kept the protection scope the same as we
>> had in the ASM maze which is marked noprobe already.
>=20
> I have second thoughts vs. tracing in this context.
>=20
> While the tracer itself seems to handle this correctly, what about
> things like BPF programs which can be attached to tracepoints and
> function trace entries?

I think that everything using the tracing code, including BPF, should either=
 do its own rcuidle stuff or explicitly not execute if we=E2=80=99re not in C=
ONTEXT_KERNEL.  That is, we probably need to patch BPF.

>=20
> Is that really safe _before_ context tracking has updated RCU state?
>=20
> Thanks,
>=20
>        tglx
>=20
>=20
