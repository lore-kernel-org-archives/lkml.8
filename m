Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E415C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8E72076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 00:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lD3hYa4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHRAWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 20:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHRAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 20:22:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5CC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:22:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so9078562pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=G4S72b5uoF0KvLSq8Fxn7M3pQq4TBaiGBup4iTUl/TU=;
        b=lD3hYa4SkXByNwvhpt56gj/tstJy1tqXwYDtCWD3Qh1s2U6dZw5MEzqRk08E30ztkT
         H/Lu0d2EH0rF/bkPDTJVXWn47uVNcdiGJ1hCMU3zKIXlLYl+dtVhUKvm1nAu1iFV1A6i
         FBmisgXAtLRbUcQ4JPFyzI1jg1WPfNLwNE1gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=G4S72b5uoF0KvLSq8Fxn7M3pQq4TBaiGBup4iTUl/TU=;
        b=UAVsFF7tOyBnG5Tgv53nN/U0bOtWrKO0aHVUPT7wMF+90D3P9qVuTiudY8zrTeE/C8
         V0kFUHnDYoDLlPztqhDWwuzklCMMiqms78h3ywGQien5jO141iU6YRLOyol0gmNBR7gx
         USrnS76sCFbgZ24tlGA6zxI3DSBXQtghlg5gS5W+iZuKSJEezTwNM7vGbtOB5WDKZuBn
         NbfWywZgm33Wpc5O2qDKqwlt096++xzaAel2sdMPoxIhZKhapPzls8z0WVhcupNfJKu2
         ho++LmsMGQ2ggnmJHf3kVRQ6af8JtB3+IN11m4tDUJ3uu81SdgxH1KIJWIw0wCVTf5NJ
         imNw==
X-Gm-Message-State: AOAM533B0RmYSTFdR/UKoJUy6O33jQCEbu97/kHPzu7OU2scB+t/5PIL
        wNPhDSLetidnlV3m9biYRrXo8j0+IOiEAQ==
X-Google-Smtp-Source: ABdhPJyx5W7AFU45MW9bjlWtaga4TqK2K/MQWMdH80dZVXkjSwadqmJpL5/JLqjL+aKPBgsgPwBzeg==
X-Received: by 2002:a63:30c6:: with SMTP id w189mr11295826pgw.241.1597710147966;
        Mon, 17 Aug 2020 17:22:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id h5sm21282963pfq.146.2020.08.17.17.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 17:22:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200817225912.3149-1-tanmay@codeaurora.org>
References: <20200817225912.3149-1-tanmay@codeaurora.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        robdclark@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
To:     Tanmay Shah <tanmay@codeaurora.org>
Date:   Mon, 17 Aug 2020 17:22:25 -0700
Message-ID: <159771014584.2423498.11072252787625455437@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tanmay Shah (2020-08-17 15:59:12)
> This node defines alternate DP HPD functionality of GPIO.
>=20
> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index bf2f2bb1aa79..0eedf057acc1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1457,6 +1457,19 @@ pinconf-sd-cd {
>                                         drive-strength =3D <2>;
>                                 };
>                         };
> +
> +                       dp_hot_plug_det: dp-hot-plug-det {

And this should be sorted alphabetically instead of put at the end of
the node.

> +                               pinmux {
> +                                       pins =3D "gpio117";
> +                                       function =3D "dp_hot";
> +                               };
> +
> +                               pinconf {
> +                                       pins =3D "gpio117";
> +                                       bias-disable;
> +                                       input-enable;
> +                               };
> +                       };
>                 };
> =20
>                 gpu: gpu@5000000 {
>
