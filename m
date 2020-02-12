Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C4EC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E172173E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cte8xNkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgBLJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:06:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33138 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:06:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so1363537oig.0;
        Wed, 12 Feb 2020 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdiHyv1C8Z3O51Il2rRtKfTPYZzHq2aAiI21t6YVfMs=;
        b=cte8xNkI44GgsFD77ysg/J0+ROdUNaqr+8/qMeiMSvUTstItSyKa+1zbC936kxrWBR
         cv0glfQP1KHjjzFbxYSTJao3VNZztB19IYH2m+ItrGt5d0F6SOq5qdEuZx+drk27kCpQ
         pGKZokcJiORu3/nxErNnRCWc+jHy2i0FoqBD0TpcDWp5R1nSQkYEKW1obTRdpv3yIaqX
         g60WNW95r77sjFcgekae14GjYakaPLg0/z8gOgdEpXQvSsttsRAlnOLg3/ke3ZtUw0Bg
         VsFxYg0aJZifwjQBgCa0LFsXmndcr6s4ag/0rW6/l/G1dQ1/RmSEQj672xfEbY+TveLV
         SC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdiHyv1C8Z3O51Il2rRtKfTPYZzHq2aAiI21t6YVfMs=;
        b=gz1jKyhc45qy7Kk3oBWTSPwbmWtHlJ5iR6dixGYdt5oksvPg+rzJ1VuQgSMEmOssf4
         vBmsY2yLZozXbUIHPWu4i3ED8Q45ZrizYzyLHlRdvgMHMnpvVnMX5pPZkCkCBbiB9TdE
         oavniu+w+JutmnVAr+mviYPZE6xGDlumFuuysJKhX4tdSd2TdKpfQvsMunZCo1IVzTLj
         mqnJ9Leo3oX+swomvhWlyFkvlCm/wV1dK/cEdTOxgTdlzLCdaUfMc/KbE/jVTqQ7qs+/
         urLlR+OxjacsVV20rOUdCbI4M9Kzm7RXnftRbv94eJ14T2clw4GAeVkjkTy9Kd1E+C7p
         gyTA==
X-Gm-Message-State: APjAAAWZ/6WlaLRCdDGPeWyxi9Ows5humYtw5SlCxt9Yk+3PVs15yp5Y
        Xwq2lCmDeAB7nA9vnjseCoZT69xCr3MMHaOSCqI=
X-Google-Smtp-Source: APXvYqz8LnWunxxKZNW1cjt4ireZgvOfph0KWPT5e7ByuK9ekEqH5ZKVzzbSPgDtk7Xf0cv7GXM0tk/J2jgQ4cISQQk=
X-Received: by 2002:aca:3114:: with SMTP id x20mr5662123oix.121.1581498402770;
 Wed, 12 Feb 2020 01:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-8-drinkcat@chromium.org> <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
In-Reply-To: <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Wed, 12 Feb 2020 14:36:31 +0530
Message-ID: <CAOh2x=kS_X-zmwWKfm2CAHAjuLqEcOZ61gkCLKKi8webmpLTOw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2 regulators
To:     Nicolas Boichat <drinkcat@chromium.org>, sboyd@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, vireshk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 2:19 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> +Viresh Kumar +Stephen Boyd for clock advice.

You missed adding us in the cc list of the email, fixed that now :)
