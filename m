Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636BC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:31:53 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FB720678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBiubb27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FB720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgDMEbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 00:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 00:31:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68237C0A3BE0;
        Sun, 12 Apr 2020 21:31:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ng8so3381498pjb.2;
        Sun, 12 Apr 2020 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cncGDqt7fHMkXaI3l27jxuKAAcyo4TLpPS8jKmBxrB8=;
        b=eBiubb27eRyfe+lqxro+fYFl17BREZ/tw3ox6LXKc1U/ONkBvPz2I8GVeROXQJ7wDj
         73JzWAIKxOS6cEpL+iXc7cNlFy4hOHVYSpV2w2OIpeUVoVobgJyP9i2q44KFCf+GPyTA
         GEmZWDuoMpA/fBn/CbKSP/HizQZT8hPsyzwWOuSvUMHbN5NJrtiAmVQlR5zSrtAMfkI8
         mJS7YB+LNizev96VgVNzWAlIAP3/zo/zBcFnaNiAITdOTfpSuS931MEfKZxM4IJAtaM1
         Ia/LZKRL2Y0qjmSeQ4mOprXlig5OGHKdATdfieX4b1exDKqvz7H5VVd0obql2UrtLT+m
         Ppsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cncGDqt7fHMkXaI3l27jxuKAAcyo4TLpPS8jKmBxrB8=;
        b=n30odw/ahWGR1Vo9rpgfcqrGd+qUzFyc0yNS9eAB+CNMjAiftBH3X70lMuMATcBh8S
         jnwXKzx9ReGfHeXTZdvyIuoV+fOMLCBvxGX/Vuw4o43A9NQDx+yXv1/yOnKGgGgUuhCH
         v5AkY3U5ZlpW5KqXLMGrHhbj5AA+tqI3hISqEkAnpBuEXn16M2uOUIGaJOXZlXdqh+pD
         FqMGLxTc5BTEa7vwuSZMILd2bb/DqexTP/Da7IQF1SdxmOvxhbP0aEJnITcvSk43t7ou
         uGh1CKhWDR3kwxTHty0meivrawSQX44796/wb86WYff1yi9o0Jj9frlyUwaqroYyLw1k
         JaDg==
X-Gm-Message-State: AGi0PubquyEmuL6frSAtGYafvquUzm5scgABEHt5dFDC3nHgl4pxSRTH
        1nrv/C355FDi0UfHJ61fdp4=
X-Google-Smtp-Source: APiQypIRcMeZlHWm/EdnTHFU5olUz6v2AbqayudJLIZ+rDTXU5dozNE4arV7AQtDkr6IOFCAM0uXRg==
X-Received: by 2002:a17:902:784c:: with SMTP id e12mr15604537pln.191.1586752309748;
        Sun, 12 Apr 2020 21:31:49 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id m9sm7546835pff.93.2020.04.12.21.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2020 21:31:49 -0700 (PDT)
Date:   Sun, 12 Apr 2020 21:31:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200413043143.GA9116@Asurada>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
 <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
 <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
 <20200412020814.GA5984@Asurada>
 <CAA+D8AOapHbw_AREcJmef2tnM4aNiU11FLacW3HS7CXQThs80Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOapHbw_AREcJmef2tnM4aNiU11FLacW3HS7CXQThs80Q@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:16:31AM +0800, Shengjiu Wang wrote:
> On Sun, Apr 12, 2020 at 10:08 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Sat, Apr 11, 2020 at 01:49:43PM +0800, Shengjiu Wang wrote:
> >
> > > > > diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> > > > > index b15946e03380..5cf0468ce6e3 100644
> > > > > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > > > > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> > > >
> > > > > @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > -     pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> > > > > +     pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
> > > >
> > > > If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
> > > > define in this file too, rather than in the header file.
> > > >
> > > > And could fit 80 characters:
> > > >
> > > > +       pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
> >
> > > I will use a function pointer
> > >     int (*get_pair_priv_size)(void)
> >
> > Since it's the size of pair or cts structure, could be just a
> > size_t variable?
> 
> Yes, should be "size_t (*get_pair_priv_size)(void)"

Does it have to be a function? -- how about this:

struct pair {
	...
	size_t private_size;
	void *private;
};

probe/or-somewhere() {
	...
	pair->private = pair_priv;
	pair->private_size = sizeof(*pair_priv);
	...
}
