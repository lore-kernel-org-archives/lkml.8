Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D39C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0003A206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vi1FEP2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbgCPUI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:08:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43733 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgCPUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:08:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id l13so15405395qtv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXYTnR2RSdF9ZUbls3vNbNnwKPqZaGBmx3h0m/8kkBg=;
        b=Vi1FEP2X8iumt4miyUdQxGMiF8UPkzZijZCE/bPHiPCrbN8HCoMo5LQjm1AYLc0vhI
         Nk6SB3B3sb8rkKyTNCCwCrJq8TcobPuH1V3tvvJ/4dqJYkXLFN07vQa/THT+UgYPlto9
         Spg0URM0FOkLWHiz/Q35IoeW49cEPIDFVXQXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXYTnR2RSdF9ZUbls3vNbNnwKPqZaGBmx3h0m/8kkBg=;
        b=XaPROH6Oiss/Xs7fIjCHdRFC9Gl/PIArkIHZeX17t88qzLCfVhuvLWOTjCz6hkts8K
         8xtxHBpINoGhfyFAr59uyBq3tDZJq4uDMJoHDQg97sUeUWkqowCzKSROLO84TYJsVjpu
         U2SQOexVw2SZMadAjB9pQ+/ZDkAxxDAxNH9+IbGO5HIh3VfJS7sFGK9I4Uo4IF0LoPM9
         NDqFkGvzyJdi6JVFMPwlQ/1xbjJGubabl8hIO2OUQuGHT6QeIkc5YGw5GZk2qGznsuHm
         yyFNK9tRfCLIUcUK5Sk0QlJDUnm3dSMKNNbfa2C+psc2ccIyrkfokJsfEZIOQU9URjZi
         mrOw==
X-Gm-Message-State: ANhLgQ3SYFxI14z5QDt+tcONoKqm6oVq+pPhzekxmdcFJZ0LXR7YLWx2
        VrdEcI3DndYY/+nooMosAT8XRzhNg74/HJyGW0Qt3uIJ
X-Google-Smtp-Source: ADFU+vsIbBJKT5bXfDYDhgVaQBFCHbt+8VVcY2MdUQ1YQUXRur1HC2pNuz0cesRGlimb33H/ijA5NUEPCMEQOI3cHMY=
X-Received: by 2002:ac8:140c:: with SMTP id k12mr1875447qtj.117.1584389333039;
 Mon, 16 Mar 2020 13:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200316090021.52148-1-pmalani@chromium.org> <20200316090021.52148-5-pmalani@chromium.org>
In-Reply-To: <20200316090021.52148-5-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 16 Mar 2020 13:08:41 -0700
Message-ID: <CACeCKadzvSFT8p9t5ZoUncO+EzmTRRPqO7yGDZnsvJYdX7FFFQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] platform/chrome: typec: Update port info from EC
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Heikki (missed in the initial email)

On Mon, Mar 16, 2020 at 2:01 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> After registering the ports at probe, get the current port information
> from EC and update the Type C connector class ports accordingly.
>
> Co-developed-by: Jon Flatley <jflat@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v5:
> - No changes.
>
> Changes in v4:
> - No changes
>
> Changes in v3:
> - No changes.
>
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_typec.c | 89 ++++++++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 9f692eb78b322..874269c070739 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -172,6 +172,81 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>         return ret;
>  }
>
> +static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
> +               int port_num, struct ec_response_usb_pd_control *resp)
> +{
> +       struct typec_port *port = typec->ports[port_num];
> +       enum typec_orientation polarity;
> +
> +       if (!resp->enabled)
> +               polarity = TYPEC_ORIENTATION_NONE;
> +       else if (!resp->polarity)
> +               polarity = TYPEC_ORIENTATION_NORMAL;
> +       else
> +               polarity = TYPEC_ORIENTATION_REVERSE;
> +
> +       typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
> +       typec_set_orientation(port, polarity);
> +}
> +
> +static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
> +               int port_num, struct ec_response_usb_pd_control_v1 *resp)
> +{
> +       struct typec_port *port = typec->ports[port_num];
> +       enum typec_orientation polarity;
> +
> +       if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
> +               polarity = TYPEC_ORIENTATION_NONE;
> +       else if (!resp->polarity)
> +               polarity = TYPEC_ORIENTATION_NORMAL;
> +       else
> +               polarity = TYPEC_ORIENTATION_REVERSE;
> +       typec_set_orientation(port, polarity);
> +       typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
> +                       TYPEC_HOST : TYPEC_DEVICE);
> +       typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
> +                       TYPEC_SOURCE : TYPEC_SINK);
> +       typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
> +                       TYPEC_SOURCE : TYPEC_SINK);
> +}
> +
> +static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
> +{
> +       struct ec_params_usb_pd_control req;
> +       struct ec_response_usb_pd_control_v1 resp;
> +       int ret;
> +
> +       if (port_num < 0 || port_num >= typec->num_ports) {
> +               dev_err(typec->dev, "cannot get status for invalid port %d\n",
> +                       port_num);
> +               return -EINVAL;
> +       }
> +
> +       req.port = port_num;
> +       req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
> +       req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
> +       req.swap = USB_PD_CTRL_SWAP_NONE;
> +
> +       ret = cros_typec_ec_command(typec, typec->cmd_ver,
> +                                   EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
> +                                   &resp, sizeof(resp));
> +       if (ret < 0)
> +               return ret;
> +
> +       dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
> +       dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
> +       dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
> +       dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
> +
> +       if (typec->cmd_ver == 1)
> +               cros_typec_set_port_params_v1(typec, port_num, &resp);
> +       else
> +               cros_typec_set_port_params_v0(typec, port_num,
> +                       (struct ec_response_usb_pd_control *) &resp);
> +
> +       return 0;
> +}
> +
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
>  {
>         struct ec_params_get_cmd_versions_v1 req_v1;
> @@ -218,7 +293,7 @@ static int cros_typec_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct cros_typec_data *typec;
>         struct ec_response_usb_pd_ports resp;
> -       int ret;
> +       int ret, i;
>
>         typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
>         if (!typec)
> @@ -251,7 +326,19 @@ static int cros_typec_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> +       for (i = 0; i < typec->num_ports; i++) {
> +               ret = cros_typec_port_update(typec, i);
> +               if (ret < 0)
> +                       goto unregister_ports;
> +       }
> +
>         return 0;
> +
> +unregister_ports:
> +       for (i = 0; i < typec->num_ports; i++)
> +               if (typec->ports[i])
> +                       typec_unregister_port(typec->ports[i]);
> +       return ret;
>  }
>
>  static struct platform_driver cros_typec_driver = {
> --
> 2.25.1.481.gfbce0eb801-goog
>
