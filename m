Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA74C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A71D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1z2pTrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404347AbgDNDAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404224AbgDNDAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:00:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD7C0A3BDC;
        Mon, 13 Apr 2020 20:00:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e16so4393534pjp.1;
        Mon, 13 Apr 2020 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmrBJGYvPULTYsXID1n2ssFRwyCJcPGlCp+ffDZ2ue8=;
        b=l1z2pTrKK/Z24bQCWju9hYO5K6LvWpD5DCoSXiSBLwZQZhhqLNJWoTKQgkoRKDgqvS
         fGfrn44Syk3yqgAQT+0OHNxD38qhIvqRmOcHX2AIf/pJBV9I4jsBWyuIigF4kB57t1F5
         kkNWOJUdpFxyY8Z8j1+sJh7FDdYpGVtUV1tG0X0B1BFMhGwROxgCbFiuwXhyYrcC6NU+
         bquTjcpxjVMjaVjEnodWHqImGRm0YaH9oPuWfSFC4fMFcoSTo3Qd3dATP64+4irVrKYk
         Qr6a18t9b/XMXEruEs0P1w1FaiNO+ZI9ha7UQIbZWSfK0rRfKPOVy3b15IvbvjWy0LOA
         96ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmrBJGYvPULTYsXID1n2ssFRwyCJcPGlCp+ffDZ2ue8=;
        b=aiRFvPCP3sJPbv5a/4z7cKwJxGq8TCHRgqjkZ6lp/LzPIAxWY+gD1wNxYkkWrPV/n4
         sPqe/5q/lW4ivB4Tuo6yxkJvznvs/3FcxGQ8OO0sA2FFx9CtL+fhdrf3ncozryFt7joY
         NCRmcRGD3Xeno/wmNgEM4zSuxYd+pTaD8dJMfAp75oGn2CX8FuA2hFQxvlxKWXWUUsRq
         mts7xlAMzxCsHABFtfRwcUXsJTqurMScZr+1ynGV5VchRXIy2fF4olDZeUb+XlSTHKnY
         lTGJ639CGh0rGY24XpVvz6nmM6VKnD/yJT0vbHOAyJMEARI58aJurRrrtx212WascgrD
         8IIg==
X-Gm-Message-State: AGi0PubWfzxle1PK5kAGMFyl84nuJZth1XR7c4uYB54SLEOBMSaI8mQo
        mTF9kM/O1OBSWXNiJK0a0cY=
X-Google-Smtp-Source: APiQypKXuSLr1DLchZKjuBPOYZJBPpmlryaYyd6OhlIzheb4f5k8FxOq0gGgnslC+hA8mdo0s8KKyw==
X-Received: by 2002:a17:90a:6043:: with SMTP id h3mr6406198pjm.69.1586833209564;
        Mon, 13 Apr 2020 20:00:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c84sm1464971pfb.153.2020.04.13.20.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Apr 2020 20:00:09 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:00:17 -0700
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
Subject: Re: [PATCH v7 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200414030017.GA10719@Asurada-Nvidia.nvidia.com>
References: <cover.1586747728.git.shengjiu.wang@nxp.com>
 <6d2bed91bcdbc3f75a9d12ac4ebf6c34c9bb9c3f.1586747728.git.shengjiu.wang@nxp.com>
 <20200414020748.GB10195@Asurada-Nvidia.nvidia.com>
 <CAA+D8AN8OUtTftc_So-Z0_sjWt4RXq6fr4GpSy3Xh+YbkryfpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AN8OUtTftc_So-Z0_sjWt4RXq6fr4GpSy3Xh+YbkryfpQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:21:29AM +0800, Shengjiu Wang wrote:
> On Tue, Apr 14, 2020 at 10:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Tue, Apr 14, 2020 at 08:43:07AM +0800, Shengjiu Wang wrote:
> > > There is a new ASRC included in i.MX serial platform, there
> > > are some common definition can be shared with each other.
> > > So move the common definition to a separate header file.
> > >
> > > And add fsl_asrc_pair_priv and fsl_asrc_priv for
> > > the variable specific for the module, which can be used
> > > internally.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > > diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> > > +static size_t fsl_asrc_get_pair_priv_size(void)
> > > +{
> > > +     return sizeof(struct fsl_asrc_pair_priv);
> > > +}
> >
> > Perhaps we haven't understood completely each other's point.
> >
> > Yet, would the following change work?
> 
> Should work, almost same

Function call involving branch instruction may fail CPU's branch
prediction and hurt performance, depending on the CPU arch. If a
variable simply does the job, we should avoid doing that.

> or do you want me to use variable to replace function pointer?

Yes. And please add my ack once you change it as the reset LGTM:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
