Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9390A21556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="jia5Icuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCCJOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:14:51 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38136 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgCCJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:14:51 -0500
Received: by mail-vk1-f195.google.com with SMTP id w4so666062vkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=82sNWGjFmkVLBw+FxrgCKF+vSCptDwYcsAW/FKpfGeQ=;
        b=jia5Icuk9eDsQK/O3bwyskMqnRE3YCqTgyeT5XMkVrG1a25bC9c7C8VvHR22iePtAx
         j10IwItrOGzWdVSN0DSbc3I1+IBdzVU60++A3ycgxyfIRyEyxS+XK9uuRJASMOm9eN1O
         XoFjYL+S2T6BhwactfaUfYl3oUkHe/byjavsEWBySp/nf6yKB5JFLIH9DXvyzvO46Z2u
         /wgbLcBQxZRQ+NEXftCiugNjGGaCBmsDL4qRfiixZ1Q1W3VMP7/dcDJgUJDoMF/nvwRv
         jB9xXMaTj4FooiW193xrCbIFDSOmt44NXW/aiWDpX1g9Y63AcqWvxftXtA18GGTfIbAa
         NbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=82sNWGjFmkVLBw+FxrgCKF+vSCptDwYcsAW/FKpfGeQ=;
        b=j67WvXTvyyUxxDwyR62NCiEw8jsW6+W+7ifWPyLUZGaf3929zjKOFTWikmuzBXvA6q
         wTo1Cpb61f1UflRVQ0c1aWTd/9KbkG+cVSQ7mzq2/HEHtcFfZ0pbC5lnQC09nzshvX4w
         0rTeDDDddJlBDTrIvZHbLrjYJrDIXyz7gIVtJ+J5ki7xJdKKMr+XWjfAjp/Tuhpz9J7G
         TMWw9o0hz8HvyFtJjZGMfDE1h+YyqT6T8LEZwvG59v1VviM2S7f/C/Bq8d0qMXcyuzCd
         xLxlW6OmJKX+RdRyZYg8G6XYrIPuMCOVDQFphNV5OzizHYXmt5ny75MdM3UYWE1aaX3A
         oXnw==
X-Gm-Message-State: ANhLgQ35tx4mjOG7v3ktRjRmHolvGh/npHsLUo+d4fPImCpYFDdI8aos
        WiFpcLXTSVLrwE+XrGTChPUG0cwzZleyIFouGGyo8Rxu
X-Google-Smtp-Source: ADFU+vuzgnySETrv7JCPPbmi1t5WTcKrvGy3yJyLc0ysG69xum0gJOPpsbo1HvAzy8C6M8p0dZ+ff1IsbctcsiCKomM=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr2310909vkn.79.1583226888730;
 Tue, 03 Mar 2020 01:14:48 -0800 (PST)
MIME-Version: 1.0
References: <1583222684-10229-1-git-send-email-Anson.Huang@nxp.com> <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583222684-10229-2-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Mar 2020 14:44:38 +0530
Message-ID: <CAHLCerNLQ11UR8AW2DcKC+9rh39KPWJG2uRiWGuwbFbyqPH72Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: Remove COMPILE_TEST for IMX_SC_THERMAL
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 1:40 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> i.MX SCU thermal driver depends on IMX_SCU which does NOT have
> COMPILE_TEST enabled, so need to remove COMPILE_TEST for i.MX
> SCU thermal as well.

Wouldn't a better solution be to add COMPILE_TEST to IMX_SCU to
improve compile coverage?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 165b7d6..4fb87df 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -253,7 +253,7 @@ config IMX_THERMAL
>
>  config IMX_SC_THERMAL
>         tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> -       depends on IMX_SCU || COMPILE_TEST
> +       depends on IMX_SCU
>         depends on OF
>         help
>           Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> --
> 2.7.4
>
