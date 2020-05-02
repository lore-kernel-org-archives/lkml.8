Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90158C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634AA205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTs/6dNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgEBKxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgEBKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 06:53:35 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA8C061A0C;
        Sat,  2 May 2020 03:53:35 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so6704778ilo.6;
        Sat, 02 May 2020 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9LZ8ST+6LzjBGdaEIV2c8yn5dkQzPADS108pGHml1w=;
        b=PTs/6dNbidwTJZIuSOvkN3VnCcJkyoKXyCzjrsOB1mAFUi0LpNXsxG4gW2mbcI/pik
         CydNAU8z+t0IfESfNvQOBLhUmCJJVhdFzqBVFlXd/Zn3JthWpHFdD4pr8Mt4TlUznip3
         U/WiPUJFoCTualQQW3ESl0ZJxpFBKGQZjnKZkA6RL6+YkjtndgJem6S8BWMjWP5MiQfn
         rgI0dSLWwh8kW5bDRi1Jrda1ump3s5oJkEILM08E0MArVJL5U8v7oc6K6VATSYbttmjd
         4LtrPfaYIROee4lV8XwomJf0kUBmTtBpr4Yy9BtK4EaagU48REe9+S4mvoQqmhVdmRBt
         QuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9LZ8ST+6LzjBGdaEIV2c8yn5dkQzPADS108pGHml1w=;
        b=ChQRYVb0RdB8URhIVXnSFjOKWjMilxQebtv7K1eNfsUUNcjj+htJZPvpPpvPpnkaP/
         8jDOpGySHWw9Zgq5h2XVCyHzJu9ffUDcp1SOk9XICVAMwGpBQqEimXQNMZ/ZIGpoAEL0
         9YNdt7GFA4AtG36lN+EEU4ynN/pByI+4K84mIbqPNoT2nYieTXC9xaWLqfhizDaibXwB
         4c4nOT0omRETXc/lCEPG3GcE9C/V+SIZrTz9mS9FXrmNMM5PKGZGQOpdRMOgPD2lr1Tk
         riJRIuji94xIsgJghIZBok48YKkGrYa5RTVRdsuj4GDVa24QBTf6AqMcWzTPFwEgHUqA
         jHNQ==
X-Gm-Message-State: AGi0Puam0keT2yapnV6cdXCQ0TknIc1MCdqy4Q0QyOA7PfRfGB5DBLgA
        iGdqe0A3UjflS67vWXpqjk8R5YvDxSIYtLd1A1mWLedQ
X-Google-Smtp-Source: APiQypIHiSluSp8zltLiHWhXVtICtbgab42gEUfjztSVhleg/ky/1r1/Ss6C7gJM4qs0WFi5ehg92uoORRSH1sEc+F4=
X-Received: by 2002:a92:c144:: with SMTP id b4mr7597001ilh.89.1588416813921;
 Sat, 02 May 2020 03:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200404161537.2312297-1-aford173@gmail.com>
In-Reply-To: <20200404161537.2312297-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 2 May 2020 05:53:22 -0500
Message-ID: <CAHCN7xJBxaS-7e=PY8BXVyit-Ye22JKmfOk3=oUTv1BZurE4oA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: vc5: Add support for IDT VersaClock 5P49V6965
To:     linux-clk <linux-clk@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Charles Stevens <charles.stevens@logicpd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 11:15 AM Adam Ford <aford173@gmail.com> wrote:
>
> Update IDT VersaClock 5 driver to support 5P49V6965.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>

Gentle ping.   Rob H has given the 2nd which adds the bindings his
'signed-of-by'

Once this has been approved, I'll be issuing an update to an another
patch series for this same clock, and once those have been approved,
I'll be introducing a new board, but I need this patch approved before
I can do that.

thanks,

adam

> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
>
> index 24fef51fbcb5..fa96659f8023
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -124,6 +124,7 @@ enum vc5_model {
>         IDT_VC5_5P49V5933,
>         IDT_VC5_5P49V5935,
>         IDT_VC6_5P49V6901,
> +       IDT_VC6_5P49V6965,
>  };
>
>  /* Structure to describe features of a particular VC5 model */
> @@ -683,6 +684,7 @@ static int vc5_map_index_to_output(const enum vc5_model model,
>         case IDT_VC5_5P49V5925:
>         case IDT_VC5_5P49V5935:
>         case IDT_VC6_5P49V6901:
> +       case IDT_VC6_5P49V6965:
>         default:
>                 return n;
>         }
> @@ -956,12 +958,20 @@ static const struct vc5_chip_info idt_5p49v6901_info = {
>         .flags = VC5_HAS_PFD_FREQ_DBL,
>  };
>
> +static const struct vc5_chip_info idt_5p49v6965_info = {
> +       .model = IDT_VC6_5P49V6965,
> +       .clk_fod_cnt = 4,
> +       .clk_out_cnt = 5,
> +       .flags = 0,
> +};
> +
>  static const struct i2c_device_id vc5_id[] = {
>         { "5p49v5923", .driver_data = IDT_VC5_5P49V5923 },
>         { "5p49v5925", .driver_data = IDT_VC5_5P49V5925 },
>         { "5p49v5933", .driver_data = IDT_VC5_5P49V5933 },
>         { "5p49v5935", .driver_data = IDT_VC5_5P49V5935 },
>         { "5p49v6901", .driver_data = IDT_VC6_5P49V6901 },
> +       { "5p49v6965", .driver_data = IDT_VC6_5P49V6965 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, vc5_id);
> @@ -972,6 +982,7 @@ static const struct of_device_id clk_vc5_of_match[] = {
>         { .compatible = "idt,5p49v5933", .data = &idt_5p49v5933_info },
>         { .compatible = "idt,5p49v5935", .data = &idt_5p49v5935_info },
>         { .compatible = "idt,5p49v6901", .data = &idt_5p49v6901_info },
> +       { .compatible = "idt,5p49v6965", .data = &idt_5p49v6965_info },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, clk_vc5_of_match);
> --
> 2.25.1
>
