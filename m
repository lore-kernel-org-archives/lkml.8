Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E2C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6641224654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmExyP/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCIVE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:04:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52282 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:04:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id p9so1067767wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPBql3SwnAWXA8bzGM5bAkSVwPmTU0okRlw09OOSTfQ=;
        b=MmExyP/mYk+2OXsRI4sWEDNBuTe0XrTKYZ4cHF/vlRg4JbJykPReC4Kb8vyDHC5YaW
         jvA6Ubv8k4CyajsL7sGjqoU92pUiDmr73cmGD3IBOmLh+JHYmZlOyLjPdlaId2pJQjPq
         YAop7y4iuCxpaqEMf38Y4pgoXaudsMw+2MBH02I78Xv8VXSc6HIa9kCQ9j9ZLae+ceAq
         mpyKlME+5ttvjgs3nsQPhT3zZgDVYTKZ1SeqoE4x0n9QbndliSZ9XOV8ncRujKQlWYdv
         iJllEj7PV/ZQ55CvStyXeES9oUusHJl0fWcNHg/ML4EQNKcgiSzgf5mnBixpdZiThRSL
         3Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPBql3SwnAWXA8bzGM5bAkSVwPmTU0okRlw09OOSTfQ=;
        b=YdfprRX/wOz0e/8/6DQiii+93WwPZaggfIuiF6J95VWE9CBD2Fvab9LBCzS0jOSMwZ
         3hI2m0P0pSHitjZSutwTUj7+PZe1uY56bUKVs84nrTZBT/5zW0x++FCaoDoyugdpkH1f
         6iRyi75bjV/YB1bg+fBwXwKmFM+u083Krz03ALbdqpWmDkoXsBcQsWY3OKvJHtucG1wV
         4AQb5yZ6+e7akngCw8d+29R7LEDa3CS81o+5iccOaPXdcOEejB/OH/OKFBk9g3EdFDGM
         8waGH/29EF+Tg+UsSCWCi3evCLG3/ETIhS0te+Az1aD4vejJpgxUQf7AiK03vQBfA6CK
         Me6g==
X-Gm-Message-State: ANhLgQ1lYvUHTyTB7t+QrqN3xF+oeIUoF+mcvDB+SiKBNKumTdWpHpM1
        wzPAdbKkbseHaN9O0fE5p3m0VugD+eAVERxsscU=
X-Google-Smtp-Source: ADFU+vt867l6+2f6xQRs6lHCyVXlKu6ZX8u2Fkbn27zJpglt9LXymm94ueIRIayE7EahP879gdzct1u7kXjVYQAbarQ=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr1067033wmc.39.1583787897357;
 Mon, 09 Mar 2020 14:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200306234623.547525-1-lyude@redhat.com> <20200306234623.547525-2-lyude@redhat.com>
In-Reply-To: <20200306234623.547525-2-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Mar 2020 17:04:46 -0400
Message-ID: <CADnq5_PfLg=Pvcb6SQtaEphxfj9G=Ad2t+oAFBK03rPQTn3vdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/dp_mst: Rename drm_dp_mst_is_dp_mst_end_device()
 to be less redundant
To:     Lyude Paul <lyude@redhat.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mikita Lipski <mikita.lipski@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 6:46 PM Lyude Paul <lyude@redhat.com> wrote:
>
> It's already prefixed by dp_mst, so we don't really need to repeat
> ourselves here. One of the changes I should have picked up originally
> when reviewing MST DSC support.
>
> There should be no functional changes here
>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 6c62ad8f4414..6714d8a5c558 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1937,7 +1937,7 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
>         return parent_lct + 1;
>  }
>
> -static bool drm_dp_mst_is_dp_mst_end_device(u8 pdt, bool mcs)
> +static bool drm_dp_mst_is_end_device(u8 pdt, bool mcs)
>  {
>         switch (pdt) {
>         case DP_PEER_DEVICE_DP_LEGACY_CONV:
> @@ -1967,13 +1967,13 @@ drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u8 new_pdt,
>
>         /* Teardown the old pdt, if there is one */
>         if (port->pdt != DP_PEER_DEVICE_NONE) {
> -               if (drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
> +               if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
>                         /*
>                          * If the new PDT would also have an i2c bus,
>                          * don't bother with reregistering it
>                          */
>                         if (new_pdt != DP_PEER_DEVICE_NONE &&
> -                           drm_dp_mst_is_dp_mst_end_device(new_pdt, new_mcs)) {
> +                           drm_dp_mst_is_end_device(new_pdt, new_mcs)) {
>                                 port->pdt = new_pdt;
>                                 port->mcs = new_mcs;
>                                 return 0;
> @@ -1993,7 +1993,7 @@ drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u8 new_pdt,
>         port->mcs = new_mcs;
>
>         if (port->pdt != DP_PEER_DEVICE_NONE) {
> -               if (drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
> +               if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
>                         /* add i2c over sideband */
>                         ret = drm_dp_mst_register_i2c_bus(&port->aux);
>                 } else {
> @@ -2169,7 +2169,7 @@ drm_dp_mst_port_add_connector(struct drm_dp_mst_branch *mstb,
>         }
>
>         if (port->pdt != DP_PEER_DEVICE_NONE &&
> -           drm_dp_mst_is_dp_mst_end_device(port->pdt, port->mcs)) {
> +           drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
>                 port->cached_edid = drm_get_edid(port->connector,
>                                                  &port->aux.ddc);
>                 drm_connector_set_tile_property(port->connector);
> --
> 2.24.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
