Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF87C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668C12067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598221627;
	bh=ywQ7wbvfZOV7aZ30pD3zOxjP7J3ylb5kVjfEk/wwAcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SmHuHTTmrVuhkcdrEqn864rr9u4T3km/yueoBfNytTGlqaRnGwI4vgr2tQPB9GkLO
	 xVATijjGL5QNDWqg+AVcTjeOP6fTk1s3fhqUAdVvUfyS/8IWrPdVS+YDIphYFaqm3u
	 YtZtBYx2vai5wg6RctvAMT8Am4UK/LTbuUdjfxBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHWW1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgHWW1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:27:05 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F192067C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 22:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598221624;
        bh=ywQ7wbvfZOV7aZ30pD3zOxjP7J3ylb5kVjfEk/wwAcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pu87/nn8tvRz5AvJUWVKOCjthZ/PL0hoWvqrq5a4BJwIMGy2mjCKWhQcOuVLD0oow
         YwmRAf5c40XMM7RgYHDfD1InhU94OFxr2yUYDQzea88QoliWRsQehvvTKoItyOW7db
         moLTOZTSVWj/lLhL7anmhruL74pHR76gc2XxyGII=
Received: by mail-wr1-f41.google.com with SMTP id h15so105706wrt.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:27:04 -0700 (PDT)
X-Gm-Message-State: AOAM531BhDqfJR+/uKUUIRNCjNW+lnracj00aMCYaigZ1z0tU4ZATwhF
        8unm/jYMlkfrzwEAGbNwIvU+8kUobjxCQAr09AtnJA==
X-Google-Smtp-Source: ABdhPJxxkTewnABDF1snMo38SAmkcDhAIMHKGfs0qEnsQORpj4dQEv0BGI67lZ5op1LN62U1zAx3RAQ+K6q3JsbdLYQ=
X-Received: by 2002:adf:9283:: with SMTP id 3mr3022561wrn.70.1598221623317;
 Sun, 23 Aug 2020 15:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos>
 <159817113762.5783.6214320432160748743.tglx@nanos> <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
In-Reply-To: <CAHk-=wiQQRS1f0qMwVVWKd6YHJ9K3bUK4BR2zoeGeCWRpTM3aw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 15:26:52 -0700
X-Gmail-Original-Message-ID: <CALCETrUSE6cTgaa9LWK=JgKhJt4vgGz42uPJEkk6XZWA9dOkvg@mail.gmail.com>
Message-ID: <CALCETrUSE6cTgaa9LWK=JgKhJt4vgGz42uPJEkk6XZWA9dOkvg@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.9-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 11:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Remove the RDPID optimization, which is not even
> > backed by numbers from the paranoid entry path instead.
>
> Ugh, that's sad. I'd expect the LSL to be quite a bit slower than the
> RDPID on raw hardware, since LSL has to go out to the GDT.
>
> And I don't think we need the GDT for anything else normally, so it's
> not even going to be cached.

Every interrupt is going to load the CS and SS descriptor cache lines.
Every IRET to user mode will get the user CS cache line.  Because x86
is optimized to be as convoluted as possible and to have as much
garbage in microcode as possible!

--Andy
