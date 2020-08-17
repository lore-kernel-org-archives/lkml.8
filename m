Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88262C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5956020658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0e4OPRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHQIW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgHQIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:22:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C160C061388;
        Mon, 17 Aug 2020 01:22:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so16713856ejx.6;
        Mon, 17 Aug 2020 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vvUS3MsWiDgWXcdNJuKrD06TaaumHLEcVAY3eJQqbI=;
        b=Z0e4OPRPwxORMLo/h2Jx5AMLsngyx/pXUhtSkZkqTuBNK6AKh2lwQ4I1lcZuUI7SlN
         ff3cNA7Sk+QHsq9C+khSBjpZesdJEcHH9Y4xILlrbd3Vkpdg9cjydTS8XzCrT+ntfFxn
         rxAyK0nItr2Ptll37DxIFkMe/NfxpI/8jK/kSzuhBpMoHetsmwGijoYRMjqRINRJty7N
         ZD3bXKynFlrXWijEcaq5telZXkARlgQ3m2TMBAE7+aB5ExXriSJm1s4BZEr/849tlZBq
         wbDfVCD4Avjfk5NqjCDpgrYhA/Qy1psnHFvT5EyNjJY80ONA0QGaCwgRIBT2nyGWLPA+
         KWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vvUS3MsWiDgWXcdNJuKrD06TaaumHLEcVAY3eJQqbI=;
        b=j3sYSyaNgamu+f5fi0/B5ML54Cq3gidiZM4jONhhQSQGzGaSIzreitt9PMHLKwwO/c
         AE8H7avA1BG+Q7qzWaDrNg1YIJQeZVxv9KElyGXjAOkLjvBBIoAY+MLxWfcxwF/I2v0i
         9ySjcrLM9lQVRe/E+NN8CkPqRD67v5TAzfjVjd90VzP9Eh+pyYJomnxxHJd3llz7BHZp
         KzuAcWVK/i3eKU8RZcrlZBxoVFFuhdwmPErYN+W4xwbQ/0cb+blM9QyH4kDwYjfrHVJ0
         9mV2dxUUrE1V/Aem4a6/bRhsGvvFU17iQmibbCXkvVEjPUa+FISTsPR4sLARbq5BTy3u
         v3AQ==
X-Gm-Message-State: AOAM531s9kV3+ZL7+jomDmwU8UcOa8mVv8vfHaMEr5wvLtfgbTO4CZ6a
        yppB/NExyx+DK+fk9UnVtC1Rk9B9oCof8VqreX0=
X-Google-Smtp-Source: ABdhPJynJYGy6+mtTZDN2BR36xcy5HcTLNM0YlY7cyrY0gq/xOcmt/zLd8HraV/Nj1cBiSyb//rwsLCQkG9ypFrXiuI=
X-Received: by 2002:a17:907:7090:: with SMTP id yj16mr13634256ejb.73.1597652566928;
 Mon, 17 Aug 2020 01:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com> <1597406966-13740-11-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1597406966-13740-11-git-send-email-abel.vesa@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 17 Aug 2020 16:07:41 +0800
Message-ID: <CAA+hA=S980MzGYn+TS56JnOJb_Sazc2eH1XUU++bYNQdrxU+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTRL
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:14 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Document the i.MX BLK_CTRL with its devicetree properties.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
