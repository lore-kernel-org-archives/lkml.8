Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B78C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88956214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgcbDHoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCBRtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:49:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44131 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:49:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id 7so236069lfz.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUu1wzaanq2EdQmQjBWfzQcQ7Y84OgJMEq7zr5n2p/0=;
        b=ZgcbDHojtwEVgyZCHT3X+9NU9qMzTPpRnpZXGQGqhJ+zQ+Kk45gGv2mn2YMjUYmC1V
         96MJnffx07TFgzfrnXg/dkVESlb9KSKuKJ7tiODuE+Rmk3plG5tR0alzQt3A9rFSVcYs
         xhMKIJN0e5cZlIqHlrvWL4hyMSyiVO0Z1YeQGPwAmf75L4vHRLQzSJqpnB9IQUfA2M5w
         83A2CcAa8zZnY1QIv5XO3avPA7ImG9h/aO2cOOjTUlHiNncnITq4pbkpQYQHWLTFdWVs
         rhkk1xQo6BtR7qJTgQch7BBuoHK7EZOQUmmM1tCdlUPCqBcQexSGulp9bd7SAIRbG+bl
         Iakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUu1wzaanq2EdQmQjBWfzQcQ7Y84OgJMEq7zr5n2p/0=;
        b=ZC7/i0CeChaIZuqg6K2cjGdrJ4NCrc1tU0QKtXox/HKv2M2oi9fUz1qCnUPwhreKeh
         hxjbRxU97xMtjB0qXnmixXmGOCtfu7dZAtVLdkOGFDTbgSSF/lWVB0NPivrDJqsT12zq
         IXvOtsV9oGYdjatjpgc3fBbW8Vsrgs9XrKy+BRixtDmlAzq2O8txsLNfy05iSLC6q6Ae
         GFZc4910o0R1TLq2hfBz0TIo4XhQHgu6c2xdRnrumwNAoSulEXf1MKiquNdZdjbImIct
         BEAiDTNX1TlNh8D/8f8bzAQVppuPkgLb7ZE5Mu5W5b6+DIgjJVRBG3NdmU4E4dervcvX
         nsZg==
X-Gm-Message-State: ANhLgQ0HimsP01Ru8tja14S1Gu/RCrC1x+YJLII8+lRsCND9FUPCCIhA
        jlN5DiZX+Hj4REff7TxhKOExWJjkImSkXN+dBeA=
X-Google-Smtp-Source: ADFU+vsDhZEdarbEFoLsP6WxRJRd/vyQxpntoFm7v88XUxtZTItvbvqaFKCQM5EIaEaYlN6Dvu+rqPUpEhML5PGW+U8=
X-Received: by 2002:a19:4344:: with SMTP id m4mr163017lfj.140.1583171351354;
 Mon, 02 Mar 2020 09:49:11 -0800 (PST)
MIME-Version: 1.0
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com> <AM0PR04MB4481FF78BB300729E59D6D8C88E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481FF78BB300729E59D6D8C88E70@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Mar 2020 14:48:59 -0300
Message-ID: <CAOMZO5CBSL4yn4m6n56qES0jDVUQZJSGZyCxng1Kg7fvD5k1JA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Sun, Mar 1, 2020 at 10:40 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Shawn,
>
> > Subject: [PATCH v2 00/14] ARM: imx7ulp: add cpufreq using cpufreq-dt
>
> Is it possible for you to pick up patch 1~8, 12? Or any comments?

I haven't tested this series, but just wanted to be sure that 720MHz
operational point will not be populated on a system in LDO-enabled
mode.

Please confirm.

Thanks
