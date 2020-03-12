Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954D3C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A080206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQu62EYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCLMGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:06:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCLMGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:06:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so7107307wrm.9;
        Thu, 12 Mar 2020 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2p/7SIg8MCZHxFUY3pP8RLBthQecsMKTDvHJF9Cxh4=;
        b=cQu62EYVZoH9uWyGFbyd7rLtCEUYWD9fCPPmFQlWWv/s9rTLVzvviBTYVvVhlAUisS
         Jp7Rjv9lwe+54BtrTfsubzxpPk2djT+d5lsR9hCrSRf9qvZN5b2NHGmkvOByolYU+98L
         DtrHR1x1AkLEXKbWI4H46uDIE0kW8DMeuE7Houy8gTEyTIaGyPKnTk/TacWigIWISEQe
         SS6Qm5yCkLBkAKZrqCw9yrGiIX0ZgsOYlJzHJIO+CplDfGBRnaeBc3lKkRyDeEI7JcYm
         ntuS9KWNZO7pCoerj5U+DwiHb3Qb4WrOQYt6Zl3J2ZIuJdmimLe0o+wU+hk2rfUSWXtX
         sfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2p/7SIg8MCZHxFUY3pP8RLBthQecsMKTDvHJF9Cxh4=;
        b=NB/0TvCH6vFAMy8r4xJXzI9X0XFRxOScU2r5pMa2JBpa50pvZPQiwmUILczyVj73sn
         E6NNRMe5voS2h04S6B/VAMDc8YMEk8B0c4KBKcvwCHeNe72n2Q4NKDI+n2ClbDWPgwzq
         lHzT/jZOMX0nWDFkCNxyGTB8FjG0jIppfD7AvViqL8COdh1Kf55s3qOuQolJ2ahg0+VJ
         yB1GD3MhvrsKKECHsikrHFP3C1qP9ZBSJ0AiT9EqFrwzTW676Oy0Y1AXae3dRGbsOCM5
         drSOX+Lu9kzHMzMa8rd196S0yeRpffFG2eR42USbXRsLnAjolp8/k5z5PS/qoTgQeMkx
         ZN5Q==
X-Gm-Message-State: ANhLgQ1ccaI1LseMuX4rNwfTy6dGc70dkEacUHjd8tS7sVfbkVaTC6sq
        2bTz3KhCPimFBdaUiUHom1gxWOE3nxcwS7gIyRU=
X-Google-Smtp-Source: ADFU+vt2XB+Cs+k9BSJreoLcKSt8xFNXmOK4MreSyN5BoEuSGaDnBeErsHZRQaBi8jrLmM1GoqXOcvzph96UGXsVIPA=
X-Received: by 2002:a5d:420c:: with SMTP id n12mr10711313wrq.173.1584014808827;
 Thu, 12 Mar 2020 05:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
 <20200309204326.27403-3-thirtythreeforty@gmail.com> <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
In-Reply-To: <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Thu, 12 Mar 2020 07:06:37 -0500
Message-ID: <CACmrr9hSK1CzDGQ9_v6gNF7TBH65J-QAL_pwQJdKCc4ZxF_-ww@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on
 suniv SoC
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

On Thu, Mar 12, 2020 at 1:51 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
> <thirtythreeforty@gmail.com> wrote:
> >
> > The suniv SoC has one USB OTG port connected to a MUSB controller.
> >
> > Add support for its USB PHY.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>
> Not sure why Icenowy's SoB is here. If she was the original author, you
> are supposed to keep her name as the author.

So, I was unclear on the convention here.  This patch is based on her
patch, but I've modified it and rebased those modifications back into
a single change.  I'm happy to change the author field - does it need
a "Co-authored-by: myself" here?

> >
> >  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> > +       { .compatible = "allwinner,suniv-f1c100s-usb-phy",
> > +         .data = &suniv_f1c100s_cfg },
> >         { .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
>
> Please use the same style (and ignore checkpatch.pl on this one).

Very happy to change this, it was bugging me!

George
