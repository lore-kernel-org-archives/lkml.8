Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7DC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4990206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9pcgC8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgD2IVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726366AbgD2IVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:21:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8EAC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:21:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so982817wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YrQOHDbmJnPKKTvmQG5p/Lai5qrrvsqVUCdrarGgC0=;
        b=I9pcgC8TZZt5Kg0A7T7Sj2GX1f3NndD9VL3+SitseYmNYZCHbW4qyQbSaIhgJ2k8F9
         A4I/PYoz9MXS1mMf5mMtKKa8odnpWVMfBdSeYkjsmyccvPIjsyDG2KvoZckg84yWXCAT
         Y6BibMgeLOuRP5/QlCmQbtJbOwX2chmzcYD+0bKcOGgb2Jv2xrHxrCh8hYEH2YHJ6vF/
         6YBdsXb5KcdSrNCXK005EXZs+/4NDKa0kcEOmgHV35NNBcB18QblhsCRsehmWumsgBh4
         CE+724OEI0a1mlv9maOUA39PwHvLs1bBqHnYrym3q5oe0JXZlwl/nIpAO6g3UoDq/rNh
         SFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YrQOHDbmJnPKKTvmQG5p/Lai5qrrvsqVUCdrarGgC0=;
        b=gktL5DgTuibXouApnTCCUPPoiLck/mQYEM7+yW87KyeAcSv41F20vb72LmkcTLrGWE
         w0kOi2BxL85k5ebSSlC7yaWT4MfPh23dB6y3NuRKmPm1DJ45Dg775tWzjBIydNYkEDjJ
         +db3cLy2J/OnhI4Z3Q8gz42+/SeQy2eRwUPsbpJmd9bpRUNE5C9xzVysOZSfGpmsW/T+
         I+CGSQqUuwWisFKXCOmHX3z1stGmhhHPEPo8rWAGKoy9mvN+XmnSvzksz+zLgyYJfDWN
         /wll8x77hPuaXGb2BwOIEZYbQarDxapCv4VFnkdAXVRPOnTEQ84Zrv8iGHny2Ndb08pE
         sTvQ==
X-Gm-Message-State: AGi0PuYz9JptX0XbXqRAGqTu/b92nQM6lsnNOFIrkwP0UomDNDWMINDh
        ITLg+kW0QBUKheJ5PL70/PPtN2zYXqYknXHJDGA=
X-Google-Smtp-Source: APiQypKGkoXSNV8IrqXx0pbjTev2ByLg0A0Y8YCXnburHa1C62WyWY3/obBJqfCR72hvN1/GNuPReGW+qHxhMBIIIcs=
X-Received: by 2002:a1c:9948:: with SMTP id b69mr1828574wme.44.1588148507074;
 Wed, 29 Apr 2020 01:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200428212752.2901778-1-arnd@arndb.de> <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
 <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
 <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com> <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
In-Reply-To: <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 29 Apr 2020 11:21:35 +0300
Message-ID: <CAEnQRZCr0NAfx4UGcd3v6Cr5bZpUmQg5VCG9OA=aj=4uJX0qOg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Pierre,

Thanks for looking at this.

> >>> Thanks Arnd, do you mind sharing your config?
> >>
> >> https://pastebin.com/HRX5xi3R
> >
> > will give it a try, thanks!
> >
> >>> We noticed last week that
> >>> there's a depend/select confusion might be simpler to fix, see
> >>> https://github.com/thesofproject/linux/pull/2047/commits
> >>>
> >>> If I look at the first line I see a IMX_DSP=n which looks exactly like
> >>> what we wanted to fix.
> >>
> >> Yes, I think that fix addresses the build warning as well, but looking
> >> more closely I don't think it's what you want: If you do this on
> >> a config that has the IMX_DSP disabled, it would appear to the
> >> user that you have enabled the drivers, but the actual code is still
> >> disabled.
> >
> > Are you sure? we added a select IMX_DSP, so not sure how it can be
> > disabled?
>
> I just tested Arnd's config with the patch we came up with for SOF
> (attached) and it makes the unmet dependency go away and builds fine.
> the problem is really using select IMX_DSP if it can be disabled by
> something else. My proposal looks simpler but I will agree it's not
> necessarily super elegant to move the dependency on IMX_BOX into SOF, so
> no sustained objection from me on Arnd's proposal.
>
> Daniel, this is your part of SOF, please chime in.

I would go in favor of Arnd's patch as it gets rid of exposing
IMX_MBOX into SOF.
The code will be fine even IMX_DSP=n, because the exported functions
used by SOF have dummy implementations in case IMX_DSP is not selected.

One concern is that we could end up in a case where IMX_DSP={y|m} but
IMX_MBOX=n.

Technically this is not possible because IMX_DSP depends on IMX_MBOX. So,
one cannot generate such a .config file from menuconfig interface.

You can add my:

Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
