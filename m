Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A2C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C45206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 05:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKBgOWhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD2FqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 01:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgD2FqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 01:46:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22FFC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 22:46:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so848765qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 22:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z6P3Px4RUsQGpCsP0tLcahroG5Q7PAYgk++UN9Efoaw=;
        b=QKBgOWhXO0CGqmIPgmrY/waFwwJCD1tMEsHj/0+i4Yksqe4nRqI9ez82ompbl4Znkt
         R75KhHsT+uL4Mb/QXMcentByrET3RCOnXsUuIyfA0S0Q6cTjIqlSXYv+4O+StaNST7Sr
         ByBO3ho9QnYrSomRn0ge+mt3rNN9oM5M5WREw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z6P3Px4RUsQGpCsP0tLcahroG5Q7PAYgk++UN9Efoaw=;
        b=ZTC6dZCHg/XJ9y/NvbsnOA/n5lWsH9+CrGqVjC69tFJrYVDqRfJPHreQR/4QXxbjqT
         UJswrXWTbB+cDqP72Nn1dTz9e+3Cv30gBdVdtAgayr8ZHrj34oG3FB/6il75uIZ/5eUx
         4FrNQ8/jV0YID+a3VxLlQvpuGRYvS19CzYVg9YElarzgkFIwexXioNiecznu2U3A7d5b
         Rlj0E4oMoFCXFcs1w7dGGPdxnEkqXpbOKdR1guYeNGE7gLFKAjkKTnJmsimi013W/Kko
         fsQmnC33WU2+KPdAkCtkJ+PO/dRCOW5vBULtnICCbsb2RN6SPSzaMyVthrIo8oL9N5vc
         8Owg==
X-Gm-Message-State: AGi0PubinSYvUitmQZQBTC5KvvblDeemBgYu8YleTVitJDwZkQ2k0w1z
        8vy+t4TVRbL5ODJoI0Xi7eyezFycZwI0VWNm7Nuc5pig
X-Google-Smtp-Source: APiQypK60pdEJh5Y5blGk+UcYQ0UpsJDO7M+MfFFuZSKu+VULMZ67IsZJHyhKEZjZ8OnqsEQng7a6fxdrUIP3BnEcjU=
X-Received: by 2002:a05:620a:7f6:: with SMTP id k22mr19884854qkk.180.1588139171615;
 Tue, 28 Apr 2020 22:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200429053319.113508-1-pmalani@chromium.org>
In-Reply-To: <20200429053319.113508-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 28 Apr 2020 22:45:59 -0700
Message-ID: <CACeCKaesd4tbHEfM+dX=cjRMAkWEwYtqF-d7D2vvjOsECfsb1w@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: mux: intel: Handle alt mode HPD_LVL
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, didn't compose the Commit message quite right, have sent out v2.

Thanks,

On Tue, Apr 28, 2020 at 10:34 PM Prashant Malani <pmalani@chromium.org> wro=
te:
>
> According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> 0.6, when a device is transitioning to DP Alternate Mode state, if the
> HPD_LVL in the status update command VDO is set, the HPD_HIGH field in
> the Alternate Mode request =E2=80=9Cmode_data=E2=80=9D field (bit 14) sho=
uld also be
> set. Ensure the bit is correctly handled while issuing the Alternate
> Mode request.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> ---
>  drivers/usb/typec/mux/intel_pmc_mux.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mu=
x/intel_pmc_mux.c
> index f5c5e0aef66f..c599112559e7 100644
> --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> @@ -157,6 +157,10 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typ=
ec_mux_state *state)
>         req.mode_data |=3D (state->mode - TYPEC_STATE_MODAL) <<
>                          PMC_USB_ALTMODE_DP_MODE_SHIFT;
>
> +       if (data->status & DP_STATUS_HPD_STATE)
> +               req.mode_data |=3D PMC_USB_DP_HPD_LVL <<
> +                                PMC_USB_ALTMODE_DP_MODE_SHIFT;
> +
>         return pmc_usb_command(port, (void *)&req, sizeof(req));
>  }
>
> --
> 2.26.2.303.gf8c07b1a785-goog
>
