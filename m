Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E9C2D0E1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E9D21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zj9C1l8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgIKHGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIKHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:05:54 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F97C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:53 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t16so8075623ilf.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjqzgjQOFRpWcDyxvZxk4QJoi3x7zBwCHCwHFZiUpHE=;
        b=Zj9C1l8KtRpl+As+fC2SodYHV3leGr8IKnqUrXtbIKaxuPg+jO46cUnNc8nVxX18SW
         mbEW+8P41/MJvM/E4u41uFzqENs/81i6qVqtPc1CTfNlU3EKI4I1TUEtnco1j69bnEZB
         wLRzlq0oAuyYLrpP3Z5qmaGoU/ISEgtJhEqpeGcisx9o3OBg19btgYSqmZJKzsuqIBqd
         Is69lQN28aGTCuDIiW2Zryc/kx6uTbqlcXQ9Homq6iIxjNcfkNX3gKaIihnTzR7UstAN
         2VmsxeVA/wm3GsAiYpgtNStNHtBtN5TvK8oY9/xl1uIVCpI92OXTTqJMUgchu/8p+4nA
         i2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjqzgjQOFRpWcDyxvZxk4QJoi3x7zBwCHCwHFZiUpHE=;
        b=YwCo6z1KDQlXVFUIs19iG6Nk/RY2HxkkIcYGm5dNjuUZxJ0rJojh84NRhJ35nHRjI3
         N+tDIuipcOa2FtmHzGtmmb5zNI0ZZyOw971yITn6VunzPb5CfC4J/Lwd9U++20Wd7rFx
         lVNM2QbHZMofMxLS5PULuwz0VpAXI4VM23EDq6XoB5VZ49NayZ9KQmMPu46rAubkSK0z
         RIqtApIX03vC+fdsL/lk5zvROP4PeDZPA/6kxIC7lHMW/aWxw3iBpAGwOMjoJSFIayYy
         dWI1yHrU7OK8XpP5N9F0mwacjt8zm7PFFGqbyqONbiErKQRMfhtQWm9tO4jRLCuVpo9M
         PRHQ==
X-Gm-Message-State: AOAM53302YkJUHKOCq3Nt0PGy51KPjhIO/lvX/0yccFNDKyfYQWnVYyO
        UW13oUsYxDJEM5+KZKKd5q6iLIPIaNwFPIlJnd9BOWCQKxzl+Q==
X-Google-Smtp-Source: ABdhPJxx9W+H95xTgv9e14gbLyf1rs3mr+kr5EwsJPRKWUGmYYoAK21qecVtMoUC7yBc5BRWpykI7hnP1cxl9BbtPK4=
X-Received: by 2002:a92:217:: with SMTP id 23mr715365ilc.118.1599807952488;
 Fri, 11 Sep 2020 00:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200910052347.1790735-1-cychiang@chromium.org> <20200910052347.1790735-4-cychiang@chromium.org>
In-Reply-To: <20200910052347.1790735-4-cychiang@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 11 Sep 2020 15:05:41 +0800
Message-ID: <CA+Px+wVGaSfJxNGXX9LEw10k11vG=m9_bLpONA5w4-0O7XF0mQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Ajit Pandey <ajitp@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 1:24 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> +struct sc7180_snd_data {
> +       u32 pri_mi2s_clk_count;
> +       struct snd_soc_jack hs_jack;
> +       struct device_node *hs_jack_of_node;
> +       struct snd_soc_jack hdmi_jack;
> +       struct device_node *hdmi_jack_of_node;
> +};
hs_jack_of_node and hdmi_jack_of_node are not using.  Remove them.

> +static int sc7180_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               return sc7180_headset_init(rtd);
> +       case MI2S_SECONDARY:
> +               return 0;
> +       case HDMI:
I guess this enumeration has not merged yet?  It doesn't sound like a
specific-enough naming.

> +static int sc7180_snd_platform_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card = &sc7180_card;
> +       struct sc7180_snd_data *data;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       /* Allocate the private data */
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       card->dev = dev;
> +
> +       ret = qcom_snd_parse_of(card);
> +       if (ret) {
> +               dev_err(dev, "Error parsing OF data\n");
> +               return ret;
> +       }
> +
> +       snd_soc_card_set_drvdata(card, data);
To be neat, move this line immediately before or after "card->dev = dev;".
