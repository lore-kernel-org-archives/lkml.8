Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC152065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATDuV7yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGMW6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGMW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:58:46 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF8C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:58:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 1so6690113pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMa3nnO5KaoJ4bHARK9iJcAUNODTUZQxMuVvwY7m8WI=;
        b=ATDuV7yhLeocSSqXWB9OVSb61s6+cSY09CNr7jW6WVE/r8f1DZmAahLb8wVmPIDis8
         j0kB16+b3h5Cuo9E5Dfv2H7pUp3pc2Q5jgYzRokro3I7Q+h/hSJXAei8aX5eEajffzcN
         MFL+hktCdglOsECO+Ez2Ujb5Puwz09elYYadmXImhag41nldn/dAIq8MWD1m+LEXoZH+
         G9yTpnTftpvdHp9Q/CWoLqJQRvaAJ+AZXSiDy46y+GDfq6g+PFEE+RneViBTYt2LJgqH
         wLqymBcMxmKVJ0lBJhYMuihIyUUZeylK0EwVUocG2LMlhQ++JJj5mWOGwB/DKM7UQ/6w
         q3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMa3nnO5KaoJ4bHARK9iJcAUNODTUZQxMuVvwY7m8WI=;
        b=QDmKI1l9r3JcSZLZ2pjxATba0RPzx9NweOlkbSqySkYcmLnS+wZUDgJXHV+OhItVHF
         CH3wM3M6DJFe+woS1gfxYq7GSD1xxuuZFrQsRrnkL1IBpsvLSbHypNqKvK4APF7Bpniy
         6I7TFnRMIQ+EhM5DjIeBmXRLdFzkiRiYV/JE8GGAAGwrxareLlVl0Yvq/2cRfZsPmDnc
         mRjHErj4uhtbWWsvzDzy7y+qnuc8HJWPAtL7AK+z4ONnCoUYxswAk9NbHN4IR7QS3+zw
         3B7F255Bs0nDaNHHswq9f+yBNjsc+SHPcQ+Q6eiXXycPi0W867wHIH/fo+IcztSNjNmI
         /+Vg==
X-Gm-Message-State: AOAM533DpODsvQ6Av3fm853EjQLGC3sxpAq9ounWgsPDIk4S7lPF5Cbe
        6a0IL9/Z4gpU/GDXl1K6bFAsAXGYD/wInj7Is4q/eg==
X-Google-Smtp-Source: ABdhPJyL6NMed/UdNI+6KTXlhAZYdUc1Fxbl4nD0DjU8gBhC53KAnMMSzttjgPpg6NowA4RmITPbag6nI28LT482vrU=
X-Received: by 2002:a63:a119:: with SMTP id b25mr1118617pgf.10.1594681125577;
 Mon, 13 Jul 2020 15:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com>
 <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com> <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com>
In-Reply-To: <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Jul 2020 15:58:33 -0700
Message-ID: <CAKwvOdmsap8iB+H5JXiHYwSJFrtQ_krjNH7eQCGe7p-LjK7ftA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 3:40 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jul 13, 2020 at 3:24 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Otherwise, is there any additional feedback on this series or is it good to go?
>
> I've lost sight of the series. I'm sure it is fine, but maybe you can
> resend it to me (in private, if it's already been going out on the
> mailing lists and everybody else is completely fed up with it).

Is there a fast way that maintainters amend ACKs to each commit in a series?

>
> And no, pointing to the "plus this hunk" with a web link isn't what I
> was looking for ;)

So you're not accepting pull requests yet on github? I jest.
-- 
Thanks,
~Nick Desaulniers
