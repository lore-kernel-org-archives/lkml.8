Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB236C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDA424654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qLusgcn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBSP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:27:17 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38036 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBSP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:27:17 -0500
Received: by mail-wr1-f53.google.com with SMTP id e8so1032882wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 07:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=xr4KCy9LjDDC7/U990Djpkp9h3+bHMJP/CuHnuQdnQo=;
        b=qLusgcn5KbYtblag3ItTqC/KfOT7gzpTagmfjrK72YZF2YtNKk3oZEojedbhvN+otQ
         NEw7qy5LvmAR9XYW/jvQ7BZup7ygvcw9HJGfzOe2jjfV3JjpMms5H1AQH9OFclJqgTuS
         uLKOer0DPMTVNsYuCC8CMbDhrv2Yt2TU+K14mhJTBIVNS9Sgu/AzaY7NEIm0yZK5c5dI
         y7LmmO8BuUCbitrvTF3q6PsbBkNkDXMFCW8Bc/F0qZb2yJex04sRccZWuXsWVFAxyjQ+
         31i/D8+L5aA1lXOsIVSGa3AuErQys1+UHlCv2IFT4kJ4ICrkBI5uiDC2hVNEkZuDCdgX
         u88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xr4KCy9LjDDC7/U990Djpkp9h3+bHMJP/CuHnuQdnQo=;
        b=W0QLFjUjsn85L218+/i2+YYFL46TUwdXy+niu5z9OvHUa2l+RRDmFWYqsYEYc7EkJh
         lE6KN4+kJJBFNY7mtZLb+OEy6K7dbyb6dD8LgwTvcLoZXE/MKijo70BCpB4rCy9W5oih
         8koiEN+gGdGl8oIz7zvj+dw5kPifLDUV5W4PuMZzz1I9MLS5V78kIHBML+fxUF4aOh+M
         U6syu9R5h01H7887dA8VzycSwm1bQAcYrs6Lv5tPXa4P4k8ZC/GW36Ol6DkBQIsDj+uS
         UP6sWNrWB2EyWbknvhnGoyH1XZBvzNQFZznRF0puE7+bV299IUcUdpwM4N1VlQIpW7YJ
         FX0g==
X-Gm-Message-State: APjAAAWgI8DpEIpjo0iEW4Q/qf/9LA7ft8Gv1Yj8JdcVMtIBTi51HXtZ
        BlIGSHesZAzmyx97fjDOS+TJ8w==
X-Google-Smtp-Source: APXvYqwYyZmGAEcdumWTLBen7hSlFvchvYN2atMg/kgjiqNCGQr0Y4/R6fWnH8UUM7Wz8uv/QQZF1A==
X-Received: by 2002:adf:e50f:: with SMTP id j15mr36883719wrm.356.1582126033825;
        Wed, 19 Feb 2020 07:27:13 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id t81sm241883wmg.6.2020.02.19.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:27:13 -0800 (PST)
References: <20200219133646.1035506-1-jbrunet@baylibre.com> <20200219133646.1035506-3-jbrunet@baylibre.com> <20200219145500.GC4488@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] ASoC: meson: add t9015 internal DAC driver
In-reply-to: <20200219145500.GC4488@sirena.org.uk>
Date:   Wed, 19 Feb 2020 16:27:12 +0100
Message-ID: <1ja75ey4vj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 19 Feb 2020 at 15:55, Mark Brown <broonie@kernel.org> wrote:

>> +	/* Channel Src */
>> +	SOC_ENUM("Right DAC Source", dacr_in_enum),
>> +	SOC_ENUM("Left DAC Source",  dacl_in_enum),
>
> Ideally these would be moved into DAPM (using an AIF_IN widget for the
> DAI).

I can (I initially did) but I don't think it is worth it.

I would split Playback into 2 AIF for Left and Right, then add a mux to
select one them if front of both DAC. It will had 4 widgets and 6 routes
but it won't allow turn anything on or off. There is no PM improvement.

Do you still want me to change this ?
