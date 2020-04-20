Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195EAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF70C2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgDTHJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:09:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41102 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgDTHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:09:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so7907021oia.8;
        Mon, 20 Apr 2020 00:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqzgTPsqGqTG082KlFRd2nLB+TsOjdtbh8/Iv4M7mXY=;
        b=ahcYLo7IbBzfuCDl+KHDYQ2aDaoyhg9pWdZbGL5KfhjepQfDbub7TScjqLLAzJWdyl
         ElSo5n4jfCJKBRURm+8SyZJc1SGLiOSkWoYdtFNeEPLZ5dpbnbG/mX+rW41IsI6NnPLc
         /wHPoX75byzha/qby1htio5dA6RpetExdByzoCacqS57ZW37OnPzRQdQ9xUcNI/vBc+Y
         +DP0GUUDOozTDIe+Y+eeh92ScmYQ0ysy+prXk7UNC+HecdA23VVD0kzuENZYlJjFGMie
         GQRl5s53ig4Xr18Di5lgDCP5sZWdmHzHcE4ZBmJCitYGLkzjerTMPO+yJjGzg/y5YOfO
         6woQ==
X-Gm-Message-State: AGi0PubUssHcLSwoyd9lA5FnJ5ww6P37vR7eBoY622ubgKNP5oEAwJ4g
        Sxo1wInqmt7aR2XmHrTERi72gw0RSrIhIlB3YZg=
X-Google-Smtp-Source: APiQypKGHCQK5p6sv+gc747Hng/rlsT/C7m3rCTyS0eq9olqr91xBNYEDwUpFysdhr4rAeuomxGpe2n/QxOaYd1MVVY=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr3273957oig.54.1587366550697;
 Mon, 20 Apr 2020 00:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200418070751.25420-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200418070751.25420-1-christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 09:08:58 +0200
Message-ID: <CAMuHMdUDO_rTzZbtOsMvH=uFG1oytTYDdJY_WSE7+70EERDNSw@mail.gmail.com>
Subject: Re: [PATCH] m68k/PCI: Fix a memory leak in an error handling path
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 9:07 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> If 'ioremap' fails, we must free 'bridge', as done in other error handling
> path bellow.
>
> Fixes: 19cc4c843f40 ("m68k/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
