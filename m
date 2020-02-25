Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E5EC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E8B20726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgBYLKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:10:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41717 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbgBYLKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:10:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so11682922otc.8;
        Tue, 25 Feb 2020 03:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ShF1rKEK1sHJi4bV5AliSANHk/vwDEu/sJwUMKOAytQ=;
        b=Fg/TotUMSk7QXSXk+m98jtZD8Vl88pH3O57RgFun3g3aQJMM/bL9DlHkQdMlJ9HsCa
         uPYtx9Foya/owzzapQlN7pr197BYCoNKd16yA+RHpmlBkcktnWzag9cHY3YtVtxHAgAc
         2rXfvh9zkT25B4TsF5SxJyV7FsfG1gi+cuE8L2g43agkEq3NF/ylGx+Au152O0Qe2LYF
         s0BDRGCjA+OIh6EwzWlA3V7ffdNlN185/fEiDBN3yAKTFvRYPUN2XsLwgn+p4Wwqz+Js
         loTuNRZC4vD3E/tM8XzHpIDdwza9ArLxAftRJec3h8/oJ+1b95Vai7VMbko07NYYMKll
         2GaQ==
X-Gm-Message-State: APjAAAW4WTp5KG4Fx4NqLybVelarfBNATrKDg82H3+YEuyV687HgRoX2
        +ovl9/N2K+u+JyReD/mppCbzFF9gpVV0oeD6ZP4=
X-Google-Smtp-Source: APXvYqxrMaSMRykUQR0d01z8RXFwEIAPMGRIumb8H1Es0tsGNPGUfg1hHfXUZPkQRkGTPUS0CeT4/nilPWSHjFSskVc=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr44161260ots.250.1582629035571;
 Tue, 25 Feb 2020 03:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20200225104223.30891-1-luca@lucaceresoli.net>
In-Reply-To: <20200225104223.30891-1-luca@lucaceresoli.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Feb 2020 12:10:24 +0100
Message-ID: <CAMuHMdVuk_BcFH16eBQYeQxREAF9VPz+R_sBKQpG0jQ8JDLn0w@mail.gmail.com>
Subject: Re: [DT-OVERLAY PATCH] of: overlay: print the offending node name on
 fixup failure
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, Feb 25, 2020 at 11:42 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> When a DT overlay has a fixup node that is not present in the base DT
> __symbols__, this error is printed:
>
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
>
> which does not help much in finding the node that caused the problem.
>
> Add a debug print with the name of the fixup node that caused the
> error. The new output is:
>
>   OF: resolver: node gpio9 not found in base DT, fixup failed
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Thanks for your patch!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> NOTE: this patch is not for mainline!

Why not?

> It applies on top of the runtime overlay patches at
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git on
> branch topic/overlays, currently based on v5.6-rc1. This looked like the
> most up-to-date version of the overlay patches. Should there be a better
> place, please let me know.

Topic/overlays does not contain any changes to drivers/of/resolver.c,
so this patch is applicable to mainline, too.

> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -321,8 +321,11 @@ int of_resolve_phandles(struct device_node *overlay)
>
>                 err = of_property_read_string(tree_symbols,
>                                 prop->name, &refpath);
> -               if (err)
> +               if (err) {
> +                       pr_err("node %s not found in base DT, fixup failed",
> +                              prop->name);
>                         goto out;
> +               }
>
>                 refnode = of_find_node_by_path(refpath);
>                 if (!refnode) {

Probably you want to print a helpful message here, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
