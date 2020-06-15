Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA32074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592261036;
	bh=WZVjusbCDXQWsU97UC/QKAvXChN3OhqaYfSZhBDrkx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vAv1bXgH9xPxo/7q549ltSlnm2Uf2lSg+TyF+JUTSUF4mtoewi6cFs5JHwfFq8Ycz
	 91A0PiHW1k7T27Kbg1czjKORGf/y5krZpAcdpFGYooBVcyCiy3KVjNbxGoTBORTpZZ
	 M4MUpVmtsgIACM59gB9/J/QcvueTq9ZxtBuTbL4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFOWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:43:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59227C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:43:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a26so6098203lfj.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnO4cwlFCUJUOIyYZniVvW9lhO2uwSTm46Zo2a7YIe4=;
        b=D2BTfmIBALrkXlPjm+67fJeWl95P22c/xtF/lGCI6gMmQwE3D0mHwqI/nK+W5E2L+6
         cYKsfYWshdApieSjHUu3HJSdOmJ9yn9zAjOPfF5xm8GPV6GG4lKNFZ08xKTtCn6RTd5h
         ryPwyXqxmYgdeXEvwMFGWEgaaIthQ0zr5d6Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnO4cwlFCUJUOIyYZniVvW9lhO2uwSTm46Zo2a7YIe4=;
        b=W/GoFz3rOvcZ7Xg5ZWwEA/ej15DiRY9F4ZZHdmGb2S25uJlXX6qR+q6VdPa/JynYFS
         82QD9IDJvXt6JEo3xXx/paB0KOwSJFvdyjmF8qoQJWDGGsjNv7s2lbaH1zovjRsFQOI5
         0luM+qAkq5ukOqfB2SrCwzxM6VvfswX/nUwfHTjA7IX9CM7nEjfSTO7eAJH3rMfg38VY
         luhdqWNHW5Gko6jZSCpoChBUSXSpinM1uRx4WF027yUTsHhtpmdB4IiMOu9/1JKRYk8h
         Sk5wfU5gKQS3RMNPUe7IqjRnKEOJ4eQ5Mc5cDuxJ4lV0YULEjHRlpHVKurfxjvZPLV9X
         oh/w==
X-Gm-Message-State: AOAM531t3uaUCfCAmoAQJL+497nEhVFIRr5QR06HCOxZqe0oVv6SUuZJ
        DsHHbOxU7iYNlDrjlLKui9qiPGfWOz8=
X-Google-Smtp-Source: ABdhPJw71s5oIbmgQ8XJ2Db/wkRMEMoS2tQCwS5nOSg8XjJeeeuFuOiuYjg+FIX59IxG4b1ySuIpiw==
X-Received: by 2002:a19:8055:: with SMTP id b82mr107200lfd.178.1592261028918;
        Mon, 15 Jun 2020 15:43:48 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y3sm4032218ljk.39.2020.06.15.15.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 15:43:48 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id i27so21143266ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:43:47 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr13023068ljn.70.1592261027069;
 Mon, 15 Jun 2020 15:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
 <20200615222427.60126-1-sashal@kernel.org> <CAHk-=wid9pjXmafH_-F6TooC9j7nfqKweWbHKzENkk+YHTo=AQ@mail.gmail.com>
In-Reply-To: <CAHk-=wid9pjXmafH_-F6TooC9j7nfqKweWbHKzENkk+YHTo=AQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 15:43:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2VeXjf0vPXSJzaV3zk6iNEfnumn6YDQF44OmEcGpoYw@mail.gmail.com>
Message-ID: <CAHk-=wh2VeXjf0vPXSJzaV3zk6iNEfnumn6YDQF44OmEcGpoYw@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace: warn when modpath is needed
 but is unset
To:     Sasha Levin <sashal@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, that looks straightforward.

Hmm. Decided to test it. It warns for every case: a bit excessive,
perhaps, but I guess it won't hurt.

So Shuah's thing results in

[    9.791367] Call Trace:
WARNING! Modules path isn't set, but is needed to parse this symbol
[    9.791377] ? snd_pcm_hw_params+0x3ca/0x440 snd_pcm
WARNING! Modules path isn't set, but is needed to parse this symbol
[    9.791383] snd_pcm_common_ioctl+0x173/0xf20 snd_pcm
WARNING! Modules path isn't set, but is needed to parse this symbol
[    9.791389] ? snd_ctl_ioctl+0x1c5/0x710 snd
WARNING! Modules path isn't set, but is needed to parse this symbol
[    9.791394] snd_pcm_ioctl+0x27/0x40 snd_pcm

which looks a bit redundant, but maybe that just means people _really_ notice.

So the patch stays.

           Linus
