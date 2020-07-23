Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A95C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED3C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1NFcx22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgGWFqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGWFql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:46:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8889C0619DC;
        Wed, 22 Jul 2020 22:46:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so2063398plr.2;
        Wed, 22 Jul 2020 22:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4Bsv9nIgqKmSYSIOMPedKdrcSWXd/PYFSO2aIq/191g=;
        b=h1NFcx22ZnIuEzuWbSbkC3x7IEN9Y2dN6+57CJu8RbnCZqVp91BCoOWxD1R6Zx93Sb
         lo4nx9IxNGFCzW2Vz6QX3Plltlj4h16/LmJ0YIpIuapYsFxfeqrNXg9VDLvCy2d2UU/J
         haOQ4c/cYL4G2Y4SES+dw1eVWHBr7SQGOS22NA2U1bvjwxKAggTPT31ZqEZ3WTNy+Z7d
         PMLE8ufxcP4Y16XHvH3S/qkr0LjvrGNndguO5t1XbH1XujDd0rCNUBn2mcdMWQrhslMf
         sTP8OF/bVRL/XHpQt9lGLV6hdQRH5BtFSe/3/rFD60TtGwM6GvYDM2P8XIPmb+ZLPh6Y
         afdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4Bsv9nIgqKmSYSIOMPedKdrcSWXd/PYFSO2aIq/191g=;
        b=Yp7JQ578EWkYzFUIa2gCG8TGI/oqUNRUYdWg0sf8a6jJazdl9m+oA6fqodEs+VGOd9
         w9BgLbBfYNNw+ON391ULd+hJBQWvMDWY4gArPGK95ejaKhJ45yDewa1AfpqOubgH2mXx
         a+/55VSIVSCEqfZCDXnemzqgYZhB6QXM81ow4Dku6xhtnmgH5/m7AjWgb6ZXj6lga+FK
         I+bPM7A6KfHZ5FN0im20SfVo3GkWoqke3HRcp3TaYfibTF/EXlnNTsGdxWFjTu7E6tIU
         hrCf59Fj89ocs9pvbtRkJHfcqfeg+otGJi/Hx4puOowwv1Pd3v/IJvJm4TqPFyy7bf2u
         /4Pw==
X-Gm-Message-State: AOAM532CgZSQRtcdITWo8FBuyXs7UgA6pblEmrMSBkQDwzwyDCN7LxEJ
        7xIc0v6UcyvCTQmi+WZrM7I=
X-Google-Smtp-Source: ABdhPJyIls34k7x9JFSOkkgOqf1QQEkFiI5YZQPlp/pPPicar1BpkkeJw1obLQi4kxe5E1ASY31oLg==
X-Received: by 2002:a17:90a:1a02:: with SMTP id 2mr2574014pjk.150.1595483201112;
        Wed, 22 Jul 2020 22:46:41 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u16sm1295001pfn.52.2020.07.22.22.46.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 22:46:40 -0700 (PDT)
Date:   Wed, 22 Jul 2020 22:46:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200723054604.GC5476@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <abdd7265-43d2-49b5-6afd-70d65baac30e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abdd7265-43d2-49b5-6afd-70d65baac30e@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:16:42PM +0200, Arnaud Ferraris wrote:
> Hi Nic,
> 
> Le 02/07/2020 à 20:42, Nicolin Chen a écrit :
> > Hi Arnaud,
> > 
> > On Thu, Jul 02, 2020 at 04:22:31PM +0200, Arnaud Ferraris wrote:
> >> The current ASRC driver hardcodes the input and output clocks used for
> >> sample rate conversions. In order to allow greater flexibility and to
> >> cover more use cases, it would be preferable to select the clocks using
> >> device-tree properties.
> > 
> > We recent just merged a new change that auto-selecting internal
> > clocks based on sample rates as the first option -- ideal ratio
> > mode is the fallback mode now. Please refer to:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200702&id=d0250cf4f2abfbea64ed247230f08f5ae23979f0
> 
> While working on fixing the automatic clock selection (see my v3), I
> came across another potential issue, which would be better explained
> with an example:
>   - Input has sample rate 8kHz and uses clock SSI1 with rate 512kHz
>   - Output has sample rate 16kHz and uses clock SSI2 with rate 1024kHz
> 
> Let's say my v3 patch is merged, then the selected input clock will be
> SSI1, while the selected output clock will be SSI2. In that case, it's
> all good, as the driver will calculate the dividers right.
> 
> Now, suppose a similar board has the input wired to SSI2 and output to
> SSI1, meaning we're now in the following case:
>   - Input has sample rate 8kHz and uses clock SSI2 with rate 512kHz
>   - Output has sample rate 16kHz and uses clock SSI1 with rate 1024kHz
> (the same result is achieved during capture with the initial example
> setup, as input and output properties are then swapped)
> 
> In that case, the selected clocks will still be SSI1 for input (just
> because it appears first in the clock table), and SSI2 for output,
> meaning the calculated dividers will be:
>   - input: 512 / 16 => 32 (should be 64)
>   - output: 1024 / 8 => 128 (should be 64 here too)

I don't get the 32, 128 and 64 parts. Would you please to elaborate
a bit? What you said sounds to me like the driver calculates wrong
dividers?
