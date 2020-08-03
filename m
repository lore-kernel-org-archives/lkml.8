Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE92CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899B920738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGZ0QXkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHCKSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHCKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:18:24 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56CAC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:18:24 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id d20so1206144ual.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnGkiTDp9E3rHzKy6YghTS3W9G53uuf3g0jyIUWx/X0=;
        b=eGZ0QXkMDfZSBr593z40Ozez0QyFSDV1hNy8UFRCYTx6p8fiM25n4T8MwpfXFskY/G
         emzpfy/R4uHBg4EtND4UOGHWc8gNPnFyZXyC0J3CocwU2QVf/vieXAWYuWyxMIjnX7Bl
         CRrMO7md4uUbAypGQdz6S65U0PjTqjQq9ixOT/WmKhPpdyJXseZj3E0nBvs3dB6xA8E2
         0nXf5XY8faXUfaV7WIw7kXCPPAbKM+/6h6WTcHbBlJyc8hyZ7agReGbUAxKlPZrEnpw/
         TrcxxBR6Mw15fvg/7WP8QyIm9F9lXF9hlGnRZ0DMmqBWtUFbmtW1BC2IdKSIk2Uf5Dpe
         Y1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnGkiTDp9E3rHzKy6YghTS3W9G53uuf3g0jyIUWx/X0=;
        b=h/Qk6QUSi0jgK/RpWWhlqyl7ty6uq27Sd2/DYJ1PFVeX3vxNoYizbgJ1COfNNih12i
         28IHyol70+W8zPC/j9xFsq1GpB9cBdkIlmFXKY9J8ptVZq1wTQ6pBAd6ufaM+4gHdsjs
         jskFxRcBVv/v9onbjBwVJXBCW6ZSf94/CEefRuokIJHx8vIvXXMYoNgRjWQ24f0JfcML
         AdmLnYEqN8jAB3nyXNuJ9eivVGASA7eTg+Q7yuPYvw35eWGmyvF9f4CFG9l5BHJbDIZv
         p/NxHwQQt1E4f8twO8mK4eQsJzzJgyQJRJ0BT+wcHTdGxoFEYryTX1MKnTgspqypeKnU
         +O9A==
X-Gm-Message-State: AOAM531EYDqkzqb5zBapgePZh2YY60iEkv9JhQbTnE5w0HsKa8bFqMht
        lD8xzdk36GytppYSaEWcpC2cBWaPPjpIw6BWcTk=
X-Google-Smtp-Source: ABdhPJzBwQ6qtnjisxk6h/1XBYxCcUnUvMtpeFdzghcFrthLpr5cK3BVOyTshFL2tGRaO01KTn7ytL8cx/hbnhdF/Io=
X-Received: by 2002:ab0:5a6c:: with SMTP id m41mr10374387uad.61.1596449903550;
 Mon, 03 Aug 2020 03:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com> <20200803095720.GC1375436@lahna.fi.intel.com>
In-Reply-To: <20200803095720.GC1375436@lahna.fi.intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Mon, 3 Aug 2020 11:18:12 +0100
Message-ID: <CAD2FfiFt6=OueX3E0g2ckPU+7F69yCmM0+bzF_6UD1sd4E_k_A@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 at 10:57, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I think instead of this we should simply make it so that the driver
> never tries to make the chip writable.

I think this is a good idea, but I wasn't sure if it was an acceptable
behaviour change. Should the driver still try to set BCR_WPD when
writing an image (i.e. defer the setting of write enable until later),
or just not set the BCR register at all? I think your last comment was
the latter, but wanted to check.

Richard.
