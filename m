Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0972253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DQxdAFgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCIRdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:33:35 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44209 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgCIRde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:33:34 -0400
Received: by mail-lf1-f44.google.com with SMTP id i10so8393566lfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=bgiHSLTQXM8E0mv0SF7G09UBPAaNCg/++oKU9IO6Jv0=;
        b=DQxdAFgBLzOAYx5M0Q2Fh/zkVoV6kRmCETSjJWCX2qfbDblPeSMRSyXVWiyOt5Ig3w
         gMJcpRqwnRBelmbxOy+sO0cchBZqoMdedCWSBBTnV3n3ng/yHVlq3GqcCNbjCr0OjUSN
         bIhthscycsWpgsCe1Hw6pRZIVFPhvr5K67Giw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=bgiHSLTQXM8E0mv0SF7G09UBPAaNCg/++oKU9IO6Jv0=;
        b=DINjUTw2IJl2/VmJTKLktwyru+wPIVLVormH82ZKOX7iPtguV66ySjfuJhQSI9AQcR
         nx0JTKiMZp/YW0HbJOsa6Ny6lpvxb6ieskvFReiVga0bzJaBvMtDG7a56uDMWOicFtdH
         KES8YDLJLgNLu5/IMUzaKuIKhcgxhQQpWFs1gvucmtYm1Z89/QdA5O8FLpWj1q/jDprK
         ZOj+pue1T5p9MT3OiyBvU4UDy6ssTzXCA9HzJL5MUsE8TKPj9TnXcDwLj45DhAmm/Sq7
         +kqekqJ1T+0kLoqybmaQW89mvr5ZtH3o0oKRzwCHF+P2IypStDYRsZ0oJIjeeBY6EUsg
         0GKw==
X-Gm-Message-State: ANhLgQ1Kz9L0W61OM98sH0m3X9seSNI4BmmIMmTTTa83BLzNcogtIS7h
        uu2xr/BiYVRSf5/nbQdpHky6L/TffClO5aWa6Zh9QA==
X-Google-Smtp-Source: ADFU+vuq3eH9wkuVNiO3iVGw7rhwXN2qPoAEtL/Vxw8RjRXO3sz1OPnFMpu3+6cw1VwM6E+14wRoY4uUL6ksq3D8aLA=
X-Received: by 2002:ac2:4834:: with SMTP id 20mr9943688lft.93.1583775213105;
 Mon, 09 Mar 2020 10:33:33 -0700 (PDT)
From:   Kevin Li <kevin-ke.li@broadcom.com>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com> <20200309123307.GE4101@sirena.org.uk>
In-Reply-To: <20200309123307.GE4101@sirena.org.uk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK6AtPk+W1UvlC/8YJn5FlJAEq5hQGCyJpIpmw/bzA=
Date:   Mon, 9 Mar 2020 10:33:30 -0700
Message-ID: <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
Subject: RE: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

The SoC I2S block we currently have shares one clock and frame sync signal
for both playback and capture stream, plus playback and capture can only
have one master at a time. If we set playback and capture master at same
time, it will have jitter on clock and FS.

Based on above, for playback and capture, whichever starts first, it will
be master, another stream will be slave if it starts before the first
stream shutting  down. So working as master or slave for a stream is
depending on another stream's status.

Same thing for shutting down a stream. A master stream shutting down will
have to set another stream to master if another stream is on working
status as a slave. A glitch/Jitter will happen at this moment. But we
minimize it.

That is why this master/slave mode handles in startup/shutdown functions.
Not sure how other company handles this kind of I2S block.

Let me know if it is still not clear.

Yes, set_fmt() is not needed. Will be addressed along with rest questions
you mentioned on the next patch, with a patch version.


Thanks!
Kevin


> +	struct bcm_i2s_priv *i2s_priv = snd_soc_dai_get_drvdata(dai);
> +	struct regmap *regmap_i2s = i2s_priv->regmap_i2s;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		regmap_update_bits(regmap_i2s, I2S_TX_CFG,
> +				   I2S_TX_OUT_R | I2S_TX_DATA_ALIGNMENT |
> +				   I2S_TX_DATA_ENABLE |
I2S_TX_CLOCK_ENABLE,
> +				   I2S_TX_OUT_R | I2S_TX_DATA_ALIGNMENT |
> +				   I2S_TX_DATA_ENABLE |
I2S_TX_CLOCK_ENABLE);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_CTL, 0);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_IFF_THLD, 0);
> +		regmap_write(regmap_i2s, I2S_TX_IRQ_OFF_THLD, 1);
> +
> +		regmap_read(regmap_i2s, I2S_RX_CFG_2, &slaveMode);
> +		if (slaveMode & I2S_RX_SLAVE_MODE_MASK)
> +			regmap_update_bits(regmap_i2s, I2S_TX_CFG_2,
> +					   I2S_TX_SLAVE_MODE_MASK,
> +					   I2S_TX_MASTER_MODE);
> +		else
> +			regmap_update_bits(regmap_i2s, I2S_TX_CFG_2,
> +					   I2S_TX_SLAVE_MODE_MASK,
> +					   I2S_TX_SLAVE_MODE);

Setting master or slave mode should be done with a set_fmt() operation but
your set_fmt() operation was empty.  How would this be configured?
