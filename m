Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07224C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DD32073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+1avq+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgF3MhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgF3MhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:37:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E891C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:37:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so22254438ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjZ6pxTtSr9uxy/gwY+hSwq1zDBqrweQsuZnBCKIprM=;
        b=p+1avq+WJ5MS40d96OKyqyYSxO3pkEL1n6EmXdtseZ+6YX4nfvKqMa9GJEsluECWqU
         cd+Uy1Ua1W6INq+V0RwNjtjCT2Py5m+g7rZ7r8whvJIFmOdgL1wUayXf+08iCfAqvbNw
         pyWc9kpmPofFDJRC4avDXqO6o3bt8kYMZRPsjGYXIT7Io7+4q1ZBQDSCjuEvPfeBc1L/
         UsnZWXHMdtJw+fksTbIw3xGp5ZXbb02J/igC66udsYra3yAWTT5ru/Ai54aJEGelYwxX
         MbNlevxnzE0EWj5nsBlgNvo/Zf67PxhRRvv/1l+84WKLCy9oCiyYQC1NBBH6qIa6VonX
         lHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjZ6pxTtSr9uxy/gwY+hSwq1zDBqrweQsuZnBCKIprM=;
        b=jlBUF6GxLDUmlpHhRb51B3fCUk1Rsv147GBpCJyTUbtXEKm98kPqFXwmbMI2JHOELj
         p2mscJFsAqNEqVvXW/FtzIBZgB5xxTM2zG3MyqorV6+uqQ7yY+eyirZlagZJBr5o5FKu
         Y/2IOC4ItHm0eQC1l/TqpabHXJE3jgIpk/0i9wmqRF8CKTi92hadSsSYdDhifYBdB1Jv
         EC1WBhJOpW3O2oZfqBfeh4Ycgzcq+Ma1cREs7IwWJ+kZcj+n2eqpckxWLwAztuC2FS0W
         L8ZxOkogYmGMIAQrNDClggAxAqLy1v4s520hphpqCYeH6osUc0QkRU8l9gmbFUfQpd5w
         GLHw==
X-Gm-Message-State: AOAM532w40vktRTTJFy23UaI1GAgB0+E8BgfR0FfSYGbG6wAC58wfPgk
        zrYJ3NwO0Zf8cHL0vZTmPDdkmneUMR1Xlfo/q1w=
X-Google-Smtp-Source: ABdhPJyiv4tKOT0Q7iWTJRY3kT7Jhr0Mk21hdtaLMTH/M7qtgYtfElYU9Hc4r3jz/dO6EKDkddNJs9EkeqCM9iN55yc=
X-Received: by 2002:a2e:880e:: with SMTP id x14mr745594ljh.218.1593520628813;
 Tue, 30 Jun 2020 05:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1593439115-19282-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jun 2020 09:36:57 -0300
Message-ID: <CAOMZO5DRv4jkHsCkAmwV4BC1tO3O1nNdZgctMcorgK0WCA86tw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add an option to select internal ratio mode
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Mon, Jun 29, 2020 at 11:10 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> +/**

"/**" notation may confuse 'make htmldocs". Since this is a single
line comment you could do:

/* Select proper clock source for internal ratio mode */


> + * Select proper clock source for internal ratio mode
> + */
> +static int fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
> +                              struct fsl_asrc_pair *pair,
> +                              int in_rate,
> +                              int out_rate)
> +{
> +       struct fsl_asrc_pair_priv *pair_priv = pair->private;
> +       struct asrc_config *config = pair_priv->config;
> +       int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> +       int clk_rate, clk_index;
> +       int i = 0, j = 0;
> +       bool clk_sel[2];
> +
> +       rate[0] = in_rate;
> +       rate[1] = out_rate;
> +
> +       /* Select proper clock source for internal ratio mode */
> +       for (j = 0; j < 2; j++) {
> +               for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> +                       clk_index = asrc_priv->clk_map[j][i];
> +                       clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
> +                       if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> +                           (clk_rate % rate[j]) == 0)
> +                               break;
> +               }
> +
> +               if (i == ASRC_CLK_MAP_LEN) {
> +                       select_clk[j] = OUTCLK_ASRCK1_CLK;
> +                       clk_sel[j] = false;
> +               } else {
> +                       select_clk[j] = i;
> +                       clk_sel[j] = true;
> +               }
> +       }
> +
> +       /* Switch to ideal ratio mode if there is no proper clock source */
> +       if (!clk_sel[IN] || !clk_sel[OUT])
> +               select_clk[IN] = INCLK_NONE;
> +
> +       config->inclk = select_clk[IN];
> +       config->outclk = select_clk[OUT];
> +
> +       return 0;

This new function always returns 0. Should it be converted to 'void'
type instead?

> +       ret = fsl_asrc_select_clk(asrc_priv, pair,
> +                                 config.input_sample_rate,
> +                                 config.output_sample_rate);
> +       if (ret) {
> +               dev_err(dai->dev, "fail to select clock\n");

fsl_asrc_select_clk() does not return error, so you could skip the
error checking.
