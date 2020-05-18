Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DFDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625CE207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbwPB+32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgERQVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgERQVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:21:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1024C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:21:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so12527298wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mPan/iOK3FlJrRcEPq0sqHhm0unuccyfQDLEwiWdKUY=;
        b=jbwPB+32E8dRbvJ2wuQ2JG0caMLHZmmizHiGemUQmDcbJFiV+TvTZGRDL3d8PDtLsY
         2ofvAnRHxEjj2ccKFu/Y5AQ4iCGeV1QxDIb1SuzLFLi9OIJdiJas6gQG5cCvWSMPOGBU
         x/V/WqmQj0E7HnKvep4LT6igUvk+nrxoUYNON3dPkrUZJ9KDQUPW6Har3ir+HmcgWsqf
         alrdsuwFyryYBcb3FZss6FzqoR50INrutQ/9FhINws5OiGc6tiKlOXePO31DMMzaYdT8
         /Y2of1GPQsIZoDVqZozjtvQotHRUsqHUJo+Fk8R0XnV0TubHTbxg8/nwPjxSaIXvslXu
         PaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mPan/iOK3FlJrRcEPq0sqHhm0unuccyfQDLEwiWdKUY=;
        b=Tk77iQqU7eWn1nKKaoiTdxCJ8KnBt4v4EXc6KigNqgjld6J/JZlOZcHkL8uRxovzIW
         rVy7rt4avQOazrkjayoVTNyRt4XjBf994Bidvv3aSPeRTsbGW1Wrr4udAYCfOBLEGyzJ
         bUKNBOkSZ0NSKz2WZlTdkSebOjSafgG30HciqOla0+feNwIVt1FMBeS/4ysjIBgVHTmX
         UrvsUNbsW42EOVBv0RPTDjhdI5c4J7KgI5e8PhPX0YBXGYC3amlwLTmSNYxifpKVFKmG
         rM8pn3mlv+JbZ9HFErhXnAuoC8Kljy8ABl8JDOg0h161pNqBiQaX0YjTnangxa7uhxNc
         PEmQ==
X-Gm-Message-State: AOAM532HG8+SXHKQoWiuU4/gLqfQJFOZIPGCPnnfLemW1GVcsMdJ5I4/
        m1jEvOni74XHTMd2M4h9iZoA91wo+24=
X-Google-Smtp-Source: ABdhPJyiDuft1ud8pm340dhXzBtCA6hZi5QfdvTeiEMwEovwvB9rBLz7UQdecu8ItPbWcTbrcrKeiQ==
X-Received: by 2002:adf:f40a:: with SMTP id g10mr21964592wro.117.1589818896319;
        Mon, 18 May 2020 09:21:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id i74sm17145474wri.49.2020.05.18.09.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:21:35 -0700 (PDT)
Subject: Re: [PATCH v1] clocksource: arc_timer: remove duplicate error message
To:     Dejin Zheng <zhengdejin5@gmail.com>, vgupta@synopsys.com,
        tglx@linutronix.de, linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20200429151223.3120-1-zhengdejin5@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54f33384-2d2e-ce84-4242-d15286f65dfa@linaro.org>
Date:   Mon, 18 May 2020 18:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429151223.3120-1-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2020 17:12, Dejin Zheng wrote:
> it will print an error message by itself when arc_get_timer_clk()
> goes wrong. so remove the duplicate error message.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
