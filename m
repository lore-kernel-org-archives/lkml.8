Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E091C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A9724650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSPNOfzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgBUQjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:39:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33491 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:39:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so2778334wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QjTyTbipJt5dMzjmIdDzAUN6hlDcjLhrXHCIzO32swU=;
        b=SSPNOfzSs9LjzxjHRN7eg6XW28B3PaBN5bgPA5Pv+CJIpiaCw80cexZogBaEx3obvN
         Ix0ERJnECtRHuNfPwlx6Lqof4XhKpEwuOHyRdRmIVnf7ZqdlIK1jfwPHdAT73zKnA5fi
         kK/1cC+5JpjWdCIdTTlqpzlxmkDHIGh2dzLdC8QPIVCzYGhU2nT1VHomXeumu3Wb3ldU
         mRQQWNmx8eHKBsy06cTVsIEsbt2keYOVa//zUotuolDVnG8sU22Am2VY12s1ikLBsBfI
         Cb3dt2g/O+rXt5rYn1rjSUfI7pyblpgOCKc1/TCrfotm2O39qxxGXqCUmdXUXeENv93g
         RcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QjTyTbipJt5dMzjmIdDzAUN6hlDcjLhrXHCIzO32swU=;
        b=lS+KvzTBmERDWY1OazuPZMpUH8J4WjQoyemOKd3UeP65UgPFlOgECbY7b+3K9bOQV2
         QJJeOjx8LkWOpmTjra6Q4XcjLV68kIvzOo4b0tTqD73vxll83p4J2CtQ5Zl48sKfW93F
         h7jyJ5r9gxfcHHLTHTPZ3T4gtT+9ENB6fG0/BcRT9aGu7NLzMIIDXgrXX1G6PU/cqQTN
         xrzJ8mWYKzGU3RzSB+2f62hOGid5+3gwbbUnns3LYIPfVdTXkCI8t68OUS2VHGIKfKTQ
         3ngZo7/zR/80KHOYyM+dtlue+K3qGdvPfME4X3rz8r+xVzOzrKxDPRLWAPQg1A0XyIB8
         oIlA==
X-Gm-Message-State: APjAAAU4roRJE2YuupfkOySqBxON/xCS/HcwwLFbanDmS6CkH6XLMjpf
        9vHOn/q+NQmXJIrI42kAJeRWtA==
X-Google-Smtp-Source: APXvYqyhVFhFBPSqnFo56LCyr1nJlT2hcmUgR2c5NunDYfi/Fc9CnjlmGN7Mc7+ge8fiAVpk5qDoGw==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr47981280wro.375.1582303156945;
        Fri, 21 Feb 2020 08:39:16 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id t9sm4805226wrv.63.2020.02.21.08.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:39:16 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:39:13 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 15/17] cpuidle: tegra: Disable CC6 state if LP2
 unavailable
Message-ID: <20200221163913.GT10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-16-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-16-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:32AM +0300, Dmitry Osipenko wrote:
> LP2 suspending could be unavailable, for example if it is disabled in a
> device-tree. CC6 cpuidle state won't work in that case.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
