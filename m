Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7454C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3F22073E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAxSNt/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgHDBj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgHDBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:39:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1413C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 18:39:55 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so26679246qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 18:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIlUlELrgUmFnEMwt6u0RG5w8m9jnPh4zMYQKE4rWn4=;
        b=jAxSNt/vI3knrlvcM/xUyi0d88/12xRP+gOojXUE75gaB2oAtcw88Oc/pkfCQn+Gvg
         HuoJQkx3jwVg+ztcFSoeLLvQR2yynSZZFx0Hj0sj24HmdWUDPpMkqs5ahWh81e6BNPA7
         TpeOGLr7gyNkBcEV9utZTleTYwCk2Eg0WaJtmWMs+K79yKJa61ArrlDO0P2CWnsxc0IS
         H98IKvtV9g+Qk78P5KbIzKFQxhVsGlQdqn9cCJRiFStWfy5H212HvH8brR0nbmmr7oaW
         pYcjLRvxPNwxYj+NnPLCwxT8B8j2hZapYbeKWwC6RC9CsR7yGF9EHi0ejb1o7jN3Y2fi
         RK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIlUlELrgUmFnEMwt6u0RG5w8m9jnPh4zMYQKE4rWn4=;
        b=gw96DZ5ajug1oWVwsdWsUdxtaCVJzTZ3JjxSntjorArzkUr6y67CGhblSnXPLobyvT
         NaoK+N3WfgwqHdMEhppHjOitoauMTtWW+rdLuIj9HRGq7yIGJU1E52BfI9PWF8Yqe1oK
         z2kSsRs+MtU1tSZHwQTxLRthTUPXUjpD1iz9f9hVYrmfCj8360kYX7tjyjqsfFa/xi6c
         2KltaOT5ARRd6/1Bk0lWb0XnMZ8mstZHNuB7/UBZCln2aOczUbIT/SjT3JLyJs/lu5TA
         UKF8l3lErVYwn5O1XWfqQN8w5CBENpEm4+HJWpAhjy7iDksINAS3EzvNyMXwvbWqdZGm
         YwWA==
X-Gm-Message-State: AOAM5308t7ibXdG6s6BK0I6neChR8iGWx/wtuPVcRU5TTVuj3q/POxMr
        GMnux8yWOn0KUmetQKHltd5stjeYlLgwR+gfHow=
X-Google-Smtp-Source: ABdhPJyCVJyr/DR+n59uS5oG98ADiiNam8gKyl/6hZZsy3LPTTng/7IrTqLdgbjMsk7CytbooD98U9ki2vUAhABvp8o=
X-Received: by 2002:ac8:564f:: with SMTP id 15mr19448921qtt.54.1596505195017;
 Mon, 03 Aug 2020 18:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia> <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
In-Reply-To: <20200803215735.GA5461@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 4 Aug 2020 09:39:44 +0800
Message-ID: <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
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

On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
>
> > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > is enabled.
> > >
> > > You are correct if there's only RX running without TX joining.
> > > However, that's something we can't guarantee. Then we'd enable
> > > TE after RE is enabled, which is against what RM recommends:
> > >
> > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > # If the receiver bit clock and frame sync are to be used by
> > > # both the transmitter and receiver, it is recommended that
> > > # the receiver is the last enabled and the first disabled.
> > >
> > > I remember I did this "ugly" design by strictly following what
> > > RM says. If hardware team has updated the RM or removed this
> > > limitation, please quote in the commit logs.
> >
> > There is no change in RM and same recommandation.
> >
> > My change does not violate the RM. The direction which generates
> > the clock is still last enabled.
>
> Using Tx syncing with Rx clock for example,
> T1: arecord (non-stop) => set RE
> T2: aplay => set TE then RE (but RE is already set at T1)
>
> Anything that I am missing?

This is a good example.
We have used this change locally for a long time, so I think it is
safe to do this change, a little different with the recommandation.

>
> > > > +             if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> > > > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > > > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > > > +             } else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> > > > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > > > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > >
> > > Two identical regmap_update_bits calls -- both on !tx (RX?)
> > The content for regmap_update_bits is the same, but the precondition
> > is different.
> > The first one is for tx=false and enable TCSR.TE. (TX generate clock)
> > The second one is for tx=true and enable RSCR.RE (RX generate clock)
>
> Why not merge them?
>
> +               if ((!sai->synchronous[TX] && sai->synchronous[RX] && !tx) ||
> +                  ((!sai->synchronous[RX] && sai->synchronous[TX] && tx) {

oh, yes, good point!

best regards
wang shengjiu
