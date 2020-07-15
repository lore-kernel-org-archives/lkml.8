Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BEEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DFAE207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594856814;
	bh=0Z67DEQDHtPE1jpEjdWwnW7bGURvhC5c7yF3Sjpr8hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gs9ipQUGPHY8UbCd4wmTpLfkLcxnANzqz7mmC2ONV53pS9+sJpyznj+MyDdZEfeBw
	 GBZa80ENCSftPEiMY0n3FdS5s84xZij9Imru5KUBdx9ZEvDcZjFtH1dAjLUCul5f17
	 QV2VV9eCrLqkLt6jj9FFFEDMFkQ1lbBhTw7hXGN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGOXqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGOXqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:46:52 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DE82072E;
        Wed, 15 Jul 2020 23:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594856812;
        bh=0Z67DEQDHtPE1jpEjdWwnW7bGURvhC5c7yF3Sjpr8hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYZW967hw78HF44rBPZbhDp74+Fd+k9NG8yQo6a39ZFC/RrcnhJ6l1FplyjoUsLrm
         FQsevYclY00Fz2eqEoFv+K3SCB82olAXFZcdd4hjHkAP04Pzv0CBfGSUBl69T9+uwx
         QCWEh/HsT2CBwvEiB8OsGm01nw7B6frzsh/OrI6w=
Received: by mail-ej1-f44.google.com with SMTP id rk21so4339531ejb.2;
        Wed, 15 Jul 2020 16:46:51 -0700 (PDT)
X-Gm-Message-State: AOAM532kg9G4jea9PAjzpCEwCelwqCRo5gplmvtz9bDuYmVSrDB8uDB1
        26B+GzpQPWw1hFpMqjV5xtdTaad8obIQiyUOMw==
X-Google-Smtp-Source: ABdhPJybFTPB4ttZSVsoT9XP7GbTBiZv3OHdAp22XXJXjOEHZph4uhAj/ulMlTNJr2ITr8vkAIq1+BAKIAJ+CF4iAB0=
X-Received: by 2002:a17:906:404e:: with SMTP id y14mr1294495ejj.260.1594856810429;
 Wed, 15 Jul 2020 16:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com> <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
In-Reply-To: <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 16 Jul 2020 07:46:39 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-6d12FUf5XnYco0f0CfeWsb-XjsCESsLixLr_Q=jnc0Q@mail.gmail.com>
Message-ID: <CAAOTY_-6d12FUf5XnYco0f0CfeWsb-XjsCESsLixLr_Q=jnc0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, Neal:

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B47=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
>
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
>
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---

[snip]

> +
> +/*
> + * mtk_devapc_dump_vio_dbg - shift & dump the violation debug informatio=
n.
> + */
> +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *devapc_ct=
x,
> +                                   int slave_type, int *vio_idx)
> +{
> +       const struct mtk_device_info **device_info;
> +       u32 shift_bit;
> +       int i;
> +
> +       device_info =3D devapc_ctx->device_info;
> +
> +       for (i =3D 0; i < get_vio_slave_num(slave_type); i++) {
> +               *vio_idx =3D device_info[slave_type][i].vio_index;
> +
> +               if (check_vio_mask(devapc_ctx, slave_type, *vio_idx))
> +                       continue;

I guess if one vio_idx is masked, its status would never be true. If
my guess is right, I think you could skip check_vio_mask() and
directly check_vio_status().

> +
> +               if (!check_vio_status(devapc_ctx, slave_type, *vio_idx))
> +                       continue;
> +
> +               shift_bit =3D get_shift_group(devapc_ctx, slave_type, *vi=
o_idx);
> +
> +               if (!sync_vio_dbg(devapc_ctx, slave_type, shift_bit))
> +                       continue;
> +
> +               devapc_extract_vio_dbg(devapc_ctx, slave_type);
> +
> +               return true;

I think multiple vio_idx would violate at the same time, why just process o=
ne?

Regards,
Chun-Kuang.

> +       }
> +
> +       return false;
> +}
