Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E113BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC56120760
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EVAxOV8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgHQWvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgHQWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:51:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8CC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:51:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so8266723plk.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=SQkF1er9CI/HdoW+CwMyTYmnG8SOeqdla6TOsxwwXL8=;
        b=EVAxOV8OGoEBu6rnvdmhL7nV88zwX29yi/vbnC+n+vOBoGdfRXKTYRNxwwIeZ+BjCL
         n00zv8FJcL4GNWB1T9HqvbiknMeFsz4MVl/oKDDvDv4xSzjhGPRsrR7FG1kxoxuIVabp
         rL28hlM7qopNZnIsSx/06Xt488jLS5/+IANV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=SQkF1er9CI/HdoW+CwMyTYmnG8SOeqdla6TOsxwwXL8=;
        b=ZSM6yRXs2Ghh8s6w31i3yKM/Bt6kyMil/f9VnyVvE/y9GQX/qz7g2UCSEpfG0s4kwr
         Nke8BNK+t1p5R7NPkVxvHhwfsZorWPokKDr4rT2XCqr9ZwDPMOCh+BZzKUGMj+O33roc
         NFChdNcKvkbw8IxXPsW0KkxlpJHCULly9+NV5g+hf/Sm/af0t4TDrGFZwh621i6Prkko
         1FsGGdJoMzLilqa/9naiIGZIJMmwFHw9nWlwLiR7CrTlIt40Ao9o3z+RjrFmslinfUSw
         oYzhzVnkrtykAB2kotnLAd4h5XniQN0Za1cUYaQ4mdMEAWEY9SUKM7cGLzMu3JsMdyu3
         8p7A==
X-Gm-Message-State: AOAM5337bUhnbi9qVa0szf255yD9UYVAiAkle4DGtOWZfZUAAZLBUOND
        8fY0ND6V7LaSxllTMR7acvU0hIs4YVatMw==
X-Google-Smtp-Source: ABdhPJyJOVgzQkXpdtBDVbGzjM+WmdvtLlVBSbnc4J38wcBX/4/0hz901JkQfbgFaPFVLg8jtt6UJA==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr13953355pjw.146.1597704658834;
        Mon, 17 Aug 2020 15:50:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z23sm18201207pgv.57.2020.08.17.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:50:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200817224527.28532-1-tanmay@codeaurora.org>
References: <20200817224527.28532-1-tanmay@codeaurora.org>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        seanpaul@chromium.org, robdclark@gmail.com, daniel@ffwll.ch,
        airlied@linux.ie, aravindh@codeaurora.org, abhinavk@codeaurora.org,
        khsieh@codeaurora.org, Tanmay Shah <tanmay@codeaurora.org>
To:     Tanmay Shah <tanmay@codeaurora.org>, devicetree@vger.kernel.org
Date:   Mon, 17 Aug 2020 15:50:56 -0700
Message-ID: <159770465685.2423498.15137387317243148552@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tanmay Shah (2020-08-17 15:45:27)
> This node defines alternate DP HPD functionality of GPIO.
>=20
> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index bf2f2bb1aa79..9f97cf5dd9ab 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -1457,6 +1457,20 @@ pinconf-sd-cd {
>                                         drive-strength =3D <2>;
>                                 };
>                         };
> +
> +                       dp_hot_plug_det: dp-hot-plug-det {
> +                               pinmux {
> +                                       pins =3D "gpio117";
> +                                       function =3D "dp_hot";
> +                               };
> +
> +                               config {

The node name is usualy called pinconf. Please use that.

> +                                       pins =3D "gpio117";
> +                                       bias-disable;
> +                                       input-enable;
> +                                       drive-strength =3D <2>;

My understanding is that drive-strength doesn't do anything when the pin
is input. So this line should be removed.

> +                               };
> +                       };
>                 };
> =20
>                 gpu: gpu@5000000 {
>
