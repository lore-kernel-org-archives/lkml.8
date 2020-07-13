Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4459EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2CF2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgq1KeTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgGMI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:56:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D60C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:56:33 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id by13so12483850edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKhgh71JHWnYuUs5WzifYf8vsoBOrJ3djWHu6qmeIyE=;
        b=lgq1KeTy9Pt3GIhvirUXelC6tan8vdCBEJ1rO5Zr2wBGzhy+NuVI64edV2EXQp4rlu
         yMq1posmcpsQwYZjsBWMYOmILEi5X8raaBiZpqzX5LHWYSmrI3OTtp+K0zQsvhcPTgPg
         0bklTShe4ClUjUk/ABVIDd6x9bCwSEPukFpcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKhgh71JHWnYuUs5WzifYf8vsoBOrJ3djWHu6qmeIyE=;
        b=oGwAXpcTHmxw+Yfs2AyWjNtQYn/DylB0ZIOVvKzdY5fGFRUDGDAOH41WGdxw0KSeOU
         l6b5PEHWrK0P3j/1ZKxgspEKT8DSVCfELP2EIXrWnw9W5IS6dPc/ax1qKQ0yrm1UslGE
         PbAUMwYSkhhhugIbjlHdlGfaWB2uH7eP8FlBB5vaa3mELtXqDtSpIjfpLNYj8rDsXw3H
         Dw35nzs8I6QGknBp2xQNb+R636EbPDU9prdDgAnvlX9s4s1kNVWlVmQA5Hk8sIlP3FS8
         rxlDyAPjhXwi5kqNeBqMk55qjJV3YMU2h/jfakTNQhmpdjLJtohHe366RWDDr7ZlqWw0
         kPkA==
X-Gm-Message-State: AOAM533W3IVU6hbTppyU+0KGcI15s4Ixj5qdS86aUEfLjuq2Bvz4SEfv
        JmfxmDKNjI3OjhBVf5zI+mLE+unywIfZZLsLPLMVJGu7Jew=
X-Google-Smtp-Source: ABdhPJyXq9AZLsbhANiRrr2qjNt1s4angeZE/+KX7QoROrFioZkDONHx2FW0fVWyn4I9Cf91+8Y1zF/rHTqZP/2rHFU=
X-Received: by 2002:aa7:c614:: with SMTP id h20mr90022009edq.29.1594630591990;
 Mon, 13 Jul 2020 01:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 13 Jul 2020 16:55:56 +0800
Message-ID: <CANdKZ0f471hRgFJS1EDJ81xfaom6UKV+7RLVEC9T5x9vrt22Nw@mail.gmail.com>
Subject: Re: [PATCH] regulator: cros-ec: Constify cros_ec_regulator_voltage_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Pi-Hsun Shih <pihsun@chromium.org>

On Sat, Jul 11, 2020 at 7:44 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> It is never modified, so make it const to allow the compiler to put it
> in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/regulator/cros-ec-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
> index 35f97246bc48..eeed5aac3f32 100644
> --- a/drivers/regulator/cros-ec-regulator.c
> +++ b/drivers/regulator/cros-ec-regulator.c
> @@ -142,7 +142,7 @@ static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
>                            sizeof(cmd), NULL, 0);
>  }
>
> -static struct regulator_ops cros_ec_regulator_voltage_ops = {
> +static const struct regulator_ops cros_ec_regulator_voltage_ops = {
>         .enable = cros_ec_regulator_enable,
>         .disable = cros_ec_regulator_disable,
>         .is_enabled = cros_ec_regulator_is_enabled,
> --
> 2.27.0
>
