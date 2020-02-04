Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D2C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5590E20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaWUQ19q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBDNp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:45:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43086 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBDNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:45:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so18631435ljm.10;
        Tue, 04 Feb 2020 05:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjuIkKpIuY3IO5NXFzkY+H6oMdq2hnqWewsM3UAiOzA=;
        b=kaWUQ19qxI2q6KsqvQ7NuWYLATpwkCDvy95LVsSNKvff+Icf8rUf7NF5OEj59nyBHG
         iZXyxXooCbZ9BakT7DdxeLDpnEOzYKGjWOHx51EO8FMxIUU7WTZ5jlT/6EWXZe7IitlS
         RLwnustGbOAtIakbznaCKkOFuzE1GYU4RhL9n8rurcuz5MF+7YRWXqzLxKtTcjjoHQla
         L8mr1DJpHfcDyMdHLGbzPkL3tIZ1LwugnOM0eeBcMwB8H8GovOuWkzkqvGD46bfZsUU6
         35p6FXO0JJeKy7mHUikDIszHLMvJvxr3z02SvAIgI6OHm+X2dvk4jJuyLOO+roHHyzRy
         7OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjuIkKpIuY3IO5NXFzkY+H6oMdq2hnqWewsM3UAiOzA=;
        b=nw1I1SdLiCPy7RzLetd/5QpCXZicqqsP43pagxrtTuLXNxpOgoLpuDl5auTKeWUz+k
         jyqNgy4PddNY9dmLfaI545SZaaOO6V77ldWTUDNtTMN1pOwNV1VqX5LFT070KecrI1gE
         DhCFVXrFfvI68CEBCcb1Ooag56sd+xdUMQOMHnIXqh0OGYZyDltRA9cEOhKXYM+51nd6
         2Bg74L5VriKaqFnKgiyJcXvSy4g2m9HERTgycO05WD6C4uJP6oZRTfUTMM3rOTUr8SRE
         Dn3mf3cgOuUTmrWzzGHIDIJ8c8awm2RnL95tdAItujo7i6KxEmocymcMsQ5Tk1TVgwef
         0/3Q==
X-Gm-Message-State: APjAAAUp3LmjPwbTSEMrm632KBmnOJD+7cDwnh9KcUfXViiOygyuk9jV
        nxXDBvdOJp6sYqpec/5qU9n311YRba93KZDpBko=
X-Google-Smtp-Source: APXvYqyCbPnebDdL3Ah7VFkPwIX9LNYpKROKgH04rjXkr000ELosKdtXF2x24cnhUmr4sn6M/XjtxvIXp67SX8c2FL0=
X-Received: by 2002:a05:651c:cf:: with SMTP id 15mr18209827ljr.288.1580823953674;
 Tue, 04 Feb 2020 05:45:53 -0800 (PST)
MIME-Version: 1.0
References: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1580823277-13644-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Feb 2020 10:45:45 -0300
Message-ID: <CAOMZO5Avbrzf8jNQ301mNN3YXXPjEGYWkooae_uw=wLykMgt+A@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM: imx: imx7ulp: add cpufreq support
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ping Bai <ping.bai@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Feb 4, 2020 at 10:41 AM <peng.fan@nxp.com> wrote:

> I not include the voltage configuration, because imx-rpmsg
> and pf1550 rpmsg driver still not upstreamed.

Any plans for upstreaming imx-rpmsg? I assume this will go into the
remoteproc framework.

Without this driver, the i.MX7ULP support in mainline is very limited
in functionality.

Thanks
