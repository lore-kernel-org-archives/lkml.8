Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E0C2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA554206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 01:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+e9j9fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbgDCB5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 21:57:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388709AbgDCB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 21:57:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id d77so5615263wmd.3;
        Thu, 02 Apr 2020 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IM3PKdJzNHK1Q5ycu1+rnlpnfn6cknjyyldEYszSZOo=;
        b=a+e9j9fSz7AbZHNKex7YNRjwT4uBSpxeAMRP53RKJadBT+dXgc2zLA4tmS21UZfQjM
         hhauuyi4sgRhc1LVmZSWitM++AIwbaFs9PULb/39zKVxMGF7RvpZhRYFa2Go4vozTdJL
         6/20XASfoUrtX5/tjunrRE7dPwojOVMoE6NZeZ+vpgP9GAsUqG76qzahJHYJp28o+dph
         Wx46ceMsAXnqsInQ08sVE5l0rK+53aw2lUODic4jW3AMaqgVHnk5nChXLMvAmi3zRKmF
         +hTs6wsNVukpG/YRrKXqAcJLZWET9+AI84eWLtxkbFigDrrCPlQns4GmxYgZ8UgA3+94
         u8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IM3PKdJzNHK1Q5ycu1+rnlpnfn6cknjyyldEYszSZOo=;
        b=mX1i9pbPxQG5igJwQoc66pUl//MayFNDXZJn2GUlpnF5KVXJmF6zfIuNmdnUCrex8J
         LHDmgeWeRr2Mbsg00rAayFxIVChLzcm3HCAZOV/l1jpsURABBDPqxVnr3K0fzTcG811z
         NkyKJxjMXVLs0i1QohsQjzlILhTqcyihXxIy5blRLe2v2FW9Kid6V4PvW1qPtBH1e5TT
         3sO9RJtuYtW6NqHgZ0fVXDuNoI5Ovl9KyBKgOsz+fxniVImLRay9V0vLQP9wkmZcybAA
         L7SzFzUDf6Iwz/rxEPpV8xUbQ/r1SXCb7RFEabAQnm0HBeWOhFzu/Bp949YD9aDGhOt7
         NcgQ==
X-Gm-Message-State: AGi0Pubd+xyizoXmtHd/ECjYghtb2i83PR6m7hzGPki6JcbvijH2cdPD
        8u03DcE1zWzPZzXrWhUp/JIhmop35B1toMR2pdY=
X-Google-Smtp-Source: APiQypKQLjGMnznkTFu6yCPwzo2cD2A672D/LY1DyWimVDpCieb0sohBX8Opad5ypdMMixmhl9cEXtgKb3eWs3RFOzU=
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr5830115wmf.166.1585879037215;
 Thu, 02 Apr 2020 18:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
In-Reply-To: <20200331104532.12698-1-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 3 Apr 2020 09:56:41 +0800
Message-ID: <CAAfSe-vYe2LiAhYMuqJpt07VcXO_phuY8zUv5151JjHxxViB5w@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

This is also a fix, could you please take it into clk-next as well?

Thanks,
Chunyan

On Tue, 31 Mar 2020 at 18:45, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Don't gate uart1_eb which provides console clock, gating that clock would
> make serial stop working if serial driver didn't enable that explicitly.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/clk/sprd/sc9863a-clk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sprd/sc9863a-clk.c b/drivers/clk/sprd/sc9863a-clk.c
> index 24f064262814..6c6ac158ef61 100644
> --- a/drivers/clk/sprd/sc9863a-clk.c
> +++ b/drivers/clk/sprd/sc9863a-clk.c
> @@ -1671,8 +1671,9 @@ static SPRD_SC_GATE_CLK_FW_NAME(i2c4_eb,  "i2c4-eb",      "ext-26m", 0x0,
>                                 0x1000, BIT(12), 0, 0);
>  static SPRD_SC_GATE_CLK_FW_NAME(uart0_eb,      "uart0-eb",     "ext-26m", 0x0,
>                                 0x1000, BIT(13), 0, 0);
> +/* uart1_eb is for console, don't gate even if unused */
>  static SPRD_SC_GATE_CLK_FW_NAME(uart1_eb,      "uart1-eb",     "ext-26m", 0x0,
> -                               0x1000, BIT(14), 0, 0);
> +                               0x1000, BIT(14), CLK_IGNORE_UNUSED, 0);
>  static SPRD_SC_GATE_CLK_FW_NAME(uart2_eb,      "uart2-eb",     "ext-26m", 0x0,
>                                 0x1000, BIT(15), 0, 0);
>  static SPRD_SC_GATE_CLK_FW_NAME(uart3_eb,      "uart3-eb",     "ext-26m", 0x0,
> --
> 2.20.1
>
