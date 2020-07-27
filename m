Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB45920714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgG0MDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:03:17 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgG0MDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:03:16 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MIMXC-1k3NuY190O-00EKUr; Mon, 27 Jul 2020 14:03:14 +0200
Received: by mail-qk1-f180.google.com with SMTP id j187so14875609qke.11;
        Mon, 27 Jul 2020 05:03:13 -0700 (PDT)
X-Gm-Message-State: AOAM533vcq9HHCeOtxxuXp9nKyaIPoPsv2/0lVI3fLwKdvbKNhYEJHqj
        UBa+oBPQorQSlW4XJ0OJq0bNdVF4zQUMcPoyg5o=
X-Google-Smtp-Source: ABdhPJydGNaPbQYPQdZATnOhyJECt4gM7ebVNHN/s58MfHpiqyeZg0LpWkWDpFJ/kGqnCHjmw5AV+vpIysJTLWAzkXQ=
X-Received: by 2002:a05:620a:2444:: with SMTP id h4mr23543261qkn.352.1595851392985;
 Mon, 27 Jul 2020 05:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200727112236.8199-1-lars.povlsen@microchip.com>
In-Reply-To: <20200727112236.8199-1-lars.povlsen@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 14:02:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3WJTKH7-KGgp7CuhZv_wtrtY1k+1LEL-62_Rj+wqbrGQ@mail.gmail.com>
Message-ID: <CAK8P3a3WJTKH7-KGgp7CuhZv_wtrtY1k+1LEL-62_Rj+wqbrGQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] clk: sparx5: Review changes
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:465JAMwYQa9HIm4CivSQ/S/sK6bLJowniVJSY13POUZJPhe/UdJ
 7dbmVCEz9a643FvD0FBn095gmv8iRBeKqX2skW6BWkF2qaWn2UH4qGDXQUtPQt6NSZLRiP/
 p2Zt/xPeUaZ4t3WHYpx5OLTk6ahjSCWb1xxOtUD/FT3pA/V/J/g5Qz9Y4jF/MJfyghWXv5r
 QZUT2T6Rz4LQ/pBXm7wJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5B+5thkMcBg=:a6wSIwMOIhetIaf11yCBjD
 ztoxN+ptE5pFQlWDZYRIb2YEVO/pJBNqglXgtmyBuHhBH2l0v9JLfbdfP3W4mwJxtD9oGxGSz
 U/JRTc34LKOuhMyUpQESV30eimaSomHFH9Hrsf3J3oMM7hNEELizfv8nlBKN3XynbHQGPaCEe
 uP6qeXYvAT/gs9ZDMwhkNezAidigsxyL/6WXU7QNCXRliNR55D20Naf3XVtzI95lhe6FD/QWm
 TJ2hNdbyKfG0zZd2/k1fhBKxNMn2wLxYsvLBVTHiKG+zxKCpZMz4wxTDukyEPBX7B3dqfjHsv
 1RnEnEUy2nLqnGkhikvvaZuJ+0IhJORo5uyyym4SgVzNkTrnVuZOMGGMkUTgTqeuFtgNmlGbu
 9Ik+gH2LMFZfikUwlqicoQtVjNy7QIi9Wzxohp1iobqQJeoxgHsEqpr0Xbe8p8sdPPh/qjCqK
 zspddDoNpRG6A7Z9WkLKXdFIFn8t75Nf7z1u3bMNmkJiyEQzklEyoQQ1TQX7aAoykq9xt542z
 nakU4nHzv7gnPjD2EHDlwARpsCb29vI4slVHgLni2xWpsUzgXLdZdbVh+qlP7KuamiJ/9x7rN
 6u7hFoB1qbmwI7PCJ4XkbU+fih8scAqg4xOdCEQ4vO663MgArsmH18HXL+/959pMqqjX2+N/3
 +B/Jrb8zFMEo+bi8FSWgwYEd+PqoEp6JFUAIeNUwCtnSQzQnoaYuyYfPRberMAM7iyTHdaMag
 mqTwhmyFZ3pAMXYnDGSbNPviBaHQtPK3Wq1g8VMAeWaoS+rRDE8dXjYXaYyzo+LDb1YrsYYXw
 704KacatUzHSrpvtK2POnoOF55jUmL908MV1909O+blxdX7z/c71XCQiq4EtCB0wDjVock1A5
 VI0o8BADF+K1t2lomyPdRJFx5+DEV4gu6xpOQ5jw9yF21GWKw7htvbTuzVSez+emyTUxNZAPb
 6kSKqNdhF9YKI9WWntxzrxYoy1Pnd56wpu7Dg4WOJqHuDqRSR0N+N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 1:22 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
> This address the review comments for the sparx5 clk driver from Stephen
> Boyd <sboyd@kernel.org>:
>
>  - Remove unused include of of_address.h
>  - Remove unused member in s5_hw_clk struct
>  - Changed type (to unsigned long) for freq in s5_pll_conf struct
>  - Use .parent_data instead of looking up parent name
>  - Use devm_of_clk_add_hw_provider
>  - Some minor comsmetics
>
> The patch is intended for linux-next (incremental), as the original
> driver was already merged.
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Hi Lars, thank you for addressing these!

Generally speaking, you should avoid having patches that list a
number of unrelated things that are done by a single commit.

Splitting this up into six patches is probably a little too much,
but maybe you can find a better balance. What I'd like to see
is to split the purely cosmetic changes from those that might
actually change the behavior, and then for each patch that
changes something non-obvious, explain why this was done.

     Arnd

>  drivers/clk/clk-sparx5.c | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/clk/clk-sparx5.c b/drivers/clk/clk-sparx5.c
> index c2e7aa0214ebd..0fad0c1a01862 100644
> --- a/drivers/clk/clk-sparx5.c
> +++ b/drivers/clk/clk-sparx5.c
> @@ -12,7 +12,6 @@
>  #include <linux/clk-provider.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <dt-bindings/clock/microchip,sparx5.h>
> @@ -38,7 +37,6 @@ static const char *clk_names[N_CLOCKS] = {
>  struct s5_hw_clk {
>         struct clk_hw hw;
>         void __iomem *reg;
> -       int index;
>  };
>
>  struct s5_clk_data {
> @@ -47,7 +45,7 @@ struct s5_clk_data {
>  };
>
>  struct s5_pll_conf {
> -       int freq;
> +       unsigned long freq;
>         u8 div;
>         bool rot_ena;
>         u8 rot_sel;
> @@ -208,8 +206,9 @@ static unsigned long s5_pll_recalc_rate(struct clk_hw *hw,
>                 conf.rot_sel = FIELD_GET(PLL_ROT_SEL, val);
>
>                 conf.freq = s5_calc_freq(parent_rate, &conf);
> -       } else
> +       } else {
>                 conf.freq = 0;
> +       }
>
>         return conf.freq;
>  }
> @@ -246,14 +245,13 @@ static struct clk_hw *s5_clk_hw_get(struct of_phandle_args *clkspec, void *data)
>  static int s5_clk_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> -       struct device_node *np = dev->of_node;
>         int i, ret;
>         struct s5_clk_data *s5_clk;
> -       const char *parent_name;
> +       struct clk_parent_data pdata = { .index = 0 };
>         struct clk_init_data init = {
>                 .ops = &s5_pll_ops,
> -               .parent_names = &parent_name,
>                 .num_parents = 1,
> +               .parent_data = &pdata,
>         };
>
>         s5_clk = devm_kzalloc(dev, sizeof(*s5_clk), GFP_KERNEL);
> @@ -264,18 +262,11 @@ static int s5_clk_probe(struct platform_device *pdev)
>         if (IS_ERR(s5_clk->base))
>                 return PTR_ERR(s5_clk->base);
>
> -       parent_name = of_clk_get_parent_name(np, 0);
> -       if (!parent_name) {
> -               dev_err(dev, "%pOFn: missing parent clock\n", np);
> -               return -EINVAL;
> -       }
> -
>         for (i = 0; i < N_CLOCKS; i++) {
>                 struct s5_hw_clk *s5_hw = &s5_clk->s5_hw[i];
>
>                 init.name = clk_names[i];
> -               s5_hw->index = i;
> -               s5_hw->reg = s5_clk->base + (i * sizeof(u32));
> +               s5_hw->reg = s5_clk->base + (i * 4);
>                 s5_hw->hw.init = &init;
>                 ret = devm_clk_hw_register(dev, &s5_hw->hw);
>                 if (ret) {
> @@ -285,14 +276,7 @@ static int s5_clk_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       return of_clk_add_hw_provider(np, s5_clk_hw_get, s5_clk);
> -}
> -
> -static int s5_clk_remove(struct platform_device *pdev)
> -{
> -       of_clk_del_provider(pdev->dev.of_node);
> -
> -       return 0;
> +       return devm_of_clk_add_hw_provider(dev, s5_clk_hw_get, s5_clk);
>  }
>
>  static const struct of_device_id s5_clk_dt_ids[] = {
> @@ -303,7 +287,6 @@ MODULE_DEVICE_TABLE(of, s5_clk_dt_ids);
>
>  static struct platform_driver s5_clk_driver = {
>         .probe  = s5_clk_probe,
> -       .remove = s5_clk_remove,
>         .driver = {
>                 .name = "sparx5-clk",
>                 .of_match_table = s5_clk_dt_ids,
> --
> 2.27.0
