Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17905C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC9220835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgE0V5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:57:54 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgE0V5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:57:52 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MfZ9C-1j6xHy3uqu-00fxxd for <linux-kernel@vger.kernel.org>; Wed, 27 May
 2020 23:57:51 +0200
Received: by mail-qt1-f181.google.com with SMTP id e16so14735098qtg.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:57:50 -0700 (PDT)
X-Gm-Message-State: AOAM533thycOgBc34efCHA6QTlA0jBnCflO0sQAlA0+xHTyuFQKRPHuw
        9VaMnuklUJN7ShyfeCnRq1p7Zj9Uov827ljJnmE=
X-Google-Smtp-Source: ABdhPJzip70H1KwYX1s5TKJluQwoj7pMFq4UElZk7BE7UqzNUerzc1aReF2z3NGYv6cclDoxnTuN1MbNjmBT6MxK6Nk=
X-Received: by 2002:ac8:306d:: with SMTP id g42mr43805qte.18.1590616669783;
 Wed, 27 May 2020 14:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200527193730.930412-1-arnd@arndb.de> <20200527205658.GM5308@sirena.org.uk>
In-Reply-To: <20200527205658.GM5308@sirena.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 May 2020 23:57:33 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WrCGFtYx52sMu2rsWQFq6kKhEFWGEk2Tn+4gEQTLxBw@mail.gmail.com>
Message-ID: <CAK8P3a2WrCGFtYx52sMu2rsWQFq6kKhEFWGEk2Tn+4gEQTLxBw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: split i2c driver into separate module
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XOWVbmw7mJ1QwZ290rv4B4mHDMS3DenvOuVrg4mtVHmjtyD0yiN
 r3PsVGQSz5jDzRKYK9j2Tncy8f6xFCilyx/Cev8rhzsU6N9zSZVESfGvIoVl4/OlFWHTn9q
 U4qK+GRRrtqufNncI4+QTwm4zlZ6flhwWl5dmDbhORWR+f5kzG1i5E8P+WQxPb/NBVbFJ0L
 Jxagj2wQaaRpYYuSfjVbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWqGY6v1L6U=:nqVNbd4aSNZmETS7GLK+PQ
 7k1/G/9DDtUUUzGfl9LlFVmjOns74Q73uI9Vq2qGSUoZLyXglo9ouKZ6To1p/kKBfRIes9w1a
 EmZiXwWWXQ3TLv+0eHVrYZ3OsAXj1zrNFfHAC8l43YCBMx/rKvf2mdtSSwZIehHypKMcsbR7m
 JgtjBZUfadarLgav1eIApiMmpstwWiiihEGee7X2m4pTElP8cFqY74oWW2PbckkpnUvwpLNp+
 fygeeXNeod/vi9WMFwM/T2Wuy26BaM/o3fs4qIUw70jwX76kcy3impaugGYlLkbj0XnW33Fcj
 v2XtT58eJPMemO1D2Sf450nWd1E16nJ7eOXluoEuQ1ekd+x4aiXJ45iIGw4XfVZhv+jRfustz
 yph3q57M4x4Z4CpGzeWJhcxpjVESaS+Asl3HhE2XTWjTl0ml+ncr/FdhhhVGA9H9TJGsc5yNb
 M7Pq75yGqRytzxaBgDNeiuVE91oep33jWX4t2EFpVveIWzpE96kQGjV1uwkbU88QTbDTBTeSM
 nhb4b1F6NILsJ3iN3FGxbVp5o0Ju3fBHbXigaZ6Lj4lrAc5R1ae4SleO9tQVdcjtNr8oZ+JNJ
 DHvt7pi/RGk5g7cPdInXJnK3tmuJZjQJSlGrYQGQl6AaZDzCWbU9L1nSjasv/PmaQMyzG//rH
 csxYTE/MAr+issSR2XxX/KYtzFnw95dEpyj7gOPZGFwpdr2aarsmr/L6W/EAUUtcuw1p8fM2i
 eQG3Cw4DWYgvi32b111RZDpL3sluBQePQg10so7SQNXCP/RSysG2oiRkPZoZmrl+jM10IS7qF
 qEUf/7Chh3R/tUqAF6J4RecU/D/ZwJem/QfUECg7fg8x9BT+xk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:57 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 09:34:13PM +0200, Arnd Bergmann wrote:
>
> > index 000000000000..c891aa80757f
> > --- /dev/null
> > +++ b/sound/soc/codecs/rt5682-i2c.c
> > @@ -0,0 +1,341 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * rt5682.c  --  RT5682 ALSA SoC audio component driver
> > + *
>
> Please keep the entire comment C++ so things look more intentional.

That's the kind of change I was trying to avoid by just moving
things around, but I've done that now in both files.

> > +static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> > +     "AVDD",
> > +     "MICVDD",
> > +     "VBAT",
> > +};
>
> I'm *fairly* sure the device needs power even with Soundwire?

I have no idea how this is done with ACPI. I'm moving it
back as an exported symbol. There should probably be
some abstraction that handles this in the common part of
the driver along with some of the other bits of
rt5682_i2c_probe, but really don't want to shake things up
too much and would let this be done by whoever needs to add
DT support to the soundwire driver in the future and is able
to test the changes.

> > +static void rt5682_jd_check_handler(struct work_struct *work)
> > +{
> > +     struct rt5682_priv *rt5682 = container_of(work, struct rt5682_priv,
> > +             jd_check_work.work);
>
> > +static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
> > +{
> > +
> > +     device_property_read_u32(dev, "realtek,dmic1-data-pin",
> > +             &rt5682->pdata.dmic1_data_pin);
> > +     device_property_read_u32(dev, "realtek,dmic1-clk-pin",
> > +             &rt5682->pdata.dmic1_clk_pin);
>
> This doesn't look very I2C specific either, nor do chunks of the rest of
> the code.  The usual pattern with this stuff is to have the bus specific
> code do bus specific stuff like setting up the regmap and then call into
> a common init function for the shared parts of the chip.  I'd expect a
> bit more unshared code here but not this much.

Right, I was surprised the soundwire portion does not tie into
device tree at all, and none of the other soundwire codecs seem
to either and no dts files reference it, though there is some code
for the subsystem and a binding.

     Arnd
