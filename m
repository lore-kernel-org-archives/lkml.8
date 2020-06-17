Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0118C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96129217A0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hDONFDdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQTtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:49:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA62C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:49:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so1653064pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2BRxeAR+U6q8t+VU1Iu1irJtfc0+1W6flWjeS/gZ7T8=;
        b=hDONFDdA35jwcrsrcwtljPYfAXJ+ZmME34vuqf3PAughzKJZ1/OAdT5pImyJiR1tAa
         H6ZZjZniZRTl0cff2Pbfi/effw6aD5YvJ0bViib0/ViMh+lVhNKJ3QrtrkUSmGwSOpwG
         kpJlOSnb+SyKLA5yi+j/aNOkhYgCdrt7CAC20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2BRxeAR+U6q8t+VU1Iu1irJtfc0+1W6flWjeS/gZ7T8=;
        b=mMkD/BxvfgDlK3Lgb+CjNNqabnomAmwUIWbywd1rCGEFSqD7rFVx1TmUxlWq4PFHVm
         MKeyKOQtejV5nDCgKhg4S3tHNfSjeRdet3NlMi9KBZAG+D+euFlCSl/lvbqPCN5zwiAM
         Ym0O8e0Mtkplc4sEVrLpFiAOwvG1Vu6BWPuXOT693Pqmgs1txvqMfacnQiK9ZJrZ1F6V
         T2LKIlQnLo23sqgCOwviX54uyJt4naR76SQC5PAevoAmp8INlm4IUXLlyMBBNqiiPZtl
         mS1TmuruRinyzxOAXs4KV7rF6x0tpN/PR+yFMSgXNVAIhH7vAcUiaGzTwzk1Y1g92nVA
         4i0A==
X-Gm-Message-State: AOAM530Z0u+ZgKVavYdlE/VHQ5jXCGAUwowZCckw0ll3ZVPs2uw/E17y
        W++O4sHYCoT5Ee1fInBUfaZrhw==
X-Google-Smtp-Source: ABdhPJxunyHTm899ykNDEVyFYCetYC6rQz0rgIj2zO9ixuXYkV5AOgtWHO3XXmVghGaFh6muOUaZmw==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr372814pgr.418.1592423354823;
        Wed, 17 Jun 2020 12:49:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m24sm530608pgb.78.2020.06.17.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:49:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616133734.1.I1902d0d48e4f3d4c5b5f1a2008108a4cd3c5ddb5@changeid>
References: <20200616133734.1.I1902d0d48e4f3d4c5b5f1a2008108a4cd3c5ddb5@changeid>
Subject: Re: [PATCH] usb: dwc3: qcom: Make sure core device is fully initialized before it is used
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
Date:   Wed, 17 Jun 2020 12:49:13 -0700
Message-ID: <159242335325.62212.8113067612959846891@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2020-06-16 13:37:37)
> dwc3_qcom_of_register_core() uses of_platform_populate() to add
> the dwc3 core device. The driver core will try to probe the device,
> however this might fail (e.g. due to deferred probing) and
> of_platform_populate() would still return 0 if the device was
> successully added to the platform bus. Verify that the core device
> is actually bound to its driver before using it, defer probing of the
> dwc3_qcom device if the core device isn't ready (yet).
>=20
> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver").
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> depends on:
>   https://lore.kernel.org/patchwork/patch/1251661/ ("driver core:Export
>     the symbol device_is_bound")
>=20
>  drivers/usb/dwc3/dwc3-qcom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 1dfd024cd06b..5a9036b050c6 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -537,6 +537,16 @@ static int dwc3_qcom_of_register_core(struct platfor=
m_device *pdev)
>                 return -ENODEV;
>         }
> =20
> +       /*
> +        * A successful return from of_platform_populate() only guarantee=
s that
> +        * the core device was added to the platform bus, however it migh=
t not
> +        * be bound to its driver (e.g. due to deferred probing). This dr=
iver
> +        * requires the core device to be fully initialized, so defer pro=
bing
> +        * if it isn't ready (yet).
> +        */
> +       if (!device_is_bound(&qcom->dwc3->dev))
> +               return -EPROBE_DEFER;

Isn't this still broken? i.e. the dwc3 core driver may bind much later
and then device_is_bound() will return an error here and then we'll
return to the caller, dwc3_qcom_probe(), and that will depopulate the
device with of_platform_depopulate(). It seems like we need to run some
sort of wait for driver to be bound function instead of a one-shot check
for the driver being bound.

> +
>         return 0;

Also, what about acpi? That has the same problem but it isn't covered by
the dwc3_qcom_of_register_core() function.
