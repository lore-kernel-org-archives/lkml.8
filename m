Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F57C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080AB2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBAiU3Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgHDDX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgHDDX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:23:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 20:23:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w9so29916559qts.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJVhQMYihY+NvN1RkvZ0SjRkXEzhAUPHpJk8gf7XSoA=;
        b=sBAiU3ZcXSjalUW9WrVeJ2OfbjDdEBGSBgTOtZUWwMJCUVV26vPbx2WTiLEtTnrOUT
         shPiIFjVpACXcoivs0KjZmrWiOLNzwML1Ua7WyV2bXsLGbXyFGwl3qz4RuP12Wdb9DOE
         dKiGggDR9kXJm7iUS+MP1QMO9VJDHGsJS41dEwTvyJISNEH4xxIWI9H+HdgyKWV4vIBE
         fHvzhBIS4YyFjhsqig4PoC5pjKEQH55GpIp4IsM95gp4jes59+bnfD9CrHpZyvEMFY54
         sY588EVvT9VAkEUKYZfaVCZhcLNToWXlS1U0fxuFHjQXNiy3eVcIOeTQaARbbo2q6oFJ
         ITxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJVhQMYihY+NvN1RkvZ0SjRkXEzhAUPHpJk8gf7XSoA=;
        b=YyYSXtakCBoN/tHPtFGQHbSsCXRyH2vohXOQCdhoWG1zw5DnPL22l4xgyS8On4ndzJ
         JhCY29Ks412kiHHSK4wuJO1erwVEEU8COXlLQlWmNzQrzC6zAUZpnvllVpdNfaZy2XI8
         uTj9EUC0BNBWbii9IYva5TLgXZQnJrM/nfzwnpM/fcpm0IvIzwDvvjTZnD0mtUZa9C4V
         5X7MDG3I+qDfNsMGsSuXKCDAMgIahN1/AcopbfniOQ2Plr+lFcs0qP6flLLJCT/seYxs
         U8zTGtBKuqJOfgur6OJPpaqtChkmCSYE9b3xcwaUr6rQBUtDnN/Urtk2fvuGItEEuyFg
         e2vw==
X-Gm-Message-State: AOAM533ql1WaNZL35rsm+YpB4ysEDrAeTBcJWDSTmsC8GzJMr0jHMzUn
        mvj9BNI93ioZWLivM9/dL/neg3YstOGmrIScRo0=
X-Google-Smtp-Source: ABdhPJzlDtQ693Xz7R9IlMrE4fi0XcKTYMO+46NJJ0pRzPdLUk0ADOBBGZM2zpDBY1o9xKlUGQ3OoQgvUqPJju9vHJo=
X-Received: by 2002:aed:2946:: with SMTP id s64mr19963873qtd.204.1596511405886;
 Mon, 03 Aug 2020 20:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia> <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia> <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia> <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
 <20200804030004.GA27028@Asurada-Nvidia>
In-Reply-To: <20200804030004.GA27028@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 4 Aug 2020 11:23:14 +0800
Message-ID: <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
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

On Tue, Aug 4, 2020 at 11:00 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Aug 04, 2020 at 10:35:12AM +0800, Shengjiu Wang wrote:
> > On Tue, Aug 4, 2020 at 10:11 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> > > > On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > > >
> > > > > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> > > > >
> > > > > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > > > > is enabled.
> > > > > > >
> > > > > > > You are correct if there's only RX running without TX joining.
> > > > > > > However, that's something we can't guarantee. Then we'd enable
> > > > > > > TE after RE is enabled, which is against what RM recommends:
> > > > > > >
> > > > > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > > > > # If the receiver bit clock and frame sync are to be used by
> > > > > > > # both the transmitter and receiver, it is recommended that
> > > > > > > # the receiver is the last enabled and the first disabled.
> > > > > > >
> > > > > > > I remember I did this "ugly" design by strictly following what
> > > > > > > RM says. If hardware team has updated the RM or removed this
> > > > > > > limitation, please quote in the commit logs.
> > > > > >
> > > > > > There is no change in RM and same recommandation.
> > > > > >
> > > > > > My change does not violate the RM. The direction which generates
> > > > > > the clock is still last enabled.
> > > > >
> > > > > Using Tx syncing with Rx clock for example,
> > > > > T1: arecord (non-stop) => set RE
> > > > > T2: aplay => set TE then RE (but RE is already set at T1)
> > > > >
> > > > > Anything that I am missing?
> > > >
> > > > This is a good example.
> > > > We have used this change locally for a long time, so I think it is
> > > > safe to do this change, a little different with the recommandation.
> > >
> > > Any reason for we have to go against the recommendation?
> >
> > Previous code will enable TE and RE  together even for asynchronous
> > mode.
> > And for recommendation, previous code just consider the RX sync with
> > TX, but still violates the recommendation for TX sync with RX case.
> > So at least this new change is some kind of improvement.
>
> Okay. Let's change it then. Please make sure to update/remove
> those old comments in the trigger(). And it's probably better
> to mention that what we do now is a bit different from RM:
>         /*
>          * Enable the opposite direction for synchronous mode
>          * 1. Tx sync with Rx: only set RE for Rx; set TE & RE for Tx
>          * 2. Rx sync with Tx: only set TE for Tx; set RE & TE for Rx
>          *
>          * RM recommends to enable RE after TE for case 1 and to enable
>          * TE after RE for case 2, but we here may not always guarantee
>          * that happens: "arecord 1.wav; aplay 2.wav" in case 1 enables
>          * TE after RE, which is against what RM recommends but should
>          * be safe to do, judging by years of testing results.
>          */

Thank you for the agreement.

>
> Btw, do we need similar change for TRIGGER_STOP?

This is a good question. It is better to do change for STOP,
but I am afraid that there is no much test to guarantee the result.

best regards
wang shengjiu
