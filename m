Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F724C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D841722CBE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 05:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0+e+ASi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHEFDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 01:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEFDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:03:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B0C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 22:03:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so32776189qtm.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 22:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJ+vSUIfqUpR/OfEnitTx0/E2WJkwWGAd7jXaGWXUSE=;
        b=p0+e+ASizlzhr9HvCBd0RSANYOffAstBixdT/gc+PGRA3WXffZI0bH00pFNrrd3D/9
         w6BGn++Pxi73MkkbA9k/LteCWLjqk/zey4aZljPqYMdn11ZZmlCGZZxnfdcHwADa7v0h
         KuvTA7QSAFYYk7YqF8XGS5oBE0hXKUf6e86LOqdF10lzDBSynzGsib+HoGKFawjs6SVV
         9xs+kulL5aH4Hzo9HNbTvEon7mKwi7R8rfQ0R0UiPIhr9yv49x7blWgxYcRcrduhCv4b
         gU6IGg4iT0SPgCnXiPoovfgcMbeSAaPwiMVjPDfKRjAqihonMBlgUt6AnWiCxqBjalDQ
         o1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJ+vSUIfqUpR/OfEnitTx0/E2WJkwWGAd7jXaGWXUSE=;
        b=NLSxR/1T4BsCwqLtaKucG6Gp73oi0sGh60qy7dF3Vpi4NL18J77l3123387yPiqmW1
         NmVjiWI1sQ2VN/MbHwgFlcd1oJ15+hZAhj4WSBNc5SLc9T2AdnVKQ8eQKGsF5PK//da0
         9eC7OJz3MI31vHtUemF0RbhcesWzmwi1Qz77//BAfa90oZvbjCZ48B1pofJxViUCntMW
         CQ76EdWsIcMUNQeCYd8+pTRq7Jk+88Pojin5uTJKgsKUE3EKti1bxaVwdJQjiEtonYFh
         tTeHUfPTfCkwnHxuzcs4TokaR3ohGi0Fuev42Xi40vWsRdRxVRmelYySY5npqjn5VltA
         iX9w==
X-Gm-Message-State: AOAM530Qt49s28UX8/S6XtLYL+bKnfGC+zQD/Bt6Uk1GXT2N26oLWM/6
        9LyfogR6hYhyJHEyrqGWnAC19SgkOSqf1Jp8MxE=
X-Google-Smtp-Source: ABdhPJxP151f0b2pd7JM99jfAomT13Boin3/gUNf7Zg7iIwdHSVUQNJ4Qya2mEifL2X6+m0qcvOVqpVaIqcCAWtPj9k=
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr1533677qtt.121.1596603828149;
 Tue, 04 Aug 2020 22:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1596594233-13489-1-git-send-email-shengjiu.wang@nxp.com>
 <1596594233-13489-3-git-send-email-shengjiu.wang@nxp.com> <20200805041111.GB10174@Asurada-Nvidia>
In-Reply-To: <20200805041111.GB10174@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Wed, 5 Aug 2020 13:03:37 +0800
Message-ID: <CAA+D8ANv-qURC_wu3TzWiiiCAXC88Gc+WGssdjmuWoLPTRm3pA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Refine enable and disable sequence
 for synchronous mode
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 12:13 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Wed, Aug 05, 2020 at 10:23:53AM +0800, Shengjiu Wang wrote:
> > Tx synchronous with Rx:
> > The TCSR.TE is no need to enabled when only Rx is going to be enabled.
> > Check if need to disable RSCR.RE before disabling TCSR.TE.
> >
> > Rx synchronous with Tx:
> > The RCSR.RE is no need to enabled when only Tx is going to be enabled.
> > Check if need to disable TSCR.RE before disabling RCSR.TE.
>
> Please add to the commit log more context such as what we have
> discussed: what's the problem of the current driver, and why we
> _have_to_ apply this change though it's sightly against what RM
> recommends.
>
> (If thing is straightforward, it's okay to make the text short.
>  Yet I believe that this change deserves more than these lines.)
>
> One info that you should mention -- also the main reason why I'm
> convinced to add this change: trigger() is still in the shape of
> the early version where we only supported one operation mode --
> Tx synchronous with Rx. So we need an update for other modes.
>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The git-diff part looks good, please add this in next ver.:
>
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> Btw, the new fsl_sai_dir_is_synced() can be probably applied to
> other places with a followup patch.
Do you mean move it to the beginning of this file?

best regards
wang shengjiu
