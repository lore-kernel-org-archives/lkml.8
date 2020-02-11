Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C53C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA00120842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQBAwKSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBKLmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:42:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55524 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgBKLmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:42:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id d5so1199395pjz.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eMtYAOltTS55/voD4YIIDIQuDbCIU7QwDAsh+xh9z+0=;
        b=RQBAwKSJ5jjdTdzvJid/G9UHEQAUDQPKbASaPJ5LZOGJnau6jYyHulJxuN1gWnlla7
         i3EohY1ipFEibsfFWKS7DE6OyjFKPwX1N3omW19fsjod6u7yXqTITTV1qSx0+RH11K5G
         sbCZtTDBVAQdBOPTc+lHULGeR6dtBTiTFyrwYEzzwQtStCa2xdwMTY5GiE4Az8mn6R2X
         ene1Ng9ExiKTFINfCjnZZjq01tBcYls+P+5x/InP3MT5P4cQFYP9y76G1qHjzXBXJtWG
         8SVYX0947daZjOo9mthl8A1mH2Wrjlx6k9Dme+hAO3XY/hAwkXXA1QbTo0rYGNUXfx2l
         gOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMtYAOltTS55/voD4YIIDIQuDbCIU7QwDAsh+xh9z+0=;
        b=sM+zzmMMJqoa7VSuG304D0b4bUBFfVzF9SN9+c8n+5laE8iLGmxwYU0lTc3OB5ggo6
         O6dD15WqF2mAYobS7xyfR591YaLskc0Avd5LkG1/eSSNrRdsfaFSWrxR94n9XoMUqh2U
         snBPNig53MKT0Nd8f//JRHeKVj2y71JYSLRccsOa6xmGdNKKrddt+NsrDlgoRDyfSEcT
         9wOdTguKree9mel7f+BMXmdTcAnO6JJCAVOa0lPEC+r1f5znSbuxULA3y1v9M8l6MjJg
         oK04NN8cfs93Bjpi97M/hY+pkxOXpgeWMPvz9YZXJdnc02XU5RHcz8iRqZPh7fIM3Fry
         gxtQ==
X-Gm-Message-State: APjAAAVm7NX146tCwE9FXaB99oZKhlauW0aLcLEPr9rj7Z3wO32279h7
        LRmKcAmNwAvwZJ5cV9sHnl4=
X-Google-Smtp-Source: APXvYqzTIpafBVuLDUiwBEAxolN2iuDp40pL55M74XERnmN9bQb+rQv5ZZOxSM2Sc1YcYG8m+tnfvw==
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr3286677pja.27.1581421361825;
        Tue, 11 Feb 2020 03:42:41 -0800 (PST)
Received: from f3 (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
        by smtp.gmail.com with ESMTPSA id l13sm2863661pjq.23.2020.02.11.03.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:42:40 -0800 (PST)
Date:   Tue, 11 Feb 2020 20:42:36 +0900
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Takashi Iwai <tiwai@suse.de>, Kailang Yang <kailang@realtek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: hda/realtek - Fix Lenovo Thinkpad X1 Carbon
 7th quirk value
Message-ID: <20200211114236.GA2691@f3>
References: <20200211055651.4405-1-benjamin.poirier@gmail.com>
 <20200211055651.4405-2-benjamin.poirier@gmail.com>
 <b23abac0-401c-9472-320c-4e9d7eab26de@perex.cz>
 <20200211081604.GA8286@f3>
 <901c395a-7fb5-5672-5955-d6d211824177@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901c395a-7fb5-5672-5955-d6d211824177@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/11 10:35 +0100, Jaroslav Kysela wrote:
> Dne 11. 02. 20 v 9:16 Benjamin Poirier napsal(a):
[...]
> > > 
> > > Why PA handles the rear volume control with the current driver code in the
> > > legacy ALSA driver? It should be handled like standard stereo device. I'll
> > > check.
> > 
> > The device comes up with "Analog Stereo Output" profile by default. I
> > changed it to "Analog Surround 4.0 Output" to test controlling each
> > channel individually:
> 
> Yes, but does the volume control work (does PA change the appropriate ALSA
> mixer volume)? Sometimes, it's difficult to see the difference between soft
> volume attenuation and the hardware volume control.

I see what you mean.
When set to the "Analog Surround 4.0 Output", pulseaudio didn't change
the "Bass Speaker" mixer (always at 0dB gain). It used a combination of
Master, Front and sometimes PCM mixers to control all four speakers.

For example:
pacmd list-sinks
	name: <alsa_output.pci-0000_00_1f.3.analog-surround-40>
	volume: front-left: 10349 /  16% / -48.09 dB,   front-right:
	39377 /  60% / -13.27 dB,   rear-left: 23979 /  37% / -26.20 dB,
	rear-right: 47974 /  73% / -8.13 dB
                balance 0.61
alsactl -f /tmp/output store 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 33
		value.1 79
			range '0 - 87'

		name 'Bass Speaker Playback Volume'
		value.0 87
		value.1 87
			range '0 - 87'

		name 'Master Playback Volume'
		value 77
			range '0 - 87'

		name 'PCM Playback Volume'
		value.0 255
		value.1 255
			range '0 - 255'

> > > 
> > > You should also test PA with UCM.
> > 
> > Please let me know what do I need to test exactly? I'm not familiar with
> > UCM.
> 
> Just install the latest pulseaudio (latest from repo), alsa-lib and
> alsa-ucm-conf (also from repo). If pulseaudio detects UCM, it has the
> preference.

Using the packages in debian unstable, `pacmd list` shows "use_ucm=yes".
alsa-ucm-conf was already installed. Hopefully that's enough.

ii  alsa-ucm-conf    1.2.1.2-2    all          ALSA Use Case Manager configuration files
ii  libasound2:amd64 1.2.1.2-2    amd64        shared library for ALSA applications
ii  pulseaudio       13.0-5       amd64        PulseAudio sound server

pacmd list
        name: <module-alsa-card>
	argument: <device_id="0" name="pci-0000_00_1f.3"
	card_name="alsa_card.pci-0000_00_1f.3" namereg_fail=false
	tsched=yes fixed_latency_range=no ignore_dB=no
	deferred_volume=yes use_ucm=yes avoid_resampling=no
	card_properties="module-udev-detect.discovered=1">
