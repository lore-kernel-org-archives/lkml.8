Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC032076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYdif+vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgHDINt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgHDINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:13:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4811C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:13:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d1so22411717plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 01:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QTZfG/kR29WZl/QqtrKhHeYkzxPgGUcbCVsRoqYuMCg=;
        b=DYdif+vRQ34VCrII1rcRURMIr1UR4eoarWbg2ONWRx2uRCdkqrY/8JzU46Oa5nbfS1
         uzfdNROpnO06HKpLdfpbuCQ6FGlq1Q5agZp+uGKZ5nqXoP26nuPN6pGHOUvRcoyQ5bfG
         Qx/B/rXOjGtqaGu/9kKoQQZm1SZEHot04BYIN3+aFdQAblXL7A87TG51b8LtSNB5EETn
         /UOZrqg0fsXd/BPGQy1t9OVN/S/GLvcqnKP5beN4UKBBmJY+KZhj5C/MnD9to9XjnKka
         UQ5K8pRSkK4hmoSUUGWd4okRUmae3379DE7RgP2SDmoISUxFqIE48oXwWhe4UDm+zj0M
         HtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTZfG/kR29WZl/QqtrKhHeYkzxPgGUcbCVsRoqYuMCg=;
        b=cy1SJiMs00eSn+uQSsHAEIleIcAeOViGcjyBsayIBjJvF5eRP6Pj5CfISx04O8dOoH
         kGh+GAFzpVFikUdJmSgHgjmQ3VAA1wO4xuTp+lqz7ntvVEg808HEmZ2xR+pp74kX/dpW
         Px9h8fkESWyZqCWgzjuC/Nu3AzxKY+BkDMEkAEpyAbMJ5hkegmCK/6JstQawpX1ELUCC
         hcAov7LqI7NOmKDhvFr1D0xMUgZoOGklNGFLHBtksx8JDORgICaDyRiR7ZCQrGvWqhlO
         BjSk0l2u4xdGCmyjQEKQMaw+KhyVM1ukbFFGB9RHdT12BNxZe8XSpPrOYya4NothHWMO
         MmXA==
X-Gm-Message-State: AOAM533WbdPVSOponcfuTCnQ+jCwfU1Fr0Rk7a/QOYC6McYW5jTJUFzV
        nfQV641lTIh4CdzJ8+/qnzY=
X-Google-Smtp-Source: ABdhPJz+uClNx0qLTPNR0v0kaWetuL5qHIA7MjIEAIYLOMnWp36caMp4FKmFAUV7cMJ+CR83l1o0Dg==
X-Received: by 2002:a17:90b:c90:: with SMTP id o16mr3081175pjz.79.1596528827041;
        Tue, 04 Aug 2020 01:13:47 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c10sm18237720pfc.62.2020.08.04.01.13.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 01:13:46 -0700 (PDT)
Date:   Tue, 4 Aug 2020 01:13:34 -0700
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
Message-ID: <20200804081333.GA664@Asurada-Nvidia>
References: <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
 <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia>
 <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
 <20200804030004.GA27028@Asurada-Nvidia>
 <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
 <CAA+D8AP=27SdR68T-LiQHkJ0_dJaqtgcS-oi9d8arUzvTz5GwA@mail.gmail.com>
 <20200804070345.GA27658@Asurada-Nvidia>
 <CAA+D8ANodghXDbUVOqpf9uq8A5FVbDFEFkf4dWdyMUNDTPaJ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANodghXDbUVOqpf9uq8A5FVbDFEFkf4dWdyMUNDTPaJ7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 03:53:51PM +0800, Shengjiu Wang wrote:

> > >                 /* Check if the opposite FRDE is also disabled */
> > >                 regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);
> > > +               if (sai->synchronous[tx] && !sai->synchronous[!tx] && !(xcsr & FSL_SAI_CSR_FRDE))
> > > +                       fsl_sai_config_disable(sai, !tx);
> >
> > > +               if (sai->synchronous[tx] || !sai->synchronous[!tx] || !(xcsr & FSL_SAI_CSR_FRDE))
> > > +                       fsl_sai_config_disable(sai, tx);
> >
> > The first "||" should probably be "&&".
> 
> No. it is !(!sai->synchronous[tx] && sai->synchronous[!tx] && (xcsr &
> FSL_SAI_CSR_FRDE))
> so then convert to
> (sai->synchronous[tx] || !sai->synchronous[!tx] || !(xcsr & FSL_SAI_CSR_FRDE))
> 
> if change to &&, then it won't work for:
> sai->synchronous[tx] = false, sai->synchronous[!tx]=false.

Ahh..probably should be
if (!(sync[dir] && !sync[adir]) || !frde)

I have a (seemingly) correct version in my sample code.

And...please untangle the logic using the given example -- adding
helper function(s) and comments. And, though the driver does have
places using array[tx] and array[!tx], better not to use any more
boolean type variable as an array index, as it's hard to read.
