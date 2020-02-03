Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8975BC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605102087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgBCNfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:35:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38099 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgBCNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:35:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so13610452oth.5;
        Mon, 03 Feb 2020 05:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAKHI6U/8atRrhjXfusyx+ZolVRV8To+gMrA/PXOi2s=;
        b=FLe7gNjGchA51pkjpqG0jD6opj18pDwBjqM7s5VHQEL/3Hdp2NRJ596XilyakqQSut
         sMJVQHAqQLTl+PTfgPoXB3D6mX/o0ZpVKB1v4bop3SjWt+ek/bJhmvqVWcGuO1GrApB4
         D/mvC27ZEsu6b4N7pmVgu5qJTXW6D65iKemHN3tnEHltdwYh64qKJ+wMuU5NFLwKpfo1
         fvqz/iFJR5e1+fp/d+c3FBh5P5Cp6Itzjr5K+YTvGEtUzLok/vLVdt6AdRNqBqYmFp0v
         ANpyGQttfJXj6v5wFnkOmCMLGG7RdAmpges4UXbrY3UnYReTZCxNvE+mX7PMTMtrOmOG
         +GeA==
X-Gm-Message-State: APjAAAUfrMGXQ6BwwhUx5QBJxVySLgnWqKSOGYuoB2kX4K/BFhEMFCSI
        vhlM1wODcc4Fj3H0gLlyd57rNBnQX/cPLmXSjUk=
X-Google-Smtp-Source: APXvYqwyW3fVqbIvUd/QGLVmgEOuRzX+dpkiiijIR84M9xmx/U5hOyGtp+FXMGVOK97xnJ+WsT7/214jSQ+gBlQ3rjo=
X-Received: by 2002:a9d:146:: with SMTP id 64mr17855877otu.39.1580736931374;
 Mon, 03 Feb 2020 05:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <20200203101806.2441-2-peter.ujfalusi@ti.com>
In-Reply-To: <20200203101806.2441-2-peter.ujfalusi@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Feb 2020 14:35:09 +0100
Message-ID: <CAMuHMdXL=zi2P6K+3L8UtKbTu3bKE8+GSRtz=q9ZPdx9ePeW6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dmaengine: Remove unused define for dma_request_slave_channel_reason()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod <vkoul@kernel.org>, dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 11:32 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> No users left in the kernel, it can be removed.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Last user removed in commit f339f979bb333ed5 ("iio: buffer-dmaengine: Use
dma_request_chan() directly for channel request"), so

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
