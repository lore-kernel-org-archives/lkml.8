Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5349FC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24522222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="jH3pNYMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgBZTJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:09:06 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35066 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgBZTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:09:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id q39so58627pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=RBcKv7eej+JLMOjCarAoqwQ6jzrRawlUlS6bH7yzUYI=;
        b=jH3pNYMVwUv/72mC7w7CgqRcwOK8p2sf/c8G8Ep5YP+x8tPMTSk+cTtGI+nPpvgIcG
         /kgMAfma4Ktlwd6Q5zFdDvJHthZu5ziXldYtLbdtsHCAvYZ4H5djsOgKGaP/7ik2gQyQ
         7V7QpSl9SuOgsflZ5Bn3d/EGBL6X21CLanxita83+W9aIb01OZQrUciPurqd8JHqCu6l
         0C/L9+wq/yUEUpltUgXGYMiuGvBkiKc1G39LEDu/BVnVyZ53PT6NkvH7tAUm++hBEumF
         qD4gclWvTtidtz7y/4bjT66VUh/2tL0Hul9qglJavXuYjC/9IQ7QxT3rAfCW/A+Dl3oX
         kV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=RBcKv7eej+JLMOjCarAoqwQ6jzrRawlUlS6bH7yzUYI=;
        b=gk+SXiS12yWzurF9CJjov9xy/KU9lMVwoJDeO6439fc0rHZDoL7hk7SBBrE7uZfzi5
         SJVzprBuOs/QgG9G6SiJeEMlooF5kk0yBaqf2wZ2ifpGIt1/IFFEDYaDzHG8hB6tlk+a
         obgkVn1dL1kTo7wUkB7sbaQpAnvMuCAZioVlayAQU/a6r/FVFyXMjIqt/jQO8iaiIPW8
         QuHJ1u6BkXHODpDM6245pNZMH7BBfFxcy4FbA2DfnYOMBeYj7y7NL0ONCiA8mfKuYBS+
         fj79vtyN04Na05lin5naN41XTRNlAMy/uGD5CkWps0k5gZiUce45Y+hDFP4pH4eKNrGN
         /ifQ==
X-Gm-Message-State: APjAAAWq4rz7Pc7UvxfpJSEAk+jymsij4kxaHfFv9C6iDuLBNpN3DrNW
        gNfHiWKgwtd91E/kV21kmYFhv6ceqZA=
X-Google-Smtp-Source: APXvYqyO4gk5if6zO230FzcuDCu0SkToZBRtOLraR9jSQJV5zkQva/cw16xGtCoVN/ullZboFbqYFQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr604312pje.9.1582744145181;
        Wed, 26 Feb 2020 11:09:05 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:55da:f727:3bee:8a? ([2601:646:c200:1ef2:55da:f727:3bee:8a])
        by smtp.gmail.com with ESMTPSA id y190sm4003447pfb.82.2020.02.26.11.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 11:09:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on do_machine_check()
Date:   Wed, 26 Feb 2020 11:09:03 -0800
Message-Id: <F7C318D0-D9B8-4984-AE84-2E903837EED5@amacapital.net>
References: <20200226185945.GC18400@hirez.programming.kicks-ass.net>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20200226185945.GC18400@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 26, 2020, at 10:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:=

>=20
> =EF=BB=BFOn Wed, Feb 26, 2020 at 07:42:37PM +0100, Borislav Petkov wrote:
>> On Wed, Feb 26, 2020 at 09:28:51AM -0800, Andy Lutomirski wrote:
>>>> It entirely depends on what the goal is :-/ On the one hand I see why
>>>> people might want function tracing / kprobes enabled, OTOH it's all
>>>> mighty frigging scary. Any tracing/probing/whatever on an MCE has the
>>>> potential to make a bad situation worse -- not unlike the same on #DF.
>>=20
>> FWIW, I had this at the beginning of the #MC handler in a feeble attempt
>> to poke at this:
>>=20
>> +       hw_breakpoint_disable();
>> +       static_key_disable(&__tracepoint_read_msr.key);
>> +       tracing_off();
>=20
> You can't do static_key_disable() from an IST

Can we set a percpu variable saying =E2=80=9Cin some stupid context, don=E2=80=
=99t trace=E2=80=9D?=
