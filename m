Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542C8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283482070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DMw1BKgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgCXOTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:19:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41915 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbgCXOTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:19:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id v1so6738913edq.8;
        Tue, 24 Mar 2020 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehoOnX7cANRVwJFsnMxVRh4r6y5ZhsDcj+HsQoBA7+k=;
        b=DMw1BKgt0azEVcvVYUMM1IkV7V4vJbbF4AiQjha6peh3TlOebMmfm3ZPhdRYb8grnF
         CZzf0+AGl+SprOwNMoeDLN9U4c7Uz1aFz99MhqCPezI+SnIH6QankzBqanoEDdD8SKK6
         AnIcnrIn+joXS+F83m5TdbQhZpZ77Cs1WBoJCdZ0JXlg04f90b0SFshmAwhx5ompDdVE
         F7gm9WQVGNdvhE4qTCtU6wRRaQ53ZRWr4FEqpeMaqzuUcYHKoQ9/qHd+7UCsMXsDXcjN
         QMCgzI8IPVA/dhA4/7kVk2i331h9ORzUSCavNwrSWZMmYbhJ2IKONWu8xYsvNbBLWx7Q
         ZQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehoOnX7cANRVwJFsnMxVRh4r6y5ZhsDcj+HsQoBA7+k=;
        b=St5zo7rQku72HVujPKeFjDnKVsXPdMHCZAxy1AjB2sJoJTEG0aLHKV8hTOS9YZW0lN
         8uQ++Vce+ogzB7HziviCAECz1Yi5mCS1/oP6V6kK51lmAzx2d2c5eA2KePqWxTI4jPcN
         v6vs0a8VozFvCshIT9h+CNtHBB4oCw/nFaAdrQYMA+pOZORhKDzOGkL/LWlbYpaoJeD2
         EfiDHFuuOOz4SUd1rNg9og7LAvxCQyn6Q6FE5C3YOrUE+V/BH4n/WxPNS3HLciNO+DJr
         VVWFPVpy5rHYGdFY7plp+DPb0FSPpRESjUfgF4Tz4NI8Q1uaWQ9CLAPAnfngvCsp6M3j
         SaiA==
X-Gm-Message-State: ANhLgQ3LesrOLGBTRRECI/XMQO68cjTPUYdj1rJsmItbue12wKSpVGF4
        0hgIFXqPp2zzMcwcRlof/VcnjM/SZeAzm+aJUWg=
X-Google-Smtp-Source: ADFU+vt31prwEca7GwsYh+geJS6aapO+qLf6iqX1sFmVz6WP6dYHwK3JRoZpOYFXuRR1Je8lCqAgLKZWE4TAor0WPYU=
X-Received: by 2002:aa7:c910:: with SMTP id b16mr7488409edt.13.1585059551514;
 Tue, 24 Mar 2020 07:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200324102030.31000-1-narmstrong@baylibre.com>
 <20200324102030.31000-3-narmstrong@baylibre.com> <CAFBinCA9rQKWx47F2-dT4ZrCwSKW+LiwAH2VdzPKr-9ymRxkSw@mail.gmail.com>
 <a7020606-57be-81de-da2d-73d399853217@baylibre.com>
In-Reply-To: <a7020606-57be-81de-da2d-73d399853217@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Mar 2020 15:19:00 +0100
Message-ID: <CAFBinCDOrhXAEwPf4L8-5XoCGqDT89=L2CX2Qsr2J-1pQp6N5Q@mail.gmail.com>
Subject: Re: [PATCH 02/13] usb: dwc3: meson-g12a: specify phy names in soc data
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjie Lin <hanjie.lin@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 3:17 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 24/03/2020 15:13, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > [...]
> >> +static const char *meson_a1_phy_names[] = {
> >> +       "usb2-phy0", "usb2-phy1"
> >> +};
> > my understanding is that the A1 SoC only has usb2-phy1.
> > +Cc Hanjie Lin to confirm this
>
> I forgot a comment here, it only has a single PHY, but still the 2 U2 PHY
> controls slots... it would need a large amount of code to handle this
> tweak, and leaving 2 PHYs keeps the behavior before the patchset.
I just reviewed patch #3 and I now understand that it would require a
large code-change
I'm fine with a comment


Martin
