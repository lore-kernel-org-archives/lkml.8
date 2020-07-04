Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A317FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 794722084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 06:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdNwr1QZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGDGkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 02:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgGDGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 02:40:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C2C061794;
        Fri,  3 Jul 2020 23:40:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so30552858qkb.8;
        Fri, 03 Jul 2020 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fbem6xgsUHpQEkkr1bl021QDup9/jlYvisDm0Lh+SY=;
        b=gdNwr1QZAC91+OD3FOIx7q1FSHbrZ7YbJPutNryHLdnGL2EaDZXgg1zzgnIYPTYV4q
         AAbRJOeNvsOa4+McC/gP+Vq/x1uKRcc4b5DSU2mpHbVBiKbsPQX+1napYFZ55jeaHpV1
         YQu9Gnn0oySDE+iCddiHSRxkpdnWbKC60kBf4dVFWKvEF8SQlM1PYcgYMSyuzngjVOWV
         AjtZ2fZDImi88LBn5niGQdzZK6/Ue4VjB383dhWSwHXeNIoU5Lpl42xqU9yY3Lz37g94
         kSBboDMTJn+JGwhchUz/w8fBVekEtuEUQmG9fUl4dGeQTHQBcuyuMWxybtFDwxof3X7J
         yHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fbem6xgsUHpQEkkr1bl021QDup9/jlYvisDm0Lh+SY=;
        b=GmtbmfkzZVY4BYYzq9/oIYVBnUR2iq29XWF97dG6AQ9GkbDqYXa9SjTCkoHavOsacw
         esRYK45hSzlyUO/gpraAceH4tCuKZooX+vyj1W/p8y0t639V/G2XejdilZAPd7sLZ6eh
         MpRW6zX3okYf7SUZSP1cjGg77Gy4cBY7Oy7sDwC+1FWBot4P4dnflud8UrJNMhQWukVI
         JLjbWfxteQrbCD/36lWiP1gfQrhM0u3njs3t5f+aCJfT8TRNh9JXlq7jca3YDli43KbZ
         XsKZhmbAtEaHM+ZHvYvP1VuaJ0m0uUSuWQQosiLSTeY/A5nRSse2BD+9LKDoTo/zZbxD
         dIUg==
X-Gm-Message-State: AOAM533iv9kQsm1nrHFmjAJHYb/R0FEHpnfReacltKGsmsYAQKlply1s
        i4MjRjlHB+A7N5lcWa1lRp6zEO7Wp8kjlQMIrnQ=
X-Google-Smtp-Source: ABdhPJy7jzIt8rk0tJ5U6guhUCoxO+Lb/9yA05k7QhaWpyEYJTMhjhttaoUbaZnuIqKntrcFGwlzkq1eZ7HpYPc3mEQ=
X-Received: by 2002:a37:4289:: with SMTP id p131mr8989609qka.28.1593844806613;
 Fri, 03 Jul 2020 23:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <1593833659-26224-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1593833659-26224-1-git-send-email-guoren@kernel.org>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Sat, 4 Jul 2020 09:39:50 +0300
Message-ID: <CAOJsxLFF4o8AFWzPFJgwaeuA=Lb9VsjMXXfVmbhZBwLPcG=Asg@mail.gmail.com>
Subject: Re: [PATCH V1 0/5] riscv: Add k/uprobe supported
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, greentime.hu@sifive.com,
        zong.li@sifive.com, me@packi.ch, bjorn.topel@gmail.com,
        atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> The patchset includes kprobe/uprobe support and some related fixups.

Nice!

On Sat, Jul 4, 2020 at 6:34 AM <guoren@kernel.org> wrote:
> There is no single step exception in riscv ISA, so utilize ebreak to
> simulate. Some pc related instructions couldn't be executed out of line
> and some system/fence instructions couldn't be a trace site at all.
> So we give out a reject list and simulate list in decode-insn.c.

Can you elaborate on what you mean by this? Why would you need a
single-step facility for kprobes? Is it for executing the instruction
that was replaced with a probe breakpoint?

Also, the "Debug Specification" [1] specifies a single-step facility
for RISC-V -- why is that not useful for implementing kprobes?

1. https://riscv.org/specifications/debug-specification/

- Pekka
