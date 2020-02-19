Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FAC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37C324670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rTS8Mo3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBSRah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:30:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36646 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgBSRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:30:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1575794wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Vzj5fYuKhjSJIX8LLdjrzndSdJzkfLdinYyCt3Ld6uA=;
        b=rTS8Mo3OfNleBFSAn1y54h2JccThE9WwvMh1CPzzw8Yv/pYj4cc9te+MrhhNmIfNNC
         yfMLNteGG2e0ZAG+BLaoho4eshauB17hHBJVUTQUMShg50KLiriDQfNh8KH3ZF8uc1dZ
         WOUriIwI7kgYXc1ltbH177D3QQ6VSgG6tpZAbDp+kvoBwLCodiK0/tTVNyjFghyem1Pv
         MKMcF4HEcr+GlYtisjzch3biOCeX3/FJjysohqklTAVaEM6UUBQAOcoszVsj9eHalJOv
         hsk9E+Bb5gW7eR8kkEABhXOQvYd2l6jdyRDi91HdpmBNdmK5Il+GGcqBVVBeONfFY/gk
         +0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Vzj5fYuKhjSJIX8LLdjrzndSdJzkfLdinYyCt3Ld6uA=;
        b=mDNQY4Hhx6kjrLGO4Iu94tBHiRQlWB0QJbr5OY7HRA8dEdSkiQRAI7TLBQE+FhTfzT
         utYy3temKYxioNeFGmxP2YNCQje+QD61s94u7ZYgERMsuketgQxwZQ8niEmJpniLnJw1
         6EYm/4iJGMDRmxdVjnE5MPwnnv5Etjd8MhkQUdOavWhxy0O2DSrE1C7gQ2HT6to0vwE8
         31e4ZhzSI6z5TVr0d00yLw2pmAnfP3NQhRatiR0DxWi9AIOeQeVHffqyzENf7El6aSdf
         t72hC3POpBPNdU7unIAT5znwi46m9dPKfgTvtHT/KXMdYmXtyDSpQxIgej/YJeyKWKuo
         29Pg==
X-Gm-Message-State: APjAAAU81A/7+gGoMSI/bJRRIXRYT1tTKCWLQAP2xjQqK7PTSxWmJrp6
        V39tFALLsWrz+e6cg1IV35dszA==
X-Google-Smtp-Source: APXvYqz8SvtcLoz81n/o1JvdjzZKZJ/qf8otl/+1C1BQrR5Z5QNE8zns0Qa9uLXu/e2c+diOPxnt3g==
X-Received: by 2002:a7b:c3cd:: with SMTP id t13mr6145330wmj.88.1582133435029;
        Wed, 19 Feb 2020 09:30:35 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id s65sm600755wmf.48.2020.02.19.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:30:34 -0800 (PST)
References: <20200219161625.1078051-1-jbrunet@baylibre.com> <20200219161625.1078051-3-jbrunet@baylibre.com> <20200219162000.GF4488@sirena.org.uk>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 2/2] ASoC: meson: add t9015 internal DAC driver
In-reply-to: <20200219162000.GF4488@sirena.org.uk>
Date:   Wed, 19 Feb 2020 18:30:33 +0100
Message-ID: <1j8skyxz5y.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 19 Feb 2020 at 17:20, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Feb 19, 2020 at 05:16:25PM +0100, Jerome Brunet wrote:
>
>> +	SOC_SINGLE("Playback Mute Switch", VOL_CTRL1, DAC_SOFT_MUTE, 1, 0),
>> +	SOC_DOUBLE_TLV("Playback Volume", VOL_CTRL1, DACL_VC, DACR_VC,
>> +		       0xff, 0, dac_vol_tlv),
>
> Sorry, that should just be plain "Playback Switch" - this can be used by
> applications to present a combined mute/volume control together with the
> Volume control

Ah, Ok. I thought it was important to make difference between Mute
(Playing silence) and a Stream stop ... I guess the app does not care
about such detail. No problem, I'll fix this.

> (though as in this case there's no per-channel control it
> is possible some applications will struggle with that).

alsamixer seems happy enough with it :)
