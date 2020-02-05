Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C703C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE3E20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CQ3Lze5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBETm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:42:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41888 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBETm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:42:26 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so3507573ioo.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tNmqVZiW++bCIMW549FZaWf//Au+3Hw7l0TwF264r8=;
        b=CQ3Lze5zaZTjmvhE3x3CrSo88h0oGNp0S8pHmB73CSZCa/zbWjTOuqj1DSyv7+LQ1Z
         TXumJ0aRVETgtfIfkuddmzWNsxznqiJLag5g2FuxwR1yIIdW5AgvkJZngkqL/tGsl1yE
         G7DM9Gz15hCx85y4b9zRJKC38nLawLWoIaWHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tNmqVZiW++bCIMW549FZaWf//Au+3Hw7l0TwF264r8=;
        b=nZZiKBlyyTYNJHEHSCWAH11piTtigpsV+DC1fGKOdW6wrI3d2qh4rHUA1J0o/fEnk+
         A72jfuFV91d26KyvyhYmpWRL5OhKidGvX5GA0vzlJz6xXZrYOInln0Yyt4yQJMKtNp3f
         EYMPPWtQEGR5/5atleH/z7/PAMHJwehIdXSCSk0hqgD2a2kAMho8K3CHH2tYGxWkVQts
         efD/e22lKuXRlyPCdnb9YitCodS3r4TsvrFQiAdmjc9c+4mjOFF+6OPnnf7+ea6OnwVu
         4PZ3Ggii5AhbMznkTpLS1ecv/KzGimJysU2GPwaw1EySpQ4ElmKLsvrKP6yCLgKXQpxr
         crPQ==
X-Gm-Message-State: APjAAAVQGQe2buADFuh9a562Z1ekF7dILMz4em6uufPJMNB1g+pUqYO/
        YNL7KsvjaVP8wHI8SSTqFziJIoOysqTDWD8kHdQkhw==
X-Google-Smtp-Source: APXvYqzSEMPMmAVvKUvBQCZUvo4BcU8NrVHQ9+f2s894VpBliUIc0Ui4e4CSx4FNMaBk7ap8CYtPg0r5dKQIx/oArdE=
X-Received: by 2002:a6b:dc03:: with SMTP id s3mr29708124ioc.50.1580931745506;
 Wed, 05 Feb 2020 11:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20200205190028.183069-1-pmalani@chromium.org> <20200205190028.183069-11-pmalani@chromium.org>
In-Reply-To: <20200205190028.183069-11-pmalani@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 5 Feb 2020 11:42:14 -0800
Message-ID: <CAPUE2uvJuNYc=MnGZfwT=hUzEJoRAoST-aT=xKfrTOZQ=5wgwQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 11:13 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
> which does the message buffer setup and cleanup.
>
> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
> function.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>
> Changes in v2:
> - Updated to use new function name and parameter list.
> - Used C99 element setting to initialize param struct.
> - For second usage, replaced cros_ec_cmd_xfer_status() with
>   cros_ec_cmd_xfer() which is functionally similar.
>
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index d3a3626c7cd834..94e22e7d927631 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>                                              u16 cmd_offset, u16 cmd, u32 *mask)
>  {
>         int ret;
> -       struct {
> -               struct cros_ec_command msg;
> -               union {
> -                       struct ec_params_get_cmd_versions params;
> -                       struct ec_response_get_cmd_versions resp;
> -               };
> -       } __packed buf = {
> -               .msg = {
> -                       .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> -                       .insize = sizeof(struct ec_response_get_cmd_versions),
> -                       .outsize = sizeof(struct ec_params_get_cmd_versions)
> -                       },
> -               .params = {.cmd = cmd}
> +       struct ec_params_get_cmd_versions params = {
> +               .cmd = cmd,
>         };
> +       struct ec_response_get_cmd_versions resp = {0};
>
> -       ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +       ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> +                         &params, sizeof(params), &resp, sizeof(resp), NULL);
>         if (ret >= 0)
> -               *mask = buf.resp.version_mask;
> +               *mask = resp.version_mask;
>         return ret;
>  }
>
> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>
>         memcpy(state->msg->data, &state->param, sizeof(state->param));
>
> -       ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +       ret = cros_ec_cmd_xfer(state->ec, state->msg);
>         if (ret < 0)
>                 return ret;
> +       else if (state->msg->result != EC_RES_SUCCESS)
> +               return -EPROTO;
>
>         if (ret &&
>             state->resp != (struct ec_response_motion_sense *)state->msg->data)
> --
> 2.25.0.341.g760bfbb309-goog
>
