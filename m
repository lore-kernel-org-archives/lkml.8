Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467FC21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCBQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:06:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35836 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBQGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:06:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id b18so10827433oie.2;
        Mon, 02 Mar 2020 08:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCQ00dGXGbkpTntEBszN/cZPJvdcqZI+tE1FzP8Z8RQ=;
        b=II7i2Eo7k1U54Nr4oxK8izk9M3W9Km+cyzw0L4UzvyQhC+rvBbqg4SKDStK6kB1DR4
         ar14uJJvYwSKmLoQ3C/Esp+F/ARy4CucddMSuHFsbGdnNXgmx+DAYgV0nc9Dl179pbmE
         brq2gYA+DtAlwQaVPQiJpRK9iEzmgm9iX57IgxYPTcTwGK9gWwYAwlH84U9hFqBFitgu
         JItiLhAB7FKXLdRapG7Tx3guPoBLXmM9CnV72shNql12GgfFUX86oOppYjqAkhYt7Y+c
         692usl7i2phjgmYkdF5bOB922Gu0ugWOqz1/K8pwlR9RIdouTfWlpwx5z/r13HsOmesG
         aexg==
X-Gm-Message-State: ANhLgQ14VV74OmgaSxTcp5V0CnH5GnBDfZ/o2wz5szzuGOlanxji6jVc
        XudBcNZuTu10p+HUAp9g91i6dNMkyRIVceTXlf4=
X-Google-Smtp-Source: ADFU+vtZXz8SdSye/nw2ap/8pa8hJSZRa2xsrVK0nFccLQ9abSV85WjQel7krZaM1uARTj33atQw5Vpq2PqAvGuFoIQ=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr119333oif.131.1583165192444;
 Mon, 02 Mar 2020 08:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20200228084027.10797-1-luca@lucaceresoli.net>
In-Reply-To: <20200228084027.10797-1-luca@lucaceresoli.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Mar 2020 17:06:21 +0100
Message-ID: <CAMuHMdXNiZLmkLyuyvPCzdE9BdFoMDzKuGgAzRuPkv8jd2F4zg@mail.gmail.com>
Subject: Re: [PATCH v3] of: overlay: log the error cause on resolver failure
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 9:40 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> When a DT overlay has a node label that is not present in the live
> devicetree symbols table, this error is printed:
>
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
>
> which does not help much in finding the node label that caused the problem
> and fix the overlay source.
>
> Add an error message with the name of the node label that caused the
> error. The new output is:
>
>   OF: resolver: node label 'gpio9' not found in live devicetree symbols table
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
