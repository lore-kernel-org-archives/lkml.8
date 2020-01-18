Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25451C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C52469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sWCNj0ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgARV5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:57:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43846 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgARV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:57:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so25865846edb.10;
        Sat, 18 Jan 2020 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhEeNJG6Xe03fAdCWoX8L2PNC8Ts9rcXxVowinyH7Jk=;
        b=sWCNj0ZQnbgArqLuw0XgK3tLKDpG6In0kiTRu4lFsb3+62AuuZEdDNrhrHEkXU2ZjV
         +NrFKwt20CkDMRpye3isHNQcsRe4mFxsOjdn7Gp4QbGCaPHjbubuf4xMV4m850btYfaU
         TH81GKDtQnnthH05MnOsT+EYtj9H+Mq8IYH5JvMpfk5DC5lpx1gJUk04CLiNe0kou6CR
         CxjhEulvlHdjr/a8LTvPVSqxb22EoK7D09WKmiSuVPsSpOEI306HLTEK9GmVQdhZeXrk
         nqo7nRAKokRDqaXotijdhTP9Q8nwucOa4JcN2DR+I55VtM5D4dpSNez7Cw7SNzYTZsas
         v3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhEeNJG6Xe03fAdCWoX8L2PNC8Ts9rcXxVowinyH7Jk=;
        b=m5qydpr/y7Z/kyd//Xmhcem7usvxMcm3DRA7gmoLFTEL6S5sHduAbCou/UAXm067vA
         9EZUtROY/SPU9uRCxoLFJkgbF609+yvaiT39sqXz+MhSuCzAcOIrVo06/ofRQhWv/NVe
         21ydFh7wPHMfWkLMo77zNqxerkw0+7gvoZdfWbkGFb/oih8sgSSPX0sIA/tpJVgY91m4
         jU1kw6VUgi0KyH5kUGJwKbf2FzYDLz7jdlRt5Y6dt0B9TT1mXI34ykDbOQW6WAlNT9Zo
         GxcBzGA8E75mAGF7OmSTA6OjyodUMshdGRPvzgzrKeWH5zKaiNHVxDzCrxSiaOuXzcUL
         wiaw==
X-Gm-Message-State: APjAAAU8gG7ewlrFuepsXt7BS0o9q6f2ajuqUIojQm6djp/OO0NoOIj/
        SeWAntXdgUoYI6+axvaOsBYS4kygkZh+RjzFjxMwACcq
X-Google-Smtp-Source: APXvYqyjnAk8oubKYhxKxWzUPog0rE1nkqWdTWkbrvxjIY8nWbYmSn4gzUFbwFiw03cl5ZtTyqcd01lYsxkaQM35M+Q=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr10507644edb.146.1579384632180;
 Sat, 18 Jan 2020 13:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20200116080440.118679-1-jian.hu@amlogic.com> <20200116080440.118679-3-jian.hu@amlogic.com>
In-Reply-To: <20200116080440.118679-3-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 18 Jan 2020 22:57:01 +0100
Message-ID: <CAFBinCCkmUzNBeUz0k7na2FgR1SPKda81j+RnhEp9Jj84HEzmg@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] clk: meson: add support for A1 PLL clock ops
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian,

thank you for the update!

On Thu, Jan 16, 2020 at 9:04 AM Jian Hu <jian.hu@amlogic.com> wrote:
>
> Compared with the previous SoCs, self-adaption current module
> is newly added for A1, and there is no reset parm except the
> fixed pll. In A1 PLL, the PLL enable sequence is different, using
> the new power-on sequence to enable the PLL.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> @@ -323,13 +330,34 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>                 return 0;
>
>         /* Make sure the pll is in reset */
> -       meson_parm_write(clk->map, &pll->rst, 1);
> +       if (MESON_PARM_APPLICABLE(&pll->rst))
> +               meson_parm_write(clk->map, &pll->rst, 1);
>
>         /* Enable the pll */
>         meson_parm_write(clk->map, &pll->en, 1);
>
>         /* Take the pll out reset */
> -       meson_parm_write(clk->map, &pll->rst, 0);
> +       if (MESON_PARM_APPLICABLE(&pll->rst))
> +               meson_parm_write(clk->map, &pll->rst, 0);
> +
> +       /*
> +        * Compared with the previous SoCs, self-adaption current module
> +        * is newly added for A1, keep the new power-on sequence to enable the
> +        * PLL. The sequence is:
> +        * 1. enable the pll, delay for 10us
> +        * 2. enable the pll self-adaption current module, delay for 40us
> +        * 3. enable the lock detect module
> +        */
> +       if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> +               udelay(10);
> +               meson_parm_write(clk->map, &pll->current_en, 1);
> +               udelay(40);
note to myself: first I thought that these have to be converted to ulseep_range
BUT: clk_enable can be called from atomic context, so the atomic
versions (udelay instead of usleep/usleep_range) are perfectly fine in
Jian's patch


Martin
