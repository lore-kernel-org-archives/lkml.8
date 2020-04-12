Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2EC2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205620753
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 02:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDpwEbYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDLCId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 22:08:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36674 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDLCIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 22:08:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id n10so2945470pff.3;
        Sat, 11 Apr 2020 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XTiPR3NjTU2y5mQ5J0Pv6fdfmC7aqoQXGxB8xurXAY=;
        b=lDpwEbYHC9at0O1/B5PbecUoT+1zLNbJJBOjARMz1vPiPAZBxvUrVH5hV342v8CaFt
         a+I5t0MMp3yKWm1/XhdBCF5fMcDcvldG3YzNzo+98u9VjmM3qkmwU2LEH1R5FVaSneic
         7+y6w8ZmazEseq6ypQ+mk1+A5Yc9E34zL7pYLna9QbmUpef2c50w7XcQPXQXgPs9c84L
         YuZFpYEZ1xgZfskMHnj0FcLrXcK3dxQEc9RdlUv+5pH0JvRJHiFGrlGfuJwKfUeRJVPG
         xtDq/X8ZmLWtOjlWR5J0H7sDNy2S02+b8TZnC5h3QRrLCz80U5KzDaIU5uriOG0mmL0J
         KDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XTiPR3NjTU2y5mQ5J0Pv6fdfmC7aqoQXGxB8xurXAY=;
        b=OTJ/iBXtjWw8awhgZpkpWaRvRufMonYE+ODCHOCIZgcwvtcC/KdSRlkA/CURGxnQNY
         vR9aEfYRMx8UgYcvmrL33OOuAsI3/m35Q2Q5S61tLApwu9YzVtZawF8l9oanvruP6rmf
         bVWJ1aAjcrbMbKg+J5V13oucLy2geojs7PLKpHOmxbUp6W6Eqb7TyYsvCiNI80nAqMd7
         c59aTMMG5JlC0Kn33PPHe6mE0ebE6EPw3eFSRCWr6kT3pKeYphqxOfkrPUrlxRilJ2A7
         4T6PUXbNloXA6KzblscOfqukY5y9i+P3jyJJiWea6tu3CaARkghZUwBylZwiduJSPZ58
         P2gQ==
X-Gm-Message-State: AGi0PuZfZRk/YAj4KjF61ukPIbuJZUN7RP3JJFfK7Rq6IywAcPoSGGSI
        KvfJUSVgzGJ7aCKqnsJZrzQ=
X-Google-Smtp-Source: APiQypJ60bO+ukorWl/8JR2FaX5qNy91w61uKW994f9Dy9yVPv9w6abyS3PWd2+Up8uTp/PFc4Ngxw==
X-Received: by 2002:a62:cf82:: with SMTP id b124mr7362893pfg.124.1586657312126;
        Sat, 11 Apr 2020 19:08:32 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id b16sm5148188pfb.71.2020.04.11.19.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2020 19:08:31 -0700 (PDT)
Date:   Sat, 11 Apr 2020 19:08:14 -0700
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
Message-ID: <20200412020814.GA5984@Asurada>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
 <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
 <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AM69bhorQKikQGwwFRqgBYN8V2pXBW5JLZyFCVHWKkNGg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 01:49:43PM +0800, Shengjiu Wang wrote:

> > > diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> > > index b15946e03380..5cf0468ce6e3 100644
> > > --- a/sound/soc/fsl/fsl_asrc_dma.c
> > > +++ b/sound/soc/fsl/fsl_asrc_dma.c
> >
> > > @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
> > >               return ret;
> > >       }
> > >
> > > -     pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> > > +     pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
> >
> > If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
> > define in this file too, rather than in the header file.
> >
> > And could fit 80 characters:
> >
> > +       pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);

> I will use a function pointer
>     int (*get_pair_priv_size)(void)

Since it's the size of pair or cts structure, could be just a
size_t variable?
