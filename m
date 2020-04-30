Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78C3C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F37205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcZoL1BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgD3UGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgD3UGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:06:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA3C035494;
        Thu, 30 Apr 2020 13:06:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so645367ljj.11;
        Thu, 30 Apr 2020 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQkcVujmEAsC5qn/cDhjCOzcH+xokPrfvlyIJaZlQW8=;
        b=qcZoL1BDK7eicvBfj4FWexs21jkeVeVk4GsIFCF/ihe9dy/bdOcAwrfvP/iZrLyUw+
         vlQL6SOas05a8b4RIt6TvOf50qIhOlyf4eBzQFd5SI1w3iGvVCbP5uGxxmpAvjq6wmvE
         khCNoXRUuT/EAn3irEjRjpnblElG9KH1lOrQJGCtc61ieqkTw22Lwb7HmVejmipICEkk
         RYfHLbSR1lcU4EltTdu96s8KdhKUoe+YfL3hn4mBkxTHOEYq3WBaGIsNqcbiWHAdWsaT
         i3Sj11PYC8xTgKl9/nS8Pj7KxwhfHLHsr/Sz8/lSmcRbC5o/NLP+rX1bYuBzyIAC21Jc
         6XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQkcVujmEAsC5qn/cDhjCOzcH+xokPrfvlyIJaZlQW8=;
        b=F5NPjnvLpJErJAyiFG171kIlo3Kb2yjh7pNhUauvjzfGb+WIbHN9EByyTtowwPEohz
         X54OkgudnxK95RAbwuo6vCn6CzJVBctvn+2Zus1/xFetADk771YbRnSQc0EOIAGTAlTK
         hVa7gtB3zgnP2k1ja+ZHEyR3UKMV22fKIyp5nzKDPUfAe50j/LCOCgVPzrbZTHBnxsQd
         harFvEtdVXpQzlkU0p5mMATSxo7Ebs53watQQBwnjnMEda0zkXbxJJcf8JPSr34cqqjQ
         LS6dxmWXH7ScqXqkT69SF8yp1p7cSc/M6DsMe/uqvCngbth0xk28BvTI73rtYKcb6RAV
         JdZw==
X-Gm-Message-State: AGi0PuY9JHdw/5ljdMN7Z9p6omwTG9QG2btccKqvy98tCnp5HnU1FBLS
        3VkNxXdkXY7HNRjUXljMX4mckD5v
X-Google-Smtp-Source: APiQypLTEqWQvJrpR4YyHH4cNEwyvkgNntPKXXeVenvaws12vwl12CQ3C+Tcm4tN/ggxRg9Y0qanRA==
X-Received: by 2002:a2e:9818:: with SMTP id a24mr368146ljj.126.1588277177808;
        Thu, 30 Apr 2020 13:06:17 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id z9sm663609lfd.9.2020.04.30.13.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:06:17 -0700 (PDT)
Subject: Re: [RFC PATCH v11 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588197606-32124-1-git-send-email-skomatineni@nvidia.com>
 <1588197606-32124-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eadf3a5a-f305-4561-10e1-1b9241b9c5c2@gmail.com>
Date:   Thu, 30 Apr 2020 23:06:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588197606-32124-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.04.2020 01:00, Sowjanya Komatineni пишет:
> +static int chan_capture_kthread_start(void *data)
> +{
> +	struct tegra_vi_channel *chan = data;
> +	struct tegra_channel_buffer *buf;
> +	int err = 0;
> +
> +	set_freezable();
> +
> +	while (1) {
> +		try_to_freeze();
> +
> +		/*
> +		 * Source is not streaming if error is non-zero.
> +		 * So, do not dequeue buffers on error and let the thread sleep
> +		 * till kthread stop signal is received.
> +		 */
> +		wait_event_interruptible(chan->start_wait,
> +					 kthread_should_stop() ||
> +					 (!list_empty(&chan->capture) &&
> +					 !err));

...
> +static void tegra_channel_buffer_queue(struct vb2_buffer *vb)
> +{
> +	struct tegra_vi_channel *chan = vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +	struct tegra_channel_buffer *buf = to_tegra_channel_buffer(vbuf);
> +
> +	/* put buffer into the capture queue */
> +	spin_lock(&chan->start_lock);
> +	list_add_tail(&buf->queue, &chan->capture);
> +	spin_unlock(&chan->start_lock);
> +
> +	/* wait up kthread for capture */
> +	wake_up_interruptible(&chan->start_wait);
> +}

The V4L doc says that buffers could be enqueued before streaming is
started. I guess it should be a trouble here, shouldn't it?

https://elixir.bootlin.com/linux/v5.7-rc3/source/include/media/videobuf2-core.h#L379
