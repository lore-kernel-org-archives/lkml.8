Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3372468D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 03:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjSlalKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCBDRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 22:17:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgCBDRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 22:17:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so3614324plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 19:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8t+bQd6no+vX10KNUG8W7BdljgcAWDogKvSkBi86nEg=;
        b=FjSlalKmJ4p8dQ0LbDJlifEuPd4SgK3/W8fL1DZ2whuL5Vy3rP2M0bOAeHK3avA+nf
         ml6afV1CVr4XHuSgitl7PkrNj8xZ6ZPWX9F+TaBTqqOnUp6NcCCIuOK7yKG8IVfzdnNf
         8TXV4JBpYd+Y8a6MKGvP89i8SIaFi//CEFTcuaq/o2/H5ofU4FPHhBKxkP4xmjpN+2Ta
         f/lsKPYmYvz076FJAyUdt/acEm6Mu/J/2Ao6X3o/J4aKm5VuqM9CXBqnWbh4Wz/c1RVh
         1ECtmTildGwa2y5NNZx+czWG1gKpGtaNbnVb488Qac+xCAen8RG6PUn0D/MrwDYFQTjY
         w1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8t+bQd6no+vX10KNUG8W7BdljgcAWDogKvSkBi86nEg=;
        b=EvVZWLekHP+CnzDInmKHXPjDRAhwWhKrBH9C31jiEDrO8RssqaDe4ujbhIII5ONOHv
         NVEMvslzl95JXJ8AVyzpNis+f/FYMWj7ECORrQL0mDnOn02XlrtH2MXh/sFgucqxtjoR
         KOhiQ/FXqqIfIZgXWnwHFRLSZIrLe1lw7bd05hmotABL8SSU4WXqAyRF0ZezX7Es/NOG
         Aovjxb5tsOcHO8PL8LJiZ19XLgqP+datEtl5SObRVU+spfCIb9cx47mb4nG7pArdVdW4
         2VL0Ic7yMXXxJ8MY/RlXA/kXA196OTfZCnerHbodR7NXgVnbd8sx0f853WcdL90ZTcYd
         ejMQ==
X-Gm-Message-State: APjAAAWpYZn1M+FpId2KF5+9dFqoqzlKtu37lodFz2bk92X3hKYr1mSM
        B7ONmoelPIRaQphRlNS1171HOg==
X-Google-Smtp-Source: APXvYqzMb5bbHpEUw52CKGpM7wwm1tYj6NFor+t791LteEmnzNazAM/gYuWof2qUwGBuXCPYShXWQQ==
X-Received: by 2002:a17:90a:c214:: with SMTP id e20mr18478282pjt.98.1583119059840;
        Sun, 01 Mar 2020 19:17:39 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id b18sm19054466pfd.63.2020.03.01.19.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2020 19:17:39 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:47:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: spear: replace setup_irq() by request_irq()
Message-ID: <20200302031736.5or4ww5a4l7zomfo@vireshk-i7>
References: <20200301122315.4240-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200301122315.4240-1-afzal.mohd.ma@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-20, 17:53, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

I think I had already Acked it earlier.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Please get this through Arnd directly.
-- 
viresh
