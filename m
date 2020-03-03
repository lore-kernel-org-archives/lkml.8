Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A93C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5932721739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFn5BwiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgCCIB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:01:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40906 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgCCIB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:01:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id r17so3077881wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qyfM3kBipc3zwdrUhToF5IgGdBPcQiWJ6luYEueav4=;
        b=qFn5BwiDB32laJoxuwCmHsGVWOL1HvHHP8hgiaGq3mPO3Lh21cc48jsuZWS1gQGk9V
         lyQpuyJlA+dHbPTWoo7fOBFV/Sb+PJ3UZ6qJKVZ1K8452c99LNHqS0mC98ZeEtAZlULk
         y73YAoVYOhfm6SqQe8L7Q+Er0EN+QmR1lv9UCGCyg1g0wDAU1pv4kxgNkP/dCBQRCRjg
         /+w7qhcHOHzaSiCSoxvCY90qj9M8deX1b5gfL9LaOFAPc6nKGR0gonFWOsS9JmQY9sfk
         ngaSEJYVfihTTJmyCha9sYGdPvaDRoDeeTYSobz7sTX2IAunvb25+AmOYeNnpi6Pqy7o
         PAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qyfM3kBipc3zwdrUhToF5IgGdBPcQiWJ6luYEueav4=;
        b=c8mA8yb1ZC4/1rO+phdBhpqF74D9H7DWOlO3AS3UQE6mhokEZyOqiYeAKOVYRfzzyk
         j1SP2fTNL8rqUTAhyWQeYYN80XeTvVs9dZQ11R25EGVexGyKDMvtrX7JaQRncgvEFhYf
         13J4dcLnVTaCCxaxqJaje4m1AxYvlyzigftdHU2AOgbyRwzhIzHzQX78jXJOvQ5mpWSI
         WMd8ifJFEDHHKYiL0gEFTh0+hBb1tL/hnkwEvLBjBPonRVD9iw9tjSuzIIiDK1YNIG7C
         UtXrqGD541MvNtseccRLGQAWpsKiqU/2i9DjEiIqRmtWOQE9QAU0JEPBe8VH91Ij6EAy
         ul0A==
X-Gm-Message-State: ANhLgQ1dFA5gr7Cjqgc8QvLhqSyW2FlJE2yQ3U1UQayaee2EgkCLue/I
        Sd6VkN0WZbBRXyako1bBM4BW6uNU24DoF8ue0c8=
X-Google-Smtp-Source: ADFU+vtwxgHYElrwOCSYQopLGsPCdc8dwV3aljQ+jmR60/pLkTaD3Sl6smX0u9Ay68pEK2vSdclE7450Qvq6zEcswLk=
X-Received: by 2002:adf:ab4e:: with SMTP id r14mr4222183wrc.350.1583222486603;
 Tue, 03 Mar 2020 00:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20200303072247.3641-1-o.rempel@pengutronix.de>
In-Reply-To: <20200303072247.3641-1-o.rempel@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 3 Mar 2020 10:01:15 +0200
Message-ID: <CAEnQRZBqYxijvQOLN9MQQEkoGbF2eXsKjqG_f+Q+rgw2cVr_6Q@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: mailbox: imx: take over maintainership
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

Thanks for your help.

On Tue, Mar 3, 2020 at 9:23 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> I would like to maintain the imx-mailbox driver. I'm the author of this
> driver and involved in reviewing of all related patches anyway. So, make
> it official.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38fe2f3f7b6f..8f3f6b764779 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6681,6 +6681,14 @@ S:       Maintained
>  F:     drivers/i2c/busses/i2c-imx-lpi2c.c
>  F:     Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
>
> +FREESCALE IMX MAILBOX DRIVER
> +M:     Oleksij Rempel <o.rempel@pengutronix.de>
> +R:     Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:     linux-kernel@vger.kernel.org
> +S:     Maintained
> +F:     drivers/mailbox/imx-mailbox.c
> +F:     Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> +
>  FREESCALE IMX / MXC FEC DRIVER
>  M:     Fugang Duan <fugang.duan@nxp.com>
>  L:     netdev@vger.kernel.org
> --
> 2.25.0
>
