Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043EC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538E520731
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7WSfNvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgDEUfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:35:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47079 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEUfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:35:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so12415335ljg.13;
        Sun, 05 Apr 2020 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TYj3+piE/UAROa6yTF6va+D/lbusT9K2oVQZrG1pkaE=;
        b=p7WSfNvVEr21OKR2Vwi7/YyqmoWABh3RCnOgxOmLDu8YvKoliyIXJECGHFSjT6k0su
         SZDoPjEvKBj1wSGUF7CSaUtEErPYbshXwjHEFLhOfo1DQVOx3k4mkwlm7LVTb0pVDzhs
         MNfYmxokNZ9Ug2ulUrAQlo7pdlGoMree74fBes9DSJ6X7amBHhfcAOzDFbYTNa/Dc3iU
         hHoux1al+ala12Xu8e/b9LYYrzXBucPXBwvYumNCCPRKVFweGdyE/kThbXsSAp74LO35
         wDcGFI9m2OXXSiSyYDJwGSWNwjISL5PK+zbRS1tqtyjKiAd3IWBJ59uus9+jnz1qUvBq
         lkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TYj3+piE/UAROa6yTF6va+D/lbusT9K2oVQZrG1pkaE=;
        b=Zz4OWPWJeRKuf7xlJmHazYrKTXOAdPoQfJcYYoRFn4rZDjrl13d6zE+3tmcqdAxZmI
         7OntSZaKpk1Pt5MKqLsGhwib7fSQgZteaQ7IrUqPlzmA7dWjeepvWH89xD/H6doUG5Q6
         1l66VUYeqPg0PqMEYLEKGDpQRtoAWicHR0zMzoF726v8bMY1K/VifWVkm3eFx2u3+82B
         DYMjPJcR6eUdNwOS045iNgcovktgdxN5pd/Ls8+ZRbUTkmobW6GixCmEl76lqXpfGgpL
         BuWp2qnc8YEmIlud/712DF9HuTbPnaT2ljcwBKdJWLjU9gD2xjk1hiHWIAIGqcsEZwQg
         fwdQ==
X-Gm-Message-State: AGi0Pub2j0Pf8JjUO+zQLhlRDfUSGN38epwWXz93qATxLbCw0iqFhDl0
        +AzQK4jNJEiF3Ttqljd2soJeknyq
X-Google-Smtp-Source: APiQypKKUtpUiTpuV3h9pfmygV8lu3USP8vFclc/FNcjwFw68mOjNKAAhM1Hu3VI/3NNbNOrXBGOYg==
X-Received: by 2002:a2e:7513:: with SMTP id q19mr10530807ljc.221.1586118942298;
        Sun, 05 Apr 2020 13:35:42 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id a4sm11152222ljb.27.2020.04.05.13.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 13:35:41 -0700 (PDT)
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <38d921a7-5cdf-8d0a-2772-4399dd1a96a0@gmail.com>
Date:   Sun, 5 Apr 2020 23:35:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2020 04:25, Sowjanya Komatineni пишет:
...
> +static int tegra_channel_capture_frame(struct tegra_vi_channel *chan,
> +				       struct tegra_channel_buffer *buf)
> +{
> +	int err = 0;
> +	u32 thresh, value, frame_start, mw_ack_done;
> +	int bytes_per_line = chan->format.bytesperline;
> +
> +	/* program buffer address by using surface 0 */
> +	vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_OFFSET_MSB,
> +		     (u64)buf->addr >> 32);
> +	vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_OFFSET_LSB, buf->addr);
> +	vi_csi_write(chan, TEGRA_VI_CSI_SURFACE0_STRIDE, bytes_per_line);
> +
> +	/*
> +	 * Tegra VI block interacts with host1x syncpt for synchronizing
> +	 * programmed condition of capture state and hardware operation.
> +	 * Frame start and Memory write acknowledge syncpts has their own
> +	 * FIFO of depth 2.
> +	 *
> +	 * Syncpoint trigger conditions set through VI_INCR_SYNCPT register
> +	 * are added to HW syncpt FIFO and when the HW triggers, syncpt
> +	 * condition is removed from the FIFO and counter at syncpoint index
> +	 * will be incremented by the hardware and software can wait for
> +	 * counter to reach threshold to synchronize capturing frame with the
> +	 * hardware capture events.
> +	 */
> +
> +	/* increase channel syncpoint threshold for FRAME_START */
> +	thresh = host1x_syncpt_incr_max(chan->frame_start_sp, 1);
> +
> +	/* Program FRAME_START trigger condition syncpt request */
> +	frame_start = VI_CSI_PP_FRAME_START(chan->portno);
> +	value = VI_CFG_VI_INCR_SYNCPT_COND(frame_start) |
> +		host1x_syncpt_id(chan->frame_start_sp);
> +	tegra_vi_write(chan, TEGRA_VI_CFG_VI_INCR_SYNCPT, value);
> +
> +	/* increase channel syncpoint threshold for MW_ACK_DONE */
> +	buf->mw_ack_sp_thresh = host1x_syncpt_incr_max(chan->mw_ack_sp, 1);
> +
> +	/* Program MW_ACK_DONE trigger condition syncpt request */
> +	mw_ack_done = VI_CSI_MW_ACK_DONE(chan->portno);
> +	value = VI_CFG_VI_INCR_SYNCPT_COND(mw_ack_done) |
> +		host1x_syncpt_id(chan->mw_ack_sp);
> +	tegra_vi_write(chan, TEGRA_VI_CFG_VI_INCR_SYNCPT, value);
> +
> +	/* enable single shot capture */
> +	vi_csi_write(chan, TEGRA_VI_CSI_SINGLE_SHOT, SINGLE_SHOT_CAPTURE);
> +	chan->capture_reqs++;
> +
> +	/* wait for syncpt counter to reach frame start event threshold */
> +	err = host1x_syncpt_wait(chan->frame_start_sp, thresh,
> +				 TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value);
> +	if (err) {
> +		dev_err(&chan->video.dev,
> +			"frame start syncpt timeout: %d\n", err);

> +		/* increment syncpoint counter for timedout events */
> +		host1x_syncpt_incr(chan->frame_start_sp);

Why incrementing is done while hardware is still active?

The sync point's state needs to be completely reset after resetting
hardware. But I don't think that the current upstream host1x driver
supports doing that, it's one of the known-long-standing problems of the
host1x driver.

At least the sp->max_val incrementing should be done based on the actual
syncpoint value and this should be done after resetting hardware.

> +		spin_lock(&chan->sp_incr_lock);
> +		host1x_syncpt_incr(chan->mw_ack_sp);
> +		spin_unlock(&chan->sp_incr_lock);
> +		/* clear errors and recover */
> +		tegra_channel_capture_error_recover(chan);
> +		release_buffer(chan, buf, VB2_BUF_STATE_ERROR);
> +		return err;
> +	}
