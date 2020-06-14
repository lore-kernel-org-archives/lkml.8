Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7ED20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="APf6tsCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFNMRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:17:20 -0400
Received: from mout.web.de ([217.72.192.78]:52937 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFNMRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592137013;
        bh=3uPeZr7YUtp8oPBanX8wpWVmN5bEN92MxWCaDMklPvQ=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=APf6tsCZ9Q1T1q4LZeI/S86C/NAzHLWwSkuLCdfntkhlHxb5JW5ZF2DRVGrItTPxf
         TupY7NZhrpk8Uqx9t2sZPo5Pbo93xNxX2W4PfkC6MnuR0hwcfsdL5B1GLJ713dDO/q
         PSlKc9pSJSms4/wnkOioBMqtdt1Oj5IC07Da3GGA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MS2LO-1jLoEg3AUM-00TGVa; Sun, 14
 Jun 2020 14:16:52 +0200
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: fix ref count leak in vc4_dsi_encoder_enable
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a81cacf1-88e5-18d1-9d01-8e8d32f6f0a7@web.de>
Date:   Sun, 14 Jun 2020 14:16:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g7WsRZns8wK5DeP8vMqrf1sr3VIsyatiqyKyZOtsG8Fwee6lCiJ
 tcE2gFd3gFNCOhU4MVba6g8qpkQQnmE9RhWRgDTbP1jXY9AfMgjOGdCZI9xqATkC6l+a/gd
 Fhh+9/gI+5+x/v+BQOogOi1EVi2BOxATnDA78sHjOeCPUWJxsHDrQYblS5dq9yLN7M1O8WA
 OcMcExBpmezB7wlmpiG1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yHXBjf+SAZM=:7G1iR+qf8bpnXx7LjxfqT4
 t1O0mcP90xvonwfqwq9Q87uw7FXXzZ48LD0xNuaH6Dy2xe3e3SwWhaQmc74/fuQdoDm7f+/T+
 4VkWggaCk5nAT4AVCvbce9cyOcqeMBqeXWMfYUZcA17PGFNYn55FhY2KQNCxLiRMAfhYD+yTO
 SfsgXX1cXSbvkESaNrv8VNwhbHOq7Y2J+5oyG0xRW7662IF9Ggwl3dNyVaVdbs1PmuYhFF6NL
 IkxfVdG5n/Y2BHXpMIc6rCYFwWE9yTq0PUurTdiKd1AxrmObiMEGiG9N7NfQVx+lXQk+iBSQ+
 YFexzfZli66RqaMAVwK+7Sz34skMN9Qav5AUABNmdjhKp1yF7bBmhhH9P/OSUra4hC3gPAQ+1
 uWXL5YgcP+OSnVb628FwOstRt0qOV6rzYk8gwtbAe1XBIMrpLxtfaMT5FhilRUg6BZImUVL87
 F3RuFARVB1SRoE/vErptN9/ssRytqeC2Y5PIUROqklgLtUVLz/wINN0udBWmGzGVzFHtBbIr8
 lbiy3MaGbdfdjFOano99jjUBwMKezQ1FkYIKsfqmRFz/ktS2Ga9HNf3WUu7EMjrdD37FpSv28
 XOQ7/wHlNjoYA1YDAzR23SwHlu7zSJ6vZtxu6ui5hXHxWVSJdzJXEQ/YX2KC69gv/0qFPpnSA
 jqkSTNGa6t2limdTJ7KtRsbSh17myv123SX41mONhPZLWZ16FnnkTgUE5o6SH9A5WDsx89YoP
 s2f4vVbBMFVIy2dk9H+w0GmEtCLiz6o/uAfG6cxwkb4SpEFViSmynI6jJnXKNUWNNlz/jYvvC
 1PHejOSUcQvhPjjxmhLksigIVGbVziqF4jG2T+YOXrjky9mLfDb9KuopDBv8N4fzm0IYxLskv
 ZB9q+wns5/Rm7E1Z7X//yhOu2wlJERQXJ1NZAHrcKskTWtyip2dZ84lYud8wtpGTk6A0zPylI
 aoSdOxjQCWJ8CD7jvLR6celNKo/9iRmucj58XBEhffG3mjJjecYMDWp/h7L5MnU04BwTpoQcb
 GL35oO/nCR/qkReWx5IZgwqfOPvauJK05P43Qjk9wbYxY0nJ43Q3k2MhYHN0JfUM6G5GeFGa+
 1WtLWb3fD8yZwfyPG1+BSiNLZzAJQaOADx5BQDjnGP+MrTOgvcPDswYHRG29D9PwiwMDQmky6
 gj52eY4K+k55i0EN9JmXjoSspUtbgO4dcJEVByXJZyYoIJKIDb3UDxZzQ3GpadhSA3c+vLidS
 JsEZT1aBlqj578coA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> in vc4_dsi_encoder_enable, the call to pm_runtime_get_sync increments
> the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.

* Can the term =E2=80=9Creference count=E2=80=9D become relevant also for =
this commit message
  besides other possible adjustments?

* Can it be nicer to combine proposed updates for this software module
  as a patch series (with a cover letter)?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?


=E2=80=A6
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
=E2=80=A6
> @@ -1088,6 +1088,8 @@  static void vc4_dsi_encoder_enable(struct drm_enc=
oder *encoder)
>  		dev_info(&dsi->pdev->dev, "DSI regs after:\n");
>  		drm_print_regset32(&p, &dsi->regset);
>  	}
> +out:
> +	pm_runtime_put(dev);
>  }
=E2=80=A6

* Perhaps use the label =E2=80=9Cput_runtime=E2=80=9D instead?

* Do you propose to perform an additional function call always
  (and not only according to failure cases)?

* How do you think about calling the function =E2=80=9Cpm_runtime_put_noid=
le=E2=80=9D?

Regards,
Markus
