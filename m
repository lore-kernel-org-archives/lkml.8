Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52828C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC2620B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8CKmrpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgGTOPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgGTOPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:15:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA5EC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:15:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j11so20402578ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfDULJX5Fvi0AnSdtZ5x+Bly5Vi8m2zGpSYTEybdvqg=;
        b=X8CKmrpKIRDTR+391ddqGlixEfo0VQi97P2ADPs7vuh5NP9YgZk7+L7U6CmkKa6OY3
         hPVuGIju545zlwUnlWzs/vPd64g/P8uOifPACHN95/KPV6ng3T6XTFavh9K7dtwhiifD
         Tmekf23hliYhrzOx//efBGMF3o9ekZ1HjTeQPye6OUtK0YBNMXZ27znaM61e7FRrSlnO
         hrbaXMIZ+Sw3y5dXT3zbl18epj326Su4k08b4C9xGpjCWrc4Dxa4Mubf/gVYifOMq5gh
         0y2dJA0UPEhTyN3WepdWepfYWQeLp4mJbMPVNpMFivC3aURIOpFYhxxr5gMHBBvo1Pze
         kC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfDULJX5Fvi0AnSdtZ5x+Bly5Vi8m2zGpSYTEybdvqg=;
        b=sy49vEHEolLbUcbQZyi91czMDpqM7tcXu8PQ5+2w9GzzFSga4b1FDp8m7FCQF+jQAq
         SDu7roKZG34qRh/I7tuHccyJPmKb7Xft/ZoOu+FifShh5HkYpu1MNoVPTQ6luztyybRI
         hTvIaTQkC4SO3swXoqWHhmFC86dGBwtrUkRTc+m9J6YOFiFsXrR3RJL/Z2w5XdtE+ais
         /M6LoOmpdOJNYZmRZFSUVTi3a7ImmDByk025yBtx2mKihzNeNrZu2qFgr7pnyBJ/vmgN
         voAazKNfr06nCiDsL1kMlYc3HBemTkBp5f2NKP0N1q8iIyxwnQYyaQhSucvnmZuxdNch
         xVpg==
X-Gm-Message-State: AOAM5332ej+Hr5EGzCRcwOxZgm9o+sk2kdLgpKeqOmjaA1hIcIR3zYfN
        BwQfLbRcTCYgucFfuiWPahGSuqFOYfnpj693GLx6Wg==
X-Google-Smtp-Source: ABdhPJzJjx8vNcnh/65/X4MGI6RRl+bTcBOm3KWASNFqOxp/j8FXGDaynb8IYg5p7ZlpUYwl1qRNQBpiH+ql0tKsRqs=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr9748320lji.338.1595254529367;
 Mon, 20 Jul 2020 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200706070259.32565-1-ricky_wu@realtek.com>
In-Reply-To: <20200706070259.32565-1-ricky_wu@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 16:15:18 +0200
Message-ID: <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add
 support MMC_CAP2_NO_MMC
To:     ricky_wu@realtek.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, rui_feng@realsil.com.cn,
        Bjorn Helgaas <bhelgaas@google.com>, kdlnx@doth.eu,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 9:03 AM <ricky_wu@realtek.com> wrote:

>  drivers/misc/cardreader/Makefile   |   2 +-
>  drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
>  drivers/misc/cardreader/rts5228.h  | 168 +++++++
>  drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
>  drivers/misc/cardreader/rtsx_pcr.h |   5 +

This drivers/misc/cardreader business is a big confusion for my mind.

Is it really that fantastic that it needs to be a unique special case?

To me it looks like a drivers/mfd thing which should have separate
drivers/regulator/rts5228.c (LDOs)
drivers/clk/rts5228.c (clocks)
subdrivers.

See for example drivers/mfd/sta2x11-mfd.c thay spawns a few
devices off a PCI card.

Yours,
Linus Walleij
