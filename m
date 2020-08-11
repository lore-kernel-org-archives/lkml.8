Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1652076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="d+qdLXSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgHKLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:04:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:17993 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgHKLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597143860;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zmGqtyvDjnPl9SF3eHck7clcf6r4U0VaDRO31hZb3o4=;
        b=d+qdLXSBv6QDhgBQVDigRdPZMhyqciRmS1qhnmw+3KSrfQhbqj41S15Tzcbmfu9zhc
        z/opV4OpNXZiDWO7J6b7tb3vbovk8gDdR0IRb4KZDSp3vD4VbRCS1eMFFypT9R493Z9o
        zezUEpNh4rMSqDJrk4ZOAPFts+eqDYYygZ1zFVU57CUN3IXpox4vfXP5u2SOJ9edDTlA
        A5x+mTLpriXUB93wmcmPWinlvS5RhZKW0ZTvH5w4hFzx5bfVQATOnxPakqY9MRTXInqB
        w2DCvbx1MMJPEVEUCMuNuTIBM2kHuZS3W7gpai+B7qay/yS7Z3w57oJ5YU5su5IVhBhJ
        UfCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9IczHboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew7BB4HjIj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 11 Aug 2020 13:04:17 +0200 (CEST)
Date:   Tue, 11 Aug 2020 13:04:09 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        john.stultz@linaro.org
Subject: Re: [PATCH 1/2] ASoC: q6afe-dai: add dummy register read function
Message-ID: <20200811110409.GA1481@gerhold.net>
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:25:51AM +0100, Srinivas Kandagatla wrote:
> Most of the DAPM widgets for DSP ASoC components reuse reg field
> of the widgets for its internal calculations, however these are not
> real registers. So read/writes to these numbers are not really
> valid. However ASoC core will read these registers to get default
> state during startup.
> 

Actually q6afe-dai does not seem to make use of the register number.
The DAPM widgets all look like

  SND_SOC_DAPM_AIF_IN("HDMI_RX",  NULL,   0,    0,     0,      0),
                  /* (wname,    stname, wchan, wreg, wshift, winvert)

Wouldn't it be better to replace wreg = 0 with SND_SOC_NOPM in this case
so the read/write won't happen at all?

q6routing on the other hand does make use of wreg, so this would not
work there...

Also: If I remember correctly the ASoC core will also attempt to write
to these "registers" when starting to play some audio, so you might also
need to implement component->write().

Stephan
