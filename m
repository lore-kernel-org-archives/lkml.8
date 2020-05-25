Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 411452071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgLbL5BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgEYGSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgEYGSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:18:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:18:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so8285616pgn.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qkQKxQdGGgWdvEooTQeXfQ5Uv6xFbcDpVhOQuc16oUc=;
        b=sgLbL5BCVGnsptyzLFvhBHakHWNFyE7cXapL55cgodXb2vOhXm56MOdyIhCbvyn+V6
         N5SpUnMqMfQTxpDC1oxfNr3O0Z5D9Q+P35dmFRYpwkUHzM7HUXzNKDIN4y3Q/pt4yOOj
         nJ79hm3sG+vkBgfUoOUM7+9/7ASYFUIelrkTzM+sj4p7iYvQyMjNUzbnGcY/2i3fO8x8
         78Xsdeo6b0CdlwlRBVjX9uib/uaYHpQkXdll055UGUGElf7mLUzQphtdpc4wZyA7j5eV
         FgMRfBBTXcDDFYydBzTMFJxhjryo7u9v5GiERnJ6QEtJl9DvihXJrH+0ZCeDrKJ9dyYr
         NrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qkQKxQdGGgWdvEooTQeXfQ5Uv6xFbcDpVhOQuc16oUc=;
        b=j+enOJ8RGQDhc+xN1TkOpyU8tw/5uprMU9BRw8/QUktlupmxGPKfGnl/fZM9OB6kKo
         aI1MCgY4w/cvSLf+eE6q3mLqKS5Vmb2qRrZUm6VLcfgMwDeaBqaey1iJGSs+e6/TXU8e
         F8P8zGAnWYrRXNOxwerc0JMJdONxWGTT5oFgOzVpN8jfxb83lNg47vi1xIRgl+ddMHf1
         fi6RSoSvw/ZCEtIG7Dx7EqoD17UvUO0p2O27l742sWgAB5jFNKnhy3aQ03IcjDyJ3tPt
         /IjQK5vCo2p0dgGVyKlYL8z4gyoyqDzXNOauG1s7gKZndENjTU1IZ+9zjpP3ilMQ1IGT
         xlXA==
X-Gm-Message-State: AOAM532o/PQS1s3YBN41jTeKHyKNIdfTP2CXOzYqbo+LjsRWoQ4YB5Wj
        C2Wp+9qE+966gAiGz7mZofs=
X-Google-Smtp-Source: ABdhPJxg1bg01cddhbRJZVYfWekQ2aQNsAE8dMBcRjN0GaOgL4XmmTFhE2NzLEqiY8iUckwGGjP/VA==
X-Received: by 2002:a65:52cd:: with SMTP id z13mr10751049pgp.259.1590387512418;
        Sun, 24 May 2020 23:18:32 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id i197sm24018pfe.30.2020.05.24.23.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 23:18:32 -0700 (PDT)
Date:   Sun, 24 May 2020 23:18:27 -0700
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
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to
 runtime_suspend/resume
Message-ID: <20200525061827.GB12112@Asurada>
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
 <20200525050950.GA1244@Asurada>
 <CAA+D8AML7P3j+14w5PywPy4QEcxw09z1izZSZbrOB_nte+XDmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AML7P3j+14w5PywPy4QEcxw09z1izZSZbrOB_nte+XDmA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:11:18PM +0800, Shengjiu Wang wrote:
> > > @@ -1135,6 +1137,24 @@ static int fsl_asrc_runtime_resume(struct device *dev)
> > >                       goto disable_asrck_clk;
> > >       }
> > >
> > > +     /* Stop all pairs provisionally */
> > > +     regmap_read(asrc->regmap, REG_ASRCTR, &asrctr);
> > > +     regmap_update_bits(asrc->regmap, REG_ASRCTR,
> > > +                        ASRCTR_ASRCEi_ALL_MASK, 0);
> > > +
> > > +     /* Restore all registers */
> > > +     regcache_cache_only(asrc->regmap, false);
> > > +     regcache_mark_dirty(asrc->regmap);
> >
> >
> > I see you doing regcache_mark_dirty() in the resume() now,
> > being different from previously doing in suspend()?

> Which is for probe -> runtime_resume case.
> After probe, the power may be disabled, so move mark_dirtry
> to runtime_resume, then regcache can re-write all the registers.

I see. Just noticed that you add a regcache_cache_only
in probe(). Acked already. Thanks.
