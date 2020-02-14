Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A04C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378F0222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n4dLxQPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgBNNQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:16:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42490 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgBNNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:16:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id k11so10855642wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 05:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dttGVPvYe+0DFSlsyRJJUIcITjzQToEc+jk1zM06Pt4=;
        b=n4dLxQPN0JhQQXTz6SAWnhIsES9PG/QVSp0Dyca5BW5cpCWum4eN99uqSXNHYL7Enn
         +dQ6hjLXyzNN+qRU6P8ZQ3bymeC05amrV2ZQs/Oru8U9C/TTUrBI0e7s1j31+6c0lBlB
         X50KMfhdpCPfu63obK7Sgb6H6mVprmx1vYdIUpn1TSeCMXVI0PiitAaY/f+5+fHwDg3V
         l5+gFxyYCqkIhi+K84UgNZ5lyLXjnNjI2x6z7PmmTgecaZchzZWhTuT761DMKg4ESnYa
         AxfmDuOlpYhvctS4KcMy0He5uS0OxyE9fDBB+PVucONar1gJtmNqOQJANF+zrODomHHX
         SOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dttGVPvYe+0DFSlsyRJJUIcITjzQToEc+jk1zM06Pt4=;
        b=kViLE76S+K4SGe/7+uidv8r5OjhbhOCmbZX81fFnBJHXugpxk6ERc4Z5FpS5BKpKx9
         bpq2GUYYTuRtI5yz+mfKg+YTXNnU6WI5dJLAnFCyO1FMuRz14SeRz3/GNh3meTEoCC8z
         wNnAjKIepH+pH+8D5GDJsBA4eF8nixJLDzBL03nHyE7KicOWC2iEF41Qaa20ur8CNt/I
         yk964+jAAGm12DzVpHcgqQuZYczvRRE/T53NJxd7l7BxRB32dLINbC8n3pnN5q4/gOdF
         t+c3V6XW78kxNu9l4IbL6LbIdJUv2t19Kb3BwZsw3cf7VfiGPAeYEbuWpwuud3UB+NgY
         Avsg==
X-Gm-Message-State: APjAAAV6dpYLGcaztIWE0/l3J93zg0hsTKYAWhMCFHsv9P8pm4Yf4GUz
        nMhfhvS+OQ+ELE4lhBA90CmAYg==
X-Google-Smtp-Source: APXvYqwJkUMkAB0wiz7MQgXQAaFjzRStc5erCu+G50eOFaOD6CBvB6S541TCYfW4sox+swqm82Pg5A==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr3995329wra.8.1581686171959;
        Fri, 14 Feb 2020 05:16:11 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s23sm7147787wra.15.2020.02.14.05.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 05:16:11 -0800 (PST)
References: <20200213155159.3235792-1-jbrunet@baylibre.com> <20200213155159.3235792-6-jbrunet@baylibre.com> <20200213182157.GJ4333@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 5/9] ASoC: meson: aiu: add hdmi codec control support
In-reply-to: <20200213182157.GJ4333@sirena.org.uk>
Date:   Fri, 14 Feb 2020 14:16:10 +0100
Message-ID: <1j36bdfgx1.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 13 Feb 2020 at 19:21, Mark Brown <broonie@kernel.org> wrote:

> On Thu, Feb 13, 2020 at 04:51:55PM +0100, Jerome Brunet wrote:
>
>> +int aiu_add_component(struct device *dev,
>> +		      const struct snd_soc_component_driver *component_driver,
>> +		      struct snd_soc_dai_driver *dai_drv,
>> +		      int num_dai,
>> +		      const char *debugfs_prefix)
>> +{
>> +	struct snd_soc_component *component;
>> +
>> +	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
>> +	if (!component)
>> +		return -ENOMEM;
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	component->debugfs_prefix = debugfs_prefix;
>> +#endif
>
> You really shouldn't be doing this as it could conflict with something
> the machine driver wants to do however it's probably not going to be an
> issue in practice as it's not like there's going to be multiple SoCs in
> the card at once and if there were there'd doubltess be other issues.

I'm not sure I understand (and I'd prefer to :) )

As you said before, initially the there was supposed to be a 1:1 mapping
between device and component. The component name is directly derived
from the device name, and the debugfs directory is created from component name.

I would have preferred to use snd_soc_register_component() directly, but
with multiple components from the same device I got:

debugfs: Directory 'c1105400.audio-controller' with parent 'AWESOME-CARD' already present!
debugfs: Directory 'c1105400.audio-controller' with parent 'AWESOME-CARD' already present!

I copied the code above from other direct users of
snd_soc_add_component() (soc-generic-dmaengine-pcm.c and
stm32_adfsdm.c). I suppose they had the same name collision issue.

Instead of addressing the debugfs side effect, maybe  we could just make
sure that each component name is unique within ASoC ? I'd be happy submit
something if you think this can helpful.
