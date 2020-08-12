Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0320C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A219D2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMwbVIHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLANr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLANq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:13:46 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:13:46 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id p191so425674ybg.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 17:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebsHfoPVNGyXMrTkuHjA53YYYGdAsPwpEIUxxBmOE5U=;
        b=KMwbVIHY6RQinyFbgj+S+JbWFu5Hz8CkOf0IpHfoV7byPdoFpi7iyd+3RPzPeint2A
         cdWYuHUf3IBLzJ1+gxBKQ0QaEjSmhuwvJubViwJbC8aHG9KVs+7hE2eJBXwJfoK6ctrk
         QfqFl6WlQouM4UrZO3UMwmYQ5f1Y2ROUbSr4izzpN5hhsHOFcLuHfdELWXTyn/FbBkq0
         kyVJzp63jXUBGbXLlBCCrvKHlfmIvnygJD2W+EhiBwCF255rr/WIN89NbJcClnEOaTKo
         wMcRgwscBPXLkoQjgOmYPFCBhRWYXYkEh5DMd6sMg/QqSVnF/v97S4UxE8tLsxf1Y0np
         50QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebsHfoPVNGyXMrTkuHjA53YYYGdAsPwpEIUxxBmOE5U=;
        b=MsqaePhQLSIjtVAAdiUIXyjTVi5UTo/nq0RnGoav1a2I7+DvjnLRushv6fAyvE6RAp
         MboN92myEw3sUSM+d+ghigomQbyg2TBadu3FvDATyNOd+qiljh48l/yw9+4GNu1yUiso
         nxu4C2xUky5BUMyDoUu4Pxp9dWcnRhSYJlVjk1Lq7ARYIUjnbA3V4+6+qDtxXH6S657/
         Sulg8pgz+3N9tI8p2XWFqrY3Vr91DTXT6oYIBSYY8N0nioo7rLeS6XzcA9S3tNcm7IZE
         +gOQZNUeUXe6pyM+jiy2Tn1UWxQRWAjvakpJfpvWNPHEerPJnEsh6iE4Da5Dz2rynmLw
         rQWQ==
X-Gm-Message-State: AOAM531VavCFDQNEJ6hSuHruFgxh54CkmyzDr3e6TJHPkZiF5Gy8G9Pg
        8qessNRsWY9kUy+/tTTp99al2S343MtGu5hwm90=
X-Google-Smtp-Source: ABdhPJxe0XSsaIztI9QzAt/GPKTs1l02Z9HdJLOKtL/GZEPcf7TDtTfw3LMoiyCjQpm57qHO7bNIU364fDuWX15ZTYE=
X-Received: by 2002:a25:cbc5:: with SMTP id b188mr48035429ybg.268.1597191226039;
 Tue, 11 Aug 2020 17:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200811200457.134743-1-lyude@redhat.com> <20200811200457.134743-18-lyude@redhat.com>
In-Reply-To: <20200811200457.134743-18-lyude@redhat.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 12 Aug 2020 10:13:34 +1000
Message-ID: <CACAvsv40EOqf9pB16vPrRySm3BRP61ZeD09PDNKDWOuy_sCfmQ@mail.gmail.com>
Subject: Re: [RFC 17/20] drm/nouveau/kms/nv50-: Add support for DP_SINK_COUNT
To:     Lyude Paul <lyude@redhat.com>
Cc:     ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Ben Skeggs <bskeggs@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 at 06:06, Lyude Paul <lyude@redhat.com> wrote:
>
> This is another bit that we never implemented for nouveau: dongle
> detection. When a "dongle", e.g. an active display adaptor, is hooked up
> to the system and causes an HPD to be fired, we don't actually know
> whether or not there's anything plugged into the dongle without checking
> the sink count. As a result, plugging in a dongle without anything
> plugged into it currently results in a bogus EDID retrieval error in the kernel log.
>
> Additionally, most dongles won't send another long HPD signal if the
> user suddenly plugs something in, they'll only send a short HPD IRQ with
> the expectation that the source will check the sink count and reprobe
> the connector if it's changed - something we don't actually do. As a
> result, nothing will happen if the user plugs the dongle in before
> plugging something into the dongle.
>
> So, let's fix this by checking the sink count in both
> nouveau_dp_probe_dpcd() and nouveau_dp_irq(), and reprobing the
> connector if things change.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ben Skeggs <bskeggs@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nouveau_dp.c      | 54 ++++++++++++++++++++---
>  drivers/gpu/drm/nouveau/nouveau_encoder.h |  2 +
>  2 files changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
> index f6950a62138ca..f41fa513023fd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dp.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
> @@ -36,12 +36,22 @@ MODULE_PARM_DESC(mst, "Enable DisplayPort multi-stream (default: enabled)");
>  static int nouveau_mst = 1;
>  module_param_named(mst, nouveau_mst, int, 0400);
>
> +static bool
> +nouveau_dp_has_sink_count(struct drm_connector *connector,
> +                         struct nouveau_encoder *outp)
> +{
> +       return drm_dp_has_sink_count(connector, outp->dp.dpcd,
> +                                    &outp->dp.desc);
> +}
> +
>  static enum drm_connector_status
>  nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>                       struct nouveau_encoder *outp)
>  {
> +       struct drm_connector *connector = &nv_connector->base;
>         struct drm_dp_aux *aux = &nv_connector->aux;
>         struct nv50_mstm *mstm = NULL;
> +       enum drm_connector_status status = connector_status_disconnected;
>         int ret;
>         u8 *dpcd = outp->dp.dpcd;
>
> @@ -50,9 +60,9 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>                 ret = drm_dp_read_desc(aux, &outp->dp.desc,
>                                        drm_dp_is_branch(dpcd));
>                 if (ret < 0)
> -                       return connector_status_disconnected;
> +                       goto out;
>         } else {
> -               return connector_status_disconnected;
> +               goto out;
>         }
>
>         if (nouveau_mst) {
> @@ -61,12 +71,33 @@ nouveau_dp_probe_dpcd(struct nouveau_connector *nv_connector,
>                         mstm->can_mst = drm_dp_has_mst(aux, dpcd);
>         }
>
> +       if (nouveau_dp_has_sink_count(connector, outp)) {
> +               ret = drm_dp_get_sink_count(aux);
> +               if (ret < 0)
> +                       goto out;
> +
> +               outp->dp.sink_count = ret;
> +
> +               /*
> +                * Dongle connected, but no display. Don't bother reading
> +                * downstream port info
> +                */
> +               if (!outp->dp.sink_count)
> +                       return connector_status_disconnected;
> +       }
> +
>         ret = drm_dp_downstream_read_info(aux, dpcd,
>                                           outp->dp.downstream_ports);
>         if (ret < 0)
> -               return connector_status_disconnected;
> +               goto out;
>
> -       return connector_status_connected;
> +       status = connector_status_connected;
> +out:
> +       if (status != connector_status_connected) {
> +               /* Clear any cached info */
> +               outp->dp.sink_count = 0;
> +       }
> +       return status;
>  }
>
>  int
> @@ -161,6 +192,8 @@ void nouveau_dp_irq(struct nouveau_drm *drm,
>         struct drm_connector *connector = &nv_connector->base;
>         struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
>         struct nv50_mstm *mstm;
> +       int ret;
> +       bool send_hpd = false;
>
>         if (!outp)
>                 return;
> @@ -172,12 +205,23 @@ void nouveau_dp_irq(struct nouveau_drm *drm,
>
>         if (mstm && mstm->is_mst) {
>                 if (!nv50_mstm_service(drm, nv_connector, mstm))
> -                       nouveau_connector_hpd(connector);
> +                       send_hpd = true;
>         } else {
>                 drm_dp_cec_irq(&nv_connector->aux);
> +
> +               if (nouveau_dp_has_sink_count(connector, outp)) {
> +                       ret = drm_dp_get_sink_count(&nv_connector->aux);
> +                       if (ret != outp->dp.sink_count)
> +                               send_hpd = true;
> +                       if (ret >= 0)
> +                               outp->dp.sink_count = ret;
> +               }
>         }
>
>         mutex_unlock(&outp->dp.hpd_irq_lock);
> +
> +       if (send_hpd)
> +               nouveau_connector_hpd(connector);
>  }
>
>  /* TODO:
> diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
> index c1924a4529a7b..21937f1c7dd90 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
> @@ -74,6 +74,8 @@ struct nouveau_encoder {
>                         u8 dpcd[DP_RECEIVER_CAP_SIZE];
>                         u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
>                         struct drm_dp_desc desc;
> +
> +                       u8 sink_count;
>                 } dp;
>         };
>
> --
> 2.26.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
