Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91886C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7C620733
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="ms+A/tTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBHSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:43:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53832 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbgBHSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:43:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so5726670wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pkGGU8cEcpg1WQ5oeotxdCpOUBGNhi+JYRWVa+V80s=;
        b=ms+A/tTuvVz3HZCbAlRinLVe0SmeiI3IuRip/0uQPzHbS9mUbtBNFcgeSke7bLaLSp
         p5pgxVUFVWi2o+JvDU/dCAkNUKIwrCe5x+XurkivpcLK+ONpQm0aNnwLePtsKr2qGk0F
         PIUqpCV4OgxB5Clg78ul1dEnBJQqlb+Wm/dVlpVgInHGrWnynXzHG5xdBFivNhc1a4y+
         pWbLAE5x3LdoSNIyrCnG8Uq/2rd4rELIqEg8m69IeDmeAv1okYOMcgkjrScZ/bjfwNoT
         BCQffulbka/25ZR/6d1EvPDrVwadiuJbkfmlKsw9jN9iVuThDkS/FMsdAa4OKYi0zKAQ
         H/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pkGGU8cEcpg1WQ5oeotxdCpOUBGNhi+JYRWVa+V80s=;
        b=mhOvOnr/zioN3AU5nmCTF3rgfe3zPZhC6/OtQoT1gqNsrbBwAQkaR1iKtnlPXE9v8E
         eTobqCpC7qxyA/8L/wER/GVlzEa+4qWs9sp/JIcXL2WjaWeP5BOBCUl9QEU9JHith2Qi
         CN/Vg2hZDcbgxvGJd04bW34aRMze30M5scX/rHcJnryBYJlmIA5YNfoT7Hb0+T43hDDb
         y4Mhs6HalkOsz3TRECd/YjKSVrQLIdTiB1EvE+JkLRq906mB5AcjhZbd48YkzdAIreBd
         3dThQYWI7hFmI0WjLR922NUdt+r7t78bS5roVcdccg6N1lDHyg5babIQxxvTgkKOneaU
         6SWA==
X-Gm-Message-State: APjAAAXELz1B1LiUpCkWKVn5F1xUGciuLJqSH2JhD12h4v/1LMoRffGR
        +dPg4ARuV2vOYA11lWLJuqNf1KwNy+9PFts1yl+7Qg==
X-Google-Smtp-Source: APXvYqxtmrVmPK8v7/hnwsOr9LLRPCmhswgHaA017VNaGV7/DhRBF2VBSd/TMopxN856SckCGc/G/zrwkCk+G1ht4Fw=
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr5128787wme.23.1581187416790;
 Sat, 08 Feb 2020 10:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com> <20200207075654.GB2667@lahna.fi.intel.com>
In-Reply-To: <20200207075654.GB2667@lahna.fi.intel.com>
From:   =?UTF-8?Q?Micha=C5=82_Stanek?= <mst@semihalf.com>
Date:   Sat, 8 Feb 2020 19:43:24 +0100
Message-ID: <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanekm@google.com,
        stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        levinale@chromium.org, andriy.shevchenko@linux.intel.com,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, rafael.j.wysocki@intel.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Hi Mika,
> >
> > The previous patches from Dmitry handled IRQ numbering, here we have a
> > similar issue with GPIO to pin translation - hardcoded values in FW
> > which do not agree with the (non-consecutive) numbering in newer
> > kernels.
>
> Hmm, so instead of passing GpioIo/GpioInt resources to devices the
> firmware uses some hard-coded Linux GPIO numbering scheme? Would you
> able to share the exact firmware description where this happens?

Actually it is a GPIO offset in ACPI tables for Braswell that was
hardcoded in the old firmware to match the previous (consecutive)
Linux GPIO numbering.

> > > What GPIO(s) we are talking about and how does it show up to the user?
> >
> > As an example, the issue manifests itself when you run 'crossystem
> > wpsw_cur'. On my Kefka it incorrectly reports the value as 1 instead
> > of 0 when the write protect screw is removed.
>
> Is it poking GPIOs directly through sysfs relying the Linux GPIO
> numbering (which can change and is fragile anyway)?

I believe so, yes.
