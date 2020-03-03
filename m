Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1F220CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erfB9EEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgCCUUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:20:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36168 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgCCUUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:20:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id j14so4392678otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 12:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2kzWYnhHNwPKndZNxUfTV8Fu7co3KaoSWSaF0iBUUU=;
        b=erfB9EEXH1OrsG7ZoHatHAnCFvM5uXNWzBvJHrxa3PNccf1O+8LugRnExtYFRWJ5uP
         2ZqjCuPbZviv5jOvIxmKCZnwfw8ScajoJUrA+m5KKeVbTSsYdgKJ9qAxw/Mb6hguDJhf
         SE1UHtlKMKKFU1aAGNlUdg2pdNbzs5xFlhwsBnNnlqrO4d8AuoETisVrThfpVWmQlvBv
         BFJQiMXCMPLtvxA8V7bQaoOzoZFUkATmzjsnw1J1asWEzusfJxBiy+lFK2SOprNGT35+
         1kSaP+2YgMYsUU0nxd+X8t6Tly2u9E4NzvvFBhP8CCV9LIknKelxkvLF9g2KMlwJp8Zm
         GP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2kzWYnhHNwPKndZNxUfTV8Fu7co3KaoSWSaF0iBUUU=;
        b=IlQUqKsq3CanXAP0fnemHuK+ftgJPRQiJiRJkarM96rD2i7WbMgof8GSbHm2oKqswH
         KmxzvdQ7Su74H/SL2Ca/sEuRD3EPsYvp4MY1uzbIpN0Oec6uDNct9ODZ7o0EvFYfbw/D
         vztpi0SS5gJ5nk44+zyjrOCWUroPXZIhdVNpMyxy900IMG7Hz1/b8f0c6dV3pd6mpYv8
         UgUhp0+90ZCLCCQzxhhLOoqd7js/lWsR1E7DJCB3DAKPTpImJHYDefWWiajELFb7LZMl
         Wwo+PGLdgerRLZoP+uSDAoc1DznImSYzEJeUoJgUVDn0+JZs0vlmmMnJn9aDaD6RI7RW
         PFcw==
X-Gm-Message-State: ANhLgQ01XckQv2f6cEpM7ECxoUSNiFsnLN+5NMqOd2DVBZhrAN3OKIWW
        hDnLv2XRdw4YtuLHy5I4cebm0RoEUCQVwiwnThttrCUPKv8=
X-Google-Smtp-Source: ADFU+vs2DtsvTbW47OVOu6Ao9H1B1gjgvRzFxWp+o3Hao6p4+O9zUgSqehDixn13kp4U4VInFxKDQNdyTxgN5AhhznI=
X-Received: by 2002:a9d:906:: with SMTP id 6mr4419945otp.251.1583266851521;
 Tue, 03 Mar 2020 12:20:51 -0800 (PST)
MIME-Version: 1.0
References: <1583263716-25150-1-git-send-email-cai@lca.pw>
In-Reply-To: <1583263716-25150-1-git-send-email-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 3 Mar 2020 21:20:40 +0100
Message-ID: <CANpmjNO6SmBvG5LfrLZCeummtfbPk0cDBfmwv7q09W-nQ0=+yQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] mm: disable KCSAN for kmemleak
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020 at 20:28, Qian Cai <cai@lca.pw> wrote:
>
> Kmemleak could scan task stacks while plain writes happens to those
> stack variables which could results in data races. For example, in
> sys_rt_sigaction and do_sigaction(), it could have plain writes in
> a 32-byte size. Since the kmemleak does not care about the actual values
> of a non-pointer and all do_sigaction() call sites only copy to stack
> variables, just disable KCSAN for kmemleak to avoid annotating anything
> outside Kmemleak just because Kmemleak scans everything.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Marco Elver <elver@google.com>

Thank you!

> ---
>  mm/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/Makefile b/mm/Makefile
> index 946754cc66b6..6e263045f0c2 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -14,6 +14,7 @@ KCSAN_SANITIZE_slab_common.o := n
>  KCSAN_SANITIZE_slab.o := n
>  KCSAN_SANITIZE_slub.o := n
>  KCSAN_SANITIZE_page_alloc.o := n
> +KCSAN_SANITIZE_kmemleak.o := n
>
>  # These files are disabled because they produce non-interesting and/or
>  # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
> --
> 1.8.3.1
>
