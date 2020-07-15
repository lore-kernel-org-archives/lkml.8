Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA18C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE502065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf3pdpYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGOUrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGOUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:47:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A25C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:47:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so2874907plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FXz7OnFn9ZprLznWsMLDc1PTFviPFIrchOGsQ58Z+yI=;
        b=Hf3pdpYHLXpQj0ceAPhAiJWguzWIx1DkVx7VzOu8/NuBvdM0uzSDDQoXF8+61PDq/G
         5Gzh0SQ1ifzWaK3+VdLkWAet53Z4WTCzPNYk1wmPq9dVabyxntyXt7Mx3X8fPAiOfSy9
         iaTb0FZ9jSe3Wkkw4YloqRpQpVgw13bN9c3YBE2V+JxikNgZK4ZGNTdUzj+XP55eJ0jb
         rlospzo9NEnSdP9H0quq0WHGeo41hjgffgLpGc7iSDxLToaO5SNhQTDVYhHPuB+zPXGq
         ruW75+BJgJf3+ZIFuTWqoKMbzJ4IcuE6MaclsR2e8NSHoIpoYMRuxHc9RvpBbo4aKDBp
         plTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FXz7OnFn9ZprLznWsMLDc1PTFviPFIrchOGsQ58Z+yI=;
        b=lIkW9a6YusFRrbgNOlp43utVy3djeLHu5dnE31GJk+J3BwTxkKeWxuGsJTeA0d3y2o
         m2EdN8Fp//527KgSwjz3bZnuzBn2jaFkniYaKwOMZW1Ru0a/hNPjVRlwpFxR9JKWZ+Ae
         ErrhfKQqDr3cGpt7Uy3l7UxZjBRWmi5RyP8I8EyJlJsiOFKzP2kdhoyS2WaXtY32tcRz
         HtqwZpfRMCRgIwfexqqMbZi1JAraLgNy0u8I0CbvqnQKtqVB9/ovNTI7bQ+xwjX5NtLl
         O5nzNJ9+Y0SgAy7U77m0n5S3TM1NwVBTVsa2Z357HSiSSsBtuuxm6NCBMIK7Xh6/EewC
         kuyg==
X-Gm-Message-State: AOAM533m056GC5hLf/Zy7QfeWcVu8q5TKAK01mS+gPEQBiB/SS8Xit6v
        seZnibb+thYXe2KGrTg1rN8=
X-Google-Smtp-Source: ABdhPJwoIb2MvOzijl+bvxJwJXZRfIdjOy5U9ImsWQ93NI6qGX2IrEdqizHwXV3920DgPiADXBKk3A==
X-Received: by 2002:a17:90a:e2c7:: with SMTP id fr7mr1460963pjb.103.1594846023187;
        Wed, 15 Jul 2020 13:47:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c14sm2839648pfj.82.2020.07.15.13.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 13:47:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:46:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200715204636.GA14539@Asurada-Nvidia>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
 <20200714205050.GB10501@Asurada-Nvidia>
 <20200715140519.GH5431@sirena.org.uk>
 <0a56326b-27a9-d9f4-3923-8773963d7548@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a56326b-27a9-d9f4-3923-8773963d7548@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:18:38PM +0200, Arnaud Ferraris wrote:
> Hi,
> 
> Le 15/07/2020 à 16:05, Mark Brown a écrit :
> > On Tue, Jul 14, 2020 at 01:50:50PM -0700, Nicolin Chen wrote:
> > Anything wrong with ASRC selecting SSI1 clock for both cases? The
> > driver calculates the divisors based on the given clock rate, so
> > the final internal rate should be the same. If there's a problem,
> > I feel that's a separate bug.
> 
> Calculations are indeed good, but then the clock selection setting in
> the ASRCSR register would also use SSI1 as the input clock, which
> doesn't work in our case.

Could you please elaborate why it doesn't work?
