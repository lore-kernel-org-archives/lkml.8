Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E816C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A57420738
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6lz/F0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgHDDAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 23:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHDDAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 23:00:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FF2C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 20:00:19 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r4so11442468pls.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/S5vrlNulwp45H+XxtQvmflrkKxTEGHdqIBJtU71UM=;
        b=E6lz/F0loOMWpzwzL9EL5uI8uRE19tRQP8x66a03pEQA0uuyi7toqSi6AoaweZG9K5
         kdGBp5YQODii2KyuK6QSITM5ArS23MuRPv9wtCeM+iFwogJdPooAtuBAD3kl7rBkul3Z
         R574Ut7X2gu4Fp4ggfuY4Tp19hbBgM/cyON+33LrsuHrhR+DMqGp+4VaFCINEnqz63ZH
         SU+QivAajBxArpmeh+oDTzNtjVD6xiliQbWJhcg1lb1tGoBPXM4m1lMUKH4lk3a7Um20
         bqFef/sVT2SphtvqJRmrZQ/S1K9XhN5acH4havK7QeGCXf7JFUlZS1upKs7BOrgz7HLI
         yqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/S5vrlNulwp45H+XxtQvmflrkKxTEGHdqIBJtU71UM=;
        b=sog5IPcjR3w6sL0ApbpgGz3NEOxae/FgmjhRex7AzRW2WFKGe30OR/r4OzmEgqnEuK
         c6ww3X7kL1KYCV7XixQg9P2gIbIq+qcO/yYqDeM/92aHjBlj61ygwpbvTBf6m+q4cSr6
         0W6dA872qWvBEprhvegVKYvR5lq9PBplVf2/TDaRIQV8Zj394KoXe+S5cgexemIwJ9/U
         w1k6Ew3oHq7pDMUJYg6godSCRI3EaIunnh+1l+/9IoeQ6y15RIKJt1+/lqqpB/UY43xz
         qvBM0p157Y0qKPN+ZNBwqgDHRqKDtEalomPwKGX0xQH4gKbjPI3FP5hY/LD5Udoa44EN
         BAAQ==
X-Gm-Message-State: AOAM5320bCIcSHC7xOVkqPhbNyj1botXXQDJuAg5ji/IkA1JiI8ayTYC
        02p9rn3mCcHxdv8YD/WMxgg=
X-Google-Smtp-Source: ABdhPJx1+9OQ1P10b47ZvUn/LDad5t2VFaOqWhE2dXRFv7b+mWMz8VgTzGFprojAaDIAxuyGHT5M3Q==
X-Received: by 2002:a17:90b:3652:: with SMTP id nh18mr2298790pjb.30.1596510017980;
        Mon, 03 Aug 2020 20:00:17 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j142sm21055148pfd.100.2020.08.03.20.00.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 20:00:17 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:00:05 -0700
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
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
Message-ID: <20200804030004.GA27028@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
 <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
 <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia>
 <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:35:12AM +0800, Shengjiu Wang wrote:
> On Tue, Aug 4, 2020 at 10:11 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> > > On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> > > >
> > > > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > > > is enabled.
> > > > > >
> > > > > > You are correct if there's only RX running without TX joining.
> > > > > > However, that's something we can't guarantee. Then we'd enable
> > > > > > TE after RE is enabled, which is against what RM recommends:
> > > > > >
> > > > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > > > # If the receiver bit clock and frame sync are to be used by
> > > > > > # both the transmitter and receiver, it is recommended that
> > > > > > # the receiver is the last enabled and the first disabled.
> > > > > >
> > > > > > I remember I did this "ugly" design by strictly following what
> > > > > > RM says. If hardware team has updated the RM or removed this
> > > > > > limitation, please quote in the commit logs.
> > > > >
> > > > > There is no change in RM and same recommandation.
> > > > >
> > > > > My change does not violate the RM. The direction which generates
> > > > > the clock is still last enabled.
> > > >
> > > > Using Tx syncing with Rx clock for example,
> > > > T1: arecord (non-stop) => set RE
> > > > T2: aplay => set TE then RE (but RE is already set at T1)
> > > >
> > > > Anything that I am missing?
> > >
> > > This is a good example.
> > > We have used this change locally for a long time, so I think it is
> > > safe to do this change, a little different with the recommandation.
> >
> > Any reason for we have to go against the recommendation?
> 
> Previous code will enable TE and RE  together even for asynchronous
> mode.
> And for recommendation, previous code just consider the RX sync with
> TX, but still violates the recommendation for TX sync with RX case.
> So at least this new change is some kind of improvement.

Okay. Let's change it then. Please make sure to update/remove
those old comments in the trigger(). And it's probably better
to mention that what we do now is a bit different from RM:
	/*
	 * Enable the opposite direction for synchronous mode
	 * 1. Tx sync with Rx: only set RE for Rx; set TE & RE for Tx
	 * 2. Rx sync with Tx: only set TE for Tx; set RE & TE for Rx
	 *
	 * RM recommends to enable RE after TE for case 1 and to enable
	 * TE after RE for case 2, but we here may not always guarantee
	 * that happens: "arecord 1.wav; aplay 2.wav" in case 1 enables
	 * TE after RE, which is against what RM recommends but should
	 * be safe to do, judging by years of testing results.
	 */

Btw, do we need similar change for TRIGGER_STOP?
