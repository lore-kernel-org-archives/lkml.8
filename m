Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BC22076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWCkXl8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHCV5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCV5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:57:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0142C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:57:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so8749771pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yuVzOzKa2hJtd7uaE4veinXP3zTwwT8hP9/UMc26Jxo=;
        b=cWCkXl8L5UI8SuRjQ0cl053tTauIzhi1afwfNgdwh+S/UrqCe7b6aQGPQk0rAl20em
         Glao1b3gOcesofK02TSpw5cNYZvAFOShat12fYg11KP70iKBxdvyi911W6RX/otsR5Az
         0dXE+t4tOtG1SRK/Nnab/slKYIK2LQXD2MYu6VeCuOrZfyoRG5DJQZ40VyyaQxIz6T7s
         R+JiLGDzcw6HtZ5oPnPU68nrEGi66BH+YcGNnATp1qAAhw04FBNX41QxHdpHZru+wqrM
         bn9qgqzWEjtrWmhNB6yGIaBChRxAwB2CdYQAAEL5M7rEfQvyspMLu4+3pk5mCM45S3cm
         WKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yuVzOzKa2hJtd7uaE4veinXP3zTwwT8hP9/UMc26Jxo=;
        b=ZhlR9RBP8LpnggT8r4GZjWTNE3iW7OqEFto40lSkoMNN0/Z0BJpBVGjMS07vBJecDN
         HLLFeEfNDpQoWUDKV7IF+TK9JJ8XIQgg1ZzwG3W6w4Gmx9J8UxenHMp4342YoAYJrwt/
         E1IpMoDw5RQKHGljHP43TTEjqcve14FSLl0NWmh8meNYn/n81SIhjlobNWgc6bNuhAHu
         L2u/6w6fzvHbqQ69R8RriYzXzqMJ0O7Gad1AziXw6k9/f1F8qaoLU51UMoCS/rAMRsr9
         rM4Nkx9zWZ5D+n3VCMwAiaVDqF18v+RMRyMFq3CKz/eipYx7uJKtW2aNhd8vOr2qMdxu
         yiRQ==
X-Gm-Message-State: AOAM532rXFe+xFw2T6osvMcpMX1QMLwVFCreMqCwtixXLDNwS21DouKr
        E+ANKrj0oLwSxK5xDrPnyno=
X-Google-Smtp-Source: ABdhPJygNIzoSP6mtrUmL5aG3TEs5sU+U9sui5b00C7eA2kbujQ2/HiOWRUN0IxJIz03F+8nQCZiWg==
X-Received: by 2002:a63:c447:: with SMTP id m7mr16425864pgg.118.1596491868043;
        Mon, 03 Aug 2020 14:57:48 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id lk16sm406515pjb.13.2020.08.03.14.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 14:57:47 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:35 -0700
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
Message-ID: <20200803215735.GA5461@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
 <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:

> > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > is enabled.
> >
> > You are correct if there's only RX running without TX joining.
> > However, that's something we can't guarantee. Then we'd enable
> > TE after RE is enabled, which is against what RM recommends:
> >
> > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > # If the receiver bit clock and frame sync are to be used by
> > # both the transmitter and receiver, it is recommended that
> > # the receiver is the last enabled and the first disabled.
> >
> > I remember I did this "ugly" design by strictly following what
> > RM says. If hardware team has updated the RM or removed this
> > limitation, please quote in the commit logs.
> 
> There is no change in RM and same recommandation.
> 
> My change does not violate the RM. The direction which generates
> the clock is still last enabled.

Using Tx syncing with Rx clock for example,
T1: arecord (non-stop) => set RE
T2: aplay => set TE then RE (but RE is already set at T1)

Anything that I am missing?

> > > +             if (!sai->synchronous[TX] && sai->synchronous[RX] && !tx) {
> > > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> > > +             } else if (!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
> > > +                     regmap_update_bits(sai->regmap, FSL_SAI_xCSR((!tx), ofs),
> > > +                                        FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
> >
> > Two identical regmap_update_bits calls -- both on !tx (RX?)
> The content for regmap_update_bits is the same, but the precondition
> is different.
> The first one is for tx=false and enable TCSR.TE. (TX generate clock)
> The second one is for tx=true and enable RSCR.RE (RX generate clock)

Why not merge them?

+		if ((!sai->synchronous[TX] && sai->synchronous[RX] && !tx) ||
+		   ((!sai->synchronous[RX] && sai->synchronous[TX] && tx) {
