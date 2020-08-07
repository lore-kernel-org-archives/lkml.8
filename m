Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B191021744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vG0VER3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHGHEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:04:12 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C4C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 00:04:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so1064106oiv.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 00:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oYWNp/GpuNpaVK72kwx0orN+HBmw3zsxbuspfgdgQAw=;
        b=vG0VER3/fpNDvr9mnd1+MncBPnDmbCH2YpAigdAFgnMGZc8mrbbOr7jFYmHBWwvC8R
         Y+myxpR5y2JQbZX5ykV19khJ3+KHjaZm/LFm431GzGPvUljPvBkgRiDu7yv/zndyam4W
         kBqs/xJhZQHVUqjJ9oSlA6oZ45LJhyHUya/jdoSEZIw9XoBKKG7Oxmo04nTK1darbxqA
         VgVmNRwcVDxc8Q4CtGy1Fh0cPxVE15vcrnq66hJRnxhQ9ha8ArkaerlkfIpXbqaRLzj1
         ZLAByKo8qYsy7RyhtSxicVC+O6udeWYzRh4DxTes1TOLl40aKfZvGKUv7xEH3W6CZG6X
         Q5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oYWNp/GpuNpaVK72kwx0orN+HBmw3zsxbuspfgdgQAw=;
        b=s84mg7T98JDoylRLbHdOe+GaznhNwZkRsJ/t0hNXM4dRwKN3/csCoWraaOZJwy6enE
         z2kr5weclcYz1afp87ZWr5zVRIfxL0GOI88uJb2/0SUV3fk5tPviqgwgoFp76xKxLCBp
         RqTKvz6mIdPWsl2GMt2qLnZwuzc8nrFtGYDDMzolMoOSe3hjFPHhFdrRQxUdJx4Wk16j
         WG4Xqv5Z6Asg6LdJDrhV1HoWnKwJX1NyQ0Kxo32HbzHcKCtJx1r4J+x26Ngxp9ITkZYE
         XZPqxSeMWenGiWED83BBm2+NCt7waWScS5/N92C9Dj2zugcA3Gc26xbm6wcPhpvbyiqn
         Q5LA==
X-Gm-Message-State: AOAM533p3oV1AQKtHOCCrGjfyiLC1rzYdUVJdjdYrLt+G3OPFZVn7Ay6
        /YOXQC307sxcFzaQndxt70mKw5/NI1Q6SAqMOf8=
X-Google-Smtp-Source: ABdhPJyx67TqDmr+TFC7z82Z0l0CKJBL9H1gdVhdSvwmXwhtI6apmn24XHSA+FzKoOhOTdAPJvnjBK6HVQlAEHmHcTU=
X-Received: by 2002:aca:724f:: with SMTP id p76mr10105390oic.35.1596783851057;
 Fri, 07 Aug 2020 00:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CA+icZUUcH91QDDEin9GyEoD8kqrQSPAnkZJyMnXU40Sk5FAo3A@mail.gmail.com>
 <875z9vh18a.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875z9vh18a.fsf@nanos.tec.linutronix.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 7 Aug 2020 09:03:59 +0200
Message-ID: <CA+icZUWpbYDJ7CnVOsWG9paoi-EHpzW2=ERYK=GeR2z9WtJCbw@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 12:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Sedat Dilek <sedat.dilek@gmail.com> writes:
> > what is the status of this patch?
>
> Just looked at it.
>
> > I needed this one to be able to build VirtualBox via DKMS as an
> > out-of-tree kernel-module.
>
> Not being able to build the vbox rootkit is a feature, not a bug.
>

It must be a funny job to work for Linux/x86.
Keep your humour :-).

We have a second issue hitting this problem when CONFIG_LKDTM=m.
There are more details in CBL issue #1120.
Especially see comments from Nick [2] and user pcc [3].

Thanks.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1120
[2] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-668736160
[3] https://github.com/ClangBuiltLinux/linux/issues/1120#issuecomment-668746486
