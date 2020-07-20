Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF71C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CC322B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595254844;
	bh=Vib6dxAx8u3DoTSWJXH5KMkq3799ypAVfeuWMkW6Hj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mepeGaa1oNhoJs5lYVQzxfVjaNlR5/WXyofHP/2GFIbhJrufX5KlPWnVgVIfq84Za
	 bRPPGo6v1LnkCK0MqXyD4PBc3DFwxx2Q3gkqnxs5aRqg9BGm38xeHRrpbIBTtQTfT3
	 DRTypuXg8n0fsTT4ZjOAZGSmZ8j8ZiljncYUkD34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGTOUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgGTOUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:20:42 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B577222CAF;
        Mon, 20 Jul 2020 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595254841;
        bh=Vib6dxAx8u3DoTSWJXH5KMkq3799ypAVfeuWMkW6Hj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y+GBWxSjbTxcsL9FTO8DgCDwnf9G9i9jJLGRzjbIbJbnfc/p3SWainC3JOFWzl6Cg
         tBHe3qPnv2X+MrorxWay6AqVOd7lyzKu4NOxYI1QLVEVp10EF8yFfC7aHWL2x20SU+
         jiSfuE5OwnT2P+CSRXld82tpVBQxGuMdwC+oFpLE=
Received: by mail-ot1-f47.google.com with SMTP id h1so12300859otq.12;
        Mon, 20 Jul 2020 07:20:41 -0700 (PDT)
X-Gm-Message-State: AOAM533N1r6ZPXPkVmfboR8Lbo6R2gpoE0O4+lPFhHu8hg0iZyGcDa0L
        yu7T2KBaOSSdMYzWRXbqVP3m3cdWZLGeWm0/Xw==
X-Google-Smtp-Source: ABdhPJwHTembEjVuQTsjX9Y4lVbdIElrObkCp3VjWe/eZu4PcW+QH4GExQ6U+8YWt1byxEkCF1wg9PXj+VhOMp2l8VE=
X-Received: by 2002:a9d:46c:: with SMTP id 99mr775393otc.192.1595254841027;
 Mon, 20 Jul 2020 07:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com> <1595134890-16470-2-git-send-email-spujar@nvidia.com>
In-Reply-To: <1595134890-16470-2-git-send-email-spujar@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Jul 2020 08:20:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+HBBLkUY=ODo+TmV_MhO40r9sfB=k1j64j7m67GUoSaQ@mail.gmail.com>
Message-ID: <CAL_Jsq+HBBLkUY=ODo+TmV_MhO40r9sfB=k1j64j7m67GUoSaQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] ASoC: dt-bindings: tegra: Add DT bindings for Tegra210
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com,
        nwartikar@nvidia.com, Stephen Warren <swarren@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 11:01 PM Sameer Pujar <spujar@nvidia.com> wrote:
>
> This patch adds YAML schema for DT binding of AHUB and few of its
> following components. These devices will be registered as ASoC
> components and binding will be used on Tegra210 and later chips.
>  * ADMAIF
>  * I2S
>  * DMIC
>  * DSPK
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
>         t=1595134894; bh=DX96zRQRNplPikN828HbAfbjGumAn9IgtktrsenKjgk=;
>         h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
>          In-Reply-To:References:X-NVConfidentiality:MIME-Version:
>          Content-Type;
>         b=IhfGFjMxsnRHso1Ku2GEGC+mtLCy3AbRKPfgTS56XGqEWquUr/1s8n9tFpriqF7a+
>          tJGrTN9mKhRQGrwdey/AHsMY4Tbm4fKEWxIASgAV/lFPCfgP3BnVjEdHclc7FdBaB0
>          Qvd3zs8HFsgoIzksLrtHNMrUepkeZajn0/XnC7nghGDRim4+6Hauupr5kj/KVlihsS
>          KS1YQ2Zz9TZzLaC5QXALiHj3ATLvBFrmIf6Vj19q7hePt0menTZVzQNy+y3h4xZfLH
>          +OvBCsLgHGGhq+iM9rm64D+S5Op2vCslwq3Q/42TnYZ0vDbD7aA9nTAQzfYeI6HK6b
>          vi7eYbryzCTSg==
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra186-dspk.yaml       |  83 +++++++++++++
>  .../bindings/sound/nvidia,tegra210-admaif.yaml     | 111 +++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-ahub.yaml       | 136 +++++++++++++++++++++
>  .../bindings/sound/nvidia,tegra210-dmic.yaml       |  83 +++++++++++++
>  .../bindings/sound/nvidia,tegra210-i2s.yaml        | 101 +++++++++++++++
>  5 files changed, 514 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra186-dspk.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-admaif.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-dmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml

Use get_maintainers.pl and send to the correct lists if you want this reviewed.

Rob
