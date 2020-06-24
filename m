Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE19C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EA92145D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593038271;
	bh=j/JT04bUIGp1KPXmU9tBSt/XagxtgDGn8tJTtwxowlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AgJ+eCVC10LqDB/a6TRlknlCfu/a/TEk05tJ0y2Wj7W0MpIPjX1IbcNtbRQ9ZT+MZ
	 QHstdLLZXBNdnruwPPeEMt4i8QEC6GiEUDVGRpO6lFU1Nv1rGTk0PVDCCkF/QKv1bK
	 HLCakC4EAkwRmuOYg9gFrdDUOotecqa9x2gNUNFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgFXWhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgFXWht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:37:49 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA0C2145D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593038269;
        bh=j/JT04bUIGp1KPXmU9tBSt/XagxtgDGn8tJTtwxowlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CcPNKzfA716pG2lRlW/5iMiAIi48GuzF32J9ROS1YCZbBJjNEo89KuaY28IBoFm9S
         3fGrD7tx6vll0/sQfgJVW4Bs75aM76sRCRo0POv+9w4JsyobkVbJ9BLRzb0nWLsfoY
         4APO8Pfuiv3rm95SJpHC1SKyVW0WHHe21HU0ktjU=
Received: by mail-wm1-f54.google.com with SMTP id q15so3731146wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 15:37:48 -0700 (PDT)
X-Gm-Message-State: AOAM532fTWNzZYMpC9/8sar8C3B3lnGgawug7UY2G3L3Ku9Dvf7LNEK+
        a3xpoHqwChMVHG3rE7e4acclDkJHoUw1azQeMHPT3w==
X-Google-Smtp-Source: ABdhPJx4fLw4UTKYwGkCEWfPFEcMOBCPz8bEmhCE2U5/jNza+cfbnDxCsmikFctzGxT5KdtB+DKb1MjHPY4h/GK89tU=
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr3460wmb.21.1593038267193;
 Wed, 24 Jun 2020 15:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200618190207.GO576905@hirez.programming.kicks-ass.net>
 <257B4193-08FB-4B3E-85E9-6C512B52C2C2@amacapital.net> <20200618211823.GP576905@hirez.programming.kicks-ass.net>
 <20200622114713.GE577403@hirez.programming.kicks-ass.net>
In-Reply-To: <20200622114713.GE577403@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Jun 2020 15:37:34 -0700
X-Gmail-Original-Message-ID: <CALCETrXjyp=P7b_tcFHD-ZCVrF4-KhojYDas7WJpMSzPr2B0Tg@mail.gmail.com>
Message-ID: <CALCETrXjyp=P7b_tcFHD-ZCVrF4-KhojYDas7WJpMSzPr2B0Tg@mail.gmail.com>
Subject: Re: [PATCH 1/7] x86/entry: Fix #UD vs WARN more
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Matthew Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>, jthierry@redhat.com,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 4:47 AM Peter Zijlstra <peterz@infradead.org> wrote=
:
>
> On Thu, Jun 18, 2020 at 11:18:23PM +0200, Peter Zijlstra wrote:
>
> > > So maybe also do an untraced cond_local_irq_enable()?  After all, if
> > > we=E2=80=99re trying to report a bug from IRQs on, it should be okay =
to have
> > > IRQs on while reporting it. It might even work better than having IRQ=
s
> > > off.
> >
> > Yes, very good point. Now I want to go look at the old code... I'll fro=
b
> > something tomorrow, brain is pretty fried by now.
>
> How's this then?
>
> ---
> Subject: x86/entry: Fix #UD vs WARN more
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Jun 16 13:28:36 CEST 2020
>
> vmlinux.o: warning: objtool: exc_invalid_op()+0x47: call to probe_kernel_=
read() leaves .noinstr.text section
>
> Since we use UD2 as a short-cut for 'CALL __WARN', treat it as such.
> Have the bare exception handler do the report_bug() thing.
>
> Fixes: 15a416e8aaa7 ("x86/entry: Treat BUG/WARN as NMI-like entries")

Acked-by: Andy Lutomirski <luto@kernel.org>
