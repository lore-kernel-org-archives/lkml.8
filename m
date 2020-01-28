Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65473C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A03B214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMv4HGCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgA1Q7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:59:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33019 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgA1Q7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:59:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so5328443plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1kp2/4gfvXmBxJbriEuhD88FxIhMu/4bGwo/Zmm5PKU=;
        b=gMv4HGCWc9VWs5EKeYQSo1N5YZJjHcHm5rePnbNpI2VfXdzTRQeVopa5wPpcg0/et2
         vJKJjtefINOeaW+sEA+VDaUVkxgPh5nCZs7q/9YWl1jAc7yFKmoqpiqKOvvSK+kpCEU8
         GAkC4C5WPDb7EmZT5IUhnkUlSj7wT+Jv8ls90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kp2/4gfvXmBxJbriEuhD88FxIhMu/4bGwo/Zmm5PKU=;
        b=PSj6TTurGsoeAt1bFkvGssSLI4ErgDwxGvNBdUtLQnTmSTs21axZWl5OhtkGTYyyVX
         EUOoXGeswtaJsQJ/3swjlNYnT6dayEP2JREYaROznC+GBXOHgncxqKJXMnNJcNCQb0Wd
         pwt4lLQP0pOPsLkhQC/ZNACbMx3jBB2J6PPhSLIoMkv9AQBCZBwNE4rcuCwhUNKi6egU
         vRmosjlUfo/pi3fCjT8VgcXP51D3AafJyD7qSEwQVVf2YbO/77ApedM83BWYD7zeDd6c
         ltuSwIZZx4pRaDlJgE4N5P2KcOb2CUkCdCcUo6aeP4Dt/i+L2KG/h3IHza+lMCSc8eJI
         wTxw==
X-Gm-Message-State: APjAAAX2VUtp0+lnGv+WFRg/fWWE/VFOgTcVMK+J8A03+/XwLGlNOeTz
        NrJZRlxvhpyuOMxDXXWjmmEQJuO25QQ=
X-Google-Smtp-Source: APXvYqz4Fe5UYt5JsxB+qb5DTYyRJiQDfd/YRmrFWOH3PqMenfkwwnYBY5XA1SogZI/YyyXrvhedTA==
X-Received: by 2002:a17:90a:dc86:: with SMTP id j6mr5834870pjv.33.1580230758169;
        Tue, 28 Jan 2020 08:59:18 -0800 (PST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com. [209.85.210.172])
        by smtp.gmail.com with ESMTPSA id s131sm21933251pfs.135.2020.01.28.08.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 08:59:16 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id y5so3854625pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 08:59:16 -0800 (PST)
X-Received: by 2002:a1f:c686:: with SMTP id w128mr13530554vkf.34.1580230755259;
 Tue, 28 Jan 2020 08:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20191109191644.191766-1-dianders@chromium.org>
In-Reply-To: <20191109191644.191766-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jan 2020 08:59:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WcjHMzRE0yHm4uRFYj=Zoxz_v1FgiZETOwjzMtkjJcfQ@mail.gmail.com>
Message-ID: <CAD=FV=WcjHMzRE0yHm4uRFYj=Zoxz_v1FgiZETOwjzMtkjJcfQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] kdb: Don't implicitly change tasks; plus misc fixups
To:     Paul Burton <paul.burton@mips.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     qiaochong <qiaochong@loongson.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-mips <linux-mips@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        James Hogan <jhogan@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Nov 9, 2019 at 11:17 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> This started out as just a follow-up to Daniel's post [1].  I wanted
> to stop implicitly changing the current task in kdb.  ...but, of
> course, everywhere you look in kdb there are things to cleanup, so
> this gets a few misc cleanups I found along the way.  Enjoy.
>
> [1] https://lore.kernel.org/r/20191010150735.dhrj3pbjgmjrdpwr@holly.lan
>
>
> Douglas Anderson (5):
>   MIPS: kdb: Remove old workaround for backtracing on other CPUs
>   kdb: kdb_current_regs should be private
>   kdb: kdb_current_task shouldn't be exported
>   kdb: Gid rid of implicit setting of the current task / regs
>   kdb: Get rid of confusing diag msg from "rd" if current task has no
>     regs
>
>  arch/mips/kernel/traps.c       |  5 -----
>  include/linux/kdb.h            |  2 --
>  kernel/debug/kdb/kdb_bt.c      |  8 +-------
>  kernel/debug/kdb/kdb_main.c    | 31 ++++++++++++++-----------------
>  kernel/debug/kdb/kdb_private.h |  2 +-
>  5 files changed, 16 insertions(+), 32 deletions(-)

I noticed that this series doesn't seem to be in linux-next, but I
think it was supposed to target v5.6?  Do you know if there is
anything outstanding or if it'll be queued up sometime soon?

Thanks!


-Doug
