Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF41C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B89206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgD2IZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:25:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2IZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:25:04 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MtwQk-1jBDAQ2IIu-00uF3o for <linux-kernel@vger.kernel.org>; Wed, 29 Apr
 2020 10:25:02 +0200
Received: by mail-lf1-f41.google.com with SMTP id f8so885280lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:25:02 -0700 (PDT)
X-Gm-Message-State: AGi0Pua8gDD1YzhlCUT2AwIsakNBc1aS3Jpukdr2y5ag9ZRQBs3CJkjr
        1zArKHGhIVzvMQlvSkxcKVv9xNzMElwE/o9G3fo=
X-Google-Smtp-Source: APiQypKYwuif1CT2TpVka5FFL7aLnwCZS2moXiiZbTlODTEUY1BIra8wbAmWai01XE2gYsYojcCm4wCdH9lAq0wmfsY=
X-Received: by 2002:a19:505b:: with SMTP id z27mr4237553lfj.123.1588148702030;
 Wed, 29 Apr 2020 01:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428212752.2901778-1-arnd@arndb.de> <6b39fbba-c65d-2c02-14bf-11c2d00547af@linux.intel.com>
 <CAK8P3a24whg2RhJE3Vf5u3EWy+wvFqhXdp7EQZuQx0shPsMARw@mail.gmail.com>
 <f91c9a68-7641-beb8-a23e-bd1b9b8d0acb@linux.intel.com> <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
In-Reply-To: <b784c008-7094-05cb-6200-6b246ff39bb8@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 10:24:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3vri_-tdEy3x6tRGUjb_k-+Mc+Jt9bQpgFvqm2RN+cJA@mail.gmail.com>
Message-ID: <CAK8P3a3vri_-tdEy3x6tRGUjb_k-+Mc+Jt9bQpgFvqm2RN+cJA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: sort out Kconfig, again
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        sound-open-firmware@alsa-project.org,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:86EeJyH+/ActAOlbYrnMSx4hzYaVuqqOBSwdFI6ZXY4pnrAnL5L
 7ejvAoYbD0S8Sj6cMtRzDWicOQXIwGCdMeYPnPHZ9oxSq7+uTHDTktMjIpMlNJ5i8K9S7/d
 hjs/S9xuCP7hZmzSXp5S77FC3hWXnfWJ8MYZwotSbjl51Xm3tzmuYRj9BZ39Lno6X8aSFAJ
 u4gByjW6UIkIot4lkKk8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RPkyGWEqyjM=:yn3Xr3A9yaDk09ZdH0WaJm
 W5FH7H9EroekqXxs4XQd/NmWgk/Ylno2bTNHZbG6vaV5hvSEt+vrm2vpfm8BS8KtUgkfub88t
 f2WwcxNoq2Dx1RXCy9K9/LrKFhFgR6QL88P42pQhAeHGkZtWu6l5nL2Ra/nkt97/QwAUHAAJ7
 CshBKYARojtns1RhNHm6YiRceNlPDeTOhPN5JpNsLO4tlwc8OGIzVcaS9KXK6+JQzZxiKarRJ
 BSu6oNnC0jgVnwzoshtTAY7QyG4A+WO3IoW5081RIQUMq1ynMX+4PhXxwyskT72WjNL+B4Dmm
 q0btOrRqXtS2a2nWtyXI/8nTzzP3zGCZDDPIjtbN8hW1A0S4itxKvDl3Da7/NJ1h65rRm6Y57
 5rqGyqj9qrfK07+I9jiABlKFQx4/QFjcFvBPA9BepEMAD7GTcDV4iSg27/sOSLoZa5LXBNToY
 Nc4bpocsxLlJLKwHATAXvMjZQZgeWKy2JBM8R5T48H4cxgg8lR6xZVyBNn7ANKu0JGKkwzZB7
 PP5+YPOHMxl2256yb7Lj8Y832rCgEzE8/qj8XbyVHacRKJXR44lFwrAbJ7d4agdS2K9UaYLgo
 5exiMsdorm40AbZRYuaMjXC6RNeu+1fAZlF6GstPHYAMkJC50rKmRHS2T6vYvjRMvAQK/u+BP
 fXMSAee13nmLDHjQMMs+qVJptwSC98wFG3yaTZN93zozQn1u5WA5Q2bdtfCFJ30ysiHwqGxyc
 BfS7GJsPRvsWmC/nP7W4A48t2aSKit2UnXkicacRvcy8K0vw5aoozkXZHDb76CZ1KkJOnqldn
 nj2XRxnOqfmwHPZBFrXTLdSp60/w8dhtOCO4zXWK2wmGYa9CXg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:00 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
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

Ok, thanks for testing!

I looked at the bigger picture again and found that the more fundamental
problem is the dependency reversal in sound/soc/sof/sof-of-dev.c, where
you have common code that knows about and links against a hardware
specific driver. This is something we try hard do avoid in general in the
kernel, as it causes all kinds of problems:

- Expressing the Kconfig dependencies is rather unnatural and error-prone,
  as you found

- Adding multiple new drivers at the same time leads to merge conflicts

- A kernel that supports multiple SoC families, like all general-purpose
  distros do, and Android is going to do in the future means that you have
  to load every hardware specific module in order to just use one of them.

- In Android's case, it also breaks the model of having one vendor provide
  support for a new SoC by enabling additional modules they ship in
  their vendor specific partition

I think this is all solved by moving the "module_platform_driver()"
and of_device_id array for each driver into the module that defines
the corresponding sof_dev_desc structure, and have those drivers
call the exported sof_of_probe() and sof_of_remove() functions.

      Arnd
