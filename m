Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF46C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C069121775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqmot9h6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgG0H1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgG0H1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:27:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED959C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:27:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so7549494plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+yXBFkFF1Q2hs9eJ61ZmtSb7ia2MRn3KxqycD73Flw=;
        b=Cqmot9h6sPwuj2faph4jOKs5weve7eUvzLaNx9IhHsELXyEoGYyUza9Ardp+smS119
         TGfMgjCb+Q7A7eMlTsKK1TArG0L4+p6Yh5Hitl9TxMzHIgngQbZVbvG96NyRIghMd4GZ
         PSQhOpZYac/IkW1TddyHCGy0l1+sGFE81BAyo2Hb5QjOOcz26H384tpdAi1lBSX3uiAT
         /Fot+ATlEjMnzh3JJdOAz9bKQICojC/8+16x4lno+1tGL0LHnT06tvaHkiv5jK2COAjS
         Y5WBOGm3KMcL9mujuHQ+2frzPL0jk3yHfeDvv9sz4bvVgOxWnCyTONCx+MkvocuDhwAh
         xXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+yXBFkFF1Q2hs9eJ61ZmtSb7ia2MRn3KxqycD73Flw=;
        b=r6B3kWj6P/qhFVOHbf+9OPFFumzLG0Z9vYbK4QGngDYiuhDsWi5FIw7NJmlvXxA1C7
         qLtPHO44Aw95yCV7g/YWSlgosgVZpjSS73miWpVUViGCtON02AR7aTr4tFxnRRIdorAK
         MAWUinUFvKz09tfmMgbWXlTtjrR4+rwmt+yqDbyQq0m7ECib9CkHdycPidTQprCWdxKA
         TP+mu8RO9xV5lL8KSPaRtwGdcgvlsHsi3fpvJR6La9HndltiDq3xa8ak/smIEJPhpi3T
         BcFI0JgODbPkGOYPF9HIQe7maQZpz+O5I3AFMv9p51CC5qKx9UYS2YchHVqE2sS2esTS
         2goA==
X-Gm-Message-State: AOAM532Bq6bqMz5b5FBKJ/zuSYeC6V/41M1MN/Y42Wrqn6avFrBbL8qL
        rk3jMAu/BgYNEQWVeVVkjWg=
X-Google-Smtp-Source: ABdhPJzONbuJenpMzjphtdEOeUlAPu08ifyLaXxU1TZh2ESyDjSyATv/zYZBeXghWq9As+UF665jdA==
X-Received: by 2002:a17:90a:db8a:: with SMTP id h10mr17706557pjv.58.1595834860479;
        Mon, 27 Jul 2020 00:27:40 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s10sm52384649pjf.3.2020.07.27.00.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 00:27:39 -0700 (PDT)
Date:   Mon, 27 Jul 2020 00:26:59 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level
 function
Message-ID: <20200727072658.GA16513@Asurada-Nvidia>
References: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com>
 <20200727005558.GA30124@Asurada-Nvidia>
 <CAA+D8AOfh1gDec=0BPk6SUutqtY_gL1Rm1-Uc4Dv4s-86LAwPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOfh1gDec=0BPk6SUutqtY_gL1Rm1-Uc4Dv4s-86LAwPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:33:18PM +0800, Shengjiu Wang wrote:
> > >  static int fsl_asoc_card_audmux_init(struct device_node *np,
> > >                                    struct fsl_asoc_card_priv *priv)
> > >  {
> > > @@ -611,7 +600,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
> > >       /* Diversify the card configurations */
> > >       if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
> > >               codec_dai_name = "cs42888";
> > > -             priv->card.set_bias_level = NULL;
> >
> > Can check if set_bias_level is still being used with this change.
> 
> Do you mean to keep this line:
> priv->card.set_bias_level = NULL; ?

Sorry. You can just ignore this part -- just double checked the
code, and I think I misread something :-/
