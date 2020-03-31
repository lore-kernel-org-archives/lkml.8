Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5520578
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b05sdn21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgCaHBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:01:16 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:34692 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCaHBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:01:16 -0400
Received: by mail-vk1-f193.google.com with SMTP id p123so5431924vkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvuAH+ZYLpn75EjzibJc7yETVLNUxZFK2JZ8MLXPA78=;
        b=b05sdn21WYjo3DK3zZJ08Q9TtPiYpAWWxAiq3/L7PYpRFs/rZNM3yw8hc22eRKyInj
         UD1o2FE+dPcLqR5R6YWgTaKL21ubz/I/91Cb+o3NdwJnYvnq0FbGmnpibJ9CQqxa9Yjb
         baslK/+CNW5WROZHoLLrT2uhkCXjBz6iTM6HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvuAH+ZYLpn75EjzibJc7yETVLNUxZFK2JZ8MLXPA78=;
        b=n7Omj1pxKb4CSRhBMCVN9IZu/LYO9trr6r76pEvFYHCsAJNyCo91uaF8g04UASzyjL
         /FvkdcEHoxI9kr724u+4Mvxym+i4SHZZwyd0aoPezd2tuf7ylqC2QBkivAatl6bNbKjR
         KxPK1yqqyn4QAgSpvaSaHDa70ZySVRKTW28g3kMaoL+3jalPMpanbBPdIaGqqbAYCGT4
         aeq135w5/rzZfiLjadCm4jJ9r+oDlmA/a2eXSrRHQCcFh6y6PtwP9/cqCzjsPvpr4RcS
         4EPdNmqkFVLk5mBfk4H1bDuYpIQ4sUXXMrLKFPr18oKtiQOJQJzjbZirDqCyDa+Keg2v
         3viQ==
X-Gm-Message-State: AGi0PuYOacX0YjplIHrzBARGWnAToom/hQYMb6c6H3gBnmWT2+HIByW3
        hPbVvcP4sKTHLUhULNqhvj5maNqQFpdtsDa0xuBeTA==
X-Google-Smtp-Source: APiQypJZp4XEKa40PUQLr268/WGLXXDcI/rS9Qr2D5ddfkZrMAM7A+tJSFJKi5kKIZ/EhuBfEg7SRBKJmqp8r6cd9h0=
X-Received: by 2002:a1f:5cc4:: with SMTP id q187mr10506325vkb.85.1585638075720;
 Tue, 31 Mar 2020 00:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200324075734.1802-1-david.lu@bitland.com.cn>
In-Reply-To: <20200324075734.1802-1-david.lu@bitland.com.cn>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 31 Mar 2020 15:01:04 +0800
Message-ID: <CANMq1KA_iHHbCfm8AwBuj7zaazZtdtaE-nS+ZvdX5OyVTDbrmA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: boe-tv101wum-n16: extend LCD support list
To:     David Lu <david.lu@bitland.com.cn>
Cc:     David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        jungle.chiang@bitland.com.cn,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 4:17 PM David Lu <david.lu@bitland.com.cn> wrote:
>

No very strong opinion, but for consistency, I'd have this as a title:
drm/panel: support for boe,tv105wum-nw0 dsi video mode panel

> Add entries for BOE TV105WUM-NW0 10.5" WUXGA TFT LCD panel.
>
> Signed-off-by: David Lu <david.lu@bitland.com.cn>
> Change-Id: I5b1cef259de5fb498220dcc47baa035083c41667

No Change-Id please.

Otherwise:

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index 48a164257d18..f89861c8598a 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -696,6 +696,34 @@ static const struct panel_desc auo_b101uan08_3_desc = {
>         .init_cmds = auo_b101uan08_3_init_cmd,
>  };
>
> +static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
> +       .clock = 159260,
> +       .hdisplay = 1200,
> +       .hsync_start = 1200 + 80,
> +       .hsync_end = 1200 + 80 + 24,
> +       .htotal = 1200 + 80 + 24 + 60,
> +       .vdisplay = 1920,
> +       .vsync_start = 1920 + 10,
> +       .vsync_end = 1920 + 10 + 2,
> +       .vtotal = 1920 + 10 + 2 + 14,
> +       .vrefresh = 60,
> +       .type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct panel_desc boe_tv105wum_nw0_desc = {
> +       .modes = &boe_tv105wum_nw0_default_mode,
> +       .bpc = 8,
> +       .size = {
> +               .width_mm = 141,
> +               .height_mm = 226,
> +       },
> +       .lanes = 4,
> +       .format = MIPI_DSI_FMT_RGB888,
> +       .mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +                     MIPI_DSI_MODE_LPM,
> +       .init_cmds = boe_init_cmd,
> +};
> +
>  static int boe_panel_get_modes(struct drm_panel *panel,
>                                struct drm_connector *connector)
>  {
> @@ -834,6 +862,9 @@ static const struct of_device_id boe_of_match[] = {
>         { .compatible = "auo,b101uan08.3",
>           .data = &auo_b101uan08_3_desc
>         },
> +       { .compatible = "boe,tv105wum-nw0",
> +         .data = &boe_tv105wum_nw0_desc
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, boe_of_match);
> --
> 2.24.1
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
