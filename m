Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D267C20720
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtMO7CWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGDSbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgGDSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 14:31:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B571C061794;
        Sat,  4 Jul 2020 11:31:08 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so26116276qtq.11;
        Sat, 04 Jul 2020 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFLUHOIJlWWk7hAI07Y9tp1o5QM5QJCYXSXyL0loMUc=;
        b=JtMO7CWw51DLAx12Q1J7wDQrbMLhCpTUxO44RqG7IexDvBT3q/Ppj/UrQyV4iupDhg
         /55dybi9z2Ip1geGBwWutbj91Ou1gqVieINEmiTZ/bH6CNGiPnZkVompFBiTVtuq11Hq
         V3j3XbYzDoCXX0a1Z45umxZsJ9vTklMXVTauHc7pl28MCAE3L8ZT5oqpWlyl8kH4AqRg
         sY9MO+xVu58iyOk1zqeUZvlJzJ6TWWPwoON8Tj0a+W1xmxpkHPpNjUrMWRiHqWzHkocH
         Al1Zi/WqxVY6u6iAJbzeukTCQR8CoNp8vQHenRjmpMW/lwnowiYeOsefSlWsrpOpiiZH
         ovKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFLUHOIJlWWk7hAI07Y9tp1o5QM5QJCYXSXyL0loMUc=;
        b=JO+jtpP4PGU2jstLM24AoZck/J2cr3X2mfi3Tkl0iziUe9zPirX2pWVNF85heLQyBX
         iXWhaVTAvG9967PC6IYtgCD1xTOvDtOCgY3HtiKEVGBHb94/NV3ysOEfcB7+8LfZTZtY
         XTo7gM+kYkhMRRqubdEJZP6XY8IucY2Ly4LhbBYICg/NYc1gfdnY/KFAbANAbUKS+DpX
         5ps3eyyUH/X5OkrIpo4Bu5ETgIIgUAL3fGqghypqLA65C2awO7WvkrEwwzIQ4S62BXrO
         Quch5if8o6cSGmP3NPpP9ZRzM0IZa8poccGVn/e7qYKtolst9q7+01EsLTjQytkoRmwl
         PFXg==
X-Gm-Message-State: AOAM531ytmlBdxx9Jet2AFNMRl/kSePXUOj+OIETsHff8O/AGNlXmGZm
        wOQ/GZ8+JJt129KdW7418LN17ndg8r9Rj3chjS0=
X-Google-Smtp-Source: ABdhPJwSRtILfOImuh8qk8haIBu/Hxgg+XL6PXWIgOMU1jKJ7Qi5EhbGfS4iXfEMEQwvOgsLA+uDBZjvovcMQpvgIRk=
X-Received: by 2002:ac8:4b5b:: with SMTP id e27mr39335257qts.96.1593887467803;
 Sat, 04 Jul 2020 11:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <1593833659-26224-1-git-send-email-guoren@kernel.org>
 <CAOJsxLFF4o8AFWzPFJgwaeuA=Lb9VsjMXXfVmbhZBwLPcG=Asg@mail.gmail.com> <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
In-Reply-To: <CAJF2gTSYyj5rTUJW-yDDrrV7T3hUssAhGc0gnCntcQpuixNJzw@mail.gmail.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Sat, 4 Jul 2020 21:30:50 +0300
Message-ID: <CAOJsxLFSH2_e03xo_HMqKAzVE+2Y9=hriv-Zu=GdVUHgDMgYtw@mail.gmail.com>
Subject: Re: [PATCH V1 0/5] riscv: Add k/uprobe supported
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        bjorn.topel@gmail.com, Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> > > There is no single step exception in riscv ISA, so utilize ebreak to
> > > simulate. Some pc related instructions couldn't be executed out of line
> > > and some system/fence instructions couldn't be a trace site at all.
> > > So we give out a reject list and simulate list in decode-insn.c.

On Sat, Jul 4, 2020 at 2:40 PM Pekka Enberg <penberg@gmail.com> wrote:
> > Can you elaborate on what you mean by this? Why would you need a
> > single-step facility for kprobes? Is it for executing the instruction
> > that was replaced with a probe breakpoint?

On Sat, Jul 4, 2020 at 5:55 PM Guo Ren <guoren@kernel.org> wrote:
> It's the single-step exception, not single-step facility!

Aah, right, I didn't read the specification carefully enough. Thanks
for taking the time to clarify this!

FWIW, for the whole series:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

- Pekka
