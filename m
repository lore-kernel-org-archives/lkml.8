Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A29C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 22:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826DF2074A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 22:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jf5XJT25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgC1WTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:19:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38337 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC1WTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 18:19:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so6651237pgh.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=co2N4bkvAOJAUXCk/vC0UWvLXVTotTW2AO2YGPmDkQg=;
        b=jf5XJT25fVNwQA+I/A1whuGeDvFPM4+wyvi/iO9+vImp8u3YMrI49UHciUb0rE8Czj
         aGoG3ghm/Qhhq9oW8xnJZmaXO28xovjK/MOvqk3a4GD+RPDlSKdaK+ZtTJXmxv2icxut
         SDex7XpenXHpKKRJq7Z6yKwbKl3JC3KGfChE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=co2N4bkvAOJAUXCk/vC0UWvLXVTotTW2AO2YGPmDkQg=;
        b=qFc+ISM95T9KVjrRm+P1Otpox45ZVBuHoKsA548D8NvjPNTWApp9zLEf9ALTTSxai7
         7E4VAAp12t/sj4Ky9eIcxtL8Vbw4rgDVDNYSGQfA8XNhUkoL62gu8hxGBnZBIeKLTXJV
         pyumAievEgX2Ler6lszIljNiyZrHlqhdaQ8S3xArLPrfdmpwl/A658PJJ9ZzK93dndPh
         WPZN0UVVxc+U5h0Ti3EvAnfAtaiAkfebz/6EcDBAtGbPnOW/HcCCl9Wz1YtFWuep7Bv4
         5i7pOXRkemQSMQP/i7jPzjParhZ4tS2HF3jZXxO6gRqdUXj1EnozeGKOK8mHSWCUo+vm
         U3bQ==
X-Gm-Message-State: ANhLgQ3n9MynUa4ufhFlPcx43guHW495aEmqUkDYeMJikQIzykOy0y5O
        ibnKvpbKatEFAxTVTaPUxLtXWw==
X-Google-Smtp-Source: ADFU+vtLr5xkNiaIyt5Ozz0raelxqkQC97tZxG4/MYeJahlnnqZKwK63Bzq/imqA23inH9Oocgbuag==
X-Received: by 2002:aa7:850f:: with SMTP id v15mr5712127pfn.119.1585433970045;
        Sat, 28 Mar 2020 15:19:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nk12sm6752020pjb.41.2020.03.28.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:19:29 -0700 (PDT)
Date:   Sat, 28 Mar 2020 15:19:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [x86/entry] 8c5045f89b: will-it-scale.per_process_ops -12.9%
 regression
Message-ID: <202003281505.0F481D3@keescook>
References: <20200327074002.GV11705@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327074002.GV11705@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:40:02PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -12.9% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 8c5045f89b181a4412b698cafc9dc257192a3a65 ("x86/entry: Enable random_kstack_offset support")
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git kspp/stack/offset/agnostic/v1
> 
> in testcase: will-it-scale
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: lseek1
> 	cpufreq_governor: performance
> 	ucode: 0x11
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale

Whoa. I'll take a closer look. I fail to understand how this could be
happening. In this CONFIG the changes are a NOP. And that would be
true for both process and thread. O_o

-- 
Kees Cook
