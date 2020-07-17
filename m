Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B8E22B4E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 04:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCfJfUai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGQELw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 00:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQELw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 00:11:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA27C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:11:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so9542812wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rvR6cE24nxWQvXGdr9bGR9ZG+XTVZS068TlSRdO5TQM=;
        b=zCfJfUaiQ3/FZ/3nr1m3bjl9N4yIO4cRS9Pf35oDuNvsV78ximJhzcTCr9DX5zUsG0
         Os9dViTz3WvBphCVNQzHpVKDzCCBZOM7gxS8FzAa4BS0pq3adPwzXD2wSxgS5dEMWrGO
         J9LxKnUbA54Gaq+IY8IeLGMpNToJj+P/HZfmgP80/eR6uQ2SxFJ8eLZBXOf9eHsdvmLV
         u1yL3Olvte+k91OP4xymYCP6v+hJfGMBz2gAWVLYD3w8oHsBZhtZSUdEAlOMqFvTpyqL
         veRuFk/ZRon8C5r0tmqqRf8KdPjufP8JfJup34Vz2MWM3umPNSGvtp7q14dVNwLTAxSY
         TcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvR6cE24nxWQvXGdr9bGR9ZG+XTVZS068TlSRdO5TQM=;
        b=JGRA158sOfjWlFOTAV68p0ADtNMoJHNpo20dcZ6G0wJR61OH5ncKls3+j1fe0LpXBC
         mJfp/ERiD3Dd1NQj+VIcG7eEtRMseNF0YnQZh7sZrTjMGre6hvf3gwVBvRKMqV9BhQP5
         QJ9RJJ2KOCnGh0QWicTwidjzFpQlFrgBaqkUB3pEE7dTF1uIQ8mlRAe/aCYgtIGAnzDd
         p9gS05WtAUULbrQI8V/YfaW+503zwZ67G0HfAw/5ecFCTyirPq0JkpMQ92PF9mwwbVAx
         O1SfPc+Uqrgmwaeq1BV8OJb+w0HASMtGpK9gtdZkM/61FwcbHloSKbcmMAD8tjnN4qzS
         xBjA==
X-Gm-Message-State: AOAM531SGDvGCmDPSNrdIvTNXf76BQ2Fwnnwli7LG41drAciSNKK/Hpq
        MKM7/2mV6S/HCRL7fkBdpvwkCyS1DD8=
X-Google-Smtp-Source: ABdhPJyZ+FCZHyPWQI9nbcU9ocxqOY9fSXxQIfjAHptr2vHaW4FfXg/xj5JaVcqx5a8vUsb0jpxAmQ==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr7806083wrm.327.1594959110412;
        Thu, 16 Jul 2020 21:11:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id 22sm12746716wmb.11.2020.07.16.21.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 21:11:49 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] clocksource/drivers/timer-atmel-tcb: add sama5d2
 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200710230813.1005150-1-alexandre.belloni@bootlin.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6684b8d6-e3d2-ac2b-57d6-016e789ed5a7@linaro.org>
Date:   Fri, 17 Jul 2020 06:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710230813.1005150-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2020 01:08, Alexandre Belloni wrote:
> Hello,
> 
> This series mainly adds sama5d2 support where we need to avoid using
> clock index 0 because that clock is never enabled by the driver.
> 
> There is also a rework of the 32khz clock handling so it is not used for
> clockevents on 32 bit counter because the increased rate improves the
> resolution and doesn't have any drawback with that counter width. This
> replaces a patch that has been carried in the linux-rt tree for a while.
> 
> Changes in v6:
>  - Added final Rob's Reviewed by, based on:
>    https://lore.kernel.org/linux-arm-kernel/20200709210543.GA884561@bogus/
>  - fixed the clockevent periodic rate

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
