Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C641BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD662465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 07:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQdXjdRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVHCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 02:02:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46198 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgAVHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:02:46 -0500
Received: by mail-yb1-f195.google.com with SMTP id p129so2642015ybc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 23:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaX0HZcPwl0YS02WEUsbNoZs+84h6QQErJ2NiHAQQt4=;
        b=DQdXjdRolxFhDjUI/My5vjFZRIeQIF4rTa+uE1+W4OOVi7BTICAa583VYBOP9w5Bfs
         fCUZsP2zBOhLxrhQ+mQsHo3HavflweOvSGnl5LeRpkiLuc82SHsybXLcDZn92RiHXDXi
         pdxsCwRlYVOnEGtJjL2RyYEWHxV/W7mYYSuJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaX0HZcPwl0YS02WEUsbNoZs+84h6QQErJ2NiHAQQt4=;
        b=lKQD+2uoTgEkXSgJ2gm7JvvL9lCvxClPwqWZrhW8e6j6hVJ9UibTDPk7VuQRLusAHI
         t9N/hgGzDO7nuLNj+G2sS385/xu1NRmfbL/yUCEULO2u4kx22nOx0j6imp+nKVwNPwJF
         Yb4Q3n4BnMPTwaqjchQoq9+PxcN/VPYnzBpfajfAvVxRayT2xCNf34NFMmvUCkMj2E+I
         z4KLpT+ZLC5D29EBvpxzJxaBxKMT7UROUDrVDMImiNyRZJmpHk649V4sBu+/gmiHWLW1
         gfmYvixxTdjZ0LAZj6BZeblhg0lwscwL00Ael63W4IdLsBS9KTOZY4gC9Alqv+evsokM
         G3JA==
X-Gm-Message-State: APjAAAUxha0y2z/9vgCV4nqBeA+QqhbKwaSeQbYcOw9CN+nA1Aw4WX9a
        RDmLX+923KmjCfGsE4sqVWZkUaB3sFvNlVU+dPpt5w==
X-Google-Smtp-Source: APXvYqw3lgzzHaQ6O1QvLGLfo9XXd6gDdSmwm2wKGrSHozPz8hXQ4/w9BOwAI9Ltz1u1Z45qP5VaYFilIK8vrwXzo9Y=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr6737555ybk.77.1579676564950;
 Tue, 21 Jan 2020 23:02:44 -0800 (PST)
MIME-Version: 1.0
References: <1394712342-15778-338-Taiwan-albertk@realtek.com> <1394712342-15778-347-Taiwan-albertk@realtek.com>
In-Reply-To: <1394712342-15778-347-Taiwan-albertk@realtek.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Tue, 21 Jan 2020 23:02:31 -0800
Message-ID: <CANEJEGs+K9rFqzFG_4cPaQvi9FV3L5jMdCi4KYtcfpg1x+nwjw@mail.gmail.com>
Subject: Re: [PATCH net 9/9] r8152: disable DelayPhyPwrChg
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     netdev <netdev@vger.kernel.org>, nic_swsd <nic_swsd@realtek.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Grant Grundler <grundler@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 4:43 AM Hayes Wang <hayeswang@realtek.com> wrote:
>
> Enable DelayPhyPwrChg let the device fail enter the power saving mode
> of P3.


Hayes,
I'm very curious about this commit message: why would one want this to fail?

Did you mean "don't allow the phy to enter P3 power saving mode"?
If P3 power saving mode is broken, what is the symptom?
How long is the delay when this is still enabled? (to help identify
failures when this is still enabled)

BTW, I've reviewed all the patches and don't see any obvious issues
with them - though I don't have the technical documents to verify any
changes in behavior.

I did see two typos in the commit messages that could be corrected if
you need to send out v3:
[PATCH net 5/9] r8152: Disable PLA MCU clock speed down
   s/packet lost/packet loss/

[PATCH net 6/9] r8152: disable test IO for RTL8153B
   s/casue/cause

cheers,
grant

>
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>
> ---
>  drivers/net/usb/r8152.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 0998b9587943..c999a58ddda9 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -31,7 +31,7 @@
>  #define NETNEXT_VERSION                "11"
>
>  /* Information for net */
> -#define NET_VERSION            "10"
> +#define NET_VERSION            "11"
>
>  #define DRIVER_VERSION         "v1." NETNEXT_VERSION "." NET_VERSION
>  #define DRIVER_AUTHOR "Realtek linux nic maintainers <nic_swsd@realtek.com>"
> @@ -109,6 +109,7 @@
>  #define PLA_BP_EN              0xfc38
>
>  #define USB_USB2PHY            0xb41e
> +#define USB_SSPHYLINK1         0xb426
>  #define USB_SSPHYLINK2         0xb428
>  #define USB_U2P3_CTRL          0xb460
>  #define USB_CSR_DUMMY1         0xb464
> @@ -384,6 +385,9 @@
>  #define USB2PHY_SUSPEND                0x0001
>  #define USB2PHY_L1             0x0002
>
> +/* USB_SSPHYLINK1 */
> +#define DELAY_PHY_PWR_CHG      BIT(1)
> +
>  /* USB_SSPHYLINK2 */
>  #define pwd_dn_scale_mask      0x3ffe
>  #define pwd_dn_scale(x)                ((x) << 1)
> @@ -4993,6 +4997,10 @@ static void rtl8153_up(struct r8152 *tp)
>         ocp_data &= ~LANWAKE_PIN;
>         ocp_write_byte(tp, MCU_TYPE_PLA, PLA_LWAKE_CTRL_REG, ocp_data);
>
> +       ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1);
> +       ocp_data &= ~DELAY_PHY_PWR_CHG;
> +       ocp_write_word(tp, MCU_TYPE_USB, USB_SSPHYLINK1, ocp_data);
> +
>         r8153_aldps_en(tp, true);
>
>         switch (tp->version) {
> --
> 2.21.0
>
