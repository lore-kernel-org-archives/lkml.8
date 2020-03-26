Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083AEC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D406A20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ue1h1Ngs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgCZX0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:26:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45954 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgCZX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:26:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id u59so8971852edc.12;
        Thu, 26 Mar 2020 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqZyECE7b3l+/W5cG6aN6aQ7OERbPPJKLPh37gMr4P8=;
        b=ue1h1NgsTbotQg6qMgEzUEGsjz11gWWWp2SUopj+TH8eOOBmYryxsfc281mZqrloEv
         P76dythInNUEfdLKgr7SgCfjmFg6sE925yUai/7kD6iygiYW41tOLyueWqE41PZp/QQL
         FrX5esvWQpq4u2MT/46hJXxhdRYrB5LZG3OXoJRY8UAsN3fhBfF+Mmj+NBCYmBlhXkiB
         ee9g1chV624ys8iJxZOeJyLMD2lsOpr6uT72VNd2zFkDdFIzEQU1YJ3iJvKiaWZUvhxd
         8ctYZYkWyFiCfSr/Sev5oQ62jff2k4N93aiamR/xOeC6EwLqNDKHb5/vZDTffrPQMHeA
         j5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqZyECE7b3l+/W5cG6aN6aQ7OERbPPJKLPh37gMr4P8=;
        b=U3mjb2viczXn5UNIInSpTrD1qs9k91EIacNeAUJkp7WtX4zntiHRY6l3t52ujvc8OV
         orhdResRTti+Qqyf45272qh2ch7IVbvN+DMIwPKn9CDGSLXhUDdLKlbayUCFChHZgbct
         4FC0Mr9PjGKiVIBRo1UG4eJdUBRbk5yP5pCmV69T/cnW3WhNEjGDgVSi1RQBdYUEnXpt
         txwEXPs63Tu9wzIzTfbn9Vw37av0HQK233xppehjKikuPaCsQGZvhUN6D+6w6gTswAB2
         SqBuvdy2WMriX0glb0YCQVOOODOSfxDsj98DT4oMXIWwzMzxPPVFfWvNm5teWMhAJtvY
         BM5A==
X-Gm-Message-State: ANhLgQ35dGKMmUkpazLY+aEyggg9KqzaaaJtrySX00jDM/Nuc6MpTQpv
        PsDIjdzDbPDHJXKtNWgVTO3JjSypHR2I8RfhKsc=
X-Google-Smtp-Source: ADFU+vszUtR++CH3qXXBapVjGUYTUgP4+oCVQrrF3dM3CXErGyDOKMkYURV1D0IJSRdLQ53DbhvctfJOG7ec6N875qg=
X-Received: by 2002:a17:906:491:: with SMTP id f17mr162602eja.30.1585265176806;
 Thu, 26 Mar 2020 16:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200326134507.4808-1-narmstrong@baylibre.com> <20200326134507.4808-8-narmstrong@baylibre.com>
In-Reply-To: <20200326134507.4808-8-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 27 Mar 2020 00:26:06 +0100
Message-ID: <CAFBinCBhk+XvjGODBaNH7tzCfGktYdmk1wED8UC6cYmS3ucbig@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] usb: dwc3: meson-g12a: refactor usb init
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Mar 26, 2020 at 2:45 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> -static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
> +static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv,
> +                                    enum phy_mode mode)
>  {
>         int i, ret;
>
> -       if (priv->otg_mode == USB_DR_MODE_PERIPHERAL)
> -               priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
> -       else
> -               priv->otg_phy_mode = PHY_MODE_USB_HOST;
> -
>         for (i = 0; i < priv->drvdata->num_phys; ++i) {
>                 if (!priv->phys[i])
>                         continue;
> @@ -284,9 +286,10 @@ static void dwc3_meson_g12a_usb3_init(struct dwc3_meson_g12a *priv)
>                         FIELD_PREP(USB_R1_P30_PCS_TX_SWING_FULL_MASK, 127));
>  }
There is something strange with dwc3_meson_g12a_usb2_init.
enum phy_mode mode is added here but it's not used inside this function

I also think that we should not pass enum phy_mode to
dwc3_meson_g12a_usb_otg_apply_mode
I'm aware that the original function used enum phy_mode inside but
this doesn't seem right:
we're not configuring a PHY there
instead we're setting up the OTG switch so I think we should use enum
usb_role instead

[...]
not part of this patch but should be:
there's a still a direct call to dwc3_meson_g12a_usb_init() in
dwc3_meson_g12a_resume()
I think that needs to be changed to priv->drvdata->usb_init(priv); as well
