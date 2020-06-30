Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D21C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1CF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uewoGiRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgF3NbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgF3NbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:31:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:31:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i3so15482967qtq.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrXmMzhrfpzqEnud4K6uwivgEJVrHc8/GZLkP2z6bGw=;
        b=uewoGiROevRWGxnXkAJqkTKhBwCX3F01qbv8NnE285I74F2oy/ioesvxP5bb2T6UyH
         tK4BUrjPZkT3l4FbvbPaBf+QFdlQHVs49OU+NBHS5cw7kQdRDjj8TN+6Gadcxk8Etx8Y
         mITwoEduSsKLQKCp7zgxCWsrBXbxgsqL/mf3ojHw1E7V9C9dC+UNfLld+VnHi6emvQUr
         zrJR18Di74bbcPB1YeeSAbCaT63eDCDQfdtc9W1jY8beAKws1KKSVXXJJU+SI/OlHNan
         3jNsvQruSMsuQm29+GuAeqJv/nsrMBVdIqQNzT9jhXOL4G4G/0y50BvIVFp5xgTTz6QO
         ORbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrXmMzhrfpzqEnud4K6uwivgEJVrHc8/GZLkP2z6bGw=;
        b=K/QNHMTeM4UVM4UPYwIzTYlXCyJyiWHYSlj1xZygofwHryf00+MCnCAxbaiGItLwfh
         YertSRi2J1EaiTROhSyWXvA+ERQS2KGQAmwYXmup7yYQtrYhf3Q+CLi5EF2yNIRVf0rS
         dlOQxnby+HCh+AeanqzYVcPZv1roPDeSLHJLAuFpsQY8TJNep5U+nQPFSntrLWJ1U2IU
         WPP68eNjGtGqOAeZTzBkKyCBYAzX7zJW6x3uUjNirq3MAVoSIUQCNh+kordAms2ga7Dj
         eDIQ1H/vY9iTxPNhb/4HQv1giSxMQvIfz1n8PLY1t+7dCS79dG3rxGB6Czw9uZQMpk7v
         SVEg==
X-Gm-Message-State: AOAM533hlzZcqK0n0OIshDDMFcH/WQV2/8LnzmFIzqFlEkdeKXQFUawb
        +q/J3Nb0hHIqwpr1xgk0/p8qksuwZ2O/O5C4/y9aHAla
X-Google-Smtp-Source: ABdhPJzbw0kxobiFSnBJYHLfEBJRiSlARc+7whjl3exLQbRiQRZccm04A+6k1vp0Q3HVYgqQUwCYSu/yQFTxlTOddSo=
X-Received: by 2002:ac8:4316:: with SMTP id z22mr20775262qtm.121.1593523867006;
 Tue, 30 Jun 2020 06:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com> <CAOMZO5DRv4jkHsCkAmwV4BC1tO3O1nNdZgctMcorgK0WCA86tw@mail.gmail.com>
In-Reply-To: <CAOMZO5DRv4jkHsCkAmwV4BC1tO3O1nNdZgctMcorgK0WCA86tw@mail.gmail.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 30 Jun 2020 21:30:55 +0800
Message-ID: <CAA+D8AO5iGZjJ8MHhG=zfyu+N5JO0PnvcHYY+3BEY0Lz5xyxKg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add an option to select internal ratio mode
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:38 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Jun 29, 2020 at 11:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > +/**
>
> "/**" notation may confuse 'make htmldocs". Since this is a single
> line comment you could do:
>
> /* Select proper clock source for internal ratio mode */
>
>
> > + * Select proper clock source for internal ratio mode
> > + */
> > +static int fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
> > +                              struct fsl_asrc_pair *pair,
> > +                              int in_rate,
> > +                              int out_rate)
> > +{
> > +       struct fsl_asrc_pair_priv *pair_priv = pair->private;
> > +       struct asrc_config *config = pair_priv->config;
> > +       int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> > +       int clk_rate, clk_index;
> > +       int i = 0, j = 0;
> > +       bool clk_sel[2];
> > +
> > +       rate[0] = in_rate;
> > +       rate[1] = out_rate;
> > +
> > +       /* Select proper clock source for internal ratio mode */
> > +       for (j = 0; j < 2; j++) {
> > +               for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> > +                       clk_index = asrc_priv->clk_map[j][i];
> > +                       clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
> > +                       if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> > +                           (clk_rate % rate[j]) == 0)
> > +                               break;
> > +               }
> > +
> > +               if (i == ASRC_CLK_MAP_LEN) {
> > +                       select_clk[j] = OUTCLK_ASRCK1_CLK;
> > +                       clk_sel[j] = false;
> > +               } else {
> > +                       select_clk[j] = i;
> > +                       clk_sel[j] = true;
> > +               }
> > +       }
> > +
> > +       /* Switch to ideal ratio mode if there is no proper clock source */
> > +       if (!clk_sel[IN] || !clk_sel[OUT])
> > +               select_clk[IN] = INCLK_NONE;
> > +
> > +       config->inclk = select_clk[IN];
> > +       config->outclk = select_clk[OUT];
> > +
> > +       return 0;
>
> This new function always returns 0. Should it be converted to 'void'
> type instead?
>
> > +       ret = fsl_asrc_select_clk(asrc_priv, pair,
> > +                                 config.input_sample_rate,
> > +                                 config.output_sample_rate);
> > +       if (ret) {
> > +               dev_err(dai->dev, "fail to select clock\n");
>
> fsl_asrc_select_clk() does not return error, so you could skip the
> error checking.

ok, will update the patch

best regards
wang shengjiu
