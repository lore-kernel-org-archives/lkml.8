Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48166C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDFC20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DXhazW9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCXOdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:33:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33383 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCXOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:33:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so20959756ede.0;
        Tue, 24 Mar 2020 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqqNKN/fwkR6pokdkS+FvygaQUpQ4v7Tw1/17Jul044=;
        b=DXhazW9ruGeUUZliIqnasAbbXKy521jZ8QLY2rSxbUsFUjmEvxd5nyOWWl5MAYDm1F
         RWHKSeh0vpz3tIWxsJHE3VuTN2mKKHvksAYC0qrCK46BXcLqgKqHAR/L6wr+bGnxgI4Q
         RMR609bmrUvPxIZxOBFZIrq07AkMEU/DeD2Ig14lcgjQ4aoccXgZWBCU4sOi5t7L5t2t
         aeup/xE7KdZFvd8pev6SL/uyHB22gTdOdk+PDgmSSu4HWUlbDZvVL/C5I6+pkyPznDza
         ZBL6ZLl3pLfzrAVhoulvUX/TeXwPAy5A+Q5CSoJRPJLeyazdzuE4bBr2RhL8sT+/V3ig
         s9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqqNKN/fwkR6pokdkS+FvygaQUpQ4v7Tw1/17Jul044=;
        b=g1+c8AQdyx4hhwT9Fx7egFou73j6m+Cn6pgQFAz0+YBfTOJTVKrSQqIL0PZoABsgIc
         /u7II3b3ndkE5fwoz6AoVaj75IT/Ww1c8QkhFx9UB1ztt5gEFE13xbSVCgcyl5iJptG7
         gwpWhvuwQD9AyzblYQPUPVb0+gyFra03SDrdI1Iw/zPsJot1E6cjKij30GVRhBnzJX/A
         TDj0bqz5vMwF94K7GD8TZb4fWhlo3oEyZ1RXrBBjQrcpnnnJ+oO+JJwDRhSIpaLJoYyG
         v+3yNemy6Ed0GVrlYFyUhVby4AXz40LJxPGxJia5LioDX0VcZ7YbDa8vzRsyt1oH+B6j
         4E0Q==
X-Gm-Message-State: ANhLgQ2qU9TypabcY9oghtg18loGV670ZVKWJmN80Valp8/E1/suGc04
        7FcDuugX4qI4pxW9z9s2+sLqD8M9icg4KvgEnDg=
X-Google-Smtp-Source: ADFU+vvoB2bTSr1f8kFKut/nPCDhhp8NCXt+CrinYNbyc671g7XalQFaRlgTaKabgWUcUAHItC5U9BXD3aLyrUFCTVo=
X-Received: by 2002:aa7:de13:: with SMTP id h19mr27922573edv.52.1585060413064;
 Tue, 24 Mar 2020 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200324102030.31000-1-narmstrong@baylibre.com> <20200324102030.31000-6-narmstrong@baylibre.com>
In-Reply-To: <20200324102030.31000-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Mar 2020 15:33:22 +0100
Message-ID: <CAFBinCDrycKy6sJfpUjoB3_jkHP-ssmwvr-Cab1-fOmz_i_bGQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] usb: dwc3: meson-g12a: refactor usb2 phy init
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dec06e05a19aa2dd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dec06e05a19aa2dd
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> @@ -195,23 +239,9 @@ static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
>                 if (!strstr(priv->drvdata->phy_names[i], "usb2"))
>                         continue;
>
> -               regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
> -                                  U2P_R0_POWER_ON_RESET,
> -                                  U2P_R0_POWER_ON_RESET);
> -
> -               if (priv->drvdata->otg_switch_supported && i == USB2_OTG_PHY) {
> -                       regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
> -                               U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS,
> -                               U2P_R0_ID_PULLUP | U2P_R0_DRV_VBUS);
> -
> -                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> -                                                     priv->otg_phy_mode);
> -               } else
> -                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> -                                                     PHY_MODE_USB_HOST);
> -
> -               regmap_update_bits(priv->u2p_regmap[i], U2P_R0,
> -                                  U2P_R0_POWER_ON_RESET, 0);
> +               ret = priv->drvdata->usb2_init_phy(priv, i, mode);
> +               if (ret)
> +                       return ret;
>         }
this doesn't compile for me, it complains that mode is undefined
I believe we need something like the attached patch on top.

[...]
> @@ -580,7 +612,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>         /* Get dr_mode */
>         priv->otg_mode = usb_get_dr_mode(dev);
>
> -       dwc3_meson_g12a_usb_init(priv);
> +       ret = dwc3_meson_g12a_usb_init(priv);
> +       if (ret)
> +               goto err_disable_clks;
this looks like an unrelated fix, dwc3_meson_g12a_usb_init has always
returned int (as potential error)
also the same check is missing in dwc3_meson_g12a_resume
can you please move this to a separate patch with the appropriate tag:
Fixes: c99993376f72ca ("usb: dwc3: Add Amlogic G12A DWC3 glue")


Martin

--000000000000dec06e05a19aa2dd
Content-Type: text/x-patch; charset="US-ASCII"; name="fixup.patch"
Content-Disposition: attachment; filename="fixup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k85zzkgb0>
X-Attachment-Id: f_k85zzkgb0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1tZXNvbi1nMTJhLmMgYi9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtbWVzb24tZzEyYS5jCmluZGV4IDc0ZDA3ZGVkOGE3ZS4uZDJhNjBlNDAw
NjFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtbWVzb24tZzEyYS5jCisrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1tZXNvbi1nMTJhLmMKQEAgLTIzMywxMiArMjMzLDE5IEBA
IHN0YXRpYyBpbnQgZHdjM19tZXNvbl9nMTJhX3VzYjJfaW5pdChzdHJ1Y3QgZHdjM19tZXNvbl9n
MTJhICpwcml2KQogCQlwcml2LT5vdGdfcGh5X21vZGUgPSBQSFlfTU9ERV9VU0JfSE9TVDsKIAog
CWZvciAoaSA9IDA7IGkgPCBwcml2LT5kcnZkYXRhLT5udW1fcGh5czsgKytpKSB7CisJCWVudW0g
cGh5X21vZGUgbW9kZTsKKwogCQlpZiAoIXByaXYtPnBoeXNbaV0pCiAJCQljb250aW51ZTsKIAog
CQlpZiAoIXN0cnN0cihwcml2LT5kcnZkYXRhLT5waHlfbmFtZXNbaV0sICJ1c2IyIikpCiAJCQlj
b250aW51ZTsKIAorCQlpZiAocHJpdi0+ZHJ2ZGF0YS0+b3RnX3N3aXRjaF9zdXBwb3J0ZWQgJiYg
aSA9PSBVU0IyX09UR19QSFkpCisJCQltb2RlID0gcHJpdi0+b3RnX3BoeV9tb2RlOworCQllbHNl
CisJCQltb2RlID0gUEhZX01PREVfVVNCX0hPU1Q7CisKIAkJcmV0ID0gcHJpdi0+ZHJ2ZGF0YS0+
dXNiMl9pbml0X3BoeShwcml2LCBpLCBtb2RlKTsKIAkJaWYgKHJldCkKIAkJCXJldHVybiByZXQ7
Cg==
--000000000000dec06e05a19aa2dd--
