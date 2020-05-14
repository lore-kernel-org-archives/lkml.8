Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02A42054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gFupu26v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgENBfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgENBfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:35:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24443C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:35:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z1so577860pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZVHBCjxkrGEodwBNIRUG1uMkUWDGDtQ7oSthSg/nj84=;
        b=gFupu26vQQOiPv25Ot4ItrGDlOxezLs3bOwwqudCcRfGeHg7wu4uKuHit3iWHWD/HI
         0TCWOz6YWCbmBHJMLHOnxN82/nDihbWsG1Ev8gYSEliM/fM7R/NBdl7I0qm0LRgRZtpa
         co17IgdfcqKZVzvcFAlobv/D/cVR+SWsRGIghQeH9/5a4ANO1NA3U4vwbnT+AtSS/Aij
         xmVG63yqPojOuLlQJIlX0aE+HN0ssiqbsI9lhcCMwkfVYF2P6G3US9ODIlXBXSY1PBzx
         MWjVzDFvYx5MH5tGYFX8sp5M/dSlRze34CXKJPVbJAJjwW0F9axb6zV42lkhH1HvqVxF
         S8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZVHBCjxkrGEodwBNIRUG1uMkUWDGDtQ7oSthSg/nj84=;
        b=Xyue2aRfH0FRB9ZapWDxV/BGGHpdm7mBASxy2h4tlFaWeHqY0XuowbQ/X6TtMUSIm/
         YrIESzVat42FX5FekTVTYS0WkbZJlOTzs8VsQYxJVg4Mh3mub/ixdecX8G/bJN7xCOOg
         DV2fKaMAMUdx9bKBOmE2QRilCsV/EgOhTuAOA+hFLB9XjxBb4tnQ0bKbv6hfQNl5jmDH
         Z7L5laX+X7rK3P9f68EREyoIl14hsLQ0ADoqHEPJlb2OASTjUTiYCocQbjVd3ucA9yK6
         wYDHtlwxUf6yzZ4RLROGq+QDWfA5oY/jSxRwJ/gvXieF44Gyg5P01cJOmpOOKztxe3lk
         MIXw==
X-Gm-Message-State: AOAM532s2XCpFe9VnfRQdP+qi86E/uHdh45Wk7hB+GpplBYptiG4N3YI
        YoqEzH8xWcqnR+sIMmKK597X3g==
X-Google-Smtp-Source: ABdhPJyQphWYIWZgkPwZSAJMaE6/v3zVLIw3oTU5iRq7zoKMjGSorWxtl8rlhogqlIhzikUO8V5QhA==
X-Received: by 2002:a63:f94f:: with SMTP id q15mr1948953pgk.256.1589420143604;
        Wed, 13 May 2020 18:35:43 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:4dac:bfc1:d4fa:716f? ([2601:646:c200:1ef2:4dac:bfc1:d4fa:716f])
        by smtp.gmail.com with ESMTPSA id a16sm704383pff.41.2020.05.13.18.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 18:35:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch V4 part 3 01/29] x86/traps: Mark fixup_bad_iret() noinstr
Date:   Wed, 13 May 2020 18:35:40 -0700
Message-Id: <DBE4DB85-973F-4E16-8574-B93F9E4A51BC@amacapital.net>
References: <807929267.20601.1589416908153.JavaMail.zimbra@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
In-Reply-To: <807929267.20601.1589416908153.JavaMail.zimbra@efficios.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 13, 2020, at 5:41 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios=
.com> wrote:
>=20
> =EF=BB=BF----- On May 12, 2020, at 9:51 PM, rostedt rostedt@goodmis.org wr=
ote:
>=20
>>> On Fri, 8 May 2020 17:39:00 -0700
>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>=20
>>> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>>>=20
>>>> This is called from deep entry ASM in a situation where instrumentation=

>>>> will cause more harm than providing useful information.
>>>>=20
>>>=20
>>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>>=20
>>> Maybe add to changelog:
>>>=20
>>> Switch from memmove() to memcpy() because memmove() can't be called
>>> from noinstr code.
>>=20
>> Yes please, because I was about to say that there was changes that
>> didn't seem to fit the change log.
>>=20
>> I would also add a comment in the code saying that we need the temp
>> variable to use memcpy as memmove can't be used in noinstr code.
>=20
> Looking at an updated version of the tree, I see the acked-by from Andy,
> but not comment about switching from memmove to memcpy.
>=20
> Also, I notice a significant undocumented change in this patch: it changes=

> a this_cpu_read() (which presumes preemption is enabled) to a __this_cpu_r=
ead().
>=20
> So the 100$ question: is preemption enabled or not in fixup_bad_iret() ? A=
nd of
> course that change should be documented in the commit message.
>=20

IRQs are off, and, if they were on, the lack of a warning from the percpu ac=
cess would be the least of our concerns here.

> Thanks,
>=20
> Mathieu
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
