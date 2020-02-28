Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B41C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AF3246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsOTrP3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1Mnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:43:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Mnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:43:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so2436347otq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfQoq+1M8fvl87X+Ubkvp6zzrnswmjJsf0b9A+26ex8=;
        b=qsOTrP3sERclKpVIMKpYziz0m6/2T73Ci4O0VLjMWrAmFabsOH6/Hfhgq7d+4uG0sD
         PS9cTXQpCWjogewIdRsDWdUDpgkxbnjhBnul7Ez8GZiFu4Cz7V76bbputXQlyW0NfsfI
         f3ca5VfPhYL1yMuPomfYonVoEzBphe4ULCpd9vTD7v5nZLyueoV0KGi9frmrgyjbq8v0
         VA+tCCN8MLl09kBIUkmrOrOKLU76xbQkeu0i8CpvbVP+3nmMooQrGdSeKzLkt+UB/iOp
         v35Xl/dUCU9xg/ZWEdZ0BhzOoGxdu4tHxLI0s/eA5vZ80xkU7ZwOXShTYdq6Cumtprc6
         Wlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfQoq+1M8fvl87X+Ubkvp6zzrnswmjJsf0b9A+26ex8=;
        b=ZYE+wmOKSbcXLGa4GRfpMo6sSs1TUPSK7/KNTSozpzV7kjalMrdXt99K1y6RYci3gV
         NHEj3wZ+iuEc8dOP98K62292UHCr0rtRK9lF7tb9kEtf7owQCijCebPwD15AS1PhPxgk
         CBlxfPDCCr6LBMUfL/gp1cw1JVGiV89RahoQJQ5n+Mex7ivona1005/QwofXaUa+rDjV
         icjz9Idy7rzhF6JCc+SDuRtjqnYto4CjS0t4e/f9kauvMUydV5SuCw9mDkTaXGaEO6S0
         GiwjxauJvfUgcN7qfOJtOB6kL2J86uxNtyE7IjpIPmtHhomQk/AudhBiYW5khD/+3Rsm
         v3sw==
X-Gm-Message-State: APjAAAWTANfWdyE2kZouafGyhdzOX8ahrRX9xvAC5vbPBO/MKStUsLyC
        nnkQKH8sPuokZu7MYWAkbRWiZu1jrDudgwfDszCXMA==
X-Google-Smtp-Source: APXvYqxxN3G70uge1DlTVFUodeYfpc6d6jye62KaY4IKt5nfV1OnJVrwRPjdEzVHOp/bCxRdS+oLGB8gXuhKBgImMWo=
X-Received: by 2002:a9d:4e8a:: with SMTP id v10mr3370715otk.17.1582893823992;
 Fri, 28 Feb 2020 04:43:43 -0800 (PST)
MIME-Version: 1.0
References: <463BBB2A-8F9A-4CF1-80AE-677ACD21A3C6@lca.pw>
In-Reply-To: <463BBB2A-8F9A-4CF1-80AE-677ACD21A3C6@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Fri, 28 Feb 2020 13:43:32 +0100
Message-ID: <CANpmjNNyQ0vGAsSXCLkLtjvEVbq3T5kNnsg+T3XV-qBPCZ8FHw@mail.gmail.com>
Subject: Re: [PATCH] mm/swap: annotate data races for lru_rotate_pvecs
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 at 12:30, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Feb 28, 2020, at 5:49 AM, Marco Elver <elver@google.com> wrote:
> >
> > Note that, the fact that the writer has local interrupts disabled for
> > the write is irrelevant because it's the interrupt that triggered
> > while the read was happening that led to the concurrent write.
>
> I was just to explain that concurrent writers are rather unlikely as people may ask.
>
> >
> > I assume you ran this with CONFIG_KCSAN_INTERRUPT_WATCHER=y?  The
> > option is disabled by default (see its help-text). I don't know if we
> > want to deal with data races due to interrupts right now, especially
> > those that just result in 'data_race' annotations. Thoughts?
>
> Yes, I somehow got quite a bit clean runs lately thanks to the fix/annotations efforts for the last a few weeks (still struggling with the flags things a bit), so I am naturally expanding the testing coverage here.
>
> Right now the bottleneck is rather some subsystem maintainers are not so keen to deal with data races (looking forward to seeing more education opportunities for all), but the MM subsystem is not one of them.

Sounds reasonable.  FWIW

Acked-by: Marco Elver <elver@google.com>
