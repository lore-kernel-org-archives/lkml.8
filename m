Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CD7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8455206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTMfmVTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHXLBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHXLBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:01:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:01:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so8248450wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vJ1eNEFLaB8nJQQFgwghGU2wabwAkxn1KgMf6hL5Xh8=;
        b=sTMfmVTwLeCOxUYP0/k8SSgTjJs9jk9DQarL7xUBCbYbtS7PLGpK4BOOxSzsUPouFh
         /+dcD4qNa1NDz8hZ36wc0aHERmx8lVLKxVGbLchsAMyDFaxFQPXGGhqrJGZrdmNCZq51
         GjNtFOlLkVfnufZ9Qws82+UOiJFfCTeqQOp1eLQU78+kKoOuLV9C9b+nguzrXEmpTwsI
         pQwE2u/MRLkzuDT/fu5YhVew1acgk1FfLLkJLTorupCAT6n2dlH8hXN/GfFVKRdnGP6b
         8CyE0TlrlGuCDRd8tINbMXV8ISCBAu7PyU/IfY16jC/c3LOz9KwK8dxmIfOQCO9hfnmN
         x3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vJ1eNEFLaB8nJQQFgwghGU2wabwAkxn1KgMf6hL5Xh8=;
        b=OMFPUYRv/aRuyxK6vDWu4T55LBc99jRPnczeCMAy1PEe5zQoKRFk+iaMmrwM8aWTJR
         laAA+LkjoiqlsrvEM5aKwPHCfSlSs+ElSqaX3QXAuZ4i36LF9WCKu62JFU7rIernRcYt
         sy7v8K+MQxSbvOK4sXeyQs0PvjMyJ6hvZ691PVG/2yp3kNigGFvfb3vtAYkpoR3JK3h9
         0JjSSlxEvItnw5DeRJOuI1rjZXAFkSpjH4hMOaePMXdxgf0RR7ANEMAUXJ0nJ15hoCU5
         lsEZaaSDSlglPsVZgNQM6br8hkWnWZ8/Wp/wtVCZp9NCN/wlFDrdl+skVSXcS/65oPsD
         +xLw==
X-Gm-Message-State: AOAM532y6EG8fYq3Ju2UL/fya+hQael4TS2BPQ83K6eivZzfqS2pHwDm
        umjBu/vv55fuJm6Hf+Qz8xjxHQ==
X-Google-Smtp-Source: ABdhPJybWoKbzrnXY1ZEEs5uOne0Za2Q/iVEnEp5VoqZtSurpnQJ6PCFjrJAQOjeOulEsHmjz+NiVw==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr5717930wrp.180.1598266861232;
        Mon, 24 Aug 2020 04:01:01 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id c4sm22629929wrt.41.2020.08.24.04.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 04:01:00 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Do reset before enable
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200817092428.6176-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1e43fb86-df5b-88e0-aa54-8cc3336ce97a@linaro.org>
Date:   Mon, 24 Aug 2020 13:00:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817092428.6176-1-tony@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2020 11:24, Tony Lindgren wrote:
> Commit 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and
> resume for am3 and am4") exposed a new issue for type2 dual mode timers
> on at least omap5 where the clockevent will stop when the SoC starts
> entering idle states during the boot.
> 
> Turns out we are wrongly first enabling the system timer and then
> resetting it, while we must also re-enable it after reset. The current
> sequence leaves the timer module in a partially initialized state. This
> issue went unnoticed earlier with ti-sysc driver reconfiguring the timer
> module until we fixed the issue of ti-sysc reconfiguring system timers.
> 
> Let's fix the issue by calling dmtimer_systimer_enable() from reset for
> both type1 and type2 timers, and switch the order of reset and enable in
> dmtimer_systimer_setup(). Let's also move dmtimer_systimer_enable() and
> dmtimer_systimer_disable() to do this without adding forward declarations.
> 
> Fixes: 6cfcd5563b4f ("clocksource/drivers/timer-ti-dm: Fix suspend and resume for am3 and am4")
> Reported-by: H. Nikolaus Schaller" <hns@goldelico.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
