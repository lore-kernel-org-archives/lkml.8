Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7193C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89A52068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="sLf6cwlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgEDRhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgEDRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:37:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E4DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:37:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so95450wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJI5f8hOlgJLa4m5pIdFlzMabgKQ1SIX55UP+OjSdBA=;
        b=sLf6cwlLSRIjHDP2kg2TBle9sRTX1zi6t7cBz7OZjT9zBPnOEVCp7dAhZ5VIuRj425
         hxplPKugPEkVft3YJtydQZYUMpH30NOBQ5q0fFULuSd7zUGzC7yeqHcr+4X8P8e6TltU
         Mf26btkL2BK0+vGP6QKT0th24uAi86BCR8Jg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJI5f8hOlgJLa4m5pIdFlzMabgKQ1SIX55UP+OjSdBA=;
        b=b6uy8TCOkk+5uKALLG8akAbTpoA27h/HDRl2eIAQhOeyEuJIawfSwsu1/T3vGs4jsK
         W5D/+6lsn7YDu02EgRh/Co4RumkdFiCgrAAn3Si0TALMKxBVLYnF79toGrBi7UktSyY7
         G+lbKnUicTjhF5M66GPPy37HI923mdP9rqaHrS6xJh7rxFm+O+npzMZUO02WIY1K1cb/
         7xyJ5ACWKr19qT4HQK7kHPbErbFNmXJiHdZxBP1Gkk6d5Ln/zzsGuS4WM2KtYuHa6rEm
         rX429H9IaZy83FL5Rb3OAmoGT0vt//9d7KbL5yXMOEVQyOa7m0NPCAmHBrEZiIpPHkZh
         jiJw==
X-Gm-Message-State: AGi0PubxKtsVCUlB5/bSI7dTrUkNfg4+9ZMNA93FAE2EO+mi6EBRpMqF
        aBXVaocTKE0D2rUtD8eUpelHht53zQ5/TxrE5BLj
X-Google-Smtp-Source: APiQypKL0LFBdt9evPCiVFS44KQzDG+nTobDCx2UrOxF2R5qtZLfeQ4eUc2xP93l7Mm+VWsLa5Cp/CkvPSnw5qyW42c=
X-Received: by 2002:a5d:4443:: with SMTP id x3mr438377wrr.162.1588613871278;
 Mon, 04 May 2020 10:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200504035448.13893-1-zong.li@sifive.com> <CAAhSdy23jzYvZcmXoX_5F1wDenBQ8NpvNpoO41=aBGHoONPCgg@mail.gmail.com>
 <87tv0w3zrp.fsf@igel.home>
In-Reply-To: <87tv0w3zrp.fsf@igel.home>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 4 May 2020 10:37:40 -0700
Message-ID: <CAOnJCUKCryLuZn0Pd71z3Oa1AEN1xUfz=SW_5PBV-2pDU+Nw=g@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: force __cpu_up_ variables to put in data section
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Anup Patel <anup@brainfault.org>, Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 12:50 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 04 2020, Anup Patel wrote:
>
> > Slightly improved text:
> >
> > This issue happens on random booting of multiple harts, which means
> > it will manifest for BBL and OpenSBI v0.6 (or older version). In OpenSBI
> > v0.7 (or higher version), we have HSM extension so all the secondary harts
> > are brought-up by Linux kernel in an orderly fashion. This means we don't
> > this change for OpenSBI v0.7 (or higher version).
>
>   +need
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

With Andreas & Anup's nitpick addressed,

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
