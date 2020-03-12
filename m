Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5qnSI/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCLODC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:03:02 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:46533 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:03:01 -0400
Received: by mail-vs1-f42.google.com with SMTP id z125so3712999vsb.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zysX7qFYbDmKJo1IBHQgRnNsdUs6tucfRVl/03d4EcI=;
        b=W5qnSI/Rg0ZpnMoMIiQQtG0u9dC1a/NQIbHDTXYIkkmXZZcZs1lK35lotXl9zI5pWJ
         ZZwXZQBDjrM1oXrZUVmcKtxELuB/ObXSHOf9yWdc8/XKWubpMLJT7oRw+/8hzeFoXXCj
         4yoeFjDy/nUvwESGvlU5Flp0B+WlbF5K38vJSbihp1dvbW5Dtagu41V3FckxTySnhCT8
         3wu0ApE+Dd/SCAXVa3gRog6dttNgafLHj1kT8g4/qxsiqeSaa2dETBg0ctXC0Kctu33B
         zvk7aHYJA1ScC6ORBhWua4g+l334oiY4UCA/anZJABiDZpT+2vEGPiLV2Ab5hfBILRsM
         0dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zysX7qFYbDmKJo1IBHQgRnNsdUs6tucfRVl/03d4EcI=;
        b=X9iTStjNayjGRsrBbpJa7K+rs+5FWZ8PtvtapCaOwCWUU1fYls4Gpc2E+xE0bR3Gq9
         XqbxD67IVlGeuESY/o9r7EWMiDCiFpLIi61k8xil+IDZEFBIVboSGyVO32Jj2rVbYnqh
         P0WlG+OMMolOt5gV2Lfo/d/kIffVI+i3V364In2EqpVJIv0uOJ8GbxmjMPY5CbYEEHad
         odLa5BEaRnG8ufyzKyFoVanlb1INn383AFsL0EQitmUj7HHP5xDYK+RXDmxuvmbVrdGW
         WmHJaBtiRLCALowJYXG891c/bJiQ0utQojDCWkWleJeUIeOOiDaEcWpR/PjNaAHg5K4d
         6aiQ==
X-Gm-Message-State: ANhLgQ3b6Gs4y6eqR65j/m30B7gWaV072DoAv68/faLghLPHRijsmnTF
        jVJwBcdf6HJ0dLWGp54o0KbgUh8ohdChTBVr0N92Ng==
X-Google-Smtp-Source: ADFU+vt7EeOnJ+ZBCw5gB9SsNeP/gX+fSmg9aGBxAPxWxdByZ4i/8Gty9RCQLLokH1QngmeCcUeS/Onx+U3JOvHW0kw=
X-Received: by 2002:a67:7c8f:: with SMTP id x137mr4767187vsc.99.1584021780188;
 Thu, 12 Mar 2020 07:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200123210242.53367-1-hdegoede@redhat.com> <158396292503.28353.1070405680109587154.tip-bot2@tip-bot2>
 <CACRpkdYPy93bDwPe1wHhcwpgN9uXepKXS1Ca5yFmDVks=r0RoQ@mail.gmail.com> <1cb0397f-e583-3d7e-dff3-2cc916219846@redhat.com>
In-Reply-To: <1cb0397f-e583-3d7e-dff3-2cc916219846@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 15:02:49 +0100
Message-ID: <CACRpkdb7vxSaK1Df6gNX_Kq-LF=S1qx2iKdmBy1Ku0vEpDVPbA@mail.gmail.com>
Subject: Re: [tip: irq/core] x86: Select HARDIRQS_SW_RESEND on x86
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 2:49 PM Hans de Goede <hdegoede@redhat.com> wrote:

[Me]
> > I see that ARM and ARM64 simply just select this. What
> > happens if you do that and why is x86 not selecting it in general?
>
> Erm, "selecting it in general" (well at least on x86) is what
> this patch is doing.

Sorry that I was unclear, what I meant to say is why wasn't
this done ages ago since so many important architectures seem
to have it enabled by default.

I suppose the reason would be something like "firmware/BIOS
should handle that for us" and recently that has started to
break apart and x86 platforms started to be more like ARM?

Yours,
Linus Walleij
