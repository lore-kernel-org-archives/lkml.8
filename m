Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A511206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgHZLaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:30:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40895 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgHZL3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:29:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id u24so1191200oic.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyjOsgy6kraSv8aHLd4PWHdbJs82utSf/F+JcIOpHiA=;
        b=DNjOO+sCZZV5ns+6Nj5Oqq51IoFGCJP9229mdWleU2P9djUWayvKzgklQID793Dh6D
         qN/VadGOsI/ojva3Vodjk1RabppMG1tOlKr7d8LIV4nfWxwJ33SM1IDAd8uWU913oHap
         e+dHl4rbtYh+9J/LPlNh4ZWfcfNwb7BrmT3qG5GuoHb4NlJbiOOg3ZS/rdf9LiW1grEA
         T5SlX+Th/07jDmVHHnrCRh4nBNgqsHVRBkSHCyr60lgrpviVVbX17M0mcXmIPeEnO7IS
         k4mMDBywPsCSSAhdMM65Gs4GzKVsq5D2QHLjQKIW7CpiTGhEYXcTp017DXDz0+rnjxy5
         flIQ==
X-Gm-Message-State: AOAM532vgqq1eIYsW+pIa1foVVmDlbY/2bMOqMvfsh479Vpn2/xraAaU
        Oo9xrxflcr2N6jWiCEDXpse1xqNXU7wEEVAgqi9QRKad
X-Google-Smtp-Source: ABdhPJxUzKIMVu67ODsr0wOFJt8hPX16fug+D9cQxfCn3rdJ08t5AlCoWW8peZbcE3uJSJcg/lQbt4vM1sCVXcK6K8Y=
X-Received: by 2002:a05:6808:575:: with SMTP id j21mr3590400oig.54.1598441363259;
 Wed, 26 Aug 2020 04:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200720114314.196686-1-hch@lst.de>
In-Reply-To: <20200720114314.196686-1-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 13:29:11 +0200
Message-ID: <CAMuHMdUAeP34s_6Mk6BZR+6AScGOUbiUyrD-Wee=errk-jGA0Q@mail.gmail.com>
Subject: Re: [PATCH] m68k: use get_kernel_nofault in show_registers
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 1:43 PM Christoph Hellwig <hch@lst.de> wrote:
> Use the proper get_kernel_nofault helper to access an unsafe kernel
> pointer without faulting instead of playing with set_fs and get_user.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. applied, and queued in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
