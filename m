Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378EFC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1613A20673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvtECquk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgELO0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbgELO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:26:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F00C061A0C;
        Tue, 12 May 2020 07:26:49 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id x5so5022164ioh.6;
        Tue, 12 May 2020 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euS789G40ClREipHMw3+RHqcFIzlVY5CpOIPVEki6lg=;
        b=AvtECquk72BWa108Y6qDur37GANVAriAzDMWrfSFul6biN+gfWHD88H3kfGPSmlKyz
         wAh6VH0k60MeCfytXbn6CKZzw6b4C1M5IqXdI3XVwBASUwJIyiAHZWbY4IIVFpaOYZMj
         dHG8/3mPkk1WxG2UEfJMBfJTBGpGit2MbNYx/bS6DFux7feQU+gfXoukWzcvdPUifjRj
         QRqifKeeq+/mhySia+QoAfEEbqp1vub3cQBRxfv8sj3GE0exssLuezFYtppvu0FRuJSg
         AlXZqgRDnrE81aNFuFy8HKnBfmW1aAehYtBUECoNCxBPd57Opv4S5LvArDxYNxkmdDQM
         v8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euS789G40ClREipHMw3+RHqcFIzlVY5CpOIPVEki6lg=;
        b=b1jh8FjBYps+VawzvOx1xRlV15LHVM3ve6YxvtbObqoWuML1eOVnsMFwF/M/vqoCQj
         TvgBvOqIVTJDBJpoj09xMFdFAxml5nLKrDV0UZ+HQC+vs+T10rOoCVkHdNBYwUAYZzq0
         N7NKOZx2M/YHZGsgQ9+41QCvH3gY4adtbpCcQa8RzZP9Md3hXkIAUKdDkxWr1+R2C/hS
         kvZ/fXMY0EDMjj9/iRuwhNVk/vm/em2/9GGQ3Ts74Uq+8XuicHB01u+3WojkW6NqlLe3
         CPzfGdpzyo2yHhVxDQqRX4ysKj9KAdYWvRy8yfhBTGBf8Olld8D1MVXkofBRUoexdJ1x
         k0xQ==
X-Gm-Message-State: AGi0PuYoTolhERXFK32ivonAITZd91iQWaSbt4LJvshjAFT50wVBl9mS
        U0tCP69wTA1ybTefDI9yit3TVgbhmLufoAjVraElsMf2
X-Google-Smtp-Source: APiQypJ3lgS/gmgW2u7t5rc+xlxnMQjn2ItUEI6tE2lUqlZ5Fw/5O8xP8mad063eGoi0RYvACqsoqzazfmoAupPV/mc=
X-Received: by 2002:a02:628f:: with SMTP id d137mr20543429jac.4.1589293608845;
 Tue, 12 May 2020 07:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200508092247.132147-1-ubizjak@gmail.com> <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
In-Reply-To: <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 12 May 2020 16:26:37 +0200
Message-ID: <CAFULd4bZLkME4kn9bmbOBMtd+ZpNnsH-w8a6tPdtmpV57WSHtw@mail.gmail.com>
Subject: Re: [tip: x86/cpu] x86/cpu: Use INVPCID mnemonic in invpcid.h
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 4:10 PM tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/cpu branch of tip:
>
> Commit-ID:     7e32a9dac9926241d56851e1517c9391d39fb48e
> Gitweb:        https://git.kernel.org/tip/7e32a9dac9926241d56851e1517c9391d39fb48e
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Fri, 08 May 2020 11:22:47 +02:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Tue, 12 May 2020 16:05:30 +02:00
>
> x86/cpu: Use INVPCID mnemonic in invpcid.h
>
> The current minimum required version of binutils is 2.23, which supports
> the INVPCID instruction mnemonic. Replace the byte-wise specification of
> INVPCID with the proper mnemonic.
>
>  [ bp: Add symbolic operand names for increased readability and flip
>    their order like the insn expects them for the AT&T syntax. ]

Actually, the order was correct for AT&T syntax in the original patch.

The insn template for AT&T syntax goes:

insn arg2, arg1, arg0

where rightmost arguments are output operands.

The operands in asm template go

asm ("insn template" : output0, output1 : input0, input1 : clobbers)

so, in effect:

asm ("insn template" : arg0, arg1 : arg2, arg3: clobbers)

As you can see, the operand order in insn tempate is reversed for AT&T
syntax. I didn't notice the reversal of operands in your improvement.

Uros.


Uros.
