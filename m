Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5CC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8792220679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLK3ib9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgCPUI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:08:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41787 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgCPUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:08:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id s11so17239128qks.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7O+y+5PEoVenZhGHq9mu4e8GpUF5OMLN8jJyvkkAuA=;
        b=GLK3ib9JqbFf9iF8NGea8Z02yjbUhv86Qnz2UVCwo6GJzRWxTihfsWCUTHZiIDKBe3
         iwbbt7GKMKqQVqrPm3UqZlhhj/gpOHWNXYIU9l7EwsPYpkzTVKLEISUcpQ/Kc0T14rTK
         ba9kRoWtffQWv9ZAOZiZYjZ3/7WOSquGBDkwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7O+y+5PEoVenZhGHq9mu4e8GpUF5OMLN8jJyvkkAuA=;
        b=IpS0270uUGYygQ25qcCe8hpuOTkZApx3wujthrao0hCl8KQZgUzF5I1fS4OyZ9MKhJ
         0ZOoo290pNg1bW7zQgBBq8WWm6w1gkpuLLiydcipqFhh1fERg33703310dODZQqD+U/k
         BjufjxNNf0LKyUi4wTzp5fO2cyr0UN2EtEAHXxtBJYMXGbFRrszzA7/Pg6mGiuS9+d2I
         z0qweajOZL6L9mVk9nlf2lWQTnGgXXkhSHDB5uYZhJo/UUEhB7lv0yxhSgsm29MmYFpU
         gtKhoEMCGoKbnABSWSv64kJ/pUR78IOa0T3TJhvPKiPT2sKhssDbgj5AU0016XZy0Lxf
         2BIQ==
X-Gm-Message-State: ANhLgQ2kbMfTSGOaNXITfTmtSAt8AdEKQvt6SsG+9sd7BDIO8desYjfd
        Qdz0+H/ydKAuoYyAs6k3uuckFIiOyuDh0OGNtLRqBoUV
X-Google-Smtp-Source: ADFU+vs5S1dg4gBE563kTuO9lUVvXZUUs6RGzfibabJb0mgdl11MosVnwpbj3oj46Nfhd2cc9MhY+rZktDGLwR6+s50=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr1394597qka.179.1584389303039;
 Mon, 16 Mar 2020 13:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200316090021.52148-1-pmalani@chromium.org> <20200316090021.52148-4-pmalani@chromium.org>
In-Reply-To: <20200316090021.52148-4-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 16 Mar 2020 13:08:11 -0700
Message-ID: <CACeCKadfezCCAa67p71Dqf2WUR8szLO45xzPq4XxFG53S-Y5fQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, missed adding Heikki.

On Mon, Mar 16, 2020 at 2:01 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Query the EC to determine the version number of the PD_CONTROL
> command which is supported by the EC. Also store this value in the Type
> C data struct since it will be used to determine how to parse the
> response to queries for port information from the EC.
>
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
> - Moved if statement check in the end of probe() from this patch to a
>   previous patch.
>
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_typec.c | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 02e6d5cbbbf7a..9f692eb78b322 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -21,6 +21,7 @@ struct cros_typec_data {
>         struct device *dev;
>         struct cros_ec_device *ec;
>         int num_ports;
> +       unsigned int cmd_ver;
>         /* Array of ports, indexed by port number. */
>         struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>         /* Initial capabilities for each port. */
> @@ -171,6 +172,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
>         return ret;
>  }
>
> +static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> +{
> +       struct ec_params_get_cmd_versions_v1 req_v1;
> +       struct ec_response_get_cmd_versions resp;
> +       int ret;
> +
> +       /* We're interested in the PD control command version. */
> +       req_v1.cmd = EC_CMD_USB_PD_CONTROL;
> +       ret = cros_typec_ec_command(typec, 1, EC_CMD_GET_CMD_VERSIONS,
> +                                   &req_v1, sizeof(req_v1), &resp,
> +                                   sizeof(resp));
> +       if (ret < 0)
> +               return ret;
> +
> +       if (resp.version_mask & EC_VER_MASK(1))
> +               typec->cmd_ver = 1;
> +       else
> +               typec->cmd_ver = 0;
> +
> +       dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
> +               typec->cmd_ver);
> +
> +       return 0;
> +}
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id cros_typec_acpi_id[] = {
>         { "GOOG0014", 0 },
> @@ -202,6 +228,12 @@ static int cros_typec_probe(struct platform_device *pdev)
>         typec->ec = dev_get_drvdata(pdev->dev.parent);
>         platform_set_drvdata(pdev, typec);
>
> +       ret = cros_typec_get_cmd_version(typec);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to get PD command version info\n");
> +               return ret;
> +       }
> +
>         ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>                                     &resp, sizeof(resp));
>         if (ret < 0)
> --
> 2.25.1.481.gfbce0eb801-goog
>
