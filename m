Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD5C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325B22078B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG1kscR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404076AbgDNCWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404055AbgDNCWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:22:06 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA54C0A3BDC;
        Mon, 13 Apr 2020 19:22:05 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 11so6345082ybj.11;
        Mon, 13 Apr 2020 19:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awmGrwmcz5aeG6k8MhFEgBaKuoZUeZk5jIB18zmrVt8=;
        b=GG1kscR7x6EajZgB+6nk3ksaoiMBiXTRMW0RaFD4RVIzeNEG4w0De5NWOLiD4ZLDG1
         gh7sO3nE30kQm9RhUlQU2nmzKEFmx7yhpYtim9eaTvXRuoNDSKjvdZIPvkGEg5RU1yjy
         4xjPgyvrVc/mhQNNfQhayQTfJt46Qo5ykXU7RJfGw5LrK/i3oSo66RQfghLTbMgxMwzr
         TdLVAi8sOZMxaIg1oDg9vLTkiXtPed9UEulCMmWT503xsa430fas5vWruFU2s5+Mkk4n
         2QLA8SAJiaMSgRY5Yn66oRn2D6mpzmti3qOgFglKKGr5u62ckvtW6SopqvesdvS3oEPS
         bfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awmGrwmcz5aeG6k8MhFEgBaKuoZUeZk5jIB18zmrVt8=;
        b=ICJd/osEbfF0iKYdW7gRrylDOoDnjlqc0dOM7AiSoqw0CR8S6CE3n4fDo5lJfSPMaN
         rByCijKRr3W0R2H7HB99IiLOIZyb53gKnZL8xuFavn87gdLNH+ztcSi9c4UBZ2i1lIs1
         ISE9YiVlzRmoz0bANARWgYU0iFno64tm1uXsJkCmNpOjkZ4Lo85/tIYWFrkFZ7mEfwBm
         GLNu9cJt1u6GSPX2FLwkOKC6CMld98vnysJHyYM8iBZJHTuSqh0kEg8W4Fh9DNht/w2J
         V4Q9dXs00NtanrwK8CS8a6f42k/fJn4JVyvj96DfOYZt5raAu8CltAd4hVz/y1PkfW5G
         NTWw==
X-Gm-Message-State: AGi0Pua7QKsPG1yU/WJm/PMRMDZGwpO/S6mWfUSjBSdbYNfUorOS7n1Z
        D8Q8o26uwshu+rIZnp2Il2+mK+XlwqpVAlXZFTKwlcxk
X-Google-Smtp-Source: APiQypLMHH0a+6ypkNMRaTXre5eZdgyn24IXJp/BZeN67bbx+T1wgzVcBrLvf9iDyZK21J6aJ/AflIrlpoPaR0RLk+8=
X-Received: by 2002:a05:6902:4a2:: with SMTP id r2mr32195235ybs.60.1586830923366;
 Mon, 13 Apr 2020 19:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586747728.git.shengjiu.wang@nxp.com> <6d2bed91bcdbc3f75a9d12ac4ebf6c34c9bb9c3f.1586747728.git.shengjiu.wang@nxp.com>
 <20200414020748.GB10195@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20200414020748.GB10195@Asurada-Nvidia.nvidia.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 14 Apr 2020 10:21:29 +0800
Message-ID: <CAA+D8AN8OUtTftc_So-Z0_sjWt4RXq6fr4GpSy3Xh+YbkryfpQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] ASoC: fsl_asrc: Move common definition to fsl_asrc_common
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Apr 14, 2020 at 08:43:07AM +0800, Shengjiu Wang wrote:
> > There is a new ASRC included in i.MX serial platform, there
> > are some common definition can be shared with each other.
> > So move the common definition to a separate header file.
> >
> > And add fsl_asrc_pair_priv and fsl_asrc_priv for
> > the variable specific for the module, which can be used
> > internally.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > +static size_t fsl_asrc_get_pair_priv_size(void)
> > +{
> > +     return sizeof(struct fsl_asrc_pair_priv);
> > +}
>
> Perhaps we haven't understood completely each other's point.
>
> Yet, would the following change work?

Should work, almost same, or do you want me to use variable to
replace function pointer?

best regards
wang shengjiu
