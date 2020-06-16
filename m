Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3828620A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U6/hmvvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgFPNrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:47:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B652C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:47:51 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i12so1471215pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUln3eDvcCJnsTxP4o2nCcbHN366GT2XubrxAw/PwPQ=;
        b=U6/hmvvbBbi9/FmqWEyN7ARc+R7Qqp9XN3x/VwhFJBb4m2JgiRW7JX/moBz4mnQgZm
         WPlOUeu+0igHuD55YwEruLd1450HsTM1F0FBQ7ShKl8YTQsser8xdFrstxqNSMRYlPNl
         ZHjjjEYU/uC0c17FfWG0iljqCjCV+68N/ZbFe4w7wsTgIUtVxTIcHLGZq8nKyqMAh2cP
         GO4lbPVN1quzQkJulkGhxhz4pTvLLjqr3MA882ZhK3jTb66EMyR1yBvsowZ0hY97mIy1
         k3e7T/NBrnzQks5Z+2r8aCGXg4Cs+sfJ00+ZdD85ZaEjeSUMpLhcnGJaqAA9SFu2ernE
         WNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUln3eDvcCJnsTxP4o2nCcbHN366GT2XubrxAw/PwPQ=;
        b=FdLrb+fzrMfGZEuaBzY9Bl1EbzlszpR/Yz/CSGa6Z1Yeues3MQmV22fe0RO4thyLEN
         uFs9ou/1LpB2+0dOTzAP6tYO6qHsMKjkx7ovhj/l1wCn4qEd9CkdBRkUYjWyhcTDvng1
         6PB2Uwk0zuyeYAQhaeoG/QT5G5vZ14scq3JuQZFMqtkES0sofLTGZe3Vv6HB8XK7R3sC
         7kTZr+ZRl9L0zMDZDLK9HJJ6xix3UO/1DOi5gXb4XnIoQrbc6oz3hbNlnBjS5rL18XFu
         FCGBsceSGbRI7Y8x5LyXgt75sLO0L2P2xRUVLalNbjB5m8ZL7ks1U6Bqvbu2phw/FwpN
         S88w==
X-Gm-Message-State: AOAM533rjIudXF67W6z3bPpsoQq2m3kzdWvEAIake3+x0y3HApN8ZYUo
        ytP1NizrygNoUaVsfTMPquJTMA==
X-Google-Smtp-Source: ABdhPJwh0ibun0ESRx+TqhgJ9AGgABOCSZFvigx9X6GzGraON4S2C0XpvGXtaFdBeNA6eAekB/neHg==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18mr2057706plp.228.1592315270891;
        Tue, 16 Jun 2020 06:47:50 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id k12sm17030398pfk.219.2020.06.16.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 06:47:50 -0700 (PDT)
Subject: Re: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time
 namespace
To:     Mark Rutland <mark.rutland@arm.com>,
        Andrei Vagin <avagin@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200616075545.312684-1-avagin@gmail.com>
 <20200616075545.312684-3-avagin@gmail.com>
 <20200616112418.GC11780@C02TD0UTHF1T.local>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <d16b5cd1-bdb1-5667-fbda-c622cc795389@arista.com>
Date:   Tue, 16 Jun 2020 14:47:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616112418.GC11780@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 6/16/20 12:24 PM, Mark Rutland wrote:
> On Tue, Jun 16, 2020 at 12:55:41AM -0700, Andrei Vagin wrote:
[..]
>> Whenever a task changes its namespace, the VVAR
>> page tables are cleared and then they will be re-faulted with a
>> corresponding layout.
> 
> How does this work for multi-threaded applications? Are there any
> concerns w.r.t. atomicity of the change?

Multi-threaded applications can't setns() for time namespace,
timens_install():

:	if (!current_is_single_threaded())
:		return -EUSERS;

Thanks,
          Dmitry
