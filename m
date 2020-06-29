Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5512CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D6A20776
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DhpzuUF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgF2XR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgF2XR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:17:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C9CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:17:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so8374770pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=p5nptZDL0+e6uOVQKeig1P+xdgwO7UYCGAQCU2CHOBY=;
        b=DhpzuUF5hJ2fsxVANchsWjPwpNaKPAB0PU+nDaTYjzV1NWG6dSsUv6ml5iImoRIkJ0
         v/vW3ekNXoiPJtuD8mKtdnBa13b1XPEZmnsY7xjX0rWStArzgU8n63yIMBkF9gpaIS4J
         05s9eYKsvyr6uILsyxFVRMcmxDvIdmVav2AUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=p5nptZDL0+e6uOVQKeig1P+xdgwO7UYCGAQCU2CHOBY=;
        b=VrDEB8PzwpgbKsT93aQ5Y0G8icF9SKlldBWXd8NqCu3pqsnIFOAeRwXhqkpoEZGMvj
         1cMwhQbYoKzGCVfLBOeZc7tU3V06YzCxOpwVjKxyFA5O144ggEFwdZnzpa8Pa8niC/qk
         Egh/GFoDZXNzOcfJwwp5UciLttAoyE4jqvzRZ4jLUl21rjwiB5HBI4OvlK7vg+ZzQv9D
         L2ALXcB6fAE/qyP2CT/7MS9G6M7VnI6su1jYau6E66/Ig2+TYsPbuBw3322/4eYqy7oX
         Wl1710GaxEh+VOI06RIs8V1VT+/ed/T+oyL7zUb3+S8Uz+o0NizsI/31dluSBJrqKPL1
         tLNQ==
X-Gm-Message-State: AOAM533P86sv3gra2hvrLSid8X9WbipzOr2bQ7UIvQjCvlxHGdTD2ciH
        UoGXdFMuh9RoNXynxkVWokhQWA==
X-Google-Smtp-Source: ABdhPJwK6CbKettJAyZjmCgDQyGjAdS1Yfm3DIvJxTAITfG4XxT8lPIX/GXfCbxUOqQA/Ej+PhV1Nw==
X-Received: by 2002:a17:90a:a58b:: with SMTP id b11mr20230936pjq.107.1593472646911;
        Mon, 29 Jun 2020 16:17:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d7sm639974pfh.78.2020.06.29.16.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:17:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1592222564-13556-2-git-send-email-rnayak@codeaurora.org>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org> <1592222564-13556-2-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     viresh.kumar@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        robdclark@gmail.com, stanimir.varbanov@linaro.org
Date:   Mon, 29 Jun 2020 16:17:25 -0700
Message-ID: <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2020-06-15 05:02:39)
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 457c0bf..a90f8ec 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_wakeirq.h>
> @@ -962,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_=
port *uport,
>                 goto out_restart_rx;
> =20
>         uport->uartclk =3D clk_rate;
> -       clk_set_rate(port->se.clk, clk_rate);
> +       dev_pm_opp_set_rate(uport->dev, clk_rate);

If there isn't an OPP table for the device because it is optional then
how can we unconditionally call dev_pm_opp_set_rate()?

>         ser_clk_cfg =3D SER_CLK_EN;
>         ser_clk_cfg |=3D clk_div << CLK_DIV_SHFT;
> =20
> @@ -1231,8 +1232,11 @@ static void qcom_geni_serial_pm(struct uart_port *=
uport,
>         if (new_state =3D=3D UART_PM_STATE_ON && old_state =3D=3D UART_PM=
_STATE_OFF)
>                 geni_se_resources_on(&port->se);
>         else if (new_state =3D=3D UART_PM_STATE_OFF &&
> -                       old_state =3D=3D UART_PM_STATE_ON)
> +                       old_state =3D=3D UART_PM_STATE_ON) {
> +               /* Drop the performance state vote */
> +               dev_pm_opp_set_rate(uport->dev, 0);
>                 geni_se_resources_off(&port->se);
> +       }
>  }
> =20
>  static const struct uart_ops qcom_geni_console_pops =3D {
> @@ -1351,13 +1355,25 @@ static int qcom_geni_serial_probe(struct platform=
_device *pdev)
>         if (of_property_read_bool(pdev->dev.of_node, "cts-rts-swap"))
>                 port->cts_rts_swap =3D true;
> =20
> +       port->se.opp_table =3D dev_pm_opp_set_clkname(&pdev->dev, "se");
> +       if (IS_ERR(port->se.opp_table))
> +               return PTR_ERR(port->se.opp_table);
> +       /* OPP table is optional */
> +       ret =3D dev_pm_opp_of_add_table(&pdev->dev);
> +       if (!ret) {
> +               port->se.has_opp_table =3D true;
> +       } else if (ret !=3D -ENODEV) {
> +               dev_err(&pdev->dev, "invalid OPP table in device tree\n");
> +               return ret;
> +       }

At least it looks optional here.
