Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD54120792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsaApM3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHDCL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHDCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:11:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 19:11:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so1159162pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbNLUcgcp61dwL2pAmmG5QRL/i/NBysb7/NHuyoqPLA=;
        b=nsaApM3NTHR6R2T7nNwk1CPtmRQNw6viH5XfJjq+O/bdtm2Q65KlN7iX7rf0eDE2qg
         5OLREwXWLFEHVv+VPMreRV8/KN++G49x7xksnDd35LSOkcVgys8ZxB77H0fAJj/3vZ/V
         yIiGurTTSdPHHAeQKYX4VU0LXG0Uka8AQiqD4fW5iPAxg06Oh8EH1XBGIPIhjZtHXcmb
         xdH6v3suapQPOEpFVl1imcrWg4X0iyxtm3wU9LHtRDST7W6+uMcVWuCBJbivdT34z0kd
         OAMK6zph824b2NMgpfzKgT1pRY/9HfGNHMgt4WrjYrfbsLt8Adr7dHzIcmOypE8599y+
         WfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbNLUcgcp61dwL2pAmmG5QRL/i/NBysb7/NHuyoqPLA=;
        b=GdeYrplabhig3Q3jhvyNLjJ3P1MEufTGqflaHGsQd+UlaUGXYSwyjOcwJ9WTfjurd2
         iqg2XYhgW4fRFRHs5S3xukmB1MVkrKHKAlzdKOs2U7CsAXtFcYuEwwYVic/IproOcRXV
         oTyOp+yKQfQr5plyylBMaK/6JSC4IcVgKIJA6ayP7XrI0eP0o8ZpuGrxx9kffGi9M1CA
         mXaLL5j7x1HaVs6aq7cmjKOxjYwbkxAqWPdrTxFIkkIepYl79Fv4SM16kYssKjk/K/1g
         Ta7yxTH8+eHR0nMEdKW2a2PhBDkAKx274Em1yV46tYSIuWlb2Z2NSHbPVF1j0SAY4Dfg
         caQg==
X-Gm-Message-State: AOAM531adDL71VHkppUGn28qBfaPPipytFvcCRa3aDuRH6QvRyTFL9t6
        9miUW174jWJbTIfLHM7T21OPXZ/0AVg=
X-Google-Smtp-Source: ABdhPJxXJgybVnO38/6iDmh+Vn8Q3oldCX79b37Cqy+zqFF47vMHsrWFuGMjDfgGwC4Ihu/GP11gEQ==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr2042798pjv.181.1596507088135;
        Mon, 03 Aug 2020 19:11:28 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j142sm20970462pfd.100.2020.08.03.19.11.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 19:11:27 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:11:15 -0700
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
Message-ID: <20200804021114.GA15390@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
 <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
 <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> >
> > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > is enabled.
> > > >
> > > > You are correct if there's only RX running without TX joining.
> > > > However, that's something we can't guarantee. Then we'd enable
> > > > TE after RE is enabled, which is against what RM recommends:
> > > >
> > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > # If the receiver bit clock and frame sync are to be used by
> > > > # both the transmitter and receiver, it is recommended that
> > > > # the receiver is the last enabled and the first disabled.
> > > >
> > > > I remember I did this "ugly" design by strictly following what
> > > > RM says. If hardware team has updated the RM or removed this
> > > > limitation, please quote in the commit logs.
> > >
> > > There is no change in RM and same recommandation.
> > >
> > > My change does not violate the RM. The direction which generates
> > > the clock is still last enabled.
> >
> > Using Tx syncing with Rx clock for example,
> > T1: arecord (non-stop) => set RE
> > T2: aplay => set TE then RE (but RE is already set at T1)
> >
> > Anything that I am missing?
> 
> This is a good example.
> We have used this change locally for a long time, so I think it is
> safe to do this change, a little different with the recommandation.

Any reason for we have to go against the recommendation?
