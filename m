Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9EC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9916220838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aE1OHoox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgGaI4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbgGaI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:56:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57156C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:56:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so27247499wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKHultmexfuWBdCK9WRDRk/vbhZ+37y2O3wAMlcu988=;
        b=aE1OHooxwN4CtoTfKoukXZmAijnt7lUt7g2YEmORS3cT7AcMzMNPBMqe8jdLYclZBm
         eOHaWEarxXuFCjto12aNCFolbMakz+DiEVyPF5mrDDnb4gRfoCRQPp7jBy5l2R7n/un1
         nBoT11Vhvh4xhvgqwcqKCnGpBSQmKQyJHI6yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKHultmexfuWBdCK9WRDRk/vbhZ+37y2O3wAMlcu988=;
        b=DJSE7gbLEsSCKBspkwRLEm5zCX4zlDoea8lYevQj21Qo4bH8ncHNBJUykEe/PfjLyu
         /JQ6SY9ZKsCvicHrgHvE1Kx0tpmibZp6G+uxZGSNCW4P/SgDwQ8aijPZgBPf4ksGiBjt
         AgQHgOSBYusvUcWyH8R40wBDinFJoVosVZVWTW4GdZqeeVqgaRbp3vnvZ+EZmYktrioE
         +R5ggIjci7bUY2g+Xni5jvc/ojaE5GMdkAIKmECJ+KGbKDe7KgHw26tV0i20UTBGse61
         hKiV3XMmuMIOK5BBHLJi2frHMLZhxDD+xOPL2EXweW8xYWjM6Myd21CCcXjLhQBmCGXm
         w8lQ==
X-Gm-Message-State: AOAM532Lh7qlClKapTtjG14F6JGGSWFilDxYoMcCMv7YvbQD8VeYj7tx
        xYaKVkCkZsqRt9d+kP1q3H4tuuwSeZDC4aFs5kB7QA==
X-Google-Smtp-Source: ABdhPJzWn3jZhPtcamUMQKgiq4Q2WoIJL296BZio2qPps8qapt7QAgo3rn4E433qso7peWw9XBVW+myXjp0sLi36trw=
X-Received: by 2002:adf:e486:: with SMTP id i6mr2505317wrm.258.1596185775852;
 Fri, 31 Jul 2020 01:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200721104422.369368-1-cychiang@chromium.org>
 <20200721104422.369368-3-cychiang@chromium.org> <ce029818-5082-643b-ff63-25aafea3de6c@linaro.org>
 <20200723184432.GA321518@gerhold.net>
In-Reply-To: <20200723184432.GA321518@gerhold.net>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Fri, 31 Jul 2020 16:55:49 +0800
Message-ID: <CAFv8Nw+Y7S2EWZMUYEeFeTmt+TdzBQUTBzgHDa7reWT9CiOA1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Ajit Pandey <ajitp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 2:45 AM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Wed, Jul 22, 2020 at 10:25:14AM +0100, Srinivas Kandagatla wrote:
> > > +static int sc7180_parse_of(struct snd_soc_card *card)
> > > +{
> >
> > This code is getting duplicated in various places like apq8016_sbc_parse_of,
> > it will be nice to common this up, if possible!
> >
>
> FYI, I started work on making apq8016_sbc use qcom_snd_parse_of()
> a while ago already, but didn't find the time to finish it up.
> I have now sent it, this should make it possible to use the common
> qcom_snd_parse_of() function in this driver as well.
>
> See: https://lore.kernel.org/alsa-devel/20200723183904.321040-1-stephan@gerhold.net/
>
> Stephan
>
Hi Stephan, thanks a lot for jumping on this to help.
It indeed makes this new driver much cleaner.
I have tested with your patches and it works great.
