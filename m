Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A806C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E020863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBJLRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:17:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33548 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgBJLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:17:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so5960997otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0UD3fxGboZ2WyqDcVlDsabzbnFPIihaoicayUreTVg=;
        b=YrU3x4UaniIYmnAMV+wmdkSvWq3CK0FZZFF6S0KuLkoh0EKwxpkKSsnWPHb/lxaIXe
         UVySk5idQ5qRlKZrXY7PPWsE8iFaRRzEhW8lkkOQi0GLUxD6zIPWscoDG5wYCtyirs2A
         FW5DRcO1NkUa5enqs4Tr6IGisGBJ/Zk1ewhcW0afJ6yJa2VLrLKwITKgac+T1TJ85l1A
         r1OQJwrEVmZUCznnCmQwgqOREjcf9c5cbR8+UjYRm2k5+oh1FpHVonR5AsS61I4C0v+4
         G2MlZ0xCtjX6EcXJZTACeBV1sFNmnWzOeJvEFk3JM8B3V+696SyXLZQ3d95rMoBfA/bL
         JIZg==
X-Gm-Message-State: APjAAAUNw9eL6z+foyJ7NpkzAokBW1XCQkazPeYq0ZgHkzS7x1KjwQdw
        ftH138wKT8/zLwwDKy/t7bOJRzdOVEUTOwTm/+Z/WQ==
X-Google-Smtp-Source: APXvYqzCVs32bgURSBMbsg+6XDD8UyxECagk6yMxU+gW2aLQrlWpc/JTi5OUAALgcPW5fn/275L4Q79SRVMmdSOd8ok=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr657723oth.145.1581333423145;
 Mon, 10 Feb 2020 03:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20200112174854.2726-1-geert@linux-m68k.org> <55c34fc6-cac0-0c53-37d7-d46658a327fc@linux-m68k.org>
In-Reply-To: <55c34fc6-cac0-0c53-37d7-d46658a327fc@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Feb 2020 12:16:52 +0100
Message-ID: <CAMuHMdVeRYtrPHZ=CFPpStUwKwG6w69a-9KVWZPg2Te0wFqmJg@mail.gmail.com>
Subject: Re: [PATCH] m68k: Switch to asm-generic/hardirq.h
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 2:59 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 13/1/20 3:48 am, Geert Uytterhoeven wrote:
> > Classic m68k with MMU was converted to generic hardirqs a long time ago,
> > and there are no longer include dependency issues preventing the direct
> > use of asm-generic/hardirq.h.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Looks good.
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks, applied and queued for v5.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
