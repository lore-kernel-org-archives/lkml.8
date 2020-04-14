Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96112C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E0920575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj6dRfJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgDNNdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgDNNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:32:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4049C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:32:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k21so12523712ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PL1qV4rNoqECyojOXOX+qjKZBMB6ykqsNqwBvbzionM=;
        b=fj6dRfJueU93JLtAj9ltpUVcudfQ6pO7neITBQlY+zpG6krZTSQsunTafyhAjXMpK1
         Sva0c3U/fX3f3JvRVWlfEIjYPScaxmnLuqclj6a4NdeGwNoSsX2Wx7a4ip0eao289Fin
         qdlAqvJJ87cbEOmfSRuC0b6WBxWBG3XOhX3UEvBIQ5g/FveRd43VMRP/M/6XQ5BUEwvo
         WV6IdOdd+U8qFKYDOswpjJRsY5rzgV7i/KMHghU7RIoA5esKeHDdjaQ8qGMa2oXJgBxF
         Vsqkmia17d6EDjMNq96T9083nVCoQfNq2qhcBJ48p+TTv1D6CSER0536aoUNEUAxSXhM
         MjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PL1qV4rNoqECyojOXOX+qjKZBMB6ykqsNqwBvbzionM=;
        b=g0pPH5U2R8Am89Ww3Kh6Q6L0ivkr/LntyEYhqy6wdmgJ8QABZWJdEJSd18E8MPNPvt
         HBwRSmYUrzvkh/C6hCh5ZcOJeTruE8UwUbexju0J/+cJSiblHPR5RXdyoxD3FK0dW2uH
         /Tt0TkNIpQjN8sHbn6nlQQ3Mpk+XGuAxKfGGQcziWF+sdAlHdIq/59YnSt+ByTNZeA+P
         Qi39Z+bhseosOmzqIQAwtsfP37dcXKJwkjpBcuoOefi7bRXsCclYD0nCtRS2kMn+xom/
         XJ/kloaA7TDKnDAPhWM20jNlaKx3sy9Tt2cxuPaAWj7WYeYYXlzJfUB9VF2eG/YkQoTz
         p4cg==
X-Gm-Message-State: AGi0PuZLCIl/5zWcKxRzng3NgZky28Avu3eVQI/typuc/d2xVsUu8GaZ
        nfSzVSX+CqmYcAiljvgS6ab5orQ1W2Hu5UMFFHA=
X-Google-Smtp-Source: APiQypL9ubPg9X2xTig9P1oQmBHUPak5Twtx59MPEa+o38OQeAQhiuoTlIIp3kNs2Qco2pjx0xEiKcJuOZkCLhAy8Dc=
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr137759ljp.164.1586871145310;
 Tue, 14 Apr 2020 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1586870475-32532-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Apr 2020 10:32:54 -0300
Message-ID: <CAOMZO5APoqzvptc9gY2r69MzZ=gjTnsr2UV519xJmKmEkcx3=g@mail.gmail.com>
Subject: Re: [PATCH V2] mailbox: imx-mailbox: fix scu msg header size check
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        jassisinghbrar@gmail.com, Oleksij Rempel <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yongcai Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Tue, Apr 14, 2020 at 10:30 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The i.MX8 SCU message header size is the number of "u32" elements,
> not "u8", so fix the check.

Since this is a fix, please add a Fixes tag
